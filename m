Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B31127A0F3E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAv-0003Rb-55; Thu, 14 Sep 2023 16:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAo-0003Km-UO
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAl-0006Nu-GO
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so1317696f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724165; x=1695328965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZeOll8BQ09ocoWniNo5vad8KtAP6sMIVNw1ThVgqlQ=;
 b=Mct7NGQi4+OXQBGOnJSAvh0H4Q7Avq6a/PlwxUH5upnoETwmlRI5hns+cmtVrjbtzl
 13ecnE1ZMylAk0o9IFca84oQBfM6VQJZE7HFGmyyE+vm/UiT0/T4lb3xjgeJfcbz6SZv
 QZvCshdVyWTpO8lT/UtXDkKhK5yrKLFETvdjZiD/JoGtJIn5aoCIXj6JGNv9gJSC34yd
 2pHhH4hgZM8l/+E0GVUfFvbGyp+IamnMy8WAzo5GMtnnnZMHgu8VP159fII/b7sTbtKc
 zl11S+L8qwREsOXYRR94Aswm6jY6p4ppTpiCnmbxDdMWGpkLz3+vkE8y6eiyBMTI2bSy
 dxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724165; x=1695328965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZeOll8BQ09ocoWniNo5vad8KtAP6sMIVNw1ThVgqlQ=;
 b=PwrB0+tA6Tl+o9ccpuYbXbiI/LRT5P08tMNlBDMNOa5VPa5rwbxFBqVXYU19AMo2n2
 PSK3cAkD5u7MOyBbYA04M+oJ5QeH7+fNo305ylGCkPC85ZZDHeCdmJl34h3AQYv4APLX
 1O4glgwug7oInjobUR+vlzpj9Ud4rlUVm4E8pyXSD18jhslkZPvR6W8ZCDHyE0dbw4tW
 A4E5gYU06IkQHWHGF0klQIJj/hRmtnmYKVipuabLmn99eReqefWliNTWt24PASdJz5Rz
 1UQ/RVgvUNPhLc+c1Sn+7L0j5IiF9wix/5PW9WMrjv7N/WM81IdVRJXja2GUOEqdA6qK
 s4vw==
X-Gm-Message-State: AOJu0Yx4uaEA5RXSR4WVmNcR0jUh8VTNZKOaPUa/JLN6QsCBNsXPknu7
 J7snPd16j5P2BoLgNDz4Z2Cd97ipK2M=
X-Google-Smtp-Source: AGHT+IFaj+4TkrNrhipQidXKeODron/993PKARDJTC1KBkYQRKn+I5gooRh5hCwik8wd6Tdil3LKdQ==
X-Received: by 2002:a5d:42ca:0:b0:31f:b6eb:2a9f with SMTP id
 t10-20020a5d42ca000000b0031fb6eb2a9fmr6189379wrr.7.1694724165496; 
 Thu, 14 Sep 2023 13:42:45 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 13/23] bsd-user: Implement mprotect(2)
Date: Thu, 14 Sep 2023 23:40:57 +0300
Message-ID: <20230914204107.23778-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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
index 893881c179..74c0624637 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -603,6 +603,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


