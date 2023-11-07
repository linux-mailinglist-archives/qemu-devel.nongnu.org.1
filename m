Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535867E32F2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BsF-0004Ac-5U; Mon, 06 Nov 2023 21:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsD-000437-92
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:25 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsB-0002sI-KF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc5916d578so47301115ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324282; x=1699929082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWk8dj/diGOAbqygP4GxC5hSgGz19RDI+NWOLPDhkus=;
 b=ga0u05zCh1gByYHSNc8/sXW4gr2H/+w9yEQILAmYDy8bnfN3gN7bzR7m+iB34D99AZ
 JvXKNyHhka4owl7ZXrwNcuTyMwvyCy61bnD1EOFKAXkCpfb7YWqLwXf7JSjWGD7HjwkT
 FLiB+Z7qJfIxcfjyeirIJlMkNMMR2Gv3/c4GCfe1eirmu7t2622CasJYxRMS6C+4t2An
 vTYgfIuGTOY/aMit+8gAxKfXUjckE8/W541R/B7FL11pq+sebRX+/EAI0V/62cZI+0Ss
 mAqaRalZa0j5ZNWMXG44u7BX7S5THIjhpCiNKfII5epkEkFgtjE42HH008cj/Qwln6K8
 7S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324282; x=1699929082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWk8dj/diGOAbqygP4GxC5hSgGz19RDI+NWOLPDhkus=;
 b=TUvBdfTrFLLGecuYyD00ldtDly7RpOjgQMsetDOBocCvzpkir69KQqmn4yE/gppymU
 wxbf68D7c0M6jD+UA995BxSy3bvj0vCxiFPfHVybuqnuzdkFlGOTROoRnfXlbHBBxEco
 Pb1JCMN4Vx247Ehkhql/yz0JV48BL1eDy4UDOVRsnRMtMr1vv9k/RJ79R+UHzo8JOTqk
 mT40YkhLbYmHSD2NNQy+bsa8Tlz/pWeWKAFOsBkFp8whXRAb4azIXbmhIu2ie8XwrKBQ
 DW7UI+jP5qroQZprSc0dZNb2hkxzTc1ap914RxM755/w4Tk8jDqPKyBHo//hovADg0EO
 MOfQ==
X-Gm-Message-State: AOJu0YwoLpnvQN+Uehvf0SVCkrryRB8uwNiXzMM4BxaBDGvcS/6Ufn0L
 MLfEhrmS6VZ0VOy1nBAA2Wd5Ug56gnK1rw==
X-Google-Smtp-Source: AGHT+IFBPvGQh4F1rBBXuXA1CqDUg25lNim4qZCVO7eyGy454qP05xGXOpvcr4fpSoPd4+FA7WR1Lw==
X-Received: by 2002:a17:902:d2cf:b0:1cc:45f1:adf5 with SMTP id
 n15-20020a170902d2cf00b001cc45f1adf5mr28378632plc.40.1699324281899; 
 Mon, 06 Nov 2023 18:31:21 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/49] target/riscv/kvm: add zihpm reg
Date: Tue,  7 Nov 2023 12:29:21 +1000
Message-ID: <20231107022946.1055027-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add zihpm support in the KVM driver now that QEMU supports it.

This reg was added in Linux 6.6.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231023153927.435083-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0c5c0e957b..a11c0e4a99 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -230,6 +230,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
+    KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
-- 
2.41.0


