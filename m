Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFF990879
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Oct 2024 18:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkn0-0001uF-6C; Fri, 04 Oct 2024 12:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmu-0001sS-LK; Fri, 04 Oct 2024 12:04:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmg-0001X0-PG; Fri, 04 Oct 2024 12:04:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1344E9556A;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4D67414D978;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282518 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/23] hw/xen: Remove deadcode
Date: Fri,  4 Oct 2024 19:03:13 +0300
Message-Id: <20241004160331.1282441-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

xen_be_copy_grant_refs is unused since 2019's
  19f87870ba ("xen: remove the legacy 'xen_disk' backend")

xen_config_dev_console is unused since 2018's
  6d7c06c213 ("Remove broken Xen PV domain builder")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/xen/xen-legacy-backend.c         | 18 ------------------
 hw/xen/xen_devconfig.c              |  8 --------
 include/hw/xen/xen-legacy-backend.h |  5 -----
 3 files changed, 31 deletions(-)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 5514184f9c..e8e1ee4f7d 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -147,24 +147,6 @@ void xen_be_unmap_grant_refs(struct XenLegacyDevice *xendev, void *ptr,
     }
 }
 
-int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
-                           bool to_domain,
-                           XenGrantCopySegment segs[],
-                           unsigned int nr_segs)
-{
-    int rc;
-
-    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
-
-    rc = qemu_xen_gnttab_grant_copy(xendev->gnttabdev, to_domain, xen_domid,
-                                    segs, nr_segs, NULL);
-    if (rc) {
-        xen_pv_printf(xendev, 0, "xengnttab_grant_copy failed: %s\n",
-                      strerror(-rc));
-    }
-    return rc;
-}
-
 /*
  * get xen backend device, allocate a new one if it doesn't exist.
  */
diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
index 2150869f60..45ae134b84 100644
--- a/hw/xen/xen_devconfig.c
+++ b/hw/xen/xen_devconfig.c
@@ -66,11 +66,3 @@ int xen_config_dev_vkbd(int vdev)
     xen_config_dev_dirs("vkbd", "vkbd", vdev, fe, be, sizeof(fe));
     return xen_config_dev_all(fe, be);
 }
-
-int xen_config_dev_console(int vdev)
-{
-    char fe[256], be[256];
-
-    xen_config_dev_dirs("console", "console", vdev, fe, be, sizeof(fe));
-    return xen_config_dev_all(fe, be);
-}
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 943732b8d1..e198b120c5 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -50,10 +50,6 @@ void *xen_be_map_grant_refs(struct XenLegacyDevice *xendev, uint32_t *refs,
 void xen_be_unmap_grant_refs(struct XenLegacyDevice *xendev, void *ptr,
                              uint32_t *refs, unsigned int nr_refs);
 
-int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
-                           bool to_domain, XenGrantCopySegment segs[],
-                           unsigned int nr_segs);
-
 static inline void *xen_be_map_grant_ref(struct XenLegacyDevice *xendev,
                                          uint32_t ref, int prot)
 {
@@ -70,6 +66,5 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
 void xen_config_cleanup(void);
 int xen_config_dev_vfb(int vdev, const char *type);
 int xen_config_dev_vkbd(int vdev);
-int xen_config_dev_console(int vdev);
 
 #endif /* HW_XEN_LEGACY_BACKEND_H */
-- 
2.39.5


