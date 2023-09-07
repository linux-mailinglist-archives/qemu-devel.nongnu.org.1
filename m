Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823A79964B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfd-00015c-EC; Sat, 09 Sep 2023 00:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfP-00012M-Nh
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfN-0002xM-Fe
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so2623679f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234031; x=1694838831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31oTqmQfxy5Vixb6rYMspPtmbe4ijKJWcWRToEaaBS4=;
 b=FNbvQqFwZ6H//H7x76ry1/5Soumk8+U5FgKnz/8fs9oTNL74mus+uC1TPmh80JqrlE
 fcepVsNFUZnDAUgG1B91q5domz9jvB5ojIHWdcN+VtSWU+C1E/UPkHMAQBnSuOz35eov
 j3HZxW83ulLXphGg8fCPj7LIcAFb8IyORI1P2X5xHrAI2eISZSSkt4Ppuvq3f12XIXUo
 DcBXoWydbBlIeGNgusiKQKKY78moBkD4SGtdxDaNmzkaGhybcat9J8uckMVKZd5zzCp6
 03Fn6OQdLQ/lXvNKKM98DNVeW569f4XrLdD14dzc3vwjB37i6r7EVzF0UdumjAbGE5ii
 szMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234031; x=1694838831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31oTqmQfxy5Vixb6rYMspPtmbe4ijKJWcWRToEaaBS4=;
 b=dPmD2sQRILjQ+6emCBcLPseUt93QsrhjsQE1H6AFUwqh6GvJDk6QfSqweB54PGLHey
 c93/vHVdjS5MJ1VF3TFbdqKgoYoyTk923nS9MgRX5rz686eIYuJ107MNIklBcauzcfPO
 OvRxshYdGQulifrshzvPcpQK0iz9IxXWxX8IydQDk5J2KUWGQveziYlDiuSZpTlKEXs9
 uvd6JTaFQTtKV21l9YUYzrYKjqAwl3vSWsz9/1p1hl0CcvUnMR05fxTSbG4krzpyNEig
 S1BR/t4QjRFYqMsZ/mAAlUcYB4tB55eUNzLArjWx4vo3NVtIjhFeCb0Vg7bd4VuFJgJt
 8CgA==
X-Gm-Message-State: AOJu0YyOQhe1Yr+073B7pt3x5xhnwX+mWqJ89AgD6+hLRC8+l5klmhvI
 btwCbCk5JSiJH6AjBZvge8/wPKedLLU=
X-Google-Smtp-Source: AGHT+IHvlS0rqz8GceEoGA4gmcsGiQuMTXdA5Ou/7t5LoS0uP0nIcf54Kg5ItS9ttSr8AkoAF7rivA==
X-Received: by 2002:a5d:4086:0:b0:313:f4e2:901d with SMTP id
 o6-20020a5d4086000000b00313f4e2901dmr3062427wrp.22.1694234031023; 
 Fri, 08 Sep 2023 21:33:51 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 14/23] bsd-user: Implement msync(2)
Date: Thu,  7 Sep 2023 09:42:53 +0200
Message-ID: <20230907074302.79234-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 11 +++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0f9e4a1d4b..5e885823a7 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -88,4 +88,15 @@ static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
     return get_errno(target_mprotect(arg1, arg2, arg3));
 }
 
+/* msync(2) */
+static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
+{
+    if (!guest_range_valid_untagged(addr, len)) {
+        /* It seems odd, but POSIX wants this to be ENOMEM */
+        return -TARGET_ENOMEM;
+    }
+
+    return get_errno(msync(g2h_untagged(addr), len, flags));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 127805e079..859492dee7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -499,6 +499,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mprotect(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_msync: /* msync(2) */
+        ret = do_bsd_msync(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


