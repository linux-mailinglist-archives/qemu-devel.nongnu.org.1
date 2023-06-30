Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08E7435C5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8YM-0005Y4-As; Fri, 30 Jun 2023 03:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.nowakowski@fungible.com>)
 id 1qF8YK-0005Xq-M1
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:28:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.nowakowski@fungible.com>)
 id 1qF8YJ-0000KE-0e
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:28:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b8303cd32aso12530915ad.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fungible.com; s=google; t=1688110101; x=1690702101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7NIXm3S2ofFeqF888HBnrL1QNbDutjXr9HIiL252Hzs=;
 b=RvR4tSBqartgDm1lg2wyg3JTS6rWyxOVOrpBH5gIcznBEsy7A0gP6o3nvna8erZThL
 /CAZ8h/P5MqlPl1AQyQgVQ3vsa1YEjgtTp6eZ7db1jT+DtIta2SxcOQME3K+wZ4v6oAj
 0C7+oRvQcg8w4JgyDJZz8otU773p+42746P1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110101; x=1690702101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7NIXm3S2ofFeqF888HBnrL1QNbDutjXr9HIiL252Hzs=;
 b=NC9MRG/z50dv2PvrxUt7n6hJBRdJocTepEjnZTVRpiDFzaTEkTSBXQIHf7abWfgpEL
 /QGRwz4cNB7ENUbpuJ9KrtgWWILjMHDpGAr61+bzF87l/yFrrY9mMw3LVca68NBpgv/G
 1+9ha7im5CvNNWC6cMmCZWuqPGNQ4trPNFIHmt7/hrwySEXt/IhVr4NhkEUGKOhlfXoT
 /NF3K1xFsQxc1+98Zeq2xL0WgH199yxijr8xTF5P4J/Fft3QjkKeFDZKWX/ebC5oyhxL
 0E9AO9rQoOwpA9lPK51IOJw4+XwenGHSDT+v88yz/ULsDwD1cEl/0zoeMZ04pYtrsB8N
 XZ2g==
X-Gm-Message-State: ABy/qLYBH83jU+W8drI979jZJC+OXZ5iB/GNtGCm2SLs3CIBJYIo/VIk
 fgYGzrX/ANONHshXSxUrTe4JAw==
X-Google-Smtp-Source: APBJJlFynGo/KSCYKqPo9LlvlFMzYtuKeAZxu9P66vhSlfXmfWQnHs6sd6P7YFQmciqRmKNX4CLqAg==
X-Received: by 2002:a17:903:481:b0:1b8:36a8:faf9 with SMTP id
 jj1-20020a170903048100b001b836a8faf9mr1143030plb.38.1688110100871; 
 Fri, 30 Jun 2023 00:28:20 -0700 (PDT)
Received: from WR-NOWAKOWSKI.fungible.local
 (dynamic-78-8-247-128.ssp.dialog.net.pl. [78.8.247.128])
 by smtp.gmail.com with ESMTPSA id
 jw19-20020a170903279300b001b7ed16c7ffsm9381416plb.306.2023.06.30.00.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:28:16 -0700 (PDT)
From: Marcin Nowakowski <marcin.nowakowski@fungible.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] target/mips: enable GINVx support for I6400 and I6500
Date: Fri, 30 Jun 2023 09:28:06 +0200
Message-Id: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=marcin.nowakowski@fungible.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
so indicate that properly in CP0.Config5 register bits [16:15].

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>
---
 target/mips/cpu-defs.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d45f245a67..da122e72d7 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -709,7 +709,7 @@ const mips_def_t mips_defs[] =
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
@@ -749,7 +749,7 @@ const mips_def_t mips_defs[] =
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
-- 
2.25.1


