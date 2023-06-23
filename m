Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89E73B29B
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCc1x-0000fr-Cr; Fri, 23 Jun 2023 04:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1t-0000dX-6P; Fri, 23 Jun 2023 04:20:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1p-0002lz-Pv; Fri, 23 Jun 2023 04:20:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-666ecf9a0ceso152720b3a.2; 
 Fri, 23 Jun 2023 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687508423; x=1690100423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2MH4VazMgtpKVZkWlVs9pGXSlLjfIVFBDMD0/bLia4=;
 b=b2rgyYMaoOAfnVeURC9CIRhYOm4VUUoIabJpCpkmhMapJCeSeGQlCZvKlDAgaNd4TG
 MRISqcDSwkCf5I/1fkAZH4cmtDWsyJhTHbfaNZPT2o/8bplA0GBjmGWrPhDqbmd6cf2u
 78tUFNDO48H3rc56onj9Ou99mXQmi/qJ7l/5x2M/MjR4SKRciClAs2clCNJA5enpWRdm
 I1VhpNvuZdj1q5+2EdIh7GifAZtFDFYL7DF1PB5O8kUvnU/LLgnIvjolROdXS85KwzPs
 d6o77EF55oDvlXWahikbsE0Oj+dlp/SjL6O8rAblGTigyMqmjav2oLkVNvVhYyXFgYSq
 vM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508423; x=1690100423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2MH4VazMgtpKVZkWlVs9pGXSlLjfIVFBDMD0/bLia4=;
 b=S7g14pkkp7+4Ctycn8QoxGBSBKDC/n1Oukb7yoPa/Wqus4VCdqPzzxJM1RzYfnltqe
 N52ag8Qi44qTewBVKaSC47RHh4NDKZYbyOmIzzSCd5CxWOTdxpdX/EJDlL3Ey38L14t4
 5Dn4CQb0AG/4jbhRIGqlXLq3AYEOuo+NuZKpFL+iANVT6oPBasaCTtoap3xyEz+afrhZ
 bpva/UK2sQbkqp0hpqZ37gQNbbCh9aqkW8sHdjVzyHhkpmNQKT8bOcKyqNDKp0ubTY+w
 S2zrD96SWpLt/+QoVURoczmZGBmwxDMk+xRCdhtLffaOSf5ZkN1feXYhSKoS1VNSkGTD
 EXsA==
X-Gm-Message-State: AC+VfDx5rzy1Jzigfm9V2ukq7TZ1C7G2Eu5OImyHENT+xiTqQnxyv/lI
 RDX9xTSROBmknZmvQ+3DUFWdtTnEK4Y=
X-Google-Smtp-Source: ACHHUZ7/gHnVryNP1x34z6x/SB74LU9UG3BUbT2gky/wdgbBZfgT0Cyc1xpCm1oL4GDbO8on6gXvBA==
X-Received: by 2002:a05:6a20:7f93:b0:10b:8bc7:e112 with SMTP id
 d19-20020a056a207f9300b0010b8bc7e112mr22140741pzj.10.1687508423195; 
 Fri, 23 Jun 2023 01:20:23 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.231])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a62e70f000000b0066884d4efdbsm5780604pfh.12.2023.06.23.01.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:20:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 2/4] target/ppc: Add POWER9/10 invalid-real machine check codes
Date: Fri, 23 Jun 2023 18:19:51 +1000
Message-Id: <20230623081953.290875-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623081953.290875-1-npiggin@gmail.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Implement the correct register settings for  the invalid-real access
machine check for POWER9/10 processors.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c9bfa3a827..1c26828d8b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3139,8 +3139,6 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     case POWERPC_EXCP_970:
     case POWERPC_EXCP_POWER7:
     case POWERPC_EXCP_POWER8:
-    case POWERPC_EXCP_POWER9:
-    case POWERPC_EXCP_POWER10:
         /*
          * TODO: This does not give the correct machine check code but
          * it will report a NIP and DAR.
@@ -3149,6 +3147,30 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
             env->spr[SPR_DAR] = vaddr;
         }
         break;
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        /*
+         * Machine check codes can be found in User Manual or Linux or
+         * skiboot source.
+         */
+        if (access_type == MMU_DATA_LOAD) {
+            env->spr[SPR_DAR] = vaddr;
+            env->spr[SPR_DSISR] = PPC_BIT(57);
+            env->error_code = PPC_BIT(42);
+
+        } else if (access_type == MMU_DATA_STORE) {
+            /*
+             * MCE for stores in POWER is asynchronous so hardware does
+             * not set DAR, but QEMU can do better.
+             */
+            env->spr[SPR_DAR] = vaddr;
+            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
+            env->error_code |= PPC_BIT(42);
+        } else { /* Fetch */
+
+            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
+        }
+        break;
 #endif
     default:
         /* TODO: Check behaviour for other CPUs, for now do nothing. */
-- 
2.40.1


