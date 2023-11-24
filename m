Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F16997F6C6C
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:42:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Prl-00021p-NC; Fri, 24 Nov 2023 01:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Prj-000218-8b; Fri, 24 Nov 2023 01:40:39 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Prh-00066d-Ti; Fri, 24 Nov 2023 01:40:39 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b2f507c03cso889813b6e.2; 
 Thu, 23 Nov 2023 22:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700808035; x=1701412835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAfZHkGk9vxz48DJuLY5Nn6nkh7yrBPGZD6fhwC4MOM=;
 b=X6PJ0dE6XiD6t72D84hcUe2T8RcV8FVAPxr2+G8PipK+Rn5V59zv3/PGFAxFT7vFuN
 0xwbF0d4Rw55L+P+b9VFc6+FOTp9aRcXB5RLZQ7Ckdva4BdnHqpkHbiTFfogrff+XK0i
 kEbPhYwQn006FQvFdRESxfMLPOFHN6HOvAkujwJMNeJKxFzfrB+KmUFXHcMSkCDr84rG
 G23zAnFZVeWUG4DeSLFRBme6DTe8hTZnhEG6eOhEnKILSvrmmtWiymqwkj/sD8panTLL
 4M+ASpKpe1RoahxXS5yJSpcEzgJv/bEPImSYdqWszPnfHMVR7ZM2VKeX7kv3s+ZASOdD
 pUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700808035; x=1701412835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAfZHkGk9vxz48DJuLY5Nn6nkh7yrBPGZD6fhwC4MOM=;
 b=oC307pBYRiR99lQmaySyZ/7RkeT5jVGUX+n2T3DZ1Vi7zgK4pDc00LExdIR6BuB80N
 3MA1SHky0ru9/bnOIFjSNvGbRatMLCJK3OXCUjbz/KBy09ncupZy0cW1okCvdS4mm6vv
 E6g/J16Usn/3PzzfAmxV2hdLIQJYpN6wPIuXatEXSVlo95pGLwiKb6lRGfNiSGdNdZLO
 XvI3gLaO+NRKDz2E6S2njaBwXA+w9vzoz6fHLKelEd3Aqa6Oahaociy8XecCasUAKJ/z
 /e+UbnypcPfr5Rwe7GjQ/l7yWuMM/D1w2+LBRIq/5q2heEWdMOZ1M345q6c8fG0Vpa3e
 LG/Q==
X-Gm-Message-State: AOJu0YxbEQaFHcWe5lxbfnE2PS06IKvCjFzpgwJZmQ7qAW8qVmRwAiaj
 5Qj9aOl8LFCT+vKjzbK6hjKwcGD3y+im9Q==
X-Google-Smtp-Source: AGHT+IF+0nJa0g3T1W39U+RzyA2X2Di888/6Fk3wGIFxFAd1YvYDVxNxMGnPjjE7v7AD8xSQAqId0Q==
X-Received: by 2002:a05:6808:1520:b0:3a9:ea90:5901 with SMTP id
 u32-20020a056808152000b003a9ea905901mr2080819oiw.56.1700808035400; 
 Thu, 23 Nov 2023 22:40:35 -0800 (PST)
Received: from wheely.local0.net ([1.145.239.154])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a62f249000000b006cb8a8a4bbfsm2152013pfl.186.2023.11.23.22.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 22:40:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] target/ppc: Rename TBL to TB on 64-bit
Date: Fri, 24 Nov 2023 16:39:55 +1000
Message-ID: <20231124064001.198572-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124064001.198572-1-npiggin@gmail.com>
References: <20231124064001.198572-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x235.google.com
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

From the earliest PowerPC ISA, TBR (later SPR) 268 has been called TB
and accessed with mftb instruction. The problem is that TB is the name
of the 64-bit register, and 32-bit implementations can only read the
lower half with one instruction, so 268 has also been called TBL and
it does only read TBL on 32-bit.

Change SPR 268 to be called TB on 64-bit implementations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c  | 4 ++++
 target/ppc/ppc-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f380342d4d..8c00ed8c06 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -460,7 +460,11 @@ void register_generic_sprs(PowerPCCPU *cpu)
     }
 
     /* Time base */
+#if defined(TARGET_PPC64)
+    spr_register(env, SPR_VTBL,  "TB",
+#else
     spr_register(env, SPR_VTBL,  "TBL",
+#endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index f9acc21056..ffaff59e78 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -103,7 +103,11 @@ const MonitorDef monitor_defs[] = {
     { "xer", 0, &monitor_get_xer },
     { "msr", offsetof(CPUPPCState, msr) },
     { "tbu", 0, &monitor_get_tbu, },
+#if defined(TARGET_PPC64)
+    { "tb", 0, &monitor_get_tbl, },
+#else
     { "tbl", 0, &monitor_get_tbl, },
+#endif
     { NULL },
 };
 
-- 
2.42.0


