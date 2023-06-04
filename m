Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D95721519
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 08:19:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5h3L-0000y7-D2; Sun, 04 Jun 2023 02:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q5h3E-0000w6-8Q; Sun, 04 Jun 2023 02:17:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q5h3C-0000ZH-31; Sun, 04 Jun 2023 02:17:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b065154b79so36270035ad.1; 
 Sat, 03 Jun 2023 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685859431; x=1688451431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2v9+kHff9p72eWkN86zfAmMpPqm9MHRJ4QV1vQJlqoU=;
 b=VrD1R6N5c2EwwhlrWs4HYgiaVzsGw2xlrXd0DrZ6Ft5DL6nfUdWxSf7HcjeMzAiCg5
 K1SHt+NIDkWWyL2ahtpimgTlNSWJChYxV7RFNOM1+MEosN7FkBEn7t59hikQNYsQfjIv
 or2jlZzwFPLHiLdhS9QwchzGGjOjPfKh5V3EzCmNQYeirqEJdktJshQDstVrULTJ/gUx
 dLheCMGn8uKNOdN2bVIvhM1mcjOXkKA3sNAdBi1f0zMb/JvzA4MdXbHKUuqgq30p/Yt3
 o4QO26Ik25rd2fJLnpMIdCNzO4j9/O66dTuiJ3gIBSgJzC+LnMD042Tv5/GktEfzwjVj
 M94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685859431; x=1688451431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2v9+kHff9p72eWkN86zfAmMpPqm9MHRJ4QV1vQJlqoU=;
 b=Gao9cQFEdBYTosLSiMbG8p+vkRx0jF+1oVTobDxS6fM59iwUWmcTDTl+SJVf4Gv/0M
 jIAB2ajL3CAc55FGrxUTygjw5+lj12Ojv/6CSNz5QT+lU53Zxa6zxfiehrKjnrUrLHhz
 /B/I0a761hNIZ1o/RmR9wE+lP3w4DcQRN1zRixqMGnp1cDu61pUu5nMsiHT8Hjx+Kd7m
 Wk0KIukijEbX2eHQzzcrHOHmBKBgtiKGoOAnmjMMCtBJhoHmBbcaCH7dV5HRRdhnD4n6
 imzxHtXyWLz33B9c1dmbOf9FEn0Xb8+NeKXWVIvBeChzj+2C6MbVIpk8zINcFZhohup8
 mQOA==
X-Gm-Message-State: AC+VfDw8cMFPSy9X4WNrtCRFWpJM2UzTKgY+G3gdfh3GAipOaohgl2Vw
 r+/6C8j5SVsIYllhGO+LPJjtH3B9qMNtfAtn
X-Google-Smtp-Source: ACHHUZ6sHT+xUCHKshWPJ5mA9tXdvJO5fXwMaydJXU9zEI99N7yzfYIZrgtpQrflPhNErAnugczVJw==
X-Received: by 2002:a17:902:e881:b0:1b1:9069:db5f with SMTP id
 w1-20020a170902e88100b001b19069db5fmr5396044plg.18.1685859431083; 
 Sat, 03 Jun 2023 23:17:11 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.254]) by smtp.gmail.com with ESMTPSA id
 iw22-20020a170903045600b001afbc038492sm4075982plb.299.2023.06.03.23.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 23:17:10 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, stefanha@redhat.com,
 hare@suse.de, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 1/2] block/file-posix: fix g_file_get_contents return path
Date: Sun,  4 Jun 2023 14:16:57 +0800
Message-Id: <20230604061658.49004-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The g_file_get_contents() function returns a g_boolean. If it fails, the
returned value will be 0 instead of -1. Solve the issue by skipping
assigning ret value.

This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ac1ed54811..0d9d179a35 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1232,7 +1232,6 @@ static int hdev_get_max_hw_transfer(int fd, struct stat *st)
 static int get_sysfs_str_val(struct stat *st, const char *attribute,
                              char **val) {
     g_autofree char *sysfspath = NULL;
-    int ret;
     size_t len;
 
     if (!S_ISBLK(st->st_mode)) {
@@ -1242,8 +1241,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
     sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
                                 major(st->st_rdev), minor(st->st_rdev),
                                 attribute);
-    ret = g_file_get_contents(sysfspath, val, &len, NULL);
-    if (ret == -1) {
+    if (!g_file_get_contents(sysfspath, val, &len, NULL)) {
         return -ENOENT;
     }
 
@@ -1253,7 +1251,7 @@ static int get_sysfs_str_val(struct stat *st, const char *attribute,
     if (*(p + len - 1) == '\n') {
         *(p + len - 1) = '\0';
     }
-    return ret;
+    return 0;
 }
 #endif
 
-- 
2.40.1


