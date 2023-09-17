Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5687A3DEF
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUb-0004Zr-EB; Sun, 17 Sep 2023 17:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUY-0004Yp-VL
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUX-0004Gk-Aw
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-404573e6c8fso38787615e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986784; x=1695591584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLdkkdZEPKyUic0lLlf7pM01ehziiit06d6Q+F/iamk=;
 b=nbjkct6wbbQQW/iWaqYyKuMnq0H7oapVV9sRLDxBG/ZXi4RV5EtsWuHANWzmcuJnle
 4FdDzTblWJQH0YSD/DAIBYIwBOn2wgygl3pzQ1I6JB85RGkJiUz+qkooIaZ4wCXWPWu+
 5tnM+q3W1cUbktLgUkWzyUmQW6J+kF2DduT1K61wNYVsifMZrujo8TsYwBNq796Vrc+q
 jqHzagn8/QGTm08IfJDV3VSshEMlUSp5l4Yv2G7GimOgKK1FZ+GjLgMdJLs8EZnTSETX
 tHokPEGTGmY6iDu2Ik14EwyQs+PB+/DL4xry923AzdEgml0TgEYvUicCDqHCJlURTW3f
 qn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986784; x=1695591584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLdkkdZEPKyUic0lLlf7pM01ehziiit06d6Q+F/iamk=;
 b=UYxydIs0W8ndzfLqLmw0MaEjkV8ZIWQtchKiV5IjIlpnz7ocnfPr3/wzlDYE4m5iea
 h21Tw+qs4hUbHjeoScF6jmENiKIvJsiFKDgUQMWIJNmfvkzmqumy2awkX+2tWrlWsmOY
 CKIx1VaTlOD+4/sjIwOccs2N/f9veIS4tELCiGwxjzhfj9zAej7fuRlhVyf/OF9QFnNq
 fLm1CjKjoyF02MsmR1ku0Y6XwHDBv97yEc6iQU+LUXVVAWK5MjrILnbc8bQzGN+9Tj7W
 rvxcAtvK3HCwiWFeMaM37olHkBwYDknHShYCFRYfuYOen2sIe+LP+nPM+p4DA5cfCjnR
 ORiA==
X-Gm-Message-State: AOJu0YwGAHtRd7ckqs7Cb6SOAndEJb75wbPEJZTqUsqNHRUw4tFB9AKs
 nYdISaI2Gmx88YicW9CkT6d1hnoOH+s=
X-Google-Smtp-Source: AGHT+IGUMDUCa7PeT5dI1b91fYj7Y8yXNuFqyyd20CfXJVEDWR5GElXrlyjRIfF03xMs7N7rGB2T1g==
X-Received: by 2002:a05:6000:184e:b0:321:5211:8e20 with SMTP id
 c14-20020a056000184e00b0032152118e20mr855780wri.59.1694986783775; 
 Sun, 17 Sep 2023 14:39:43 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 14/28] bsd-user: Implement getrlimit(2) and setrlimit(2)
Date: Mon, 18 Sep 2023 00:37:49 +0300
Message-ID: <20230917213803.20683-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
---
 bsd-user/bsd-proc.h           | 59 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 +++++
 2 files changed, 67 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 57fea173c2..06b5b9e03c 100644
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


