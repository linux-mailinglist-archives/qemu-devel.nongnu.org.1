Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D006F7161E7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOa-0000an-QN; Tue, 30 May 2023 09:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMk-0005Xh-S6; Tue, 30 May 2023 09:26:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMh-0001MR-2R; Tue, 30 May 2023 09:26:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so5169742b3a.1; 
 Tue, 30 May 2023 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685453175; x=1688045175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xRUm3xFl4YSlnmQ8JCWKFHbN5DToXbUqcryjy/NOc8=;
 b=DoUm+Npi19/GjOjdyZskOYJhSJOzWF78oyMzSepZLNdM4ihMnK7/8MRKqbafmIE5MW
 RGaAUPKwaKSWTgckzg+26AREZ7pHmwNdXnH5ufydPFw2XY4TsceVmu3oI84hSdfZ9/EN
 V18NwhwcaBMyyEheVJHu+PyPVwrWrj4F+a85wJXXJopSi/4R3dP0oZ4pEuc6Vh3L189b
 J2fk+GXcYrFNf1dDZt9LLLo3krN6H3RUC/ToDjzjoVaL06CsanHOMEK9vS61pRtZbqrm
 COAGPcGdNLhoNZ3kkljKfSs5fo4mLzQ5w8uf31CCtXGhU1LU4P6MZAHTjsplvvuJ5m5m
 G/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453175; x=1688045175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xRUm3xFl4YSlnmQ8JCWKFHbN5DToXbUqcryjy/NOc8=;
 b=bSylQ48kQOdMCr2IS8F1nqM/yxfZhZrgVcTvc3g3dRGghK5cbJoKt3JeOPRCAECmsq
 NtaMh0gdTgAsqD/Jos2uV3hgOfNUjcfd5Kr4RC9UDrjo8mcTE6HMw8jwCGr92zekJJrJ
 OHsy/MGyIM8U4a4hrjGEH+ZwNu0+MUofVMUGYm6K6nATMpyfL3uw3HGaplSpR2crDp93
 zF+eTZ4xAV1sPFmK89pY4y2dknCafut5nJYPBS6RU3eBRzJhTg4+SKRxhua3WqKbM9vb
 Ri9H64wzwU4TTa7oCJVA7T8hc3TOwo8wL/HDkSScnFH2vIDzJr0NpyFfO1iOE+8CRNEF
 yaag==
X-Gm-Message-State: AC+VfDwo5UecDhNLPVjDWDWcHkC0TBvbG1YxuapJoCifDYC/bMA+3/Cq
 YMg0TvQ/al3SPPW3Hsn7MW6zMjIjgjk=
X-Google-Smtp-Source: ACHHUZ441qTGVTI5SMRjZrEgcloCxho/+Jj8+sUPpDGfvn7sefUNrHwkqIhYw7QY+wvYothq17TmTA==
X-Received: by 2002:a05:6a00:138b:b0:643:9ca:3c7d with SMTP id
 t11-20020a056a00138b00b0064309ca3c7dmr3046655pfg.4.1685453175123; 
 Tue, 30 May 2023 06:26:15 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 w32-20020a634920000000b0050927cb606asm8601514pga.13.2023.05.30.06.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 5/6] target/ppc: Add ISA v3.1 LEV indication in SRR1 for
 system call interrupts
Date: Tue, 30 May 2023 23:25:42 +1000
Message-Id: <20230530132543.385138-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530132543.385138-1-npiggin@gmail.com>
References: <20230530132543.385138-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

System call interrupts in ISA v3.1 CPUs add a LEV indication in SRR1
that corresponds with the LEV field of the instruction that caused the
interrupt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1533ad0f13..d69bd0033a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1561,6 +1561,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             vhc->hypercall(cpu->vhyp, cpu);
             return;
         }
+        if (env->insns_flags2 & PPC2_ISA310) {
+            /* ISAv3.1 puts LEV into SRR1 */
+            msr |= lev << 20;
+        }
         if (lev == 1) {
             new_msr |= (target_ulong)MSR_HVB;
         }
-- 
2.40.1


