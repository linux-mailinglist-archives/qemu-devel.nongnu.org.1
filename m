Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E8763F44
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:10:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAg-00043N-HP; Wed, 26 Jul 2023 14:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjA8-0003sX-9W; Wed, 26 Jul 2023 14:23:07 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjA6-0008UO-MB; Wed, 26 Jul 2023 14:23:04 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b9b52724ccso62229a34.1; 
 Wed, 26 Jul 2023 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395781; x=1691000581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZQTChBYLoqHBg/YGc0TeJy3uEDe22OcFDiFrIsmZvA=;
 b=FJv+P7Cj3SdeNBq230/tt5yiRrRgiRu45XvmZSfhDlK8MUyxKUVen80z/XkPZkt2zC
 VtBDExK2pI0GoJ+BEXC/mJP3CaEfa4yhUaxjAiP8lmUrbIKsT0kfYmBSf3R8DyNSvkNT
 f0foY/nap43eOoZn+qwGlzXWdUFKIilLw03JSHVMDaGgFOz/bhBkZn+AX58MQra8HiNC
 Vt+QZHo+I4JoJ7WxprBQzvfG25OHlMBptc0tLMEJwDOKbQhGGUZaurJ/KEuiJ3pVD/76
 ll7j9oINfXDHEJrkdRZhpNT/jFUTl5Z8AIPDd8oGJtIYQ9KbZKfBlT+fJG+pJl8dHi2Q
 HT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395781; x=1691000581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZQTChBYLoqHBg/YGc0TeJy3uEDe22OcFDiFrIsmZvA=;
 b=ZgsWYl3KlcVDsojnGLY5scdQQsE2ErGcJZaobbVcAv3JBoA8DmeHXUrhXKG0pPHwLD
 BcgvwhW1B2G588OJHU44+O+QKf8ZU65nvYvJxcQXQMJpo61jXYO2+RISUSJDjvX8f4X1
 cNauqC5WfOdMedjNCy8xb0ZDwrBnU81atCSRibWhYyWpk2duXy1ldxVmynCzPXKsmdhz
 07c1KNn6GD6awKv6naPXHIdoSrUw9U7ATldfaGPrx1Nwk5KVro+2sYtsaXXo9jikHO5N
 pJcoX5aijCbsrbjZbtc5qBoxzPwEpYYeAc3t3AWF/S0OHrQ7eTlXwolBp0YoKc6CoI7I
 Dnyw==
X-Gm-Message-State: ABy/qLaC/58eOI7Aboc6Q0gmMTIIIMWdlrj6FNJQDQ+CWu/x0AsoO1nd
 Q5EzpZN/12h8RBoMyqtlgk8=
X-Google-Smtp-Source: APBJJlHje8nUVDReIA09Qwl2vMWRuzqyeNeAFmmIDlwgm5VOF8QsyI6bBTs0gg7JToIvVD9Biz6U/Q==
X-Received: by 2002:a05:6358:41a3:b0:134:de8b:17f0 with SMTP id
 w35-20020a05635841a300b00134de8b17f0mr2606054rwc.19.1690395781046; 
 Wed, 26 Jul 2023 11:23:01 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:23:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/ppc: Always store the decrementer value
Date: Thu, 27 Jul 2023 04:22:29 +1000
Message-Id: <20230726182230.433945-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
References: <20230726182230.433945-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x331.google.com
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

When writing a value to the decrementer that raises an exception, the
irq is raised, but the value is not stored so the store doesn't appear
to have changed the register when it is read again.

Always store the write value to the register.

Fixes: e81a982aa53 ("PPC: Clean up DECR implementation")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fa60f76dd4..cd1993e9c1 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -812,6 +812,11 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         return;
     }
 
+    /* Calculate the next timer event */
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    next = muldiv64(now, tb_env->decr_freq, NANOSECONDS_PER_SECOND) + value;
+    *nextp = next; /* nextp is in timebase units */
+
     /*
      * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
      *
@@ -833,11 +838,6 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         (*lower_excp)(cpu);
     }
 
-    /* Calculate the next timer event */
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = muldiv64(now, tb_env->decr_freq, NANOSECONDS_PER_SECOND) + value;
-    *nextp = next; /* nextp is in timebase units */
-
     /* Adjust timer */
     timer_mod(timer, muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->decr_freq));
 }
-- 
2.40.1


