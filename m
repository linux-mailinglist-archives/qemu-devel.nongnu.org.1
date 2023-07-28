Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ABD767740
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTaH-00034C-0E; Fri, 28 Jul 2023 15:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTaC-000333-Kj; Fri, 28 Jul 2023 15:57:05 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qPTaA-0004nV-UM; Fri, 28 Jul 2023 15:57:04 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bc886d1504so709057a34.0; 
 Fri, 28 Jul 2023 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690574221; x=1691179021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNd4lGcG2nXcrLV397u9c957Nllm0VNTbLBPXZQ7+Gw=;
 b=pdKREY0ATDtTn4HZmksdgK0WYS7hNEwRPk8h+if7hpWPIudB69b4cJFPwXtDrGD1/p
 tTjVYkxPtMK+8wQCVi1IHb/TbKWZT+ptOuC/MT24PH58RMdwQzx/EFWTolFuee0JDhKZ
 T//7GYefLSX6SpAvUgse/+XI8yeTijynuse1PxPVCk5XOuCkXT/tiJxCCEMMwS6thcvc
 Qb2hFjq4gVp3FmnaIJ09okgM980trCYtt4Z9q1Ko1pkFppCoSZTit5TNz86rFqClDpJL
 jUnTx6O5p42XuRWy0WbofuBESUibxMnyL4Ww0ch5BPUHGf/QN11aVXrQvzKWTnPJToVl
 hPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690574221; x=1691179021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNd4lGcG2nXcrLV397u9c957Nllm0VNTbLBPXZQ7+Gw=;
 b=jILPpxXEQBBEZBjtQhpGK+q5H89NiDA39PuZHrJyc7tunnQ/SrG7KOafBNh7yvYm97
 pVOOHTVrJ9/fG0kwWPcDWXlWz4dna0YFEP20HVvU55ASY7arO5XNgHRLt2w6xiJ8e5ki
 mYnfl4x6gZ0Lud3hHCGDF24N0ppYpSFgcX5rec/hduSTqZXspsyZth5zI0msogivYX/S
 mwevViVexZSZwUt32j+FYQQc1e/jfi8pzDcXkjsBLrDUfkU5EyM11L06QkFFR8W63iIw
 3JYkJnPldLte+F98F0lR7lcVD2DRT232ahFR/BzObJf3EK8jhktG2qpYtKn3CX9Yg7/z
 1yrw==
X-Gm-Message-State: ABy/qLZ+RuKuQs0DLCER/pUxD7/PJjhfwJ/izve/tzp/O/QM7BKe3KID
 12DoEf7cUektbhz9iyr29kDhLcJgrXA=
X-Google-Smtp-Source: APBJJlE/GMJXk1R5IKcJJ9t8wsRCtTHc/HaGImWwFMw7plcNBd7G/Nu/YyT+rl9OPhX16dn3wWTZwA==
X-Received: by 2002:a05:6870:700d:b0:1b4:70dc:972 with SMTP id
 u13-20020a056870700d00b001b470dc0972mr4152016oae.35.1690574220924; 
 Fri, 28 Jul 2023 12:57:00 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a056870180600b001b02a3426ddsm2087050oaf.14.2023.07.28.12.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 12:57:00 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH for-8.2 2/2] target/ppc: use g_free() in test_opcode_table()
Date: Fri, 28 Jul 2023 16:56:46 -0300
Message-ID: <20230728195646.168997-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728195646.168997-1-danielhb413@gmail.com>
References: <20230728195646.168997-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x330.google.com
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

Use g_free(table[i]) instead of free(table[i]) to comply with QEMU low
level memory management guidelines.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e6a0709066..d90535266e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7129,7 +7129,7 @@ static int test_opcode_table(opc_handler_t **table, int len)
                 tmp = test_opcode_table(ind_table(table[i]),
                     PPC_CPU_INDIRECT_OPCODES_LEN);
                 if (tmp == 0) {
-                    free(table[i]);
+                    g_free(table[i]);
                     table[i] = &invalid_handler;
                 } else {
                     count++;
-- 
2.41.0


