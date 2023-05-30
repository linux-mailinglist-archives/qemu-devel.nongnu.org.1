Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25821716D1E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ad-000209-O8; Tue, 30 May 2023 15:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zs-0000tb-Jq
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zq-0001AC-D0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so5619591b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473213; x=1688065213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vXbTY4U7jCxySsgnmlA3ufH0QESJMklL3Sa7W7qxzw=;
 b=xjghtHo6feu5uXVj4OX67fCtKuSEqObq5cKcxKUvLp5IAX3tlXF/hVv9IURYB7fPud
 WW7njSloJ+rMQhKDqjv319pRto2w5n79g0t2VspLzBA4xsgLLPIay5p670OaF9I9MjRP
 Sl46LAKX85FVOS8YRvq0R8IZm0gghrDa59ysNUSNdWEaEqrWkeqHuGFYZIQDoTrToGob
 Ai9Ymjp+UWO/BaNloUEYvY3Cj7TVZxczyWtivwPZAVg9jXKACPtlxe38r6neUdAadN6V
 dMXp+QP9muN/D1lkRYCn2v9yvdidvuEW4czQkRZVIRjiAf8JfTAEZeMsWZgVHMFQKcjU
 g+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473213; x=1688065213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vXbTY4U7jCxySsgnmlA3ufH0QESJMklL3Sa7W7qxzw=;
 b=dChCGF3j5vscU5vf4Jo3V3qdWB680n40fNE5ouH8wXtIWHRCUBYxEkc//55wtboSTM
 xmvs+wknhRoTIP2Fnw+ErtlEt8EkyblttEDS7J+EXmlZQ+0rjcYfn7VuCza1nJM3scn5
 Fs3MdqMvtOSVxPbndbmHSUsv8+buox9kfGKT/47xfqGbR1m1motV0T4EyaV6ZZ64VeQG
 9GVX9yCr0UnqgYHDzwRml58bXOaVfbM8+X3aW3SRIhuZYBtT2wHZ5KNk3kuuuwRtHN5z
 +oiYwNbfRQgAqNPSrDMe2DlVXFN0kKAl1/GaYzxzWCXptnN+NKRd1+LXwi4hmf6CtFfs
 Zmew==
X-Gm-Message-State: AC+VfDxJqi8kWnga54pTEFN8fiN0q2sEde7Zqg7U4HkEdaeP0A1XyKZw
 mU1UeO0MTNvQLGJr4sNm2EfprBJhxGuIAm3SI60=
X-Google-Smtp-Source: ACHHUZ41o9GOI3iacltzIq9hQbiULOSEnAmIgqGvrmyFQHqxhJev8uxv1B1zUxAJ3d9RQPLr1b8Bbg==
X-Received: by 2002:a05:6a20:a305:b0:10a:ee1b:fdc4 with SMTP id
 x5-20020a056a20a30500b0010aee1bfdc4mr2814638pzk.47.1685473213004; 
 Tue, 30 May 2023 12:00:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/27] scripts/decodetree: Implement a topological sort
Date: Tue, 30 May 2023 11:59:47 -0700
Message-Id: <20230530185949.410208-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

To support named fields, we will need to be able to do a topological
sort (so that we ensure that we output the assignment to field A
before the assignment to field B if field B refers to field A by
name). The good news is that there is a tsort in the python standard
library; the bad news is that it was only added in Python 3.9.

To bridge the gap between our current minimum supported Python
version and 3.9, provide a local implementation that has the
same API as the stdlib version for the parts we care about.
In future when QEMU's minimum Python version requirement reaches
3.9 we can delete this code and replace it with an 'import' line.

The core of this implementation is based on
https://code.activestate.com/recipes/578272-topological-sort/
which is MIT-licensed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230523120447.728365-5-peter.maydell@linaro.org>
---
 scripts/decodetree.py | 74 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 73d569c128..db019a25c6 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -54,6 +54,80 @@
 re_fmt_ident = '@[a-zA-Z0-9_]*'
 re_pat_ident = '[a-zA-Z0-9_]*'
 
+# Local implementation of a topological sort. We use the same API that
+# the Python graphlib does, so that when QEMU moves forward to a
+# baseline of Python 3.9 or newer this code can all be dropped and
+# replaced with:
+#    from graphlib import TopologicalSorter, CycleError
+#
+# https://docs.python.org/3.9/library/graphlib.html#graphlib.TopologicalSorter
+#
+# We only implement the parts of TopologicalSorter we care about:
+#  ts = TopologicalSorter(graph=None)
+#    create the sorter. graph is a dictionary whose keys are
+#    nodes and whose values are lists of the predecessors of that node.
+#    (That is, if graph contains "A" -> ["B", "C"] then we must output
+#    B and C before A.)
+#  ts.static_order()
+#    returns a list of all the nodes in sorted order, or raises CycleError
+#  CycleError
+#    exception raised if there are cycles in the graph. The second
+#    element in the args attribute is a list of nodes which form a
+#    cycle; the first and last element are the same, eg [a, b, c, a]
+#    (Our implementation doesn't give the order correctly.)
+#
+# For our purposes we can assume that the data set is always small
+# (typically 10 nodes or less, actual links in the graph very rare),
+# so we don't need to worry about efficiency of implementation.
+#
+# The core of this implementation is from
+# https://code.activestate.com/recipes/578272-topological-sort/
+# (but updated to Python 3), and is under the MIT license.
+
+class CycleError(ValueError):
+    """Subclass of ValueError raised if cycles exist in the graph"""
+    pass
+
+class TopologicalSorter:
+    """Topologically sort a graph"""
+    def __init__(self, graph=None):
+        self.graph = graph
+
+    def static_order(self):
+        # We do the sort right here, unlike the stdlib version
+        from functools import reduce
+        data = {}
+        r = []
+
+        if not self.graph:
+            return []
+
+        # This code wants the values in the dict to be specifically sets
+        for k, v in self.graph.items():
+            data[k] = set(v)
+
+        # Find all items that don't depend on anything.
+        extra_items_in_deps = (reduce(set.union, data.values())
+                               - set(data.keys()))
+        # Add empty dependencies where needed
+        data.update({item:{} for item in extra_items_in_deps})
+        while True:
+            ordered = set(item for item, dep in data.items() if not dep)
+            if not ordered:
+                break
+            r.extend(ordered)
+            data = {item: (dep - ordered)
+                    for item, dep in data.items()
+                        if item not in ordered}
+        if data:
+            # This doesn't give as nice results as the stdlib, which
+            # gives you the cycle by listing the nodes in order. Here
+            # we only know the nodes in the cycle but not their order.
+            raise CycleError(f'nodes are in a cycle', list(data.keys()))
+
+        return r
+# end TopologicalSorter
+
 def error_with_file(file, lineno, *args):
     """Print an error message from file:line and args and exit."""
     global output_file
-- 
2.34.1


