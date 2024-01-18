Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D0831C04
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:08:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTz3-0006yE-0B; Thu, 18 Jan 2024 10:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTz0-0006nx-1i; Thu, 18 Jan 2024 10:07:06 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTyx-0007qI-JC; Thu, 18 Jan 2024 10:07:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d5f252411aso20448425ad.2; 
 Thu, 18 Jan 2024 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590421; x=1706195221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMmT9LlWmR0be5frrmNsGXpn4bRVMr0KDaW3xzcbnjw=;
 b=NkQUoxKGvyTBsw0QnnN1FljbOpwn8RDjfHiukrDDFo9BP1F0NWRfroMXAuOIN+Tyal
 9Fe2LJfZi8mg/cWeTxYxpUWE/kZQHSmtxMhHJDhZWvTQ3dQzankj1QINN3oXWw0vIEBP
 tVB9WN/Jt8qbmIBfbs5rUoRn1/I/dc1ZbokOUseES9kgNGngRuacOj+y5s4YBXhyp1yF
 f2/qF57PpCeIVQjSFobaSIEfA1JfdnG/ng/BMNywzIlcnwbITSjKDc7XoRGeraXBjoWy
 mOjAj9Uv69eW5HagQP7Xzhy80+cd2p77yMb6mlp0pvrTmhHqjmYgTfmw9aEDtQK6ziIA
 mXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590421; x=1706195221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMmT9LlWmR0be5frrmNsGXpn4bRVMr0KDaW3xzcbnjw=;
 b=Hg7DTg7SarR++DheizdWIMQkFV2fq2/ElClvRiwguu0zZ0nZq0PhjybYPCZXagRD0b
 yCA1dCNm+fiLKPwbMQDl+7gSyWkQ/J1kyfl8bept77rKkFEupamP/IFQ4uObfnsQSIm9
 8cGK53B1UH8CessPoS3Gh4Q9mUqIkAPiYMkKVLou2VTsGbjLfMdEtaOb570PgO8eWJNJ
 s8rok8EdrznB6cu77AaY+7l6ew8vkHIT6hujtP0/lzBa1uHvGecYFehOhV1xRTbRxPJY
 2Aq4Hn3sjPh2+oOAML6ebNu0lVjGO2qvsMQSGd95i/tuoO9eLHFG3azmbzFS9wxPhe0X
 Sk0A==
X-Gm-Message-State: AOJu0Yx2X+6YMGlvYdmh//jlWbHfKQdHcutXh2kMBF5hhrdv0sFCjHnv
 BBlBW4A4NZ+ZkrcibqpFSF1vRPdMVVODgZLR089EfD+TrFI7VGLTjA+ijDq6
X-Google-Smtp-Source: AGHT+IE6/+3casoEFnUVP8dJxfMz/7u+PVSqWXQTo/WwUKE9uvEaAbUdn2Izm/eXYbMr8351EbHuWw==
X-Received: by 2002:a17:903:11cc:b0:1d5:bc2d:8cbf with SMTP id
 q12-20020a17090311cc00b001d5bc2d8cbfmr1086710plh.53.1705590421464; 
 Thu, 18 Jan 2024 07:07:01 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 01/26] target/ppc: Fix crash on machine check caused by ifetch
Date: Fri, 19 Jan 2024 01:06:19 +1000
Message-ID: <20240118150644.177371-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
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

is_prefix_insn_excp() loads the first word of the instruction address
which caused an exception, to determine whether or not it was prefixed
so the prefix bit can be set in [H]SRR1.

This works if the instruction image can be loaded, but if the exception
was caused by an ifetch, this load could fail and cause a recursive
exception and crash. Machine checks caused by ifetch are not excluded
from the prefix check and can crash (see issue 2108 for an example).

Fix this by excluding machine checks caused by ifetch from the prefix
check.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2108
Fixes: 55a7fa34f89 ("target/ppc: Machine check on invalid real address access on POWER9/10")
Fixes: 5a5d3b23cb2 ("target/ppc: Add SRR1 prefix indication to interrupt handlers")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2ec6429e36..030260e8a9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1322,6 +1322,15 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     }
 
     switch (excp) {
+    case POWERPC_EXCP_MCHECK:
+        if (!(env->error_code & PPC_BIT(42))) {
+            /*
+             * Fetch attempt caused a machine check, so attempting to fetch
+             * again would cause a recursive machine check.
+             */
+            return false;
+        }
+        break;
     case POWERPC_EXCP_HDSI:
         /* HDSI PRTABLE_FAULT has the originating access type in error_code */
         if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
@@ -1332,10 +1341,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
              * instruction at NIP would cause recursive faults with the same
              * translation).
              */
-            break;
+            return false;
         }
-        /* fall through */
-    case POWERPC_EXCP_MCHECK:
+        break;
+
     case POWERPC_EXCP_DSI:
     case POWERPC_EXCP_DSEG:
     case POWERPC_EXCP_ALIGN:
@@ -1346,17 +1355,14 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPU:
     case POWERPC_EXCP_VSXU:
     case POWERPC_EXCP_FU:
-    case POWERPC_EXCP_HV_FU: {
-        uint32_t insn = ppc_ldl_code(env, env->nip);
-        if (is_prefix_insn(env, insn)) {
-            return true;
-        }
+    case POWERPC_EXCP_HV_FU:
         break;
-    }
     default:
-        break;
+        return false;
     }
-    return false;
+
+
+    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
 }
 #else
 static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
@@ -3245,6 +3251,10 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
             env->error_code |= PPC_BIT(42);
 
         } else { /* Fetch */
+            /*
+             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
+             * the instruction, so that must always be clear for fetches.
+             */
             env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
         }
         break;
-- 
2.42.0


