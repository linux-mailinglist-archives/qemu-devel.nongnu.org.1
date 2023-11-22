Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278627F3D6B
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:38:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwS-0002eD-4h; Wed, 22 Nov 2023 00:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwQ-0002dw-55
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwO-00079t-Hw
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:25 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cf6a67e290so19933755ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631503; x=1701236303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffQ3ckw80DQQK7pNtkarYFV8Ajwf2z94gxNCXOj01oQ=;
 b=MOjoVysPYNP7q+8sr/CzzSz4UAP27mVxKGplmzV0cwMSCtkXGBVIEDtWZJYm3TT2iu
 i2Kr+Swmtg8OrF5k8tNkcNXr3FewpKjOocYoVvFZ5mWtYjBbSJJuqdqKxGLaFYWiq181
 uobFrFOMiBVX2clwOhqz/FmhWYSQFtnlzd3paZDGOq+GuujYs8ufoS5msChFwkViThtv
 ellMJWJemEX+QfIoLwhCWb06CQFN37X9YFpIl82XAwdLTbBUjpqelEV0EjxI9tBt+2SZ
 dlVY2Ni6PD2HHZEreLb35X4bcTvBhHoxwk2qa0CR4r5nsIGhBtUGrd9LnOrLOEWerZGm
 iRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631503; x=1701236303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffQ3ckw80DQQK7pNtkarYFV8Ajwf2z94gxNCXOj01oQ=;
 b=IgJ0O5kBNimFHjIT7VcpWlbbZv75sQQxusOawOsSAP01w5mdPjgchxO0bd4nOo8cj/
 d1FbNxg5W5zUVlYN2CFgkd1DvvXdieH2xBCTNXr0mG3yN8cgCXCeD5vrOEPSGlu3rcPT
 HPj68TQBdSkYFt6541MZnAxcDoP461zeNot/4t2IKC4UGn3p2SD3vu9h4I0DgkmrLAR7
 Cp8d4DtSZ2adz5UJji7JwBLiFZyEDYLHpkxAJ2sgSM3ZVt3lGeaKmTvWF0lDsk9tNx6A
 qBp3gYxn/uucFy+om8/TS0WqoZ9y7FjMlksKw9vwtLN00fwnhquWgaZLgzP8U41vyKlj
 /k3Q==
X-Gm-Message-State: AOJu0YwwTLjE6Z6xm5zKoG8XKNWCcuUy+YepGjic1YOKHY6fp5tSDh1i
 gqOvDI79gumOivSA7yu6k4b7OSE+Q5jhlQ==
X-Google-Smtp-Source: AGHT+IHHdsRRxy1IDfNse5GatBzPhuDVIrFMKJoWninIQCLj8CFwtHw/9Mq8ssT8qNlmZGyr53027A==
X-Received: by 2002:a17:902:d2ca:b0:1cf:5629:a0c6 with SMTP id
 n10-20020a170902d2ca00b001cf5629a0c6mr1561205plc.13.1700631502818; 
 Tue, 21 Nov 2023 21:38:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 3/6] target/riscv: don't verify ISA compatibility for zicntr
 and zihpm
Date: Wed, 22 Nov 2023 15:37:57 +1000
Message-ID: <20231122053800.1531799-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Clément Chigot <chigot@adacore.com>

The extensions zicntr and zihpm were officially added in the privilege
instruction set specification 1.12. However, QEMU has been implemented
them long before it and thus they are forced to be on during the cpu
initialization to ensure compatibility (see riscv_cpu_init).
riscv_cpu_disable_priv_spec_isa_exts was not updated when the above
behavior was introduced, resulting in these extensions to be disabled
after all.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Fixes: c004099330 ("target/riscv: add zicntr extension flag for TCG")
Fixes: 0824121660 ("target/riscv: add zihpm extension flag for TCG")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231114123913.536194-1-chigot@adacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 08adad304d..8a35683a34 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -250,6 +250,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     for (edata = isa_edata_arr; edata && edata->name; edata++) {
         if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
             (env->priv_ver < edata->min_version)) {
+            /*
+             * These two extensions are always enabled as they were supported
+             * by QEMU before they were added as extensions in the ISA.
+             */
+            if (!strcmp(edata->name, "zicntr") ||
+                !strcmp(edata->name, "zihpm")) {
+                continue;
+            }
+
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
-- 
2.42.0


