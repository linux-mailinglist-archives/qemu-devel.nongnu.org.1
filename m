Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD1763F76
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAf-000426-Oo; Wed, 26 Jul 2023 14:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjA0-0003rg-Mr; Wed, 26 Jul 2023 14:22:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9z-0008SK-5F; Wed, 26 Jul 2023 14:22:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686efb9ee3cso103480b3a.3; 
 Wed, 26 Jul 2023 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395773; x=1691000573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPFNgLtuXEMW3RIJM7zOTpIuZJEYRDjteVhC8Ic/foo=;
 b=CqCUScvBw8ms0iPDMtX3W6zZ9ayNbbtAelie522QN2l/TCxVZhmkjCQW20aN4nuhSe
 Zo7SfwhUxnwhXijTTlPt6mJmqZx+EyuWV6dx4hz268zmq8zdJpH4RlLUxVlMY7R5q5/a
 L56zs2GPpf37JQEct2bZGyYN8KzB5DzbYgaXDbRJeUSar+7jPayWJWiFcEj9n+L6OkKM
 +spW3LVYSy0gnLBG5/0JHoUrUWlCrxaBJfhwMVGo4hbKm6FGw/V5sBG8H7BFsIhvaYX5
 qyvA8b4EpfuQoXjRTVZV9WVd27drzMVML/jgImYX1oYRuLp+mIlZ7sAWmQdQ5gXSiOc0
 MQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395773; x=1691000573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPFNgLtuXEMW3RIJM7zOTpIuZJEYRDjteVhC8Ic/foo=;
 b=TonMhVYKPqp8jtLUA/3I+eIre++n052Fs1x5LQFN0sq/xz7XmNf0Hwljama3BwyvWp
 ry9CpP/fjYxfS6tdJDkvou91L2QK5wDU1eTIxa47sjItEocYdo2MXzn4rq9meTGzkNHB
 HR7+lBjnglROCm+qaMTkwnrY/4JJxcOt79rINZQZcr+B90U20/lkmAB+VKV8kf1fjF+D
 EDf1TzM6dGlo1tbUsPv1S3fOlxWskLhNDiZVwGuj7iEcjc7x0crO7ISUHMwkv6327OcZ
 cJeaUem28V2aZ7o7Dx9+KHShZdT1n0hLoARMNkcEFTt5Cuid6KmjhzdM0AUniRkPIegb
 2QFw==
X-Gm-Message-State: ABy/qLaBX5fpzVO95pBMt8kBuhzicy/Vw+0yltzOO+vgdzXuwAZiFSs+
 6UIyvUzwZzooDKQrEUvZ5I4=
X-Google-Smtp-Source: APBJJlETfK/BxWqSAOAw7hcVCZE0qVnwtHYTa82wFMXuAMlruP8ofvtuipHseQa8iI8sp9SNEBuVew==
X-Received: by 2002:a05:6a00:2d8e:b0:682:616a:f910 with SMTP id
 fb14-20020a056a002d8e00b00682616af910mr3459302pfb.20.1690395773200; 
 Wed, 26 Jul 2023 11:22:53 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:22:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/ppc: Fix pending HDEC when entering PM state
Date: Thu, 27 Jul 2023 04:22:27 +1000
Message-Id: <20230726182230.433945-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
References: <20230726182230.433945-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

Fixes: 4b236b621bf ("ppc: Initial HDEC support")
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


