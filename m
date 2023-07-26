Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB2A763F75
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAf-00042d-Vg; Wed, 26 Jul 2023 14:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjAD-0003tm-I8; Wed, 26 Jul 2023 14:23:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjAB-00005O-EH; Wed, 26 Jul 2023 14:23:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-666e6ecb52dso123914b3a.2; 
 Wed, 26 Jul 2023 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395785; x=1691000585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnOO8sOKFvquVVGd7wwV21JSwUZNyJsumnSJEzq/sZM=;
 b=CWspJNPrG6ocNIp/srTsNnlAMFKQ+A5VA9XS0sQLHFdQQMIL0jqQZ7UIssRxDpufZq
 iEV+67KXDx/k/dQyGOhydgUK2eNdRQ7RolThD0BKvQDXHuu3NDU1UVhHk9mXwagfuaHb
 nHEJTOrllz+4G22gx46StbCLYF3sx3WuD38VzA6DIXjbOEcUC51Xh0wQQSwFeacK4Dkk
 NHnmT9MhTLmLnsRnSvB/Uc1NgC5qMN2Yf673mlybG1me+z/E9AppK/EbYXunRVtKpiFt
 eqN1dwSaX7fjPHPiL+KA78xwlZfu2XPnwEDkDX2IgKnrmvWh17YAgRAFbT9LRJXyTg3F
 /ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395785; x=1691000585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnOO8sOKFvquVVGd7wwV21JSwUZNyJsumnSJEzq/sZM=;
 b=dAQIRX+gHRejqrLEjl1/ucpjrsQ3XZL2UfGXcg5k3li35/f8rLEdUAEC9RZxc+1VkU
 7pwxCdnfO8Rxy9aOiEb/fEGG8HCLaF48IGC4mRX1xNG1wExaknWBEj3zNPPEOkwpPKjm
 YPzIkYjw75DDKzGSDvTZj5gNsG8JTfH7tcmk7zoZ2e9iHoqUuI3diOxRo7bcrvcASdrL
 DVU8s7NqodyuYlFtvzBTb4DvTrJHqbllsBf549TcvCvhV8tej0gzukvU3zSt/bSffg/E
 Gz4VxIHriK+guQeKMzZN/DTUSd7DkVbVyvD80z5DchrUp/75v36TuyVEuW8PGTxzI4Z4
 60ZA==
X-Gm-Message-State: ABy/qLbNahy2qA2xY2aFFD+21VR8HeX3bc7EEWFhAWNxdBzPQm2K4rOZ
 Kf3fUD/czXYGotqW+Ml9ohA=
X-Google-Smtp-Source: APBJJlHLSJ3FArhuPFsitrcG00MLlnEXnCEqzCgVVgjpHhNTkjFaUq7g4vzeIBOmxxS3HMy9aiB00Q==
X-Received: by 2002:a05:6a00:849:b0:686:6d87:1cd with SMTP id
 q9-20020a056a00084900b006866d8701cdmr2898903pfk.5.1690395784987; 
 Wed, 26 Jul 2023 11:23:04 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:23:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/ppc: Migrate DECR SPR
Date: Thu, 27 Jul 2023 04:22:30 +1000
Message-Id: <20230726182230.433945-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
References: <20230726182230.433945-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

TCG does not maintain the DEC reigster in the SPR array, so it does get
migrated. TCG also needs to re-start the decrementer timer on the
destination machine.

Load and store the decrementer into the SPR when migrating. This works
for the level-triggered (book3s) decrementer, and should be compatible
with existing KVM machines that do keep the DEC value there.

This fixes lost decrementer interrupt on migration that can cause
hangs, as well as other problems including record-replay bugs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/machine.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 134b16c625..ebb37e07d0 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -209,6 +209,14 @@ static int cpu_pre_save(void *opaque)
     /* Used to retain migration compatibility for pre 6.0 for 601 machines. */
     env->hflags_compat_nmsr = 0;
 
+    if (tcg_enabled()) {
+        /*
+         * TCG does not maintain the DECR spr (unlike KVM) so have to save
+         * it here.
+         */
+        env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
+    }
+
     return 0;
 }
 
@@ -314,6 +322,12 @@ static int cpu_post_load(void *opaque, int version_id)
     post_load_update_msr(env);
 
     if (tcg_enabled()) {
+        /*
+         * TCG needs to re-start the decrementer timer and/or raise the
+         * interrupt. This works for level-triggered decrementer. Edge
+         * triggered types (including HDEC) would need to carry more state.
+         */
+        cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
         pmu_mmcr01_updated(env);
     }
 
-- 
2.40.1


