Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D37981F7
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdr-00038O-Ig; Fri, 08 Sep 2023 02:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdk-0002ZJ-EM
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdh-0006NV-9S
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso13621325ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153202; x=1694758002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9QHVi3wOzOBTnchANYcU4Sl/KIRcnvifC0QwRT4WCQ=;
 b=n8iikH3MUxDnka35KkksUOHen2onJ+jMlPXLvgQy3Vghv98VpEnOHIrxazW9pljhvR
 OE8CL6P/5bwl0rkuk7lE7DUXANOjtz9TESKOlF6qmRFxEi5LrHGiK+XIIA1vw2el8U3M
 XZy6nqoyMrxcLCDbXDpNi5EPWmGI9sGmCKW7kY/8q/CJg1G8+Mzwa8Psm/PTC/mF/3zO
 cib8XKwt8xYy5/vnQRpu5N8zMjqF0+eFyE6ELp4wvF/QO7YglhMKcVNN8sQFBmTIuOP5
 6OJ6VhHrpARCe+m0R1jBzM4ZKDvupcUz9TIogchjkawcCfb+B2oNXf/58mdwaBR7ZlhA
 SGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153202; x=1694758002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9QHVi3wOzOBTnchANYcU4Sl/KIRcnvifC0QwRT4WCQ=;
 b=TLwzbmNw4N1LqXuy6yPPDgu0myCRop6YABqNqS2eqlek01MsKB2eLXDuAdB+ErqOZL
 gm25b/Y0IfmpI28pWyotthJab5pzmiT5xjRTNvI33T8RafCLbCWpU5E9BrAUJcDmbqT4
 vIBCN6wUihnq//AamF5UNTLCn1bH8SUmvJu6zpsIDtQgY6o9BPzwG2a2hCPzfKM3ouDd
 Xa0+I5Th2m8D6dmS9ZdVhUY+nBFDeSbleQYqwSUzCwX2C1BmG5HXtZ1msiSRJubreYS/
 k14YC1g8KiPmolezCZRiwvKdeTyQLOjsRA3fURCub9w15Me1ErudWcaknhUHtCoYxrQB
 J3ig==
X-Gm-Message-State: AOJu0YwpfNRer4gEBmmxlirzQHfTZBevJGx8rghs+xv3A6CRxCliuesD
 VWvxcDAMCAT72WwuJN2yg8KP2R7+90w6o1w6
X-Google-Smtp-Source: AGHT+IHkJ9p1LIaZ/5Wee7giomJGnmbK1xtFrIJ2neqEWrvqg9guOsGAb2hDBNmRD2MDTD50tHUS+w==
X-Received: by 2002:a17:902:c1c4:b0:1bc:2c79:c6b5 with SMTP id
 c4-20020a170902c1c400b001bc2c79c6b5mr1396100plc.4.1694153202129; 
 Thu, 07 Sep 2023 23:06:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/65] linux-user/riscv: Use abi type for target_ucontext
Date: Fri,  8 Sep 2023 16:03:54 +1000
Message-ID: <20230908060431.1903919-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

We should not use types dependend on host arch for target_ucontext.
This bug is found when run rv32 applications.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230811055438.1945-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index eaa168199a..f989f7f51f 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -38,8 +38,8 @@ struct target_sigcontext {
 }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
 
 struct target_ucontext {
-    unsigned long uc_flags;
-    struct target_ucontext *uc_link;
+    abi_ulong uc_flags;
+    abi_ptr uc_link;
     target_stack_t uc_stack;
     target_sigset_t uc_sigmask;
     uint8_t   __unused[1024 / 8 - sizeof(target_sigset_t)];
-- 
2.41.0


