Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6FA128D0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 17:37:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6N4-0007Xa-GK; Wed, 15 Jan 2025 11:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tY6My-0007TE-5b; Wed, 15 Jan 2025 11:35:52 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tY6Mu-0001eB-RV; Wed, 15 Jan 2025 11:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=9nRlgfR/HkbXdsVZN1RJ5s3wIYDMgIRx7AVyt9JqyRI=; b=EyF73ntA9nNRs2USmFs3VhSFpr
 jNl690oAvAmfPoM3d9Lc2BGc1l1/s1/SeknFPeuJTpxrf1A7JrWVzvlQVDsOj8a+dRPFzbNaLKfAO
 j2WHAFN3Nr8xuSB9VGGQDHCWq5KJ/qkkMZ2jVCLwxPvkJkUdNMMJeg7knUUa+/YPzo2+VwEESoAFK
 dNaXDRzPMj19LMHea3hONYRgsJN3CMHRQBl2M0zn8N29N77J4yU9eQbTo/7OQhdX7ZE6KAFTAofUj
 XtLavELYf7LC08zgEem/hTcCPhKKoUEEmBaZ3rZkt0vw8s9Tz8tyDcbsrOICPyDnOxtVeDiDXWNhn
 dMfyec3g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tY6Mq-0000000GF6P-148j; Wed, 15 Jan 2025 16:35:44 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tY6Mq-00000001Hhn-00TQ; Wed, 15 Jan 2025 16:35:44 +0000
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
Subject: [PATCH v3 4/7] hw/xen: Use xs_node_read() from xen_console_get_name()
Date: Wed, 15 Jan 2025 16:27:22 +0000
Message-ID: <20250115163542.291424-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115163542.291424-1-dwmw2@infradead.org>
References: <20250115163542.291424-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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

Now that xs_node_read() can construct a node path, no need to open-code it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
 hw/char/xen_console.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index cb39b21504..e61902461b 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -367,28 +367,28 @@ static char *xen_console_get_name(XenDevice *xendev, Error **errp)
 
     if (con->dev == -1) {
         XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
-        char fe_path[XENSTORE_ABS_PATH_MAX + 1];
         int idx = (xen_mode == XEN_EMULATE) ? 0 : 1;
+        Error *local_err = NULL;
         char *value;
 
         /* Theoretically we could go up to INT_MAX here but that's overkill */
         while (idx < 100) {
             if (!idx) {
-                snprintf(fe_path, sizeof(fe_path),
-                         "/local/domain/%u/console", xendev->frontend_id);
+                value = xs_node_read(xenbus->xsh, XBT_NULL, NULL, &local_err,
+                                     "/local/domain/%u/console",
+                                     xendev->frontend_id);
             } else {
-                snprintf(fe_path, sizeof(fe_path),
-                         "/local/domain/%u/device/console/%u",
-                         xendev->frontend_id, idx);
+                value = xs_node_read(xenbus->xsh, XBT_NULL, NULL, &local_err,
+                                     "/local/domain/%u/device/console/%u",
+                                     xendev->frontend_id, idx);
             }
-            value = qemu_xen_xs_read(xenbus->xsh, XBT_NULL, fe_path, NULL);
             if (!value) {
                 if (errno == ENOENT) {
                     con->dev = idx;
+                    error_free(local_err);
                     goto found;
                 }
-                error_setg(errp, "cannot read %s: %s", fe_path,
-                           strerror(errno));
+                error_propagate(errp, local_err);
                 return NULL;
             }
             free(value);
-- 
2.47.0


