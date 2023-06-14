Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249FF72F20F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:36:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFr-0006E6-Rf; Tue, 13 Jun 2023 21:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFU-0005jr-Qo
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFP-00053T-GV
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-650bacd6250so4761094b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705870; x=1689297870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqYjPp66NtVgNcAMiH48m1IIJyKmfxBKldx1OZytYDk=;
 b=Et2vnWmJJC/DUjoARyFm80JBYw9HPypFrWQqpDOEYKYJl0mzPI8Q8XZel5enHqn41i
 fpdJWfekVNzWE/TJIGWFUWrGi9rY24Yyh2pjUnufnsb/8kiXQAvta/Go8Uxd9Oub/sEh
 28tEwF0mKU46xd1tdonf3ZF9FmlSy782veDTueCP+nuQddD/trpcKXLaLBa21djj0vdz
 io7UtWjQUUPH6IpDPEJnwx/HRyzaIf6qZtV92YPm1SlgJhrvQXoLbt67bPuNeu/0hOor
 pX+ZQAsOZHgZ1J+HDDwQ3XqOOG1npqQg85QQe0QQFsU802MW3r292Ls+oyraBgQjl3z9
 Uqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705870; x=1689297870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqYjPp66NtVgNcAMiH48m1IIJyKmfxBKldx1OZytYDk=;
 b=D49E2enZhIOmwBpSFTsOeFsDWtzgU9q3bUvY/CbDSM5i0PhgdSW9DQiQ6vNnGC3Pmv
 aObIgPELr4qjtWr6lu0xa8n3wH+NK/eW9oBe6NpK/06p4avhPiUHD1I2ZC2gh6fn33aG
 Jlj0Ffox3lOdzqjjGGPsaXKom5DyWQbe4/VcM5J1FTgeRhRBKiVdnYOrPH7lTNQB/pcs
 4NKpBGCQ6Ex+8a0fi4FeL/yKf9tzIrHuLy3Eql8JymUgPpgaT0uWV7S+4m1Y5BLa0D7g
 1OpEww1Rol45w+T+OVhwxkehAKAJCAVt5pxIfz+z7U66pxzvKiuMmcXLdMo4kJT+Ws01
 a8nQ==
X-Gm-Message-State: AC+VfDytaz2oGxLQt4PX/nbe8Qn3z4E2Y/Wz3kRi78JfMdfo9SRtYXCm
 7RHg8MDKH99ciidm4kCX5PyA2Q5YqAXH1Q==
X-Google-Smtp-Source: ACHHUZ6zEA0Ndg1bTAbiOyyoSx0hLwklJ3Ofp/5XqIPiAhcpPqhe1POo/5fNkdOjmGjCRUT09ltqUA==
X-Received: by 2002:a05:6a00:1489:b0:666:5fc4:36b1 with SMTP id
 v9-20020a056a00148900b006665fc436b1mr166885pfu.26.1686705870043; 
 Tue, 13 Jun 2023 18:24:30 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 59/60] target/riscv: Smepmp: Return error when access
 permission not allowed in PMP
Date: Wed, 14 Jun 2023 11:20:16 +1000
Message-Id: <20230614012017.3100663-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

On an address match, skip checking for default permissions and return error
based on access defined in PMP configuration.

v3 Changes:
o Removed explicit return of boolean value from comparision
  of priv/allowed_priv

v2 Changes:
o Removed goto to return in place when address matches
o Call pmp_hart_has_privs_default at the end of the loop

Fixes: 90b1fafce06 ("target/riscv: Smepmp: Skip applying default rules when address matches")
Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-Id: <20230605164548.715336-1-hchauhan@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 418738afd8..9d8db493e6 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -291,7 +291,6 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                         pmp_priv_t *allowed_privs, target_ulong mode)
 {
     int i = 0;
-    bool ret = false;
     int pmp_size = 0;
     target_ulong s = 0;
     target_ulong e = 0;
@@ -435,17 +434,12 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
              * defined with PMP must be used. We shouldn't fallback on
              * finding default privileges.
              */
-            ret = true;
-            break;
+            return (privs & *allowed_privs) == privs;
         }
     }
 
     /* No rule matched */
-    if (!ret) {
-        ret = pmp_hart_has_privs_default(env, privs, allowed_privs, mode);
-    }
-
-    return ret;
+    return pmp_hart_has_privs_default(env, privs, allowed_privs, mode);
 }
 
 /*
-- 
2.40.1


