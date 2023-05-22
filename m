Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EF70BC4D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1445-0005H1-Gi; Mon, 22 May 2023 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1434-00054q-T2
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q142y-0007Mq-Th
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:49:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae852a5330so19558455ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684756191; x=1687348191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mAGcH5e8/Df3po5mgqSd+bFIdk4+MUX6wGZwUaFC68Q=;
 b=CmOh7Ij8xo1QPmwuAOtRgkwdeI0hCgkWW5EYxcSpQK2shEwiVQbWKnn8Ha08Sd1+06
 fpKeHbXTHZ+D7riPOKPr3PnRFdy7paZPbrQe7rg1vR+4YYVCQa2LedyTeoqQqJAc2Rtx
 6znnFJ3Hi0vz6YRmLxb2iMIf40xcovECAG7PZG+5TLqvSqLI4BG6XdIa1Q1BAouGGMV7
 Sc5wrbkaW/WFt5byhdjrnXcYnM3eGDN69TwFnMSBBTfCfo1ymlIDjwjyPDQfQyQiXQh7
 5Tq0o9WYE0L+lrISF49PAmPsMEBgvsPe/h93Gt7Yy6MEvPYWzWlJEw8vheHT1kc8wXYe
 kfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684756191; x=1687348191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAGcH5e8/Df3po5mgqSd+bFIdk4+MUX6wGZwUaFC68Q=;
 b=VABOYyyVAHGvg5licaCN3FAGeGv70QX+7xjyxcvkkv7dDoZGSHD5YqoZAmNADcrfVd
 zDOp6ClOHCkmRCOGlyi9HVLeQOT/ZtsQ7o+6kkkb+C3nqNIQvFP2xyHO65RSnElhxuGB
 uLWeVpB5C7ZOafpV4ErMP+hHTDlcWnVy74bksOz3XZKHDgru2DzX4aMUEQiSIUUTxX8O
 JlrKWLqV2FAeq3fsNGWXLb3do+djzuk2SCcqqdJHXVE1EZySvp3hy7846yyFeZzf9l6t
 SyNW1IHDeM2wFtmCOwvV7bAJSDgwbE9jes9r++hD3AZoi7X/whxWfc+z+fW4b1uSQseL
 Muzg==
X-Gm-Message-State: AC+VfDzd6iXDqlCoqdvvD4kTo7HBaCrciu0wlKN8IdYApGiNiZo08ePc
 qXn3nlkvxJugCbkDpM47/Md31aeJdmQX3Hajpbw=
X-Google-Smtp-Source: ACHHUZ7AFIqM3cUjn+5YouKRcSC/tq9kgl8S3KuL0+Y49rfsIvOum8dBhW0qLAfVHfd2KxovQb62mQ==
X-Received: by 2002:a17:903:3317:b0:1ab:1a73:7c7f with SMTP id
 jk23-20020a170903331700b001ab1a737c7fmr9113619plb.63.1684756191001; 
 Mon, 22 May 2023 04:49:51 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a170902e80300b0019f3cc463absm4725922plg.0.2023.05.22.04.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 04:49:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] util/vfio-helpers: Use g_file_read_link()
Date: Mon, 22 May 2023 20:49:43 +0900
Message-Id: <20230522114943.33024-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
12.1.0, the compiler complains as follows:

In file included from /usr/include/features.h:490,
                 from /usr/include/bits/libc-header-start.h:33,
                 from /usr/include/stdint.h:26,
                 from /usr/lib/gcc/aarch64-unknown-linux-gnu/12.1.0/include/stdint.h:9,
                 from /home/alarm/q/var/qemu/include/qemu/osdep.h:94,
                 from ../util/vfio-helpers.c:13:
In function 'readlink',
    inlined from 'sysfs_find_group_file' at ../util/vfio-helpers.c:116:9,
    inlined from 'qemu_vfio_init_pci' at ../util/vfio-helpers.c:326:18,
    inlined from 'qemu_vfio_open_pci' at ../util/vfio-helpers.c:517:9:
/usr/include/bits/unistd.h:119:10: error: argument 2 is null but the corresponding size argument 3 value is 4095 [-Werror=nonnull]
  119 |   return __glibc_fortify (readlink, __len, sizeof (char),
      |          ^~~~~~~~~~~~~~~

This error implies the allocated buffer can be NULL. Use
g_file_read_link(), which allocates buffer automatically to avoid the
error.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/vfio-helpers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 2d8af38f88..e482ab22e2 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -106,15 +106,17 @@ struct QEMUVFIOState {
  */
 static char *sysfs_find_group_file(const char *device, Error **errp)
 {
+    g_autoptr(GError) gerr;
     char *sysfs_link;
     char *sysfs_group;
     char *p;
     char *path = NULL;
 
     sysfs_link = g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group", device);
-    sysfs_group = g_malloc0(PATH_MAX);
-    if (readlink(sysfs_link, sysfs_group, PATH_MAX - 1) == -1) {
-        error_setg_errno(errp, errno, "Failed to find iommu group sysfs path");
+    sysfs_group = g_file_read_link(sysfs_link, &gerr);
+    if (gerr) {
+        error_setg(errp, "Failed to find iommu group sysfs path: %s",
+                   gerr->message);
         goto out;
     }
     p = strrchr(sysfs_group, '/');
-- 
2.40.1


