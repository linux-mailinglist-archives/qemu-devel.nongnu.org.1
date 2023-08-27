Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358ED78B921
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZK-0000kk-Rt; Mon, 28 Aug 2023 16:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZH-0000Rs-GP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:35 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZF-0007iu-0D
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:35 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso779333366b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253431; x=1693858231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mU1Nz0rgUrkX9WjeK377VjwdSgr6nNU4OZSDXdnTPY=;
 b=Wop8TLqACsZcMSGFkQXkz5mlJH+ROhzCEVNAMmWtTT97FaDjkYH69Okb4nLCfo1x/G
 1pV5MUvbhuQVrvQBp/MlQrf/Sgmwyp6Y+GR8h8GYFBUoN88j545+54v6UsFMuDLpP39L
 heMyEWGD9i8ta8bSREF9U39Zb/GlkkYXP5bT70wM2532P61oLMBnhEO+wANFGNvVIMTy
 BRBBzZdxpk+btDOeuLjxkIZDSqNJvMqAOYxNx2K0+RQJW4T9NlxA7jJO4xP3uEe8O6Po
 F5snKpDyS4jRUEEslszUPsV+T1q70lpyGJGgMxh9CHAwy02zkqVcH4xsUdj9nRTsLuk3
 y6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253431; x=1693858231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mU1Nz0rgUrkX9WjeK377VjwdSgr6nNU4OZSDXdnTPY=;
 b=evUAq0f5L0HR3owTEtXA86yJJfCBOZh87jXv0dlKKNG3qVpxEsgWFT3tGyhbX+6bf3
 K6zkCQOWBfKjPcEk8EIJePWXojISjXHsxJ1RJzc3V6lo7qHh+3kDzutggzTkd4P9TS2g
 wmZmotcIE8YW9Y0bS/8oE9/FQ8ka6/xmzFu+et4/9dNUUcJa5Cg+kz+hybPTk/xUrCqm
 lvjCrVmIAagpYIofbLaQUbKgEV05Cm5McAfkkcCU9xQv2i8RhXvUJdvmZObAArmFeGXP
 0YXnNIcBh49YrrEc6lYnhrVe5i1HRZAoExmYa6DVnkq7CJuebk0wwin4sPvdoFq3CgZV
 s6BQ==
X-Gm-Message-State: AOJu0YxQUFqjxpfO0VQvmHMNZMFv2FrgqpoCvKqBYKld0WKH9LvKV3/b
 rv7OZ1/iBU+bf8fTwbmaDKa3eYHUX65QyA==
X-Google-Smtp-Source: AGHT+IEqvOBv2TRfSd/G/cgPCruhNWsfD9tZxdYRCzzRWA70772RMQieQFHSjdqLbr4lcm7Zc520og==
X-Received: by 2002:a17:907:1614:b0:9a5:c2c0:1d0f with SMTP id
 hb20-20020a170907161400b009a5c2c01d0fmr595336ejc.12.1693253431325; 
 Mon, 28 Aug 2023 13:10:31 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 17/32] bsd-user: Implement get/set[resuid/resgid/sid] and
 issetugid.
Date: Sun, 27 Aug 2023 17:57:31 +0200
Message-Id: <20230827155746.84781-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 bsd-user/bsd-proc.h           | 76 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 28 +++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 98be0be2b9..5c072d75b7 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -286,4 +286,80 @@ static inline abi_long do_bsd_setregid(abi_long arg1, abi_long arg2)
     return get_errno(setregid(arg1, arg2));
 }
 
+/* setresgid(2) */
+static inline abi_long do_bsd_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
+{
+    return get_errno(setresgid(rgid, egid, sgid));
+}
+
+/* setresuid(2) */
+static inline abi_long do_bsd_setresuid(uid_t ruid, uid_t euid, uid_t suid)
+{
+    return get_errno(setresuid(ruid, euid, suid));
+}
+
+/* getresuid(2) */
+static inline abi_long do_bsd_getresuid(abi_ulong arg1, abi_ulong arg2,
+        abi_ulong arg3)
+{
+    abi_long ret;
+    uid_t ruid, euid, suid;
+
+    ret = get_errno(getresuid(&ruid, &euid, &suid));
+    if (is_error(ret)) {
+            return ret;
+    }
+    if (put_user_s32(ruid, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(euid, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(suid, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+/* getresgid(2) */
+static inline abi_long do_bsd_getresgid(abi_ulong arg1, abi_ulong arg2,
+                                        abi_ulong arg3)
+{
+    abi_long ret;
+    uid_t ruid, euid, suid;
+
+    ret = get_errno(getresgid(&ruid, &euid, &suid));
+    if (is_error(ret)) {
+            return ret;
+    }
+    if (put_user_s32(ruid, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(euid, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(suid, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+/* getsid(2) */
+static inline abi_long do_bsd_getsid(abi_long arg1)
+{
+    return get_errno(getsid(arg1));
+}
+
+/* setsid(2) */
+static inline abi_long do_bsd_setsid(void)
+{
+    return get_errno(setsid());
+}
+
+/* issetugid(2) */
+static inline abi_long do_bsd_issetugid(void)
+{
+    return get_errno(issetugid());
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index af3aff778d..bbfd260fe0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -312,6 +312,34 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setregid(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getresuid: /* getresuid(2) */
+        ret = do_bsd_getresuid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getresgid: /* getresgid(2) */
+        ret = do_bsd_getresgid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_setresuid: /* setresuid(2) */
+        ret = do_bsd_setresuid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_setresgid: /* setresgid(2) */
+        ret = do_bsd_setresgid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsid: /* getsid(2) */
+        ret = do_bsd_getsid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setsid: /* setsid(2) */
+        ret = do_bsd_setsid();
+        break;
+
+    case TARGET_FREEBSD_NR_issetugid: /* issetugid(2) */
+        ret = do_bsd_issetugid();
+        break;
+
 
         /*
          * File system calls.
-- 
2.40.0


