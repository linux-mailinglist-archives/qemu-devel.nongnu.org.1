Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F278189F
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZu-0008BU-9K; Sat, 19 Aug 2023 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZd-00080T-0c
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZZ-0004IQ-4V
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso1581299f8f.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438523; x=1693043323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V06ClJXz9CAp1niT/8dYkv4jhP0N6H1ZC3ac1dt4oc8=;
 b=ppg0AjKGaK9eDuJ8XyuZGG1HnVID9iRxhMrUh8Gcy0lMxSMkj8FXD3fH5zgeGVqkdD
 1YQYzwsZK5aceiiZl/hZUaxusWKlfgcqi+jXRVELBFbPf+MWvBYKE5yANB44NptLmnSG
 Ofbk2ZGz9r4saz++BI5Te/bLG/9NUWFnMIMmVLYI3OylmSkDAPJAEMOa2Ld2zrI3ekQ7
 JTJElWx0wM9BUqW1gfqeDVd1+Tdxc0IOempr7NB6GB2bUjAlArbsB5JzQYR0UTot0Nij
 dW174/Rkbf11OVDLvfN00CkHRVKYbhDLqyCzNCYoU0pwAlKZaciid/6vaBqxjj9pQPr9
 3TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438523; x=1693043323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V06ClJXz9CAp1niT/8dYkv4jhP0N6H1ZC3ac1dt4oc8=;
 b=YgMwJgaWEX2ugo0+86a/x8aD9cxAIXrmHVY7atpZuOr0XblFcY7fbl63YO/P+G3i9g
 j+5V4XS4717syHKFCyTmmnaE5TS78O9MPzCfhGyi1izvcrDxPf8edBBYMkGZ7gCnyn8V
 2jyJt4SaIpLXKu5cTm16MCa22hBX9lYyPQHu+eKfOZHzgCTav06+CY3F4EYFEdRNWWMU
 OItmRd8+jOw0O2RNhE3goLEYzNmxo5cKu+4bKkA/oewFgiOeA4BDzy46nJf3W6AI/BSt
 vWdG0JEh/bYan88KpFgYonjhK/GUKOt330t1ONKTt12G8WawI1kcBOdAE2eZji2ygCug
 mCyQ==
X-Gm-Message-State: AOJu0YyZS5JFoy73YeIQWwb0HXYL7LjfPBReYMz3VlSb2lSZmZyjhfXW
 t9nPwxQ/rX5uIRjqjayZeM6gEIc/sMQ=
X-Google-Smtp-Source: AGHT+IG7QMlesVo2FPcjS2RfQhIiDt+9iZEnkJEyBhqov6n+ass1iIqEZ5N7UJ53WCVCIYlLJJ/fDQ==
X-Received: by 2002:adf:f9c4:0:b0:317:6513:da7e with SMTP id
 w4-20020adff9c4000000b003176513da7emr1253363wrr.36.1692438523107; 
 Sat, 19 Aug 2023 02:48:43 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 06/22] Implement shm_rename(2) system call
Date: Sat, 19 Aug 2023 11:47:50 +0200
Message-Id: <20230819094806.14965-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x429.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 993e4598f9..3509ef026e 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -76,5 +76,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
 #undef SHM_PATH
 #endif /* __FreeBSD_version >= 1300048 */
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300049 */
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b4311db578..2920370ad2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
+        ret = do_freebsd_shm_rename(arg1, arg2, arg3);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


