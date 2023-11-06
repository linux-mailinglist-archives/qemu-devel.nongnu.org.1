Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 403127E2782
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:48:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jP-0005En-LR; Mon, 06 Nov 2023 09:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jI-0004Sw-Pp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:28 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jG-0000sE-4w
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTG532bz4xkN;
 Tue,  7 Nov 2023 01:37:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTD0CQlz4xkL;
 Tue,  7 Nov 2023 01:37:19 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yanghang Liu <yanghliu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/22] range: Introduce range_inverse_array()
Date: Mon,  6 Nov 2023 15:36:39 +0100
Message-ID: <20231106143653.302391-9-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

This helper reverses a list of regions within a [low, high]
span, turning original regions into holes and original
holes into actual regions, covering the whole UINT64_MAX span.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/qemu/range.h |  8 +++++++
 util/range.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index aa671da143cf82470658311599ac473c837b8102..205e1da76dc5b29327f590b8293a826ced63c25d 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -225,4 +225,12 @@ int range_compare(Range *a, Range *b);
 
 GList *range_list_insert(GList *list, Range *data);
 
+/*
+ * Inverse an array of sorted ranges over the [low, high] span, ie.
+ * original ranges becomes holes in the newly allocated inv_ranges
+ */
+void range_inverse_array(GList *in_ranges,
+                         GList **out_ranges,
+                         uint64_t low, uint64_t high);
+
 #endif
diff --git a/util/range.c b/util/range.c
index 782cb8b21c77867864a0da1b31a3638f465d1ae6..9605ccfcbed9749dc8c2a665a037300c97981d28 100644
--- a/util/range.c
+++ b/util/range.c
@@ -66,3 +66,58 @@ GList *range_list_insert(GList *list, Range *data)
 
     return list;
 }
+
+static inline
+GList *append_new_range(GList *list, uint64_t lob, uint64_t upb)
+{
+    Range *new = g_new0(Range, 1);
+
+    range_set_bounds(new, lob, upb);
+    return g_list_append(list, new);
+}
+
+
+void range_inverse_array(GList *in, GList **rev,
+                         uint64_t low, uint64_t high)
+{
+    Range *r, *rn;
+    GList *l = in, *out = *rev;
+
+    for (l = in; l && range_upb(l->data) < low; l = l->next) {
+        continue;
+    }
+
+    if (!l) {
+        out = append_new_range(out, low, high);
+        goto exit;
+    }
+    r = (Range *)l->data;
+
+    /* first range lob is greater than min, insert a first range */
+    if (range_lob(r) > low) {
+        out = append_new_range(out, low, MIN(range_lob(r) - 1, high));
+    }
+
+    /* insert a range inbetween each original range until we reach high */
+    for (; l->next; l = l->next) {
+        r = (Range *)l->data;
+        rn = (Range *)l->next->data;
+        if (range_lob(r) >= high) {
+            goto exit;
+        }
+        if (range_compare(r, rn)) {
+            out = append_new_range(out, range_upb(r) + 1,
+                                   MIN(range_lob(rn) - 1, high));
+        }
+    }
+
+    /* last range */
+    r = (Range *)l->data;
+
+    /* last range upb is less than max, insert a last range */
+    if (range_upb(r) <  high) {
+        out = append_new_range(out, range_upb(r) + 1, high);
+    }
+exit:
+    *rev = out;
+}
-- 
2.41.0


