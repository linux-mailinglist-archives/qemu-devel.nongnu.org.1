Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 160907C80CA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqd-0000rp-LY; Fri, 13 Oct 2023 04:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqL-0008Ra-As
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqJ-00014s-No
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:25 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-505a62d24b9so2348584e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186901; x=1697791701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXUPd7o0c3iST05l+ZvpK0QVidzt33YIAW6ca/eFPH0=;
 b=Cr+CmK4+VmGev9zFzZ7XZCwX4vkLgjY2exGlwTGPC9MePjwfM750YEKBiBfzJpcvcq
 hDL5XOw2P10VPcfJE5k+YOQchiu9fEoarD0FXlUnVNrkOb98dMkcnrssc3RJ8xnCOp1R
 ZUW6yu2OvcU4z3U+q4SVjqov6CFOwL3OrrGJq5R2MGgs7SGCcskVNq94axgBy5EzOxh6
 ylbnRzqCl1SswbhsgIJC+g0IrxMaXqsnPTaLeKaqx624tAijYTRyz6RcJFkeJkyPHi+c
 9kg/v18cMGy29/t1XLe5vUM3jbiZ7PajEH24y8hffVO+Ut4NiKL7ZQRc5pZJXz5Zpcgj
 qDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186901; x=1697791701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXUPd7o0c3iST05l+ZvpK0QVidzt33YIAW6ca/eFPH0=;
 b=cMJx+4vh/3kkCqecrjnT3QS5JbX00pn2DSJHqBiaxR4zz2fO7HNkJwN5tHZ6Ow3B5W
 TAZCJlekQB9ZZswaC4qExzJPqwXBDUMBECIDpFpOY8p8OeSj3NmTfiaNy+DPpboEtv5R
 Wp4TyJbUBXDgxourXJsXJ7qmLb99ulAbnALY2sRid2B8gCEtqp/q4Uo/E+QaN4C8sjBi
 zVbn71aXGO1TRs5mKTaa7m8PJHmcSixl9r9tL89iXQLDUc8TIj1IpjVJBVOg086rrKVp
 7/QY5m2U4aL6Pgg+DudeQ5MlJMTKmhxRvStOUyqmX1u+xz1EexInRQnZ/5UwlgoZhxbc
 /INA==
X-Gm-Message-State: AOJu0Yy1OSUEm4Ee2I/vHv2C2xFg0jMoanbFXy2N3B3Ev/FaOi0WZOnW
 zhb0olJ7BaZYOrQ55fSmwqq6n057s7DVBCbhUSo=
X-Google-Smtp-Source: AGHT+IGM+JAdP+Ii/wb8zB1EH01Sh2VDwNyvFSfBKtMybnzotfz7TjxzSa/Z7kUBZdw9TfY5eDNOBw==
X-Received: by 2002:a05:6512:1594:b0:505:6c7e:9950 with SMTP id
 bp20-20020a056512159400b005056c7e9950mr23881890lfb.19.1697186901583; 
 Fri, 13 Oct 2023 01:48:21 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:21 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH v3 41/78] linux-user: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:09 +0300
Message-Id: <2f060afb69cd83ecd2c60a89f1947e8d871b6f89.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 linux-user/mips/cpu_loop.c | 8 ++++----
 linux-user/mmap.c          | 2 +-
 linux-user/syscall.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 8735e58bad..38ddcadfc6 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -102,22 +102,22 @@ void cpu_loop(CPUMIPSState *env)
                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 case 7:
                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 case 6:
                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 case 5:
                     if ((ret = get_user_ual(arg5, sp_reg + 16)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 default:
                     break;
                 }
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8ccaab7859..ff33b4ccf6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1012,7 +1012,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-        /* fall through */
+        fallthrough;
     case MADV_DONTNEED:
         if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
             ret = get_errno(madvise(g2h_untagged(start), len, advice));
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d49cd314a2..d15817846c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7782,7 +7782,7 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
     case FUTEX_CMP_REQUEUE:
     case FUTEX_CMP_REQUEUE_PI:
         val3 = tswap32(val3);
-        /* fall through */
+        fallthrough;
     case FUTEX_REQUEUE:
     case FUTEX_WAKE_OP:
         /*
-- 
2.39.2


