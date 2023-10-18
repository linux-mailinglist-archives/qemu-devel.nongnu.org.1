Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE557CEC23
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:34:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0s-0003g8-VE; Wed, 18 Oct 2023 19:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0r-0003W1-55
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0o-0000Fl-Ks
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bb4abb8100so3867458b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671897; x=1698276697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1I5j+CVAtN1UYbE5YS09fVUfZ8qAm7sA0ML6lgTI9YE=;
 b=w3uxCWr+FAeDbgM3yAWT+aejaZA8XRR7mCNEedAyu1+8LFLVrfDXwhSLoHVOAMiwO6
 KNnWcKl4rNgSSazKdctDoar/OQ9WI+YFT+DQ2Tu2rh7TQcucrt/B5pt/FmBq86br+eOe
 MFYzhhMwLei2KGlOMnKlaz0bBqvB44RZLpt6A6fLpfsQAJ6d/FRPbbJLJLTR9IZNl86H
 jcsw9RhuiDrApjaYCqRU9pHa/D6crvoP2a3IYabRGAWTSykjj3REzVaU3eNxwX4L75Z2
 5dwhW3sQZekELF2V3FolReYDJM0SbfNixBMjXWaasrXh/MsMdCnQO+oKw9558vpjdqDe
 wXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671897; x=1698276697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1I5j+CVAtN1UYbE5YS09fVUfZ8qAm7sA0ML6lgTI9YE=;
 b=HljuvF88Qy8CaSVAchtdZm4JDWmGTVWZHvbYt0Z4NoVnS9kvY85AUJOP75L8Hqt05s
 arQRq+IUEW0vRJY8g6NfZGvDog3OThG2Rdu2f3cNOLSJNxGa2V41gsN0WjCwFQyKsrru
 0ezZ1Zw9yE7eDYTUEXqrggvi+YTe++r4UpD1SocZQ0n8It5nE1kbzThVJUITjwljY7LZ
 JsANNKno18TzhMdgMilSiKHxEVZgbdHlYVP+5z3+PSi7e9qIY2OgMSKQ/UlbK/m32d/F
 BviBOzB60jNwp+Gbe+ZI5xfvsMImuYzo2WBmNQ15/LVB3FnWP944fd4OVhLl3YnbZRFl
 1xTg==
X-Gm-Message-State: AOJu0YxR5QRX9Zp3V0iBhf4iQI1z5TqjzZ3O1QEQba+Hh7E9aDqiDS/A
 G480kjHLfYY+UYuZlURT4frq7GDG9FWwn7V87bk=
X-Google-Smtp-Source: AGHT+IHXiLjylmN8G6bxSVj06uKRlBovtK8IuWHWxvv5A6Zj3AUmyvtjIa8Zsxgv12YL16XFO2t1qg==
X-Received: by 2002:a05:6a00:1354:b0:692:6d3f:485b with SMTP id
 k20-20020a056a00135400b006926d3f485bmr641843pfu.3.1697671897116; 
 Wed, 18 Oct 2023 16:31:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	qemu-stable@nongnu.org
Subject: [PULL 02/14] linux-user/mips: fix abort on integer overflow
Date: Wed, 18 Oct 2023 16:31:22 -0700
Message-Id: <20231018233134.1594292-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mikulas Patocka <mpatocka@redhat.com>

QEMU mips userspace emulation crashes with "qemu: unhandled CPU exception
0x15 - aborting" when one of the integer arithmetic instructions detects
an overflow.

This patch fixes it so that it delivers SIGFPE with FPE_INTOVF instead.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Message-Id: <3ef979a8-3ee1-eb2d-71f7-d788ff88dd11@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/cpu_loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 8735e58bad..990b03e727 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -180,7 +180,9 @@ done_syscall:
             }
             force_sig_fault(TARGET_SIGFPE, si_code, env->active_tc.PC);
             break;
-
+	case EXCP_OVERFLOW:
+            force_sig_fault(TARGET_SIGFPE, TARGET_FPE_INTOVF, env->active_tc.PC);
+            break;
         /* The code below was inspired by the MIPS Linux kernel trap
          * handling code in arch/mips/kernel/traps.c.
          */
-- 
2.34.1


