Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF7B7ADEC9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:31:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHe-0001JM-Fy; Mon, 25 Sep 2023 14:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHd-0001IW-7B
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHa-0007Kt-Ib
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so55319645e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666369; x=1696271169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQFZwC0LDHIWACO0/rcAxG3mL7h/9iuVdTmtYhQ4JHQ=;
 b=TblBe7Eb5Hlaeg1b2jEfJS+BbIr0XYYIfYZgo9gLYXsYSKTGnr907DDal9RNTfhWvU
 R1IiwInby3/Q8IE3QkZ9fx4kxltGdp+SE8bSQtit43qMHzrrJc2RCBGNkwoTx2fijmno
 HOQn1S/6Te706KFb5CquXOnj1or30uC7dBmt+tBqcv+St4hBCfUQ9uZ/670vWXGzklMT
 gq96ew2X5F7nnTNUm0RaQZR73JKA4Fr2mQiiBl8rlw3k+09t8seNxWEpapKz+9r6tVZY
 x9bAkcl5BV7YsD4AL8Lw1Vrp+WycWr/YXsJo0RFUjYxP16qXGMj8/uRMzeZlfFJkb12m
 GacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666369; x=1696271169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQFZwC0LDHIWACO0/rcAxG3mL7h/9iuVdTmtYhQ4JHQ=;
 b=wtK8djPEnb7ZPMW3u7C02noNBIee98yr74JnT2jjvJD4ZfvOohJhdLU13QLFnqtQbl
 ISanbxwR9nfOxjTaZFRPUAae9DPLDcMkKRa0RSjHOZZ7TloCB0rsdeGEiRt+dJgI3qoK
 zoP9385qIGnFr7rHXhSk3mNC+mKu6viNaor5YJDXioHN9AmP51fdag1lxneYSdRpfKnp
 +xrR745+KcTeKc6xW1in/0eRLke/6dVNq9S/v+CeIxaiAM/rq6XKZfLbdQp3JVTs/KAm
 t/ftj9BIxMOeHWqrU4z1VcgW33/ckMPd8mW/cf0dD9Z/uAac8Wd6kM0BSSO9uIgVN3fp
 bXTA==
X-Gm-Message-State: AOJu0YypWth66vwA7VVGKnlNN2eOS4SZt1deSyUTti8EsLH9mJXMZ9cJ
 v4Bv4W3tOye7FAcuFY5Hn6+8j2P0E8Y=
X-Google-Smtp-Source: AGHT+IH8wG8BWytw0VdBSk+SCDdZfFsKuSoHvetMch+K2Fa6rMj1IvOH9dg6SYnzRTvgRLP/x5uBoQ==
X-Received: by 2002:a05:600c:22ca:b0:401:b0f2:88d3 with SMTP id
 10-20020a05600c22ca00b00401b0f288d3mr323974wmg.19.1695666368851; 
 Mon, 25 Sep 2023 11:26:08 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:08 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 14/28] bsd-user: Implement getrlimit(2) and setrlimit(2)
Date: Mon, 25 Sep 2023 21:24:11 +0300
Message-ID: <20230925182425.3163-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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


