Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A357ADEA1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHf-0001JU-2H; Mon, 25 Sep 2023 14:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHa-0001Ho-Vk
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHZ-0007KW-8q
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40594697600so19231655e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666367; x=1696271167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wP1rfp1dDRIiBnhp1KylL3inypQKBVqgIftLFJMUFhc=;
 b=Zmpb0krVNvykN+WskEtOwc4q+ZgckbUbKcsp1ZmrRnU+EooeVlVg179EeRJz7hlR/W
 twsBkKHFjvUe0MiR4666oOXgPbQ+i3mw6YeWnddMxssmxA2o8lWq/Yx/v1PI52Feawxl
 o9pt0IJh/LmQ7W56Mb4dmpJijG0KtROAxVshLMJ02ZCpcDCW6afYJW9IQWbs89I/7+3l
 D2PCO2PNeOuAASVOzuGVqetziTQiDBJud8OQxt49XEe/2cwJOw7YbP9TEnfkViYqBJNL
 z2fsPA8OjsNYXXHCFJYyzWWzezM96QrHfmpE2XSg58OEh6fM2IXdRp8ZAzV+lj8OHjKS
 8HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666367; x=1696271167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wP1rfp1dDRIiBnhp1KylL3inypQKBVqgIftLFJMUFhc=;
 b=pj4maorfqohMnmz/p6rF1kLTp4cUqo4mTi1ueXBZQ3YN8Osmwttkp3tqwFew1WeGsL
 +7Axv1+GD+nxi5nfKB8eju05Lvxvpumo7gR0PlTx09omS+ZwWnpZ4S5TDsmRqpWqFAcb
 bgzl4dP48Fq0r89mrCx5tDbI23YxCGnDVnOJX09ImIXXkox9DY85RCLWHWTiG96gRjr+
 5HawZBPaqJNSgb7tksVYPSwM6ebYvm5SKgJGjY2yrO2rq7zV7kvP+qcCsSU4w6Xlq0Zp
 sXRpRBrTkd8Zb5K9X7DP84UQGVkDAIG0QkB54j7xOM1k4QZS5hro0FwsT1oD539e4Nxa
 P3/A==
X-Gm-Message-State: AOJu0YyNCxF8Ec8l4P0BbQK4PDsANlcfv9R0rwzCc+mGPTU9+DXHynzq
 oCYcubHi7jAMvZqmphBDQsLPPMNPJGE=
X-Google-Smtp-Source: AGHT+IGpC19Tvza5qVDKymvnXZZppwMc8rkDsXEf6ghoNNMDgjNwAXExgrZ55V5bgulE/SObCqMixA==
X-Received: by 2002:a7b:ce92:0:b0:405:39b4:314f with SMTP id
 q18-20020a7bce92000000b0040539b4314fmr7194402wmj.24.1695666367615; 
 Mon, 25 Sep 2023 11:26:07 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:07 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 13/28] bsd-user: Implement getrusage(2).
Date: Mon, 25 Sep 2023 21:24:10 +0300
Message-ID: <20230925182425.3163-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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
 bsd-user/bsd-proc.h           | 13 +++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index cb7c69acb0..133c1b0eaf 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -124,4 +124,17 @@ static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getrusage(2) */
+static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct rusage rusage;
+
+    ret = get_errno(getrusage(who, &rusage));
+    if (!is_error(ret)) {
+        host_to_target_rusage(target_addr, &rusage);
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 44cbf52f08..5d8693ed55 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -243,6 +243,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getlogin(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrusage: /* getrusage(2) */
+        ret = do_bsd_getrusage(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


