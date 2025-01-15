Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC16A128CC
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 17:36:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6N2-0007WA-KW; Wed, 15 Jan 2025 11:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7322ae3fcc6f32da564c+7815+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tY6Mz-0007UY-P2; Wed, 15 Jan 2025 11:35:54 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7322ae3fcc6f32da564c+7815+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tY6Mx-0001eX-FK; Wed, 15 Jan 2025 11:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=j2gaDkDHKbVHS9ffxI7464SULQ6IWC/ZhoSg1yVGsXA=; b=PeIQDQ2Os1lTg7OqknjIA7QozH
 r95h74GMusKTSGt5oYuE2CJm7MFHLsNnioMi5oraYSOUyq2eiNWLidPTDZPa06ES/C3TpOrK2P6H0
 cMJj25O2dCrELtMJGXa/49tD/ukdrqsn6ntY7FPX11zBM82g4cFYj+7k5yhHbYvjqvCBCu8cv2dTN
 QDh77Wr1fACIYff6jDWxXVqAiQ0ggtVbtTTppfk8JqUbibrB2RxwMJS7f/1cYpULjjelQyRG4mSBt
 TwBg3LhhWI1eN1HgeXj/o0hY84N+Ply2TwazP6gH5e5Uyv4X0vIOEMruvEIe8mgM2vx1La6qFTCKX
 tUPDR49A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tY6Mr-0000000Atae-15pM; Wed, 15 Jan 2025 16:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tY6Mp-00000001Hhg-3xaR; Wed, 15 Jan 2025 16:35:43 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Subject: [PATCH v3 3/7] hw/xen: Use xs_node_read() from xs_node_vscanf()
Date: Wed, 15 Jan 2025 16:27:21 +0000
Message-ID: <20250115163542.291424-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115163542.291424-1-dwmw2@infradead.org>
References: <20250115163542.291424-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+7322ae3fcc6f32da564c+7815+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Reduce some duplication.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
 hw/xen/trace-events     |  1 -
 hw/xen/xen-bus-helper.c | 15 ++++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 461dee7b23..b67942d07b 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -38,7 +38,6 @@ xen_device_remove_watch(const char *type, char *name, const char *node, const ch
 xs_node_create(const char *node) "%s"
 xs_node_destroy(const char *node) "%s"
 xs_node_vprintf(char *path, char *value) "%s %s"
-xs_node_vscanf(char *path, char *value) "%s %s"
 xs_node_read(const char *path, const char *value) "%s %s"
 xs_node_watch(char *path) "%s"
 xs_node_unwatch(char *path) "%s"
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index 22fd2f6c1a..288fad422b 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -105,25 +105,22 @@ int xs_node_vscanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
                    const char *node, const char *key, Error **errp,
                    const char *fmt, va_list ap)
 {
-    char *path, *value;
+    char *value;
     int rc;
 
-    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
-        g_strdup(key);
-    value = qemu_xen_xs_read(h, tid, path, NULL);
-
-    trace_xs_node_vscanf(path, value);
+    if (node && strlen(node) != 0) {
+        value = xs_node_read(h, tid, NULL, errp, "%s/%s", node, key);
+    } else {
+        value = xs_node_read(h, tid, NULL, errp, "%s", key);
+    }
 
     if (value) {
         rc = vsscanf(value, fmt, ap);
     } else {
-        error_setg_errno(errp, errno, "failed to read from '%s'",
-                         path);
         rc = EOF;
     }
 
     free(value);
-    g_free(path);
 
     return rc;
 }
-- 
2.47.0


