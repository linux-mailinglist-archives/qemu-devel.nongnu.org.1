Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E97981E9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUeK-00065r-Bt; Fri, 08 Sep 2023 02:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeH-00062C-RH
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeE-0007I1-J1
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c336f3f449so14699345ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153237; x=1694758037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNW/cl5XE7PcFPCSWK9aTBzwWg07OvJep7oqCwyWKIs=;
 b=MD5v1ttUQBo6HfEnPmZLc9v2KX4HkTva+5CSvT8Y/tIuLdeFApMkWafaVz6QUpSXJZ
 RXy5DXAj2ybUNDjC1wBWfwLXbDUrw+PJkWOZHJVfPNjaIGzw0dkgQbt0dvMPeUDqAF2K
 Vvb89dKh/ydm7n4zyjlFtdOwmJ2K1nAGEuxYHr9Qf3aIftX1yrhLbF/FX6Nl9VYP+M5q
 KYfMrq1rBb/JcA+LcCvOlgO+jCIScCULl9LElIVDenCXrDH5Kfh5IqLETXmSlD1pT/O2
 ccXOsfqjDSSqtx3Au9mrGT70Y6w+aD7aAmAquq8J9cQ4ihSGiHEyne1diN0m1ctirCNe
 UmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153237; x=1694758037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNW/cl5XE7PcFPCSWK9aTBzwWg07OvJep7oqCwyWKIs=;
 b=Jvb/6hMOnCq69EA1nCRplgKfL9eT033X3uAVfL+x9yBDqs+aS6DCzwvvz1YVJKRIYO
 cKJrheS+JvV7nzA+HIyL/JX2KA4Qyl0aMSEytSa25Cbe1Ox9OXmuvEjoCi+7vFFW3D4T
 +1sdlfP47qc8bMST7z5oInTiOspSxs+TqgBR6feAznQtydUSu30posLxlh1hDQvKsfHt
 vbyrmgh7hwdyent0uEcE/f9fBrWlNb+aJc0e8E6r1U42wXF8gNZ38u1wl6JcX7hcQYy0
 UcpGdac2R0gLnlcp0sTe5Xay9nWSu16rfpy82tzqDX1cHb9I7glo0jzADwHfTgLWGOvg
 B6Fg==
X-Gm-Message-State: AOJu0YxZ541kt7KwbKR/soPMabcz+GDcsh0362CTwgD/WIpxhG1Q1QBv
 BG3A53E1AOz4eU/9MjE2toVpjxDeaBm3lq5V
X-Google-Smtp-Source: AGHT+IFTrO40rcArjfhnK2w23VzZ2CJxt8XlylmyXhm5mz6WUotek8zR6/jdinwPsKvf9FHazhA14w==
X-Received: by 2002:a17:902:d2d1:b0:1bd:c6ca:e0db with SMTP id
 n17-20020a170902d2d100b001bdc6cae0dbmr1711028plc.37.1694153236927; 
 Thu, 07 Sep 2023 23:07:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vineet Gupta <vineetg@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/65] riscv: zicond: make non-experimental
Date: Fri,  8 Sep 2023 16:04:03 +1000
Message-ID: <20230908060431.1903919-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Vineet Gupta <vineetg@rivosinc.com>

zicond is now codegen supported in both llvm and gcc.

This change allows seamless enabling/testing of zicond in downstream
projects. e.g. currently riscv-gnu-toolchain parses elf attributes
to create a cmdline for qemu but fails short of enabling it because of
the "x-" prefix.

Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
Message-ID: <20230808181715.436395-1-vineetg@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 34ac26e3ae..bf0912014e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1869,6 +1869,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcf", RISCVCPU, cfg.ext_zcf, false),
     DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
+    DEFINE_PROP_BOOL("zicond", RISCVCPU, cfg.ext_zicond, false),
 
     /* Vendor-specific custom extensions */
     DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
@@ -1885,7 +1886,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
 
     /* These are experimental so mark with 'x-' */
-    DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
 
     /* ePMP 0.9.3 */
     DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
-- 
2.41.0


