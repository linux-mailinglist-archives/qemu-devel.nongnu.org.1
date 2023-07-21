Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AEA75BF95
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkTX-0003LE-Fb; Fri, 21 Jul 2023 03:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMkTJ-0003He-8l; Fri, 21 Jul 2023 03:22:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMkTH-0000nW-Of; Fri, 21 Jul 2023 03:22:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bb119be881so12080135ad.3; 
 Fri, 21 Jul 2023 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689924153; x=1690528953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8QbrWNix0Xwr3iBIObSC03PruTplJcrQIiQ2PQqASzw=;
 b=r0El7MnC6Ci8l33PebymWKSXvXIERPbbq3Zn42ywDszgLBatK3qLIy+jek/NJdcsZf
 w0tWfnJ0yicYsg3oPOoI+WlnY2onL6uo6b3IVpGh6gxZWIkOJ72zMM6LCikio/j+ho8j
 1i31kePveSNq2pTpon8wHlDy2Q+f/Ai2uJ+EaVDp2oBPdevPpMaZKF+kH8ji0ODiisck
 ekZUMq6aHzU/hjfR7z+jbRWEJuJHYVfK80XwkyzhmT1vcADQA3pwoQOhRfgtcVKeUlK3
 iCROzrGBX1X/ZdPuiDJM9BEsg1rTpkC1ruCf2PShfGchvKcWn2QvwyLeY1n/YDielaUy
 J93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689924153; x=1690528953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8QbrWNix0Xwr3iBIObSC03PruTplJcrQIiQ2PQqASzw=;
 b=Tfbrg4ucAPtX5aGhKv9hV7y8JFspot2AeNHpLjgmKwjdsv2sDYjSToLypaFN5Z0r74
 wJeotrJ86gZ2KWuvkuGP5Uyx/Q6vQPM20bMNedaKBca2dw+1FylzRMYlDnNFS7SK4kyi
 RJUibulaSh8H23JGczFOHghw/YdXbt4lFkLwgurPAZ6XpnPsdGyP/veRZW4HE/A5CHJ6
 +SkbYI+fWCsmeku7KRAdfgpiGEFNe+sgMvuETmVXkdVkUO3CYCy0MEeWCmx9AotCGZS9
 oR3A1mw1M4FCJkOxREYwLneg4iNFKcmfb9rrYaopklYulrLlQpPCA+aLQ2Ez+B8UhDs/
 NczQ==
X-Gm-Message-State: ABy/qLZhBe18tFW6en2qeaJf4rYEE5nSRqWUI3Tj3qPkqjqx7fCGEiFV
 Hr62ZZss3R319L4LBNfv1tg=
X-Google-Smtp-Source: APBJJlHnz8Rc5dyWyFpZKWu7gBOjegsVlfGzLiD62SGU2Q91ALGI/jpKF6/jYUOLD5lRP170/Ei4Ag==
X-Received: by 2002:a17:902:ba85:b0:1b5:91:4693 with SMTP id
 k5-20020a170902ba8500b001b500914693mr1198051pls.1.1689924152932; 
 Fri, 21 Jul 2023 00:22:32 -0700 (PDT)
Received: from wheely.local0.net ([1.146.51.97])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a170902d50200b001b896d0eb3dsm2703274plg.8.2023.07.21.00.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 00:22:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] target/ppc: Fix pending HDEC when entering PM state
Date: Fri, 21 Jul 2023 17:22:13 +1000
Message-Id: <20230721072213.101081-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

HDEC is defined to not wake from PM state. There is a check in the HDEC
timer to avoid setting the interrupt if we are in a PM state, but no
check on PM entry to lower HDEC if it already fired. This can cause a
HDECR wake up and  QEMU abort with unsupported exception in Power Save
mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 003805b202..9aa8e46566 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2685,6 +2685,12 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
     env->resume_as_sreset = (insn != PPC_PM_STOP) ||
         (env->spr[SPR_PSSCR] & PSSCR_EC);
 
+    /* HDECR is not to wake from PM state, it may have already fired */
+    if (env->resume_as_sreset) {
+        PowerPCCPU *cpu = env_archcpu(env);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+    }
+
     ppc_maybe_interrupt(env);
 }
 #endif /* defined(TARGET_PPC64) */
-- 
2.40.1


