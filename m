Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58CC831B23
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:12:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT65-00053Z-Pj; Thu, 18 Jan 2024 09:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT62-0004wu-1V; Thu, 18 Jan 2024 09:10:18 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT60-0000t5-6j; Thu, 18 Jan 2024 09:10:17 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so10413787b3a.1; 
 Thu, 18 Jan 2024 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587014; x=1706191814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMGW3NgZceQQATl9VA8EF7mRTSS5hHP8Vew+qm1IcAQ=;
 b=T0nOEj3rrZs9pjjrOKViIP8AS2ORBlHdebawKtr0CpZ7IbJ2kQyPDQXzAv5CX+P8Zg
 +pMd+lerIEF+3DtN22Vdr+mljc3TWdU/ZdoNtydxYK4bRlgmn8YBLk7cq0V65czf4JzZ
 s3KL59ZS6iJRut2Are36Iq4wEoJoX4gTkkGvjIV2JSt07e49HgwLAbRHmeMg0CcodqPB
 hGcpMEw4h+5K80WKgtvg7F6YrP78QgqqVMVGnZfmjek2iwCnXiEs692sjOS/RkS7F1QW
 0wnhJIyclWKEOZlr2Lg0WdseSv79YYwzR76mz4B0yiReOVO6K10mxY/RI32cogCimYKm
 Pm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587014; x=1706191814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMGW3NgZceQQATl9VA8EF7mRTSS5hHP8Vew+qm1IcAQ=;
 b=T6UToQ6mcypilP6VD234DIQZLL8wo6fRopUlcS+vbgNGsfBkL3813vmdZXByP0sblh
 9WcmSgJZoCm4N468AG350Ok2sPcwD1F1KKufcifWlss30YfpekF3Uov/NbuIixYVuHNT
 Rl4bTT+Ixr/feyZgPiX9cAsgAYvd5xnct4a/K3fXJjsbJchpkId8WsNVbdkHjaeYBtGI
 pcb6SNRlVWXz1NO5UNfqjYCryjrtuOUGE0HswyDqUB13kMyk9sI7NvWhVX55nYgqKqby
 SdXutHkreRocyvAnVwCS3yJKsJ8xGjvJqoW2ZPb0BSnmDT0VWXrBwPNJ/NB1Vh6rb/b3
 4dnQ==
X-Gm-Message-State: AOJu0YyQuHZvbaXX4R8MpTEa8Wcc+xfl9wRRH8sNatck3B92ALyzYMnk
 L+sjKTWd5JYS1wg90j55D2CeTfIWh6jKVYDtZ8fVi2O2GpqBMq5/vOi8Sro6
X-Google-Smtp-Source: AGHT+IG/BiiCIb2a0kZiDBwwbGju6ONBdx+cpVOcxg3aUNV/M3kyrF9NT0LN6y9kvznr5FJ0urXZ8Q==
X-Received: by 2002:a05:6a00:4648:b0:6d9:af31:293b with SMTP id
 kp8-20020a056a00464800b006d9af31293bmr750153pfb.61.1705587013748; 
 Thu, 18 Jan 2024 06:10:13 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/8] ppc/spapr|pnv: Remove SAO from pa-features when running
 MTTCG
Date: Fri, 19 Jan 2024 00:09:36 +1000
Message-ID: <20240118140942.164319-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

SAO is a page table attribute that strengthens the memory ordering of
accesses. QEMU with MTTCG does not implement this, so clear it in
ibm,pa-features. There is a complication with spapr migration that is
addressed with comments, it is not a new problem here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c   |  5 +++++
 hw/ppc/spapr.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b949398689..4969fbdb05 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -158,6 +158,11 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
+    if (qemu_tcg_mttcg_enabled()) {
+        /* SSO (SAO) ordering is not supported under MTTCG. */
+        pa_features[4 + 2] &= ~0x80;
+    }
+
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
     _FDT(offset);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 021b1a00e1..1c79d5670d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -284,6 +284,21 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         return;
     }
 
+    if (qemu_tcg_mttcg_enabled()) {
+        /*
+         * SSO (SAO) ordering is not supported under MTTCG, so disable it.
+         * There is no cap for this, so there is a migration bug here.
+         * However don't disable it entirely, to allow it to be used under
+         * KVM. This is a minor concern because:
+         * - SAO is an obscure an rarely (if ever) used feature.
+         * - SAO is removed from POWER10 / v3.1, so there is already a
+         *   migration problem today.
+         * - Linux does not test this pa-features bit today anyway, so it's
+         *   academic.
+         */
+        pa_features[4 + 2] &= ~0x80;
+    }
+
     if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
         /*
          * Note: we keep CI large pages off by default because a 64K capable
-- 
2.42.0


