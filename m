Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7D7ADEEC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHj-0001Lb-H8; Mon, 25 Sep 2023 14:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHh-0001LD-HV
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHf-0007Mk-N3
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so53076925e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666374; x=1696271174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJNgA7i1skSBgo3G8Dhw1FER8/CjFW3btNuWKszZ4Dk=;
 b=OSgd85bmOEeWLoXk/HO0JzbXEG0AYgLYB3JPtD/298awgqViDu37wqinIuYYwb4tZD
 8+tfofqUdUNP3ILz8N3azt0Y/dY7HrfZZViD/bTfK8gxZwI8Erp9+QIM66S7BcleprrZ
 StASK9/Y8uLFCktklwL1Jbi5SIqu7ZO/quF+P4iF0ycGkp5ol1c5zBLncUrRNJUodoJn
 +mqGg1r0ohxrhCyxQWFJE1I6lb7nWwB3FUjUPGWC23rcl7GbPkamown1iO0oy25Yhu+j
 78RECYBqLWNJ9/HEdtKR6X+ERZBvjyRLJT59PJIzsogAVlWObMzu1vQ89nQpZmqPEzrj
 onkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666374; x=1696271174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJNgA7i1skSBgo3G8Dhw1FER8/CjFW3btNuWKszZ4Dk=;
 b=OfqgmAk9bVCFIABVIw3mO5E9xkDmcZFduw67V2YGf9zCbUz1MyF6fzdLexU11HByI2
 /vnWo3DxJ0nG/DsQt5AVTzsip4YICKALg0CgSYrB2vxadXiyepGaJX+zZ90GDMFQozyp
 sLsBnO/b29sRCTitRnjaD4HmljopYZQAVaz0UpJrSm5D9LgNwlxGOtpV7UOyDqM5zeHO
 hoSqtnPviNpC13Is8L6vy6keFDoJX9fVL5Jn4j7zOEEDJQthtCid9t6BBpbqfj2T2sgO
 H3/jFIxJ/wiJQWHKivFiBo0q5lTN4N+aX9SIevmCzhWHJZg4UqyGJc0unxT9Zvi5qa/w
 zA6A==
X-Gm-Message-State: AOJu0Yyy+EzZ042GoVrY58hEWwnFgabTT5kbx0TZu4zgvreHOT8sFEZj
 hkdOJhtThV5ygaSshC42oyZ+K97dlB4=
X-Google-Smtp-Source: AGHT+IHWZxOa+zHBS/8XVL4w7naQ5mPZJCobQAsOM5Q/LYQPT/bK2AdpueYsmIdCloQqshAuL3AL0w==
X-Received: by 2002:a7b:cc81:0:b0:3fe:687a:abb8 with SMTP id
 p1-20020a7bcc81000000b003fe687aabb8mr5938086wma.7.1695666373989; 
 Mon, 25 Sep 2023 11:26:13 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:13 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 18/28] bsd-user: Implement getpriority(2) and
 setpriority(2).
Date: Mon, 25 Sep 2023 21:24:15 +0300
Message-ID: <20230925182425.3163-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 2c1a9ae22f..9a8912361f 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -390,4 +390,28 @@ static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
     return -TARGET_ENOSYS;
 }
 
+/* getpriority(2) */
+static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)
+{
+    abi_long ret;
+    /*
+     * Note that negative values are valid for getpriority, so we must
+     * differentiate based on errno settings.
+     */
+    errno = 0;
+    ret = getpriority(which, who);
+    if (ret == -1 && errno != 0) {
+        return -host_to_target_errno(errno);
+    }
+
+    return ret;
+}
+
+/* setpriority(2) */
+static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
+                                          abi_long prio)
+{
+    return get_errno(setpriority(which, who, prio));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 1a760b1380..71a2657dd0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -359,6 +359,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_getpriority: /* getpriority(2) */
+        ret = do_bsd_getpriority(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setpriority: /* setpriority(2) */
+        ret = do_bsd_setpriority(arg1, arg2, arg3);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


