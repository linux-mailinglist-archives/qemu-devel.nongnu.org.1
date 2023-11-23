Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1207F5602
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 02:44:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ykE-0007nx-KW; Wed, 22 Nov 2023 20:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@rivosinc.com>)
 id 1r5xPV-00070Z-Gx
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 19:17:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick@rivosinc.com>)
 id 1r5xPT-0000GW-Mr
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 19:17:37 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cf59c07faeso2578455ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 16:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700698654; x=1701303454;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lhRYRi7vANkjLCTUL1asmQ357tOqr1+NqvoT+6py0Os=;
 b=Iad8BNNiPqgVq1BheRsbF1ZhgMnzHM4jb6X92LgGfxBMVJL1f2qPtn+i4pJ6p0Gevi
 UsW2ihf1O4Fxlj9KxDvWchlKbj6uNZ8UIN7l0zRhne7f8kQsnOScAJ2BVL3JMcaKW4Bw
 SWSJmI7ZyVPoOo4lRGgGeH7Shsd1I/Dt2O11U2BqLkaOoLcqy/W++Fj8KHVBrMkJgE7p
 jfGjzPmK6RwpDSOpxdLWESMDyiYoz9ThZUai3vJu6NHLu1lpLxCFcIJIPHNaCDI2fOm7
 0KnRZPAm3i4WBBStmrCSAJ+YbfUHEZWuT5pdmcho/b6+3V3uTcEYuyab4oPKWLU+8LmZ
 M5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700698654; x=1701303454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhRYRi7vANkjLCTUL1asmQ357tOqr1+NqvoT+6py0Os=;
 b=S0o5UTpl5SrB4RiF31Wi0Ys9oVUK4j/JWb8jgNvZs0ab7u+ePFrJ+tk5Ylhd64iiSk
 jyZJSOd3ccrQbayZNaUOUyG+07ubHUgXaV5RXxcPHrKOf+RlpH50CHrfPX5breqZCQHe
 +0yAGrTIeckS4cvP8kTaKe6CT0nugJAWm7KPahWwfSSAiU3XWIbwt+WSr1S9bhFjmi50
 tVeNkRPcjzwAXCLE/tE6u4fcmQFE9NtJHrcZI/4uryVOHwuP1ZCFiras5pmcvjt/lyVx
 qYDYdd3xwxBYa0Y1vD1BrrKFhGonZDyAstfTMvt2FM+Lh1CkFdyynDjXPCNSD27Frvug
 gjQQ==
X-Gm-Message-State: AOJu0YwegcuXqNVHEUaNgRzHsIrCLMGc3TwutGdAJh2Z40XX335Qdfpm
 kUj4Swgo6w1VEMsdmdJol2kysA==
X-Google-Smtp-Source: AGHT+IEmQPBAD7TRbg2ZcP7UEiMz/wJ1L6buvdcAmN8td2nhx1Ib6SlUSM3Ztrf8HrrvwatWmcViCw==
X-Received: by 2002:a17:902:e80a:b0:1cc:361b:7b10 with SMTP id
 u10-20020a170902e80a00b001cc361b7b10mr4647408plg.24.1700698653660; 
 Wed, 22 Nov 2023 16:17:33 -0800 (PST)
Received: from patrick-ThinkPad-X1-Carbon-Gen-8.hq.rivosinc.com
 ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 jh9-20020a170903328900b001c0de73564dsm3289plb.205.2023.11.22.16.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 16:17:33 -0800 (PST)
From: Patrick O'Neill <patrick@rivosinc.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org,
	Patrick O'Neill <patrick@rivosinc.com>
Subject: [PATCH] RISC-V: Increase max vlen to 4096
Date: Wed, 22 Nov 2023 16:17:09 -0800
Message-ID: <20231123001709.64934-1-patrick@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=patrick@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Nov 2023 20:43:00 -0500
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

QEMU currently limits the max vlenb to 1024. GCC sets the upper bound
to 4096 [1]. There doesn't seem to be an upper bound set by the spec [2]
so this patch just changes QEMU to match GCC's upper bound.

[1] https://github.com/gcc-mirror/gcc/blob/5d2a360f0a541646abb11efdbabc33c6a04de7ee/gcc/testsuite/gcc.target/riscv/rvv/base/zvl-unimplemented-2.c#L4
[2] https://github.com/riscv/riscv-v-spec/issues/204

Signed-off-by: Patrick O'Neill <patrick@rivosinc.com>
---
Tested by applying to QEMU v8.1.2 and running the GCC testsuite in QEMU
user mode with rv64gcv_zvl4096b. Failures are somewhat reasonable and on
first inspection appear to be in the same ballpark as failures for
rv64gcv_zvl1024b. Since I used tip-of-tree GCC I'm expecting those
failures to be GCC-caused & from skimming the debug log they appear to
be.
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..2ff3a72fc0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -97,7 +97,7 @@ typedef enum {
 #include "debug.h"
 #endif

-#define RV_VLEN_MAX 1024
+#define RV_VLEN_MAX 4096
 #define RV_MAX_MHPMEVENTS 32
 #define RV_MAX_MHPMCOUNTERS 32

--
2.34.1

