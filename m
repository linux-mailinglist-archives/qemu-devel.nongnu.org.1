Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C33927F6607
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:13:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ECV-00015R-Q5; Thu, 23 Nov 2023 13:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1r6ECT-00014p-Te
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:13:17 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1r6ECH-0007mr-El
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:13:17 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso1660587a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1700763183; x=1701367983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eX29FSHrxZwtoMuV95zkFBlb/od/3/uAvsNcCfbYMG8=;
 b=f0k/xHN17AdwD1QjSOeLp1yQ6x4mEkvXrEjRN9PEvl1Q1c0W0+RprrvtyDbTeYpVpo
 XjQ5l6iPdG552PdiG5bNAscjTqM62AMPOumWapPA6nUTQEjeXgWbaCCkvQQwlzioFl2+
 ETK7hEf7okXy+NE4v6fsx0ElDFg2EzQOtzeQenk8HLhDUcyf7klODIVRBEPV9WW6TJoa
 Nb1x09/q4GLMWoWc4GelN1sw5zNwLuJ+R0sTPqlnA1W9N7RaZfxj0SoPSnLMN0GTrJjO
 thtIrjsVRRd/KVgL/Xdjk7AC9fk6pGYZGSuliNKOAFef4MGIOs8gaswzxNooEJCBJxqN
 jhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700763183; x=1701367983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eX29FSHrxZwtoMuV95zkFBlb/od/3/uAvsNcCfbYMG8=;
 b=m18igMDNkPXKx6jaCnOzIMjAOrblM3kFlwGGPbx80r/YyCPv+4gW/GFo9x1kLS7VWo
 +V4B2nR6evceEBhYXnYC//yoT//ohZZMfDMkGpdOyS+oevogyE93EYIIDa4tbDWmMcaS
 k11+8GwKpQ8tHcjGyWsuKidp0/dFG86yfiYEKvI047rV3TUdrpESgbot2l5tlpY7SLa7
 Dfp9M1RDI8wbMe4pSxnT6HDLHPJy9o1gNnP9ZDF4IU8MVXAeTXoZzkBGzskNLPsgFaCp
 AnZZYJ294+7NrekuzuxKD3ClvsYrrAQP8hEH2TcxqrNMWoXCia3JO/q9PGUWxNJBsQNs
 bWDw==
X-Gm-Message-State: AOJu0YwErv9Z8faBTCgIs+HYQhuJ16Y12HPj9HFHw4BRdr1zHDoL9oLx
 0uW3RXn3B14XXqutVpaypxwpiA==
X-Google-Smtp-Source: AGHT+IHk1m6bj7LoyzZMf8eWS76aAZNzmEZzYYnrxuyh4HPiosDEI2nqUIVCFZx3C3Z9zL9qyTUI+g==
X-Received: by 2002:a17:906:291:b0:a01:b8d6:2ea with SMTP id
 17-20020a170906029100b00a01b8d602eamr82944ejf.49.1700763183406; 
 Thu, 23 Nov 2023 10:13:03 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 e5-20020a17090681c500b00985ed2f1584sm1065635ejx.187.2023.11.23.10.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:13:02 -0800 (PST)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2] linux-user/riscv: Add Zicboz extensions to hwprobe
Date: Thu, 23 Nov 2023 19:12:59 +0100
Message-ID: <20231123181300.2140622-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

Upstream Linux recently added RISC-V Zicboz support to the hwprobe API.
This patch introduces this for QEMU's user space emulator.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 65ac3ac796..2f9a1c5279 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8799,6 +8799,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
 #define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
 #define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
+#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8855,6 +8856,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZBB : 0;
             value |= cfg->ext_zbs ?
                      RISCV_HWPROBE_EXT_ZBS : 0;
+            value |= cfg->ext_zicboz ?
+                     RISCV_HWPROBE_EXT_ZICBOZ : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.41.0


