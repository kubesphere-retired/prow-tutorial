# OWNERS 使用指南

> `OWNERS`是一个配置文件，用于标记代码的文件夹的所属。

## 工作原理
1. `OWNERS`文件表示这这个文件所在的目录的所有者，包括子目录。所以root目录里的`OWNERS`文件拥有整个集群的最高权限，称之为"root owner"，所有的Pr只要root owner同意了都会被自动合并。
2. repo下的每个文件夹都可以设置`OWNERS`，如果某一个Pr改动了这个文件夹后者其子文件夹的内容，就需要这个文件夹的OWNER 同意才行，如果改了多个，那就需要多个人都approve。当然也可以直接找root owner
3. 可以在`OWNERS`文件中设置Label，所有改动了这个文件夹中的Pr都会被打上相应标签。当然，这个Label不应该出现在root OWNERS中，这样会给所有的Pr都打上标签。

## 基本语法
`OWNERS`是一个`yaml`文件，其基本形式(最简单配置)如下：
```yaml
approvers:
  - alice
  - bob     # this is a comment
reviewers:
  - alice
  - carol   # this is another comment
  - sig-foo # this is an alias
lables:
  - re/foo
  - re/question
```
1. **approvers** 能够是用`/approve`命令，这个命令是Pr能够合并的最小条件。可以没有`lgtm`，但是必须要有`approved`。所以`appovers`拥有Merge权限，类似于maintainer级别。这里还有一个注意事项就是approvers提的pr如果满足了**工作原理中**的第二条规则，就会自动会被打上`approved`的标签（出现这种情况有两种可能，1. 他是root owner，2. 他是subdir owner，而且他改的代码都是在这个目录下的），所以需要在pr merge上添加上另外一个标签的限制（通常是lgtm)，来阻止approvers的代码自动被merge。
2. **reviewer** 能够使用`/lgtm`命令(Looks good to me)，用于审阅代码。一般的repo都会把lgtm这个命令作为必要条件，任何人提的代码都不会自动打上`lgtm`的标签，必须要手动使用命令才行。主要是约束代码必须被review过才行。
3. 如果**approvers**使用了github的approve功能，也能打上approve的标签。

## 高级语法
OWNERS还支持Fliter参数（这个参数不能和上面的这些混合使用），这个参数主要用于对代码文件进行分类，可以参考<https://github.com/kubernetes/community/blob/master/contributors/guide/owners.md>了解更详细的用法。

