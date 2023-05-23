Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA370D174
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Hvq-00026p-As; Mon, 22 May 2023 22:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1Hvo-00026b-Im
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:39:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1Hvm-0002rg-GV
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:39:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae763f9c0bso36932055ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809560; x=1687401560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3++IJ2TYtdNeES0gUTOJS+aAXsabIYGpSxkbz5Q6KBE=;
 b=XYXMxIb0B0rk8KEJSoiQV22brkBv3iz7FACX3b0SIHSRKTZg02MPqiQfXfPgfDJehq
 6AI8TAt2c0ef5Y2m2bPNRwx5o+e79pexWrJuUh8KUi6yIIyMmJHu15HUIQxL/eiXAUf0
 jpLL1+deV2eGFgmOGuDi4Ct9LRvBRPN+JgiVUhuoMUTKCEOezDgGkOwB0o9rH7tGFiCw
 nL8eKiHWFvvP5wNyGGf90oBEclizH5yv5XgIPdsicT3NeIzDch2wFgSCC8fzQoXarJuH
 OVhu7O1xEmuaEDB8AdvSsj0lBI/dunCOIrcAQ6k6XEwYmHUbAyQtRzorour/uraQWwRK
 LqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809560; x=1687401560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3++IJ2TYtdNeES0gUTOJS+aAXsabIYGpSxkbz5Q6KBE=;
 b=jIoJFUP8yvvpRmzzRQL8rAJAXuo8LG/H9sLm1e+WUt7OoLuG6tgJSD9lqKtSk2Lgbq
 YT6nhgJZjuEG8M2SVSARJEfn0XqtZidEDwbATB2n+cE367cwy8RGd44Ax5IZ/msTOwp7
 qaCiVYjaW5SCfpaR6NYAtNxPij0IDCS0t8XJyE6mI+PfgL7qbj/m8BrhgPwZ49fA6k8Q
 uoilxSCoaBVGTr4hvjM7gdUIMtgjExpiW3+wsyjd5g3WsswsgDSDlakAvqC2fbqsLrSm
 /opQDekobHT+9x2bod30tQ6IH8FJJqD0VqZmRXjJKVmgeWiQwMDr2nhdurvAP477Srww
 jJEg==
X-Gm-Message-State: AC+VfDz41G6afAb5Q3g8RnOTrpLszupqfkAS8wdjoNBTrjPK51af+y2t
 DR2usdVVGyFwT5jJ7Zt0SIh2/GdEa8Qi7fJ6gCQ=
X-Google-Smtp-Source: ACHHUZ55Z2MQXVw+mm1HlAJGkNsZ8ZhbErbwX+m+f3bBTEmwZCPqYc2YBNpRdo33EJTmFDDi6H+VUQ==
X-Received: by 2002:a17:903:1206:b0:1ab:74c:bdf2 with SMTP id
 l6-20020a170903120600b001ab074cbdf2mr17510182plh.28.1684809560511; 
 Mon, 22 May 2023 19:39:20 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001a63ba28052sm5495624plk.69.2023.05.22.19.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:39:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] util/vfio-helpers: Use g_file_read_link()
Date: Tue, 23 May 2023 11:39:12 +0900
Message-Id: <20230523023912.50123-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
V1 -> V2: Initialize gerr variable.

 util/vfio-helpers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 2d8af38f88..f8bab46c68 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -106,15 +106,17 @@ struct QEMUVFIOState {
  */
 static char *sysfs_find_group_file(const char *device, Error **errp)
 {
+    g_autoptr(GError) gerr = NULL;
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


