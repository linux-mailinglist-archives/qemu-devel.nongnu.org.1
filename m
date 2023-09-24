Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C317ACE5F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSv-0003S6-QG; Sun, 24 Sep 2023 22:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSs-0003L9-KN
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSr-00006n-0b
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32320381a07so1360656f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609407; x=1696214207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQFZwC0LDHIWACO0/rcAxG3mL7h/9iuVdTmtYhQ4JHQ=;
 b=WFw6ATCL7BnZ3qXGyHtqIz9TKbGM4xe4SJSM/yIAc6FEyV+n5vYJfM8hp4FhH5B7cw
 XxvRc8eI3qXnWCVOIyYNcQopAwzeLQI3dKVUMOjNPBUtD5x5OF9PTZ73QSz09K01qbAU
 Cx65k4jj4Tn/cokTYaczP6IgDu1L+aY8IIHNpdVCKaHbTI8ifpC7Q/3MYNHWAPjAp2+e
 TTWivwh2gLLtxhA76DMHuSdYXJjhvcXepN21NYXQKulwrpMvH9AUeU5SlN2EHcahuy8F
 1bIi8UigvceTSgm9BSDcYmotqkzmLkZGELRvp4V8zNVK7cSfJfhhABolxSV8jRfDbHlK
 ASiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609407; x=1696214207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQFZwC0LDHIWACO0/rcAxG3mL7h/9iuVdTmtYhQ4JHQ=;
 b=DGwVQgTjG+XPwFCRcAfqU9v+zPkTmpmV7LYNGf8gHabwezgClnHtISMhBR7WBWIIJ5
 xKjcXjyeNDwYUphwbugmashJA6W5C91Y69BLcQyU9lnPEEvyLckiOnpJf8QqXSLEZmJe
 ETU+XC4FNT9/uJ3STwStAS/Q0mf+VGLJEpv35wFoGs2DQP0sJj9YQLmIRECjr6hCKTjf
 GIHEN1BUoygm6KsWJHIoqv4thGPVH2leF7/M/PcyOmDAxA4dp7cILBCbZr1HpPYgSSmC
 VTZAAoQ9CsOwdKrc8+s9elhFTS5mx5599ysSsvvnT9f6ickc3VwjzakFxDYYVt3nnk6A
 WAtQ==
X-Gm-Message-State: AOJu0YynstFsF95ZosW0FY7yYdXg3HYowVHGFAVqlrUfchT2gwPaWWUe
 vkzsKA2acXEY9x8sl9QhK5cveOpcx7E=
X-Google-Smtp-Source: AGHT+IEh6ccs13jFQ+HD9VgKXLGdDaW+8A9OxvwxewF8YIhCB/UL1Ha4ZHsOyndKk8RFyHAfXHpJMQ==
X-Received: by 2002:a5d:6382:0:b0:319:8c35:378 with SMTP id
 p2-20020a5d6382000000b003198c350378mr4745285wru.44.1695609406939; 
 Sun, 24 Sep 2023 19:36:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:46 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 14/28] bsd-user: Implement getrlimit(2) and setrlimit(2)
Date: Mon, 25 Sep 2023 00:01:22 +0300
Message-ID: <20230924210136.11966-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 59 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 +++++
 2 files changed, 67 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 133c1b0eaf..38d1324034 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -137,4 +137,63 @@ static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
     return ret;
 }
 
+/* getrlimit(2) */
+static inline abi_long do_bsd_getrlimit(abi_long arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    switch (resource) {
+    case RLIMIT_STACK:
+        rlim.rlim_cur = target_dflssiz;
+        rlim.rlim_max = target_maxssiz;
+        ret = 0;
+        break;
+
+    case RLIMIT_DATA:
+        rlim.rlim_cur = target_dfldsiz;
+        rlim.rlim_max = target_maxdsiz;
+        ret = 0;
+        break;
+
+    default:
+        ret = get_errno(getrlimit(resource, &rlim));
+        break;
+    }
+    if (!is_error(ret)) {
+        if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
+        target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
+        unlock_user_struct(target_rlim, arg2, 1);
+    }
+    return ret;
+}
+
+/* setrlimit(2) */
+static inline abi_long do_bsd_setrlimit(abi_long arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    if (RLIMIT_STACK == resource) {
+        /* XXX We should, maybe, allow the stack size to shrink */
+        ret = -TARGET_EPERM;
+    } else {
+        if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
+        rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
+        unlock_user_struct(target_rlim, arg2, 0);
+        ret = get_errno(setrlimit(resource, &rlim));
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5d8693ed55..5cb6086230 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -247,6 +247,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getrusage(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrlimit: /* getrlimit(2) */
+        ret = do_bsd_getrlimit(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setrlimit: /* setrlimit(2) */
+        ret = do_bsd_setrlimit(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


