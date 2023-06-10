Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB172ABC1
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhU-0004d5-8Z; Sat, 10 Jun 2023 09:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhR-0004Zq-AA; Sat, 10 Jun 2023 09:32:13 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhN-0007cS-02; Sat, 10 Jun 2023 09:32:10 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39c4c3da9cbso1232282b6e.2; 
 Sat, 10 Jun 2023 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403927; x=1688995927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lj1sYz6UyTBYonEWD+OX/F0myjoaI+MWBXnyK3Q9CWI=;
 b=XPa75vjFgQieNI6x067QaaE+ojotc8iRcIczjAM/nMpqv4Mm14IvejtJSyID+nkfp6
 ALntSjP54S467lOST7MUu3cq91YNrYYOakS4cqEC0B6+3XqJrtPI5mBEMS1sExsLCc/R
 SX4lRgr0epuPOrwRBoqDRf69CQEir49kWLG3iI9m5y6tW5ooicDL0JjljlWrQOwXmbu8
 LLXuu/hY9oxXp0wzElBmbvYXHW6jAASlcc+UUvVhx+ESY2orvvuHm7fTrpjVeFhsDjhs
 30g3kHqdAnoUTrU0QUcVdBkv0S0FuCe69zyLp+XBXCVLeFvJR0GmG3Dg1MdEyFXo5OQ1
 sb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403927; x=1688995927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lj1sYz6UyTBYonEWD+OX/F0myjoaI+MWBXnyK3Q9CWI=;
 b=CoZinNivPverQ3j5jt+EQTl0khEhUev4hyD3mh83Ife+qj3cRCeBS5h5zJxRUXbsRM
 b5t7D9FkZ6NcZVdKAHCQJ93xU9Y5dlOCIZUp7KlJUxYoPr8F382+jv3TRtRZ7krsTwDT
 TzFBG/kOwgEt6pbAwBort9gK9Q2NV4euPUuEYslFCbH1FxgTGglO29orqKdWwdM/Wr/a
 ceQpyJLDGh42eXyoh9RcZ9Ca4gCe1z6PNEokYldfDP1TBQmElfMEeDhn00/RVLRT6WrD
 V9zC4pt2gRuC+gHVSMZs8bBsLwCFIvup/+rttzWzK7XdPLDRMOtJjE6/tpHt+Jg+0AdK
 6f/A==
X-Gm-Message-State: AC+VfDyrL90/bnUvrDxMpsI9w9G3uqaKoPtjq9+uQQXWCg6L1uvxSrTh
 nKoP1fLIKyGLOG5SKKggU8INm/kjmP8=
X-Google-Smtp-Source: ACHHUZ5OB1tBU15Jz5SecZgGGd9s1nVC282du/Fq4SsVD2UMkvCyWzKTZ5IOTeHiNHmu8U+50kLLeg==
X-Received: by 2002:a05:6808:2203:b0:398:1047:9e3a with SMTP id
 bd3-20020a056808220300b0039810479e3amr1134709oib.25.1686403927467; 
 Sat, 10 Jun 2023 06:32:07 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:07 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 11/29] target/ppc: Support directed privileged doorbell
 interrupt (SDOOR)
Date: Sat, 10 Jun 2023 10:31:14 -0300
Message-Id: <20230610133132.290703-12-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x236.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

BookS msgsndp instruction to self or DPDES register can cause SDOOR
interrupts which crash QEMU with exception not implemented.

Linux does not use msgsndp in SMT1, and KVM only uses DPDES to cause
doorbells when emulating a SMT guest (which is not the default), so
this has gone unnoticed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230530130526.372701-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index de6ad121d2..befa9aab7f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1542,6 +1542,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
+    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
         break;
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
         msr |= env->error_code;
@@ -1587,7 +1588,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
-    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
         cpu_abort(cs, "%s exception not implemented\n",
                   powerpc_excp_name(excp));
-- 
2.40.1


