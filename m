Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E17E3313
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsb-0005gn-5g; Mon, 06 Nov 2023 21:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsY-0005aU-VU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:46 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsW-0002us-RJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:46 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so5525206b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324303; x=1699929103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzerSzreBEyLFpv86Iaj/StJpuCF0tcymXhTs5mU6mY=;
 b=Gi7SBFNLKwqmef7NM+tNp/1O1uE9s8TEippAY5ls7o6ksd4Kq82uo3/trp+GNbbKFB
 XnVUkyeo50JbA5Ki5W0Yohtg8aY08RihBa4Y5QWuA2eD2W/gRLVXuyAAIMwu4CDZFb7W
 NswdKwocrCwv4Q1wBcyiKeJ05DJFzpqv0eCKGOLUhl2XEkN7z7cvY4SxFEjZmgHtjwNc
 Uf5xqnSR7B2HETf8WSCXEH3Zmp+wYwDjnVlkJATp8ZNdFxCYkA2lbxTBwilpICR6V84p
 H+YTWcI1Xkv20Zk050U/fWhJPq7W+xHfjnlRB6U0/CIV7eC9M3K8kOWUh8Rd+TrODfHi
 808g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324303; x=1699929103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzerSzreBEyLFpv86Iaj/StJpuCF0tcymXhTs5mU6mY=;
 b=r65rq89NZ0lS/j2CpbNcU+XR1Js5mI6J0jJwjeoSYO2PaRIn4BBRx5EzEFHR/dnczW
 ajNFdv5QUnMJqw+wNPY5OdwxXSklKygqSBbTbwIHVOGfYGP0PcD7jf503yOOe033FC8M
 SnEZqTwuRKq8yOgr6jRqNzuuxL47stEC31JqspmJpoYtOQGX6ChXY+qpXGb1O1ACZjAZ
 MD+f6siPZLJ+fKjO+gZHvTaP5l+tLhVx1dJuTBkTJekmJ45EhI45ToUGuaBTFMdgxF+e
 oDrryEKHapwRiTu/lrwm2WuyITdksbtBU/WLx06PJ1HHwIX5uLshfhGiZxHdtXHpHVkI
 n1/Q==
X-Gm-Message-State: AOJu0Yw47i90poSAkVa0u1guLun3TiYZfi5vc/yJ0MeA/KZd6bSAHOGz
 muet3+O5al7aAcyMpV9bHEHDA4Mlt2k+hw==
X-Google-Smtp-Source: AGHT+IHG2eyK1QlxDDesWRzLoKM2XIyQpl61vR2RI1ioXTiWekKM9On7oT610c0/rJbjpsBGGPUvWQ==
X-Received: by 2002:a05:6a20:728e:b0:14c:daa9:5e22 with SMTP id
 o14-20020a056a20728e00b0014cdaa95e22mr36782476pzk.45.1699324303106; 
 Mon, 06 Nov 2023 18:31:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 31/49] target/riscv: Add cfg property for Zvkb extension
Date: Tue,  7 Nov 2023 12:29:27 +1000
Message-ID: <20231107022946.1055027-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Max Chou <max.chou@sifive.com>

After vector crypto spec v1.0.0-rc3 release, the Zvkb extension is
defined as a proper subset of the Zvbb extension. And both the Zvkn and
Zvks shorthand extensions replace the included Zvbb extension by Zvkb
extnesion.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 1f0dac5c8a..c4b2fec024 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -90,6 +90,7 @@ struct RISCVCPUConfig {
     bool ext_zve64d;
     bool ext_zvbb;
     bool ext_zvbc;
+    bool ext_zvkb;
     bool ext_zvkg;
     bool ext_zvkned;
     bool ext_zvknha;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 87baae56a1..ad7a183a74 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -508,9 +508,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
      */
-    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
-         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed || cpu->cfg.ext_zvksh) &&
-        !cpu->cfg.ext_zve32f) {
+    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
+         cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
+         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
-- 
2.41.0


