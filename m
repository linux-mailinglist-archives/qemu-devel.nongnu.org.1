Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33495831B20
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:11:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT6B-00057d-DN; Thu, 18 Jan 2024 09:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT68-00056G-Jf; Thu, 18 Jan 2024 09:10:24 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT64-0000tW-21; Thu, 18 Jan 2024 09:10:24 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so8964700b3a.2; 
 Thu, 18 Jan 2024 06:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587018; x=1706191818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfcfiBdpXmXsTWV/H5LO5HZvuIqA57o3t6QktI+ixng=;
 b=E22CQ0UGcdY3xUblsKmnHQkzj9K9KbTx5t9We65gvrddx9FoY4S2Jv/0LxL/RyirI8
 gS5UnpTbsUin72h3YvLoRC15REOka8XvWPlQqYGcDPqFn6v/YDfmVb6uaasm28jgNMDJ
 HvrL0E/13Y3NkpmF6bXI9o6n8Fj4ap3pJwK0YeevnEFWAU1H+h64vIJnHhV8fsF1Qnme
 73kE244+oMdQkLJaKWbsZVCM285PaB6HPlRR11yXkvxhvNvs41wUr79EpbNXXuibETD1
 DuJgXYp207YaQ6iRajU12yQl2Mv+jsoniDWdkvTTvD2rRJ71f9/mdrO3ciNc5vtfbcy3
 n6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587018; x=1706191818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfcfiBdpXmXsTWV/H5LO5HZvuIqA57o3t6QktI+ixng=;
 b=Y2pbR+hz8I0MRrniuTwC2fTJmhIOYFUn9X2Je3CWOp9vVaaif6IoNa0W5KOWQ3BuTr
 +W/y4jpIRjNKOhA5y4pBtw4rkNLwRg639vEHyr2Hygy4YBKbE+dtgZyodp9BmOhx3Wkf
 qHSt3fnaBUyP+j6JVHZ/LhR2vRAufoglZPO5KM6xdl3d/MI7/pG53EAS1grp2UdxjDqJ
 /I2/tzHJSXAZkGiTmlK/CBvpkaOg+QCsZKLQt15PBByG7JiPt4Lm+xs5Om7Mf5e+I6vC
 pRBfsqxwf0FB845WDFq9aABfkothJP11rp7qD4u/NzanImsA8peNHeu0FV++tZE+5KIX
 Af+A==
X-Gm-Message-State: AOJu0YxWCK34O5UTaITaPsK/rGI+rtt1aiiUJZpC93Dq8CQpR8xQW55E
 MPL/+F4EypDajEQz0wrJ8QpBssslQc2uy0w7UxvKSoaMFXpaOZwvkc/yBH5F
X-Google-Smtp-Source: AGHT+IH4gQVvdAw2Ay24azHrr+8z6IVRLRjld5q+7vhBEF2xyCCdv+ipPUlv+Zdxl37pfD0wrg9ajA==
X-Received: by 2002:a05:6a00:3a06:b0:6da:dbd9:1742 with SMTP id
 fj6-20020a056a003a0600b006dadbd91742mr938192pfb.57.1705587017765; 
 Thu, 18 Jan 2024 06:10:17 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/8] ppc/spapr: Remove copy-paste from pa-features under TCG
Date: Fri, 19 Jan 2024 00:09:37 +1000
Message-ID: <20240118140942.164319-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
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

TCG does not support copy/paste instructions. Remove it from
ibm,pa-features when running TCG. Similarly to SAO, there is a
migration issue here, but this doesn't really make things worse,
a cap would be required to fix it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c79d5670d..ce969be770 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -299,6 +299,18 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features[4 + 2] &= ~0x80;
     }
 
+    if (tcg_enabled()) {
+        /*
+         * TCG does not implement copy/paste instructions. This causes a
+         * migration issue similarly to SAO, but there is no avoiding that
+         * since there is no KVM cap or way to disable the instructions in
+         * hardware. It's also quite an obscure instruction and is not really
+         * used in KVM guests since KVM does not support accelerator pass-
+         * through anyway.
+         */
+        pa_features[38 + 2] &= ~0x80;
+    }
+
     if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
         /*
          * Note: we keep CI large pages off by default because a 64K capable
-- 
2.42.0


