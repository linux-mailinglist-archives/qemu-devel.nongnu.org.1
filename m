Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3F7F3D77
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:39:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwW-0002ex-CZ; Wed, 22 Nov 2023 00:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwT-0002eW-Po
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwS-0007A5-4W
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so41715255ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631506; x=1701236306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLbOAJzLWl9ZAwxrRE8Vm/IEKsPP3IN/EvETdsopNPM=;
 b=AzlYFhlN6rL7snbYvcyktuUHb+1KakSaICkcu6JKca7lc9oPQoB+PYCVafi4zgdbQ7
 ZgxG+MZaBT1cWn2J2I3iufIhxB96NPolq3u5atGplvnodYl7LyoEPgT9OH7hPeNpSM/w
 DYWoFU4mSkaVpt2bPIJrOPbMkPikmvX3mDu7I1zCn+Y9vXn0vIjsjzYd78nPpi5qGp/h
 n9EdkxB2tWrYixY8ho2AdnpvM/cg4zDqvhp6WdBZMI8L6AtFRwBl+hKwghMbpGmqY//m
 OjZMHw4lGWgoY2KDi795oGMpDo9eki805wM4gcy0QnBkEnLrZfTzNL/Hboa7IouybUM9
 mGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631506; x=1701236306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLbOAJzLWl9ZAwxrRE8Vm/IEKsPP3IN/EvETdsopNPM=;
 b=h0pJ/z1jCGkE3SvCc1xrTh+K8zHCxZumQM0yhfoJbyuJUDDj023iZGYW/3Gp22Kysb
 64bzW9JluMJRN2T/AfZ5Mtr/VZnHPiPMPlu3Q9a+tM1TjZHobWrhmKRP12bocmwwTqVg
 zfxnzk5o7kBHWe4wtWSIFg7c+IxsqS3NOPsSjzf7lGJRyfEBT7xg+P5VGdb6zi+/O0tB
 v9KU2u1awlKFk1qxtiD7nJRAOgZl7AnhfoUAeZmBouOeN+1QgGj7npoK/r/o2cFf49Iw
 gYPLppo5YxGG6lJWQaQUkb61DT47S+UVWviJvS4TswrWm41oT0iADORrrE2mcK9Syozt
 8Xvg==
X-Gm-Message-State: AOJu0YxlSbSEdPu39GWechVuMrzbgcbMvV3W4rH2JVl1yFiAhTKq6JGk
 YwDFc9l7NaJyLarZkvYtm3GwSAERE0u9ig==
X-Google-Smtp-Source: AGHT+IFnKbjPXvvOYxNGxrSSRvYkv990v8CTCH8ZBogx4CavNedlVP+zJZQMkgnDcyf8XS64y4C2yg==
X-Received: by 2002:a17:903:32cb:b0:1c9:d0a0:ee88 with SMTP id
 i11-20020a17090332cb00b001c9d0a0ee88mr1413388plr.62.1700631506374; 
 Tue, 21 Nov 2023 21:38:26 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas?= <rcardenas.rod@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 4/6] riscv: Fix SiFive E CLINT clock frequency
Date: Wed, 22 Nov 2023 15:37:58 +1000
Message-ID: <20231122053800.1531799-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Román Cárdenas <rcardenas.rod@gmail.com>

If you check the manual of SiFive E310 (https://cdn.sparkfun.com/assets/7/f/0/2/7/fe310-g002-manual-v19p05.pdf),
you can see in Figure 1 that the CLINT is connected to the real time clock, which also feeds the AON peripheral (they share the same clock).
In page 43, the docs also say that the timer registers of the CLINT count ticks from the rtcclk.

I am currently playing with bare metal applications both in QEMU and a physical SiFive E310 board and
I confirm that the CLINT clock in the physical board runs at 32.768 kHz.
In QEMU, the same app produces a completely different outcome, as sometimes a new CLINT interrupt is triggered before finishing other tasks.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1978

Signed-off-by: Rom\ufffd\ufffdn C\ufffd\ufffdrdenas <rcardenas.rod@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231117082840.55705-1-rcardenas.rod@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0d37adc542..87d9602383 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -225,7 +225,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
-        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
+        SIFIVE_E_LFCLK_DEFAULT_FREQ, false);
     sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
 
     /* AON */
-- 
2.42.0


