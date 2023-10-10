Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A397BF4E2
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Yk-0006Cb-Og; Tue, 10 Oct 2023 03:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Yc-0005zO-L4; Tue, 10 Oct 2023 03:53:34 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Yb-0005NK-1o; Tue, 10 Oct 2023 03:53:34 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-584bfb14c59so3334123a12.0; 
 Tue, 10 Oct 2023 00:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924410; x=1697529210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LcO0gLbMNqViKZELBCVLMmMGMEI+C0ZUAgyxlQweSY=;
 b=LxjDVPza5ogPhMGN7Fha+wyJMECJ/R8bDcw8cGhbf4aS7397sU5h8orIcMB2YYPUae
 4WoEpsN4QKe+9WRuKPDj1EqYvSLWTXap60JuDSmt0oInGflHa75qMttPK8eFerLABkSr
 cItQFdbGLgUd9YclJFwsWgZwkWH4ILflJBW9PpSblBWlIdgcMNwb/f5hfEXfYxeXvhDS
 hGhkPTJERJg6Kd9cr+gg1L/tWZpeRbUFixLRtBay2XCagSL/FWExWes0DaqeGuggWdxO
 MWfZEAq+321puHNcJaz4E22RtCN9NDiaAFQw84kWDvn/A+r0czMWz8tzal4ayaNCl+La
 MOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924410; x=1697529210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7LcO0gLbMNqViKZELBCVLMmMGMEI+C0ZUAgyxlQweSY=;
 b=cVM6cJohab2UyRh6YBwKy6HQ8NxFXexXdBYvWN3He3wjd9iDGscAfZ8cr3CXa280tx
 k0KqoB2hu9QH/t/isCMl8hf9N8kBPkGKyINNvygOcp4HDPg6UG/tfeME4ISW7vCz+bQp
 EHe1m6QSLE3FMMvEuiV98NBbdLEMF7SHdYIV/CfAxXyl77yDXrFXhYRbN72lb6FwvvHd
 r/1R96hN5zqtjOcd0Z3tD6c8QEIF/am3YPjy5BywwpvntrogEQx0a1GYVz7G6Y8Ua88G
 9iDh9dCeYL6n3fLXxYCZXDnqRHGKnMsNINjCdtlWfQlRiZM6j5l0s6+Ae70dEkLmb+G3
 iQRQ==
X-Gm-Message-State: AOJu0Yx0s4Zq6ESRzstdnXOAo4WGzKyjDlWbKS7Bs+VyvqFRCYfwMsSQ
 J3bxI67XJxrE0Pp1V8YXXLAxcN8ptRQ=
X-Google-Smtp-Source: AGHT+IEnh+eKabeyX0ROkvd77jFpkX783986fkfcz7v9ig/Q7F5SSHoxeaucX2bzqgeZQ5CNMrrw9A==
X-Received: by 2002:a05:6a20:144d:b0:153:39d9:56fe with SMTP id
 a13-20020a056a20144d00b0015339d956femr15444626pzi.47.1696924410343; 
 Tue, 10 Oct 2023 00:53:30 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 11/11] ppc/pnv: Change powernv default to powernv10
Date: Tue, 10 Oct 2023 17:52:38 +1000
Message-ID: <20231010075238.95646-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index eb54f93986..f3dad5ae05 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2195,8 +2195,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     xfc->match_nvt = pnv_match_nvt;
 
-    mc->alias = "powernv";
-
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
@@ -2220,6 +2218,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
+    mc->alias = "powernv";
+
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
-- 
2.42.0


