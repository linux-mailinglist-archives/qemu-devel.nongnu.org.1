Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1762C77A6DA
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBps-0008E0-BP; Sun, 13 Aug 2023 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpd-0008B4-J1
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpc-0000sj-0H
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so20155795e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935954; x=1692540754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTfbh54lTPCGxJdlrzh9SvxhO5f2kaYoIfXGlcT4LDc=;
 b=gC8WF4gNfaaQzBqiBaSffTA0xLX+ceG7GpfF3PKwgi0rEYADZfHRoUSUU6HER4PKBq
 tI3tdUw/JwneLdduSYn0p/k+W0zc36dr5KAhL09H/RW+htPMhHW2PrpBFbeeZu2hb0Xx
 VymKoKXf6Ud5AsYy3uVMG3YVhlrlj5sUdWPEsFQrMZhRj6scetctZDv/aL13bDYYaNCD
 zg4A+BFu253nkh/BVAsMZi8QkCUAwZfBUITzOhzzEf9Md+cJcXpzegmFOjLdck02BWHJ
 qUN4o+gkoaxnVTYCQ5sa5P1/aBlbBe3EvdoW1s7/V+nH2yyWIbfxTk5JpzW+2wLcik1P
 kboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935954; x=1692540754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTfbh54lTPCGxJdlrzh9SvxhO5f2kaYoIfXGlcT4LDc=;
 b=S/GYb9th4x84j1e+qdbo6OJqbI9cyIq/guz/YsZ0N38fF42umj6BfUFI0HxS3FYfTa
 xE01GBnjdSaGbsyqJYNHv+MgmCLs4MONM5UNyr+HKFEUUGZ+mnEjhQqkYQrShuHQadJ+
 SLiXcI8tTpjvzPxVlFV9lZhuVGyTI6V+SDUFl1nuQpB1QAhopURe7ost2fhf63EnDqqj
 q9LMi+5jZT5PejfrTlASK88RIBLyMJyClNovs+gIStim664ze/LCF6wFkvSQD1xs+ay9
 dxKI9l4NASN+iVJVrpHj3fI/WsfeVnDKfV7hp24HvaCFjy8De6JalXwy6WdPDSSKYH8S
 RU7Q==
X-Gm-Message-State: AOJu0Yyc1GTNmgc2kvGh6slsmammUAIhhpfMmmKPjRLuF13i8MEbOY5z
 tt4EKC846yrdjRN6t6kjiZ+VDHUuIdc=
X-Google-Smtp-Source: AGHT+IFC4ndF9W7mXu7sjNvhEXyxj9nu9ViSFWDQVQ+4/jBB6YqBr/seZoVYgv5olh4dtc8mzEg5HQ==
X-Received: by 2002:a05:600c:252:b0:3fc:6e8:d675 with SMTP id
 18-20020a05600c025200b003fc06e8d675mr5360771wmj.13.1691935954169; 
 Sun, 13 Aug 2023 07:12:34 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 21/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 05:10:02 +0200
Message-Id: <20230813031013.1743-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

Implement the following syscalls:
fcntl(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 7dc41cd0bf..5d9323c7d1 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -351,4 +351,78 @@ static inline abi_long do_freebsd_getdirentries(abi_long arg1,
     return ret;
 }
 
+/* fcntl(2) */
+static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
+        abi_ulong arg3)
+{
+    abi_long ret;
+    int host_cmd;
+    struct flock fl;
+    struct target_freebsd_flock *target_fl;
+
+    host_cmd = target_to_host_fcntl_cmd(arg2);
+    if (host_cmd < 0) {
+        return host_cmd;
+    }
+    switch (arg2) {
+    case TARGET_F_GETLK:
+        if (!lock_user_struct(VERIFY_READ, target_fl, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(fl.l_type, &target_fl->l_type);
+        __get_user(fl.l_whence, &target_fl->l_whence);
+        __get_user(fl.l_start, &target_fl->l_start);
+        __get_user(fl.l_len, &target_fl->l_len);
+        __get_user(fl.l_pid, &target_fl->l_pid);
+        __get_user(fl.l_sysid, &target_fl->l_sysid);
+        unlock_user_struct(target_fl, arg3, 0);
+        ret = get_errno(safe_fcntl(arg1, host_cmd, &fl));
+        if (!is_error(ret)) {
+            if (!lock_user_struct(VERIFY_WRITE, target_fl, arg3, 0)) {
+                return -TARGET_EFAULT;
+            }
+            __put_user(fl.l_type, &target_fl->l_type);
+            __put_user(fl.l_whence, &target_fl->l_whence);
+            __put_user(fl.l_start, &target_fl->l_start);
+            __put_user(fl.l_len, &target_fl->l_len);
+            __put_user(fl.l_pid, &target_fl->l_pid);
+            __put_user(fl.l_sysid, &target_fl->l_sysid);
+            unlock_user_struct(target_fl, arg3, 1);
+        }
+        break;
+
+    case TARGET_F_SETLK:
+    case TARGET_F_SETLKW:
+        if (!lock_user_struct(VERIFY_READ, target_fl, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(fl.l_type, &target_fl->l_type);
+        __get_user(fl.l_whence, &target_fl->l_whence);
+        __get_user(fl.l_start, &target_fl->l_start);
+        __get_user(fl.l_len, &target_fl->l_len);
+        __get_user(fl.l_pid, &target_fl->l_pid);
+        __get_user(fl.l_sysid, &target_fl->l_sysid);
+        unlock_user_struct(target_fl, arg3, 0);
+        ret = get_errno(safe_fcntl(arg1, host_cmd, &fl));
+        break;
+
+    case TARGET_F_DUPFD:
+    case TARGET_F_DUP2FD:
+    case TARGET_F_GETOWN:
+    case TARGET_F_SETOWN:
+    case TARGET_F_GETFD:
+    case TARGET_F_SETFD:
+    case TARGET_F_GETFL:
+    case TARGET_F_SETFL:
+    case TARGET_F_READAHEAD:
+    case TARGET_F_RDAHEAD:
+    case TARGET_F_ADD_SEALS:
+    case TARGET_F_GET_SEALS:
+    default:
+        ret = get_errno(safe_fcntl(arg1, host_cmd, arg3));
+        break;
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


