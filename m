Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E325D7B9AD7
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMT-00018A-7U; Thu, 05 Oct 2023 00:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGMG-0008HT-CY
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGMB-0007j3-H4
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:08 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3231d67aff2so597333f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481582; x=1697086382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgccYr5Dzt6X/tQjLL34w8Nky+uqW63WT4BtHcxYfTM=;
 b=tsxn5RgDjtR6zceeCoAmcBhCDjUrazsPWwYSnxUJDH2TWA8tkl/JjhkWHYOJ0cErJa
 mRpr4TY9K/a2SBzNSxh66IuoeLksFZ0cdM1zGEIvTo93CPM1kqf1yeduNUtWctmf8v8o
 b0LSJKGNSRuEyYT/PJE4cSj92gt1a9Dzv3lM05j+Z4rUPdHXjwqhe+d3YQJbQBP0DjfN
 s7LBELDhD5X/i+Wsdt93Hf/4Fbdx6tC07+oZjDU3Wx83RXgMpDJ/mwmAtKSKCIlLtM7k
 cXzxA6Dg+fp6XnRreBLJgJ7m4iWyT6DESZy+9epmTwNiGTZlka7MwJCKsMzT4i4TRfNM
 xdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481582; x=1697086382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgccYr5Dzt6X/tQjLL34w8Nky+uqW63WT4BtHcxYfTM=;
 b=qRSporsZD8AcaEu1uH0I5SBgaN+IGlHNJceQW9u9zRRyIydfQPqLY91PE93a9J56h9
 sYIL10AmTQ9VgLUxRevTmoqdLyKsEMsaugtXHdYH+96DQcKDKOzku7acdedGt3fCtEJ7
 +xKgErpWVlQIC6uESFpdmexPtWnA+EAb/9nq0ydAgEXLJb/W9uBN3VuX5Yk/EVAY6TuX
 m9Qm93OaTBJgqULIbL2h5kmnQwpjPTNv7dG7/FmMJut7z2JWWO/JzJbt9Bw87jF2gA0j
 r3+aWj1IiBYEbWMgw316/mXUEaglMnpn2eWyj34k1v7CevS9J51NO5PZPSaT1vfr9Co8
 ArFQ==
X-Gm-Message-State: AOJu0Yw36AMNyt/kCkA1EfocnLsVtiv+dc2Ow/d4gExUR+cLjz8I8ruW
 JXtS6r+zTpBm/kmCwO157iuCWG0rShY9lniuxOo=
X-Google-Smtp-Source: AGHT+IH5owR7jtNWIR28prtHirmKxSt97VWYY+bfUUCWMagUHxEKNIB8HUGhruBcqogA56OKhngf0w==
X-Received: by 2002:a5d:4144:0:b0:31a:d4e4:4f63 with SMTP id
 c4-20020a5d4144000000b0031ad4e44f63mr3618344wrq.18.1696481581749; 
 Wed, 04 Oct 2023 21:53:01 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 g4-20020adff404000000b0031c52e81490sm750030wro.72.2023.10.04.21.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [RFC PATCH v2 21/22] qapi: Inline and remove QERR_UNSUPPORTED
 definition
Date: Thu,  5 Oct 2023 06:50:38 +0200
Message-ID: <20231005045041.52649-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using:

  $ sed -i -e 's/QERR_UNSUPPORTED/"this feature or command is not currently supported"/' \
    $(git grep -wl QERR_UNSUPPORTED)

then manually removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Not sure what is the best way to change the comment
     in qga/qapi-schema.json...
---
 qga/qapi-schema.json      |  5 +++--
 include/qapi/qmp/qerror.h |  3 ---
 qga/commands-bsd.c        |  8 +++----
 qga/commands-posix.c      | 46 +++++++++++++++++++--------------------
 qga/commands-win32.c      | 22 +++++++++----------
 5 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b720dd4379..51683f4dc2 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -6,8 +6,9 @@
 #
 # "unsupported" is a higher-level error than the errors that
 # individual commands might document.  The caller should always be
-# prepared to receive QERR_UNSUPPORTED, even if the given command
-# doesn't specify it, or doesn't document any failure mode at all.
+# prepared to receive the "this feature or command is not currently supported"
+# message, even if the given command doesn't specify it, or doesn't document
+# any failure mode at all.
 ##
 
 ##
diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 840831cc6a..7606f4525d 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,7 +17,4 @@
  * add new ones!
  */
 
-#define QERR_UNSUPPORTED \
-    "this feature or command is not currently supported"
-
 #endif /* QERROR_H */
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 17bddda1cf..11536f148f 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -152,25 +152,25 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
 
 GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 #endif /* CONFIG_FSFREEZE */
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..f510add366 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -165,7 +165,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
     }
 
     if (!hwclock_available) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "this feature or command is not currently supported");
         return;
     }
 
@@ -1540,7 +1540,7 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
 
 GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
@@ -2235,7 +2235,7 @@ void qmp_guest_set_user_password(const char *username,
                                  bool crypted,
                                  Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 }
 #endif /* __linux__ || __FreeBSD__ */
 
@@ -2751,47 +2751,47 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
 
 void qmp_guest_suspend_disk(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 }
 
 void qmp_guest_suspend_ram(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 }
 
 void qmp_guest_suspend_hybrid(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 }
 
 GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return -1;
 }
 
 GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestMemoryBlockResponseList *
 qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
@@ -3056,7 +3056,7 @@ error:
 
 GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
@@ -3066,20 +3066,20 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 
 GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 
     return 0;
 }
 
 int64_t qmp_guest_fsfreeze_freeze(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 
     return 0;
 }
@@ -3088,33 +3088,33 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
                                        strList *mountpoints,
                                        Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 
     return 0;
 }
 
 int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 
     return 0;
 }
 
 GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
@@ -3124,7 +3124,7 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
 GuestFilesystemTrimResponse *
 qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 #endif
@@ -3243,7 +3243,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
 
 GuestUserList *qmp_guest_get_users(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
@@ -3386,7 +3386,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
 GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 
     return NULL;
 }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index aa8c9770d4..5c9f8e0923 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1213,7 +1213,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
 GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
 {
     if (!vss_initialized()) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "this feature or command is not currently supported");
         return 0;
     }
 
@@ -1241,7 +1241,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     Error *local_err = NULL;
 
     if (!vss_initialized()) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "this feature or command is not currently supported");
         return 0;
     }
 
@@ -1276,7 +1276,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     int i;
 
     if (!vss_initialized()) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "this feature or command is not currently supported");
         return 0;
     }
 
@@ -1509,7 +1509,7 @@ out:
 
 void qmp_guest_suspend_hybrid(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
 }
 
 static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
@@ -1877,7 +1877,7 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
 
 int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return -1;
 }
 
@@ -1938,7 +1938,7 @@ void qmp_guest_set_user_password(const char *username,
     GError *gerr = NULL;
 
     if (crypted) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "this feature or command is not currently supported");
         return;
     }
 
@@ -1983,20 +1983,20 @@ done:
 
 GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestMemoryBlockResponseList *
 qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
@@ -2522,12 +2522,12 @@ char *qga_get_host_name(Error **errp)
 
 GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
 
 GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
 {
-    error_setg(errp, QERR_UNSUPPORTED);
+    error_setg(errp, "this feature or command is not currently supported");
     return NULL;
 }
-- 
2.41.0


