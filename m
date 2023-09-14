Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D87A0EC1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZu-0003L4-A6; Thu, 14 Sep 2023 16:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZr-0003IF-5l
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZk-0001ZY-Th
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-404314388ceso12641145e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721863; x=1695326663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7MM4o6hfnwu6xJY7wrfXa5mcuCNPXgDVYr5wwCNE3Q=;
 b=GktrhpuC1mqlXRKP1vzjhrdna9AinjmWUys41pQoNcHAEu85ck5ms1XnM5UDjIucsw
 htyeVMLpsCiNkqj9tRAnwbxCrR+HdbP5q0bnrz2DbGfjvT7/8nvf/eSguMxVK9XCCXOS
 7w+pqQEo5p4exODu/gVW79bMHlNFYan/BpWOUmzAxYQRK/WxZMn+vG+JZYDl8fGAslY9
 NI6tM2LVqQ11Tqaysa20SUtnSTQ7EEHllzD+Ggd9rOBFKQwn0CHattvZhGRbe+ORMpdP
 3CMrTqDxevuT/5zuk+iLUoBQMvf5XnC0Jh97Gb34HpnafXBC4ZdHUEBRiBdtSocYc2sD
 UqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721863; x=1695326663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7MM4o6hfnwu6xJY7wrfXa5mcuCNPXgDVYr5wwCNE3Q=;
 b=EUpKjHqlaoVU0mSt9nBXY9KDuKjIttUmgly5QNZg2wdk3PruqTeP3hm4J379K74lba
 SVmX0hfkBD2vSZKz24000Egqv5rh7t1GMHh8gz5AecC4/5r+X7DSYd7LLLeh7URzedwX
 V9f9bdwtnzUgnUcplW5lI3rX3qXLWxcc51D8jNV1biockwg++OZsuUV8rd3OurCvXwLg
 D9g9FaBPEm9Ai1pEkuNyxO0rGWYfirXPqfbVEFDXxSzo4lz1tzOZxKWijzGFkhl5kQWR
 hNoiwXva4P/6k1omsCN8g1/so+FQ7CD9xoKY0px4PS6IRCJjcL1Iopob90j0Ggew40Mj
 erzQ==
X-Gm-Message-State: AOJu0YzcDnHZ6nMPOq3DiFo2oARwcT09faf7ieRLo8bBaV+vmeG1Z3V0
 FQHDilt1QUC2XUi5MO4AI17Q/NzWj0A=
X-Google-Smtp-Source: AGHT+IFw6wfzhuq/mFxS/l0mrfK0Ic7xNu2OXHxrELdgSAbPaQETHuL1xj9mbmos1Hd+bcNrLbDvKQ==
X-Received: by 2002:a7b:ca52:0:b0:401:38dc:8917 with SMTP id
 m18-20020a7bca52000000b0040138dc8917mr5666940wml.6.1694721863325; 
 Thu, 14 Sep 2023 13:04:23 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:23 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 13/23] bsd-user: Implement mprotect(2)
Date: Thu, 14 Sep 2023 23:02:32 +0300
Message-ID: <20230914200242.20148-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 7 +++++++
 bsd-user/freebsd/os-syscall.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 76b504f70c..0f9e4a1d4b 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -81,4 +81,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
     return get_errno(target_munmap(arg1, arg2));
 }
 
+/* mprotect(2) */
+static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index d88f62319b..127805e079 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munmap(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */
+        ret = do_bsd_mprotect(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


