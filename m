Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6279A3B9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagU-0003Uk-Ia; Mon, 11 Sep 2023 02:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagO-0003BD-CV
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:04 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagM-0005F5-6I
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:04 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ab2436b57dso2929661b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414760; x=1695019560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNW/cl5XE7PcFPCSWK9aTBzwWg07OvJep7oqCwyWKIs=;
 b=pQpQ09o1B6xR0TipSIQ/q0i1Es5BQFlbQhFHJ4k80Fceqds1AX/yunaJx6hCYD7ENP
 XnAkqnzEYvg8tUy0UG0pjGCw3Z52zGKvSj85wfnAqWXufzd6KUviYqdf2pGJ6oOUY49m
 JDnOpzf5dzdnOCIHuZ3plFb56KzNSivyBOOj9X70L4rizSluSTPFR+AdxaYMQflhp7Yz
 cwSoqBQXSCYbNMsttZeXVfgGRU8OA3VGBenwCgMwZQfjyHOW9nzdfeNFuECBkUGwbafz
 6lt6+TI4eiidwnpLqPp/nt/jOUW+IlWYrlY4pualc2hcRosZPbm+KyKXI5ZAovdyi22n
 NDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414760; x=1695019560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNW/cl5XE7PcFPCSWK9aTBzwWg07OvJep7oqCwyWKIs=;
 b=Hkp/nLro65HbA0QZKdaXYxrdCtOq7fEsCibakTLG2R76sALzbOUQrKJ2OvZ0EcBP0g
 HLDiOQkdSfIruUSjTWffrchdTpqIemAtznY/nCdXdl2WPZdfwDwKbOpKJfjNKAfUAXBx
 5xPQPcxN3xEYePLYf5x9l2btQ0s7sHvQni+nbe5izW/2rzq/QpL+bgggje2/DnUhaCQS
 o8bh6Tk1tCw3MGpwN+5aqMxodVsiMlvT8EnQ/N7JSd5otRkszDLcx9kJv4g3wotlwkdj
 PPqbpSUoh7Ybw29cVBrrBmWVHItCuMFnv3/0aZncfxlGJJ8qlhh4oRC5nv/R01jvBJR1
 WHHA==
X-Gm-Message-State: AOJu0YwfD94OJi8tuM/ZXwHgR+Ni9O6agcuPSTZRRCiVuEL6RT5LMZAe
 V1DLPFkbcqCoArVVslw+QaUsIXDNUnZREA==
X-Google-Smtp-Source: AGHT+IGLB22OHuyr4LgXH4DyuKEsaMn6EBFBVH9aCh7i6TiOu+spJusgMPp3amwIzAuMI6OWH7w5CQ==
X-Received: by 2002:a54:439a:0:b0:3a8:1727:5af4 with SMTP id
 u26-20020a54439a000000b003a817275af4mr9927515oiv.24.1694414760487; 
 Sun, 10 Sep 2023 23:46:00 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vineet Gupta <vineetg@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 37/45] riscv: zicond: make non-experimental
Date: Mon, 11 Sep 2023 16:43:12 +1000
Message-ID: <20230911064320.939791-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22a.google.com
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


