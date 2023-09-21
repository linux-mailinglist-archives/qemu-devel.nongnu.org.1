Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4767A934B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGIu-0006J5-AP; Thu, 21 Sep 2023 05:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjGIs-0006HG-Ad
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:48:58 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjGIq-0007vZ-CF
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:48:58 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-274c05edb69so437409a91.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695289735; x=1695894535;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tn8H0vVmPUbEDqXNIBkZym5IGh9o5sFw2NwUy0uYhGA=;
 b=BONPqY1mjUC2KefGzwPUVBICcOmqBQoFZ/Avn6MakIiBAPFzQFBDM8UjCAS2UiaPD4
 h6mUenzzzNDPEKn52+82My+6JNyW0Dybree6RDsdVbYDlwyqykA48c7d22PIPsSstIKc
 +KzudHLccM3l/MMiXldfvP+np1joGs9SxNxoTZEuhQ/B5Txb9OH+EgTHxIA6o+sdVwIO
 zNKzxcGm5Ni6WQbKBtbqc4fsAb8N4BYTPRHVi+RXMg61AaS722j/5EieQaZk0dzux2cY
 LKyHouG5bbAthQnd651j3yr+G0PDSwB84itLQssL1ec6EQmwsj7EQUwDTXWAWnWTDwhr
 HL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695289735; x=1695894535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tn8H0vVmPUbEDqXNIBkZym5IGh9o5sFw2NwUy0uYhGA=;
 b=qNpt/w9+quzQ90IwGz0TSUbk5X9kwbmrB/DH3ZQvq0rthmFukgYdGVKWyu5LGHz/4L
 RYSLRRjYxfKGMuxZI+S3DaG7fsXx4UbNYEu4LocNEINnmlQgaDqtON0uW4qc2ebN+xdo
 F1DKAmcsKYHRX1igwYf/mgPwc0ddcGLo7HBpjrXWv7qMTRO3h1VSQC+hyebL5LU24wYD
 swYLqYjKollxGsGjRNzkbZwCBB0LuQaZoulJpnMBcf1zPxdyClyoVKw6vdfV2AYlGba5
 GKfCRMZpd2EVIVFzH13ZJUsGIkejlt948u6csrQSZJBKWsR1qbRpsi9EqngSGriDe8vb
 TsqA==
X-Gm-Message-State: AOJu0Yzr5NAtVAJFfycM3XmnqRrp+fPubT/l0jk/6QnOKNLEH9uODygk
 Q1LX001Mi9L4KPReMlsATVWevQ==
X-Google-Smtp-Source: AGHT+IH48wj4AEiEW1IhNekVEAfhw2eWrEZ0Or30DnMSh//+LLWk2XTqXBOREmM7/OZcvV0gFE4LyQ==
X-Received: by 2002:a17:90b:1f88:b0:276:b37f:84e5 with SMTP id
 so8-20020a17090b1f8800b00276b37f84e5mr4782992pjb.21.1695289734906; 
 Thu, 21 Sep 2023 02:48:54 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902d38c00b001c32fd9e412sm1026138pld.58.2023.09.21.02.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 02:48:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Konstantin Kostiuk <konstantin@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2] Revert "tap: setting error appropriately when calling
 net_init_tap_one()"
Date: Thu, 21 Sep 2023 18:48:49 +0900
Message-ID: <20230921094851.36295-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

However, vhostforce is not meant to change the error handling. It was
once introduced as an option to commit 5430a28fe4 ("vhost: force vhost
off for non-MSI guests") to force enabling vhost for non-MSI guests,
which will have worse performance with vhost. It was deprecated with
commit 1e7398a140 ("vhost: enable vhost without without MSI-X") and
changed to behave identical with the vhost option for compatibility.

Worse, commit bf769f742c ("virtio: del net client if net_init_tap_one
failed") changed to delete the client when vhost fails even when the
failure only results in a warning. The leads to an assertion failure
for the -netdev command line option.

The reverted commit was intended to ensure that the vhost initialization
failure won't result in a corrupted netdev. This problem should have
been fixed by deleting netdev when the initialization fails instead of
ignoring the failure by converting it into a warning. Fortunately,
commit bf769f742c ("virtio: del net client if net_init_tap_one failed"),
mentioned earlier, implements this behavior.

Restore the correct semantics and fix the assertion failure for the
-netdev command line option by reverting the problematic commit.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V1 -> V2: Corrected the message.

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


