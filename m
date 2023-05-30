Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA671610F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z2r-00068U-WC; Tue, 30 May 2023 09:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z2f-0005bk-J5; Tue, 30 May 2023 09:05:38 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z2e-0002YX-3o; Tue, 30 May 2023 09:05:37 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2564c6a2b7dso1875538a91.3; 
 Tue, 30 May 2023 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685451934; x=1688043934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gA6mc//DvArxxfqKhwKil+8XPEtecMlW4/szXoNhYhg=;
 b=U6wJt1uYT7eh/8D7Y0aMCLyyHhhRoHQnRfrFypOZDnZ1/s1CIL9N8s3SK1YvtF3L3y
 uafUa3/nyK3lp1ja9p/lJTg8XUosrvE0Y0PsQosG6GnnA1zvarE367hQUiOYaS0GK8+0
 EclqZy3+uS3vyeWn28/xPuQbKlDY2fphCFmMpozBxFv8MIzuUKa2HSHJdrZUyftYc3ws
 BrUP16ifQ7Qu+FEeMfdbV+m9lMZ7jSNpkOPazHd1orXXt3fXJo5IBCniU3ebzq+BxdxR
 +q1ot2mD2PLLu+C/wcoKxYYv3OJq/gz9vbpYsVcjrO1dgmsotu94F6D/gTiGmo2P3jWc
 Fk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451934; x=1688043934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gA6mc//DvArxxfqKhwKil+8XPEtecMlW4/szXoNhYhg=;
 b=RnprYDqSEQlYCt86vEYKHaFw05UYcJNaUtnbPoXNxtWpr/io6A+AY7dSdh5+xgBOt+
 IKFS7ficsmgZDBwG+Jc8jWsZ/G+mkG4o95RlQdW/gplMDZHHXXFm9QLIFN+C/m6N6vbf
 ZjlSNpNx0RiI/5CBaFOdmQF7kVaIp/H/5EudlIc2rlmvaXDdMuTtMTeYTM4wJtjcSzvy
 8J9mdirHtZYhBWgpT/PRIsurwYRdZbxd60hZLXAZ+7IZVBL68wxQhH+HJzvj+IWVvoxS
 e4oNYNl4slqbrW+BqgHE4NwR90hKf4lYu9eddHcp4pOlGI+6RrQv5MIbaISe9DFFyiU0
 xpdw==
X-Gm-Message-State: AC+VfDwWSTyM/NAH8rnjFT2/hCCF9d5ctRBXd2ECJEOi8sU2hmT+NZhU
 8/aGuEmRkRd9t6GQxEbc21mXBCdGJB0=
X-Google-Smtp-Source: ACHHUZ6Ooy8ddBFshezVarS2ve7bWmGJXq3hx8bBb4mo0J9n0zKEgcchBg1nmRMigF31u/XhkCOTmg==
X-Received: by 2002:a17:90a:ec18:b0:244:9385:807f with SMTP id
 l24-20020a17090aec1800b002449385807fmr2432156pjy.44.1685451934026; 
 Tue, 30 May 2023 06:05:34 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a17090a578300b00247735d1463sm8781142pji.39.2023.05.30.06.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:05:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v1] target/ppc: Support directed privileged doorbell interrupt
 (SDOOR)
Date: Tue, 30 May 2023 23:05:26 +1000
Message-Id: <20230530130526.372701-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

BookS msgsndp instruction to self or DPDES register can cause SDOOR
interrupts which crash QEMU with exception not implemented.

Linux does not use msgsndp in SMT1, and KVM only uses DPDES to cause
doorbells when emulating a SMT guest (which is not the default), so
this has gone unnoticed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Another stable candidate.

 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fea9221501..add2bc6bfe 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1539,6 +1539,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
+    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
         break;
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
         msr |= env->error_code;
@@ -1584,7 +1585,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
-    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
         cpu_abort(cs, "%s exception not implemented\n",
                   powerpc_excp_name(excp));
-- 
2.40.1


