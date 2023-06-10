Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05FF72ADA9
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 19:21:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q82Fz-0002BO-0T; Sat, 10 Jun 2023 13:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q82Fx-0002BB-0s
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 13:20:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q82Fv-0007nh-72
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 13:20:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b39d67ea37so6362205ad.1
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686417601; x=1689009601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F4cELDLpHFxYYLs5XWsNulO6w5RqS+fMH20vt5E6+A4=;
 b=M9RlsXuMYqV+XR9GjBKTWVun3Ml3IqDtvIVvz9ymPv4yeQZN4NSSE+z4FB7NP/cLIx
 e2Pj/OpHl5KCpzUPILydyhWpPKpBYm0zQ441D5UKV0TYl9L/VBgMwFylfD9oSqXQ4jdR
 ESZncsOjphjfhcz269ectfvy2Og5B+KsL/7lHrMngax/llmadY7aIciMI0xLAihbL36/
 5FdE5BRtxAgAGATeeK5vQcEEmo+UPzzPIZq68pT+GEzNKRJpQbEJP4h3++Vq/mImcTFI
 aEbWZ7FUQ0/mAsoQ4kpGVYPRMQ71mU//mSXezgENu13gpxPL9ezpMIVuhn92tpsbPYxl
 GeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686417601; x=1689009601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F4cELDLpHFxYYLs5XWsNulO6w5RqS+fMH20vt5E6+A4=;
 b=Rigs5BZ1vVo2fjrjmTYpTviYyCEWoZzq6PXSsbk0C+pxAfbgH0F/tCKnfteIYu6hRe
 hg6mfCiy6hlH+6bbx+JmGcgQoEWK7dRNmd60TMUZ2b9RSZOfMk7vS8HfGIR59zc9ufNH
 RJHU3qTNFcBhitWa0ffKdsGdNhvKZS0FaAaaoS0TfVPg/UNdfYtYPuf6JP5LqgaafpmH
 50F6lZxRIveDJh7zb77q3aqqan5WiDi2Ndkhxu45GF//+nrnFrrfgwFABQLD3mezzfYa
 4RHplU7TfpK84LgDHEF+sGU5I3JM+wskvrI5umITznxYAWzPOEpQZ5NHyimg4nv5R7UF
 H0sw==
X-Gm-Message-State: AC+VfDz9lyWiUlXM8LlSJ/3fhywshB6pJOrZvw43ggJ7JE57Lhd3k+Nh
 aYxk0LsCPG4Eu+kfNsaKjr+a70HKPEvgATSlBOk=
X-Google-Smtp-Source: ACHHUZ5bNUdtxtXBbOd8yscxY3CtUZTfAJTaCdFsrzvMa/kmpS4ZSHB5nH/yXKCx+PwqRyHQujXLZw==
X-Received: by 2002:a17:902:a584:b0:1b2:2c8e:5435 with SMTP id
 az4-20020a170902a58400b001b22c8e5435mr2297703plb.4.1686417601124; 
 Sat, 10 Jun 2023 10:20:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001aad714400asm5234927pls.229.2023.06.10.10.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 10:20:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Sat, 10 Jun 2023 10:19:59 -0700
Message-Id: <20230610171959.928544-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This is a perfectly natural occurrence for x86 "rep movb",
where the "rep" prefix forms a counted loop of the one insn.

During the tests/tcg/multiarch/memory test, this logging is
triggered over 350000 times.  Within the context of cross-i386-tci
build, which is already slow by nature, the logging is sufficient
to push the test into timeout.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Irritatingly, it doesn't timeout locally, so I used staging to double-check:

Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108
---
 tests/plugin/insn.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index cd5ea5d4ae..9bd6e44f73 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -19,7 +19,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 #define MAX_CPUS 8 /* lets not go nuts */
 
 typedef struct {
-    uint64_t last_pc;
     uint64_t insn_count;
 } InstructionCount;
 
@@ -51,13 +50,7 @@ static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     unsigned int i = cpu_index % MAX_CPUS;
     InstructionCount *c = &counts[i];
-    uint64_t this_pc = GPOINTER_TO_UINT(udata);
-    if (this_pc == c->last_pc) {
-        g_autofree gchar *out = g_strdup_printf("detected repeat execution @ 0x%"
-                                                PRIx64 "\n", this_pc);
-        qemu_plugin_outs(out);
-    }
-    c->last_pc = this_pc;
+
     c->insn_count++;
 }
 
-- 
2.34.1


