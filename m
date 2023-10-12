Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9A7C63F1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn5M-0000nx-Vc; Thu, 12 Oct 2023 00:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5K-0000mK-G7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:06 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5I-0002sy-TX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:06 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-578e33b6fb7so390335a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084043; x=1697688843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wxF5MYQ6hqwZsaoFIB/qVZG8guqtArX+OiVDR6W7f4=;
 b=eVlsLsnZkifEj6rWdhS6/+ikW80axqBbl0dm4RJ4ttHZ6pzmZ4sCvyHYm4HVOGpiDQ
 pxDYomVy9Aeo7PIcvYUCwZsUm5AabJhCGvhwU041cBRblvLvAQOZCv2HYhUfH/ouJQBa
 KYMyn7m2316ZBcUE5aJcyt+7fPyA/XpqF9bOpw+36V94ReUKDQ9vS2s2zuuynkwdXkJs
 QVKiqMupgJ64XGpP1jZPBGaR5H4LV7Jx4VHs508esly97W6vZepkpdmRzVdZSe63CnvB
 HnDeBdx4qnuaLylI3SpQV6uCYZTpj10J1wmQAv2segHzlTaU0bZUtpqDf739Rk+BP14J
 y/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084043; x=1697688843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wxF5MYQ6hqwZsaoFIB/qVZG8guqtArX+OiVDR6W7f4=;
 b=m73rjUty/ozXrcPFL3ifMqbaRtABq439djVUQAqGPbR3Evyro0y1nKzLGc0+itUith
 81+aAugBRndpgc6cIna7EKEB+OoRCQoSnwWu6EZuVS0u9xVwQx5eNMfUsxujBd/xEj7K
 8HW+JHxurcyojzNQ3xHWCwpNCl28aKR+IbUAjlts9hUJ9MYt9m6NsuEGt7amNBPie3Wy
 h9LCPpHiT1Ey/0nyhX8IEKN070tJAIl9fmpKH+72JDm/3DGI39frfVWt7m2mu1j2DFSd
 8U1NA0axv857lEGwe+qi6hw7DDAOgAMO5Xi66r+LUMFWqAX1Uc55mG8d4XcldLj2kIZT
 qdoA==
X-Gm-Message-State: AOJu0YwvSIUpfVMWq8bAsOfK7sHMrs4Nr8TwFXsdr7xkfmuZof6ZzKPe
 2yRUA8/bc4Mi32vRWphnTUFXbppZCGIufw==
X-Google-Smtp-Source: AGHT+IH5LwPCbzrciRd90n/U7yLDMKU1XE0qJEtgdNJwpa1LbzsjZh5QnQZEnOlPQh/ogfrdSUHp0Q==
X-Received: by 2002:a05:6a20:bb23:b0:174:d189:2f8f with SMTP id
 fc35-20020a056a20bb2300b00174d1892f8fmr855357pzb.51.1697084043360; 
 Wed, 11 Oct 2023 21:14:03 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:14:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Richard W.M. Jones" <rjones@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 52/54] target/riscv: Use env_archcpu for better performance
Date: Thu, 12 Oct 2023 14:10:49 +1000
Message-ID: <20231012041051.2572507-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: "Richard W.M. Jones" <rjones@redhat.com>

RISCV_CPU(cs) uses a checked cast.  When QOM cast debugging is enabled
this adds about 5% total overhead when emulating RV64 on x86-64 host.

Using a RISC-V guest with 16 vCPUs, 16 GB of guest RAM, virtio-blk
disk.  The guest has a copy of the qemu source tree.  The test
involves compiling the qemu source tree with 'make clean; time make -j16'.

Before making this change the compile step took 449 & 447 seconds over
two consecutive runs.

After making this change: 428 & 421 seconds.

The saving is over 5%.

Thanks: Paolo Bonzini
Thanks: Philippe Mathieu-Daudé
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231009124859.3373696-2-rjones@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3a02079290..8c28241c18 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -65,8 +65,7 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
-    CPUState *cs = env_cpu(env);
-    RISCVCPU *cpu = RISCV_CPU(cs);
+    RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
 
-- 
2.41.0


