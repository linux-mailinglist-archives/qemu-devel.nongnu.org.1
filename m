Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288C70DBF2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1QlA-0002R9-1w; Tue, 23 May 2023 08:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql8-0002Ql-9T
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql2-0008Qj-F2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30948709b3cso4009486f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843491; x=1687435491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CP4iW2arzPiOFlsv2K+bA4KJE/pPkFARYRAohYFYWwc=;
 b=DfQW+/OP3KoNl5K+arAy3j2tf9Py0CE4MyMjxN8dBMdbvtyCN2DqZ7/1C2S9oZHsXN
 DxpB7md074AMUeF+2Jnq1a6K5q2wpc/qOjXuY1SiMcQGc0/ZPVKlZP7dnlT2rfw0KLfY
 B3ybDj2W3YHa0cSwZm02bTcZaxnERA8Y4/CNDHukibz//2esYkZsD0rIjccc+3GkcQy5
 qEtDEJD/Xhz9BzO7r5sUKd5HAXigQn1EfnWq/8GHbOxW1cHLsDJCkNYrBj3yPiloe8wF
 EaM7Qi7h98U7VB8NkhtfGiY8yCIrRuXRsbR+psX3XOp5pn+usc6zzHoODYIG9Axuj48u
 LbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843491; x=1687435491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CP4iW2arzPiOFlsv2K+bA4KJE/pPkFARYRAohYFYWwc=;
 b=OjeKUpsDQW3LGvSS2oxEU0g6kc9h+jUY3X/M7Irs+l3tubJuKnt01/evbiK5zNjLbx
 809nXLYoITCS+gwv7NUHwuDhj7co6mUCLROY9mGwRl/7FpywiBQkwkNYz05tVUyIV7Ka
 KAiMc5D+mc+QwzBMgXCyFb+b8iVJkSrD/CDEkvHIKVm5WBrZ1ksE8QYrLby8y9Mo3lHx
 f/M3gjApW9LFLa9NVLbwDutmyB8gMPwgF/HoFoKEIA2MB2BOJqr8bbAyo/C/rc77xprE
 Hzt29JeNrC2OgN5kc4kIwC4qxhhlE/A04kxH119GXyHpGeZTKYCJjB/crLfLNOCe6wqB
 kl3g==
X-Gm-Message-State: AC+VfDxKE3CKjjonz674GRcbMD+La9yn8qV5PCCYeYwovVFePaXkK+aV
 LZZSw8X4naLLO1rLh5KzDkhCEvBrP20hwJPzJYU=
X-Google-Smtp-Source: ACHHUZ7TyKoAx1cYmWUIvgrjoDKMGz28slyKgMp90/8uKsyRvSUHNzjudrtdB539W5FEjBAKkEuskA==
X-Received: by 2002:a5d:694e:0:b0:309:4227:6d1a with SMTP id
 r14-20020a5d694e000000b0030942276d1amr8761817wrw.70.1684843491185; 
 Tue, 23 May 2023 05:04:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/6] scripts/decodetree: Implement a topological sort
Date: Tue, 23 May 2023 13:04:45 +0100
Message-Id: <20230523120447.728365-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523120447.728365-1-peter.maydell@linaro.org>
References: <20230523120447.728365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
---
 scripts/decodetree.py | 74 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 33f4252b4ee..e1fd995eaab 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -53,6 +53,80 @@
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


