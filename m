Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591A765351
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOzdy-0002Kb-Vz; Thu, 27 Jul 2023 07:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qOzdw-0002K8-Sx; Thu, 27 Jul 2023 07:58:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qOzdv-000115-C7; Thu, 27 Jul 2023 07:58:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbd03cb7c1so5206805ad.3; 
 Thu, 27 Jul 2023 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690459133; x=1691063933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iJy56iIC6ntBFdpPInsAvAbRshuAe050haSS25yPZEY=;
 b=K0IkK2QAAtZ7KRsQmg1++8LpQmW4QJ0bk5LEbv4HmVqDqtuFwMlxdKN2doQjvhdKvw
 sgcqONYHszxF+s2io0TFcCJ3MKXlI2JyEVOt5iitP6oGXTSNfJiZrVztXYHXNLyxR3rJ
 pwDn2Y4vLBpHCCXUHnrUWMDylvyNLNVCf/DaV9cJW4sZLEOx3G2NUMhkC6zATm6Wiy6U
 vkXVy8iZEHtnIoCupEPeqypJnyFZc4CHrraQcH2jgtgq30kl70Gu/oSbIVZ1n8tb4qq3
 rgd23kotGXGp/n/Qrv9VzaX/0UHZU2vOq0WxP6zdo5w9hue5K7Q3v8i+0kHdLIs/7yoh
 dpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690459133; x=1691063933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJy56iIC6ntBFdpPInsAvAbRshuAe050haSS25yPZEY=;
 b=gRpk+CElBQ2vNdhRphiz99vWAwhgDb2l8TRPecMbJ2W/JBBqwdu3V/0kWb8SSOAWjv
 xJlB0nmyffDEsoib/33MUiyY0T7v2EAhCfycF3/wUyghTJmX3+vXrpzUxVXSZdOwE6x9
 yfAf3mF/+aTVB8r2muXAdAC8VDvbr8ej1qo/KNTBRlHH3/317efZ9g0WFlTHyanMYret
 2zq5GAWJt5c1lM/M2gZfc73hkCT3fy45GbU1fVHE+aSanKTzmdvh13Ub9vLnOVDAOlxe
 wWojcGFxAVj3T/oyAWYthNERx3LAfSnwrQ4R//2Pt3h5+UXvUQPxfCijCW6QIhzMkSf4
 jyhw==
X-Gm-Message-State: ABy/qLaAV3SYURkZbUeQHKHqbqYYqA2Pskp8trrda4NW758748j0TXww
 HI2HjsvR+K7e3msYO/Ov65BHIAo0fXt3NnwM7gI=
X-Google-Smtp-Source: APBJJlHmlPJLvqdHJDPJq5ZqVXsUQ+FV8N8WvvUnq1ZbgyMAdsIQiW519qHWbWcM9xX19jyZoK2fRQ==
X-Received: by 2002:a17:902:bcc9:b0:1b1:7362:9a18 with SMTP id
 o9-20020a170902bcc900b001b173629a18mr3668706pls.27.1690459132652; 
 Thu, 27 Jul 2023 04:58:52 -0700 (PDT)
Received: from fedlinux.. ([106.84.129.156]) by smtp.gmail.com with ESMTPSA id
 g8-20020a1709029f8800b001a80ad9c599sm1422857plq.294.2023.07.27.04.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 04:58:51 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, stefanha@redhat.com, mjrosato@linux.ibm.com,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2] block/file-posix: fix g_file_get_contents return path
Date: Thu, 27 Jul 2023 19:58:44 +0800
Message-Id: <20230727115844.8480-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62e.google.com
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9e8e3d8ca5..b16e9c21a1 100644
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


