Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C65831B30
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:15:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTAT-0003U5-Tz; Thu, 18 Jan 2024 09:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTAH-0003Ot-8h; Thu, 18 Jan 2024 09:14:42 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTAF-0002RH-I1; Thu, 18 Jan 2024 09:14:41 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6dac225bf42so6610865b3a.0; 
 Thu, 18 Jan 2024 06:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587277; x=1706192077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUe6fBSPNDQNiiBAsOj2zDX9QCAESKGGXiGMgOWN/CQ=;
 b=UeI/oqVACY64NI10ReTxV21ASXg2imdgm+gPrxiHTlIEIfstpXw3KhSjvULSPG4NXx
 a2EduyecKD+w7Cu39ZrYgC5zDF4bwIaJ9xnzRvRoyqLYxquioVqDRpj7GRsmd5mdQaeG
 hBkst/78dWGiLkKdcTj9wUNVdHLHSYq4aw1cJdlegsd9lvOqorOIuLj1zc3e6lDbiZA+
 8x7feqY90EH8I5CPWN6EMk8NB+fM6ShEv3KnLpw/ALNW/QRbqrGzCoyGB5PKltVbJC96
 X5/sRB/yexw86Wf5Th3/nOVliYznSg916/47MwwMhxvbFurMEA69E1wPjTfW2zFQskk5
 uxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587277; x=1706192077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUe6fBSPNDQNiiBAsOj2zDX9QCAESKGGXiGMgOWN/CQ=;
 b=raD8EcOkGTp4tym5cqMeRujzRwmpCga6GidbbqCzVksJAf5gT9ZfIc4PwurTt0+v4q
 aQsaeqZBnXg7Tq7YVrDs9jBFaDkDMnEW6AzNANKbgvkar6mk0L9VJVnbtziAvzrRBfBd
 InWmcCdB15M/AdiQBs23PggoHPwXpMgHtXuMiqo4vNZhtfdRW9kbT/FbvEnN/4j0f7H2
 5swe7a6vnLiL7NyCCv+Q+eL687rjuJS0tvGYWhT3BWRQHuAyRcdIPI4HaVpaRErdm347
 7MWS9ysTwsiJmO83oO29oBGIQCWFkMaBnMVueWHa+bimzTr9kzeOQhkhXRHz2Bf1O9Ns
 Xj/w==
X-Gm-Message-State: AOJu0YxpicsTl4DnKbwrZDQPCUExjS4OCa74kwD6c5s5S2jk/vqTWBBz
 O375u3p98TnY6baAO6MXdTytkZWZTVmXDq8MeS0vh9QmSYT3iOs6BAPKWWgz
X-Google-Smtp-Source: AGHT+IFGickpwtAshs4hVmQCG3LDsuALLAMASWZkoueLXIzWYYStSjhysRlMqtk6vVxT0XOtKVMaAw==
X-Received: by 2002:a17:903:1c4:b0:1d3:7c0b:d4ca with SMTP id
 e4-20020a17090301c400b001d37c0bd4camr796435plh.73.1705587277434; 
 Thu, 18 Jan 2024 06:14:37 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a170902760f00b001d4be72802esm1434781pll.150.2024.01.18.06.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:14:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] ppc/pnv: Change powernv default to powernv10
Date: Fri, 19 Jan 2024 00:14:18 +1000
Message-ID: <20240118141418.165107-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118141418.165107-1-npiggin@gmail.com>
References: <20240118141418.165107-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

POWER10 is the latest IBM Power machine. Although it is not offered in
"OPAL mode" (i.e., powernv configuration), so there is a case that it
should remain at powernv9, most of the development work is going into
powernv10 at the moment.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..b949398689 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2242,8 +2242,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     xfc->match_nvt = pnv_match_nvt;
 
-    mc->alias = "powernv";
-
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
@@ -2267,6 +2265,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
+    mc->alias = "powernv";
+
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
-- 
2.42.0


