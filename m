Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB2737068
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdE3-0007Hz-LM; Tue, 20 Jun 2023 11:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qBdE0-0007HM-RT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:24:57 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qBdDy-0001y9-Ta
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:24:56 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-55e163e93d5so3102129eaf.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687274691; x=1689866691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hRTjh2Nv0RWWlcgr3WBnu5WWioZGP5WsirTKNEfAeIA=;
 b=EVxBGVZ7tW+oDa3L/Ic48waHLioh26OBUOxVPuv9tvUxwcqTcNOo/FYziPL6zV0ll2
 MGLnrlQC6tInLF+s73jYQCVT/Z61N20lpcGN8IvoW9ho/2g/bKwx7P7Wej9Xe+f+CR52
 FYaYFln5mLk4JU+lHkRa/ckb1TqTd4Uk+zYbjJQnYgbV5dOx97QQEvD8IbOup0wCx31T
 /OWk/t7c8+CVYoZDTPvcOg/NS1bcQ6peLmKxPn8yS8lPEzhKEGaZhtV/0EF04/6rSL4b
 vEuaY5rDoHzoDecrD69378NRYhIBplj4+1vTVgrdrrk8dvO4CeUK/bFzFNEpAl13t0aE
 izOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274691; x=1689866691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hRTjh2Nv0RWWlcgr3WBnu5WWioZGP5WsirTKNEfAeIA=;
 b=EPzQY+Y+ulDRuUzFF49gbL/RU03OzqIBFHnexaD+DnR8O7ed0m0fSjLU57UI4J6N9x
 bNxueF1VrjOkkdQcOfd+gsMayi+5++qOfzxiLKrRjicyFzBMki16529EioZtzYB4LxXT
 k5+VIZayyVg4esCMyvSKG1gguQhClamEC8NOlNiyUEsLTf+qEPlvlXRa2M89y4kv4T9Z
 8QkUcQXIHmeHYqxcwTbTejQN3tFqJN8Gm9knpLPsEuIaWBsraEBb7JOnApvxP/wq3Po4
 URV7fFnDf4sFm70Y9QNHSajv+u6YYWV2UOZIh9lP4U5I46ZnQ3SLDG7kFw3oqFBJzCyt
 hFhQ==
X-Gm-Message-State: AC+VfDzWs03G4Geknxoqv06vsmgmJXLg7MzxKfSeRclqMMCAgPPZ2xrH
 VErdZz1GiactirpY8g2uuyCffYgJ4SHHtK23jWY=
X-Google-Smtp-Source: ACHHUZ5GAzc+MtcQ6d7l7Q9mqH5qCj/4yTts9IOKKfet3GqBwQb/8EkKynhPCTgrW92+iX5HePMm0Q==
X-Received: by 2002:a4a:bc83:0:b0:55c:86b2:a315 with SMTP id
 m3-20020a4abc83000000b0055c86b2a315mr9247330oop.1.1687274691652; 
 Tue, 20 Jun 2023 08:24:51 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 f7-20020a4ac487000000b00558c88d131asm1044056ooq.36.2023.06.20.08.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:24:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/cpu.c: fix veyron-v1 CPU properties
Date: Tue, 20 Jun 2023 12:24:43 -0300
Message-ID: <20230620152443.137079-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit 7f0bdfb5bfc2 ("target/riscv/cpu.c: remove cfg setup from
riscv_cpu_init()") removed code that was enabling mmu, pmp, ext_ifencei
and ext_icsr from riscv_cpu_init(), the init() function of
TYPE_RISCV_CPU, parent type of all RISC-V CPUss. This was done to force
CPUs to explictly enable all extensions and features it requires,
without any 'magic values' that were inherited by the parent type.

This commit failed to make appropriate changes in the 'veyron-v1' CPU,
added earlier by commit e1d084a8524a. The result is that the veyron-v1
CPU has ext_ifencei, ext_icsr and pmp set to 'false', which is not the
case.

The reason why it took this long to notice (thanks LIU Zhiwei for
reporting it) is because Linux doesn't mind 'ifencei' and 'icsr' being
absent in the 'riscv,isa' DT, implying that they're both present if the
'i' extension is enabled. OpenSBI also doesn't error out or warns about
the lack of 'pmp', it'll just not protect memory pages.

Fix it by setting them to 'true' in rv64_veyron_v1_cpu_init() like
7f0bdfb5bfc2 already did with other CPUs.

Reported-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Fixes: 7f0bdfb5bfc2 ("target/riscv/cpu.c: remove cfg setup from riscv_cpu_init()")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 881bddf393..707f62b592 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -444,6 +444,9 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 
     /* Enable ISA extensions */
     cpu->cfg.mmu = true;
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.pmp = true;
     cpu->cfg.ext_icbom = true;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
-- 
2.41.0


