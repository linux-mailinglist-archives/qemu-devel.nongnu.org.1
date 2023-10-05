Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A47B9C5E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoL7t-0002JY-CN; Thu, 05 Oct 2023 05:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qoL7q-0002JM-Tl
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:58:34 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qoL7p-0004Zo-Dd
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:58:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-690ba63891dso639238b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1696499911; x=1697104711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UvlJbfC9iU1xlm0Y4EWFEt+DFsas2Cq22UlJ01mNphM=;
 b=JUWdA//LV0pLTuEPTE0FXgPX5UflRO+0vvwb3jAhsPu5xwfIyVdItXp2vCJ00wVq/G
 8ykg8Xv2479Za/3vfJD83WMXLlpyLu5C0criG944RpHjrOw0QGD6Lgo38q3wj09Ivb/K
 17aGskc8x7/+mdkkoFTZaIUSj6M+vWTV6kjg2AZSgcqAicHX4jr8ksTy+B9sw+KDorXq
 ZfRWBteSd1juhyDDEkbOrpcgkxKyJyfa94J+LR7aAZhq+FBJbJlhYl8f4+etxL55lbpd
 r2Z5+22wXgBewZjBqVqHUdlMzEg6blkNqPdunA1UavLgNnSVr8XhScO+p446aWkEbPNF
 eG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696499911; x=1697104711;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UvlJbfC9iU1xlm0Y4EWFEt+DFsas2Cq22UlJ01mNphM=;
 b=di1vE3MPHcngjqX06DMSWYTxcm8/yD5qUzF55aYFPS+9mFmUcyza0ZM/O8nUphoDP9
 MUZLpJoslDDjBIZ8cbQBfwV6F9crXV32YavRmR5b9S58fnNEE0UCDo3mKOSlQ9JYuZz+
 8gSfrNBH99Tu6gJ5G1Cvgf1Kcpj8HPcDJ9t3161LNwNvKLHVQlYqJHpD5Wy/kPrUokRG
 IJWEXKmMrx80Ia8dBv5K2wJ/cA3R6lQhfWsEsdbLhfggC82OC4Lr+K+5jWjTCk1UcnYk
 VmsmEd6gsC0MzV0v3cLkR2+EV1Ew9RiS77gKuj2GYjbJsWign7ninXQcw/zJPoY2hSgG
 w9tQ==
X-Gm-Message-State: AOJu0YwPAPr6r6f3tbM8Y3fVa8a7iaPWiFwEwf14+evBZklrn2ESeYdd
 l6sOhlP68gIfRz14b2TrokkXWii1kgn8yBgTH80jW83rYuatABboEeR2vqdoM7NtYohyAI86bQH
 warw60XrL93nfXHbM0T8XnB/oUZ79HDVEJJvE8HJRe6SuQDrb1KkOTektFZIrE9QS1FA3R7q8Sc
 5L
X-Google-Smtp-Source: AGHT+IGnOGSfPGHa5NCOwtTBp8AssIFqSo3omGr9QdrMJaug35jbcf2IxGIXr4eeL8NwkE/KikYVPA==
X-Received: by 2002:a05:6a00:1a92:b0:690:bdda:7c35 with SMTP id
 e18-20020a056a001a9200b00690bdda7c35mr5098131pfv.1.1696499910537; 
 Thu, 05 Oct 2023 02:58:30 -0700 (PDT)
Received: from localhost.localdomain ([146.70.201.138])
 by smtp.gmail.com with ESMTPSA id
 c14-20020aa781ce000000b006936294bc32sm976018pfn.128.2023.10.05.02.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 02:58:30 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Fix vfwmaccbf16.vf
Date: Thu,  5 Oct 2023 17:57:32 +0800
Message-Id: <20231005095734.567575-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The operator (fwmacc16) of vfwmaccbf16.vf helper function should be
replaced by fwmaccbf16.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3fb05cc3d6e..c45d94c165c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3361,7 +3361,7 @@ static uint32_t fwmaccbf16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 
 RVVCALL(OPFVV3, vfwmaccbf16_vv, WOP_UUU_H, H4, H2, H2, fwmaccbf16)
 GEN_VEXT_VV_ENV(vfwmaccbf16_vv, 4)
-RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmacc16)
+RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmaccbf16)
 GEN_VEXT_VF(vfwmaccbf16_vf, 4)
 
 static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
-- 
2.34.1


