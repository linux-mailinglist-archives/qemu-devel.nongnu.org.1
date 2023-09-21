Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A97B7A932D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjG8Z-0000pR-8k; Thu, 21 Sep 2023 05:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjG8X-0000ow-8X
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:38:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjG8V-0005g6-Fe
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:38:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c572c9c852so5714165ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695289094; x=1695893894;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8J/ggde+3vzN/xoA7GuA4RHQpSs+bgnJJs2m4KMgiDI=;
 b=BSPTzHOS34+suGSGi0zqQio/QJGrDQnDcYeT+yw8zes/5yCRd8mcdzJMC+8sDEsDmE
 cxAUyONkItiBhW6KWBsfg8p8Y+GMTP5txq5XIwRcVNCNAU0MvAMZ0sqF0Vkay1Zza+Ng
 KFFOdKUSlZVTPvHNn+NL3UId6vohAjDNBxUBMzTlHwDkLtd+DTYiDwpze9/xuNQ+KeVh
 mWldUosR3wt+DEo9KoFMN1lx2gCDMWGNVP3sVqnC6xcxt4HjrG2tpmZRQCufo9Vf0rgY
 Jy3MwJhjRiGDVAuiVsHiT6kccrarkZ/2ivqZLyysPNeCJIsEw6v3P1pfzBr5Cv773QB/
 5QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695289094; x=1695893894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8J/ggde+3vzN/xoA7GuA4RHQpSs+bgnJJs2m4KMgiDI=;
 b=cSgI02fa5K9Pk/abFoOrfcZgQjCHG7eBurCyPiO1k++hbzAnHuw2xEm1WVkAWYNtqT
 +kKH9NSIYBUl4SSGAqiRM7YCpHotrAjOyOhZohQGvxyvqDW1MmY7BmzDML1PlMvNF0Zu
 thEp4D/OHnbO2vxeR2nFwP6JWGAu7nlOR/BHg9DeaNXB04ZT1871ng6zo3f+rA6h8qCy
 1nSOIX5r3hnIi0Q1IG4xTAyA7FrLbPSmZgy1ADaWdPLszo0u7kfBjNRmS4ar/DcYVbmP
 b4vaNUR0xSTvTGkG5trE0xq9Q2nzKtpDmABARhV5bOQW9pbbEI8RKq+2SSm2U/6hfII4
 0j9Q==
X-Gm-Message-State: AOJu0Yw3nqG0U3QNluE8/19FYrwF93l5bmuypq371NP9Yh9G7ZDOl6T4
 NeCmFVk75qXbpYSLaeaOAfWctA==
X-Google-Smtp-Source: AGHT+IFOZBY7qlrC/jmwaecyG/IwYsioG4booBVw7r962ohfs7vavvvmidYULqBlUk3GP+SR5FV9mg==
X-Received: by 2002:a17:902:728a:b0:1b8:7fd7:e022 with SMTP id
 d10-20020a170902728a00b001b87fd7e022mr3935130pll.28.1695289093950; 
 Thu, 21 Sep 2023 02:38:13 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170902e74700b001bf6ea340b3sm996693plf.116.2023.09.21.02.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 02:38:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Konstantin Kostiuk <konstantin@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] Revert "tap: setting error appropriately when calling
 net_init_tap_one()"
Date: Thu, 21 Sep 2023 18:37:59 +0900
Message-ID: <20230921093800.34723-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This reverts commit 46d4d36d0bf2b24b205f2f604f0905db80264eef.

The reverted commit changed to emit warnings instead of errors when
vhost is requested but vhost initialization fails if vhostforce option
is not set.

However, vhostforce is not meant to ignore vhost errors. It was once
introduced as an option to commit 5430a28fe4 ("vhost: force vhost off
for non-MSI guests") to force enabling vhost for non-MSI guests, which
will have worse performance with vhost. The option was deprecated with
commit 1e7398a140 ("vhost: enable vhost without without MSI-X") and
changed to behave identical with the vhost option for compatibility.

Worse, commit bf769f742c ("virtio: del net client if net_init_tap_one
failed") changed to delete the client when vhost fails even when the
failure only results in a warning. The leads to an assertion failure
for the -netdev command line option.

The reverted commit was intended to avoid that the vhost initialization
failure won't result in a corrupted netdev. This problem should have
been fixed by deleting netdev when the initialization fails instead of
ignoring the failure with an arbitrary option. Fortunately, commit
bf769f742c ("virtio: del net client if net_init_tap_one failed"),
mentioned earlier, implements this behavior.

Restore the correct semantics and fix the assertion failure for the
-netdev command line option by reverting the problematic commit.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/vhost_net.h |  3 ---
 net/tap.c               | 22 +++++-----------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index c37aba35e6..c6a5361a2a 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -4,9 +4,6 @@
 #include "net/net.h"
 #include "hw/virtio/vhost-backend.h"
 
-#define VHOST_NET_INIT_FAILED \
-    "vhost-net requested but could not be initialized"
-
 struct vhost_net;
 typedef struct vhost_net VHostNetState;
 
diff --git a/net/tap.c b/net/tap.c
index 1bf085d422..c6639d9f20 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -730,11 +730,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
             if (vhostfd == -1) {
-                if (tap->has_vhostforce && tap->vhostforce) {
-                    error_propagate(errp, err);
-                } else {
-                    warn_report_err(err);
-                }
+                error_propagate(errp, err);
                 goto failed;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
@@ -745,13 +741,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
-                if (tap->has_vhostforce && tap->vhostforce) {
-                    error_setg_errno(errp, errno,
-                                     "tap: open vhost char device failed");
-                } else {
-                    warn_report("tap: open vhost char device failed: %s",
-                                strerror(errno));
-                }
+                error_setg_errno(errp, errno,
+                                 "tap: open vhost char device failed");
                 goto failed;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
@@ -764,11 +755,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
-            if (tap->has_vhostforce && tap->vhostforce) {
-                error_setg(errp, VHOST_NET_INIT_FAILED);
-            } else {
-                warn_report(VHOST_NET_INIT_FAILED);
-            }
+            error_setg(errp,
+                       "vhost-net requested but could not be initialized");
             goto failed;
         }
     } else if (vhostfdname) {
-- 
2.42.0


