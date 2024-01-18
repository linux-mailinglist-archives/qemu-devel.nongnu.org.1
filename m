Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E91831B33
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:15:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTAT-0003T8-Ih; Thu, 18 Jan 2024 09:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTAE-0003Nc-5O; Thu, 18 Jan 2024 09:14:38 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTAB-0002Qs-Hs; Thu, 18 Jan 2024 09:14:37 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d6ed1ad986so12260405ad.3; 
 Thu, 18 Jan 2024 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587273; x=1706192073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNusOvjYfuLg8yHgiTdJsvx8h4MinrBOkyF4f+pOACI=;
 b=VsqQTcS+aFUTq+8xjJusoS8WNv9MDng7t9DQjoAMDzusMx1PI7nuqumgkZpj6tyq6i
 g8xitTQYADCR3CiKox8PuiMxf5mOuPuQUa33EWoiYduXgJw+/tjvDcZNVW1YDhP2wWK0
 HWTPIbwTc+NCw8JH4rIYcZsUrHRcifS6BPhtZ9SBdHBngYb3Ksv80hd8R0U5IqpPhSLC
 5iAUnM7zzUcXCZH6PZ/r2GklgyGk00OwPFNLr2Ew3N4Gxs7MaGIjQljfAjWJlkrQ3QMz
 LXNLMVMDqmOfjPZhTJ+nAybQ2ZC1OpRUethyQO0yegS14mmoM7eNQPxFb8v/ypH1jYAz
 2eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587273; x=1706192073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNusOvjYfuLg8yHgiTdJsvx8h4MinrBOkyF4f+pOACI=;
 b=D0IUMdjntqZU+KO0eq1oNXH4lHxZgGACR0pdcZ4R0moC7Rf1Y14jjsEnxL+FDa5Ov0
 vW/AB7H6+4CCS5lmqVGoGt18jR8nN3vgobW/fMJrjcGxDs4QTNDk1kW1HQCn4H+JgIlU
 i3tFhdO5qL0d16bWpgf3cNmBihquUEuXZNzFUuy8fhEJR5HRhZ2D3nGQWjlP94Osle9d
 pVcpYQlf4LLLYDD+47flzZ+neCXbvl5tgIda7g16jHY1lRBE6hLoVk967Vu/y69ZSMed
 r0mB2vKVFVX9sq0JZnUW44z7ReUUbffTNaYN6T0kXqzafHfP2wQ9vwGp0qOad+z1rhyv
 pj6A==
X-Gm-Message-State: AOJu0Yx6DmjsO+10OEq2/wEn37XLCbK9qLAWbjIk8XtmzQ+JtA6NJDhU
 RTOWRtPOM+ZCMmEUthyHnnlC+MoMvuNsbtkg5TNt8D8aO3mCqYwXuBvjCoIV
X-Google-Smtp-Source: AGHT+IGn0YyUZFHpKZp7Z+CmaDw/hqClvXmIZGKLjLadPN2uD5HOy3WxqWBo0OetP00/4PlYfOIaeA==
X-Received: by 2002:a17:902:bb97:b0:1d4:55e0:bd0e with SMTP id
 m23-20020a170902bb9700b001d455e0bd0emr919583pls.18.1705587273353; 
 Thu, 18 Jan 2024 06:14:33 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a170902760f00b001d4be72802esm1434781pll.150.2024.01.18.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:14:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] ppc/spapr: change pseries machine default to POWER10 CPU
Date: Fri, 19 Jan 2024 00:14:17 +1000
Message-ID: <20240118141418.165107-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118141418.165107-1-npiggin@gmail.com>
References: <20240118141418.165107-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

POWER10 is the latest pseries CPU.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e8dabc8614..021b1a00e1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4675,7 +4675,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
-- 
2.42.0


