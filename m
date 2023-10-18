Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D77CE194
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8j5-0001bB-So; Wed, 18 Oct 2023 11:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8j4-0001az-44
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qt8j2-0004xo-Jk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:44:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso6464585e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697643886; x=1698248686;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1DBZDUvIATC8PHiuhBMUA0lfNpRPy/ZdfO4sG+Ox/Q=;
 b=LCg93uoElhKqlDczVfsR7Y9WA6ipaa4yluALTNH8U8Qo3e2K3VfupqBdkZZLD/KrmE
 Sh0z4e7GhE4upYuP87KzWSi+ejbuSIQmwb3pfYPTKZ7jB2ra2PcLZ+D6M6aTZVy94U8f
 LUfaxF8y9caOzKq5FKgbDnvj2Y+y2s0qgeYnDNDNgM4h/Tlts2GSW9brYLsTbr1V2bRP
 e2lIJa1VSALq92qSKqm+9dlARNcdlcejn4vF5Q798AJkr53B/uMOgQK8ezilv/A6EhL9
 id8ahBNYB0ukVpGjExZ52Duz9xHEwkVmuN1lJc9soSJlPxs8pi5usZrbKFopG2fj0VlS
 Cbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643886; x=1698248686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1DBZDUvIATC8PHiuhBMUA0lfNpRPy/ZdfO4sG+Ox/Q=;
 b=EiWX3oayI8Nr/vwuT/NNZ+j3+cAImVw+6o97nmdO6NAMZmtO2xgN3P4vtayaXXbbpy
 Osp5dkjtXNA/Ncep1jOjpchTJyJ3P0DEMOJJJUmISlV5R/853EoVoAPyuWoMrr3Af5tl
 3iMuiCnMllza9Z8PRd2MjCKkJyGJIap8ZPEpykKu8JzYpsW6YH6T64yC7dKLWBzzlfQV
 nD8Cd1Qm5/KB6PKiiNnwv7sXOI4OyxA9T/aqr0/Ic7l/HxqAQHHFmVeGPpb7zcXQvajl
 zMXblkHnxfEgiJHk6mczufk3H2qdrj+Kuzt26FjapHgcQrocL2kFP+9JPF+bXPaZJ1jh
 vnbQ==
X-Gm-Message-State: AOJu0YxASsdSFnhu7bW7LWlhbmcACHx6P/6PUVpq5ccq4OuDNE8dKHVI
 Ek1U9bPoNAq6sO+p/uRGRSLc7UiRizKXpjaG6xmbmw==
X-Google-Smtp-Source: AGHT+IGZ3TyGkOX8y9PV4t89xyq22UXzh1kpPWDTC+4tElTFZMTeUtGjsTL6v5WXgXZ6kwSTstI6Lw==
X-Received: by 2002:a05:600c:a686:b0:3fc:dd9:91fd with SMTP id
 ip6-20020a05600ca68600b003fc0dd991fdmr4230208wmb.40.1697643886661; 
 Wed, 18 Oct 2023 08:44:46 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm1963580wmq.31.2023.10.18.08.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:44:46 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v4 6/6] target/riscv: Use MAKE_64BIT_MASK instead of custom
 macro
Date: Wed, 18 Oct 2023 16:39:14 +0100
Message-ID: <20231018154434.17367-7-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154434.17367-1-rbradford@rivosinc.com>
References: <20231018154434.17367-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A 32-bit mask can be trivially created using the 64-bit macro so make
use of that instead.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 5e89354bb9..81b25ec11a 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -25,8 +25,6 @@
 #include "sysemu/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
-#define MAKE_32BIT_MASK(shift, length) \
-        (((uint32_t)(~0UL) >> (32 - (length))) << (shift))
 
 /*
  * To keep it simple, any event can be mapped to any programmable counters in
@@ -455,7 +453,7 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
     if (pmu_num == 0) {
         cpu->cfg.pmu_mask = 0;
     } else if (pmu_num != 16) {
-        cpu->cfg.pmu_mask = MAKE_32BIT_MASK(3, pmu_num);
+        cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, pmu_num);
     }
 
     cpu->pmu_avail_ctrs = cpu->cfg.pmu_mask;
-- 
2.41.0


