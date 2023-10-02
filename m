Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC377B5558
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK4j-0003q7-Oz; Mon, 02 Oct 2023 10:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4h-0003pR-No
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4f-0000Up-S2
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso171164475e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696257544; x=1696862344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d8vWgoJe22IYAld81YZ4mtbQgSVMhoRd/0ohTdhkoY=;
 b=qL/86nIpAnQck3iKcF6De4mL5kF5imIEBlmtj8cXTp0Ma338cXE4ArhFiPU7mf6lTy
 0ocG/PkcD174ILjf6GKmJJ4A8dgU5Goz0plAFwBLkkIUt+RtVYMSsq6E7GWG4Foh97ty
 n/R9FGspVeQuObsK2K3ijZSbMRctIU02zwo9AengJEEHYsFcKbnQRwnCnZS/P75X0RSm
 Wwf6lqxyffzjJl+W8rYtueDNx6HqKo6+ZflNqSX1v+ukQDxZcszo0L9zArLlKBPWGxqe
 u9ELGG26xYt9Tz2fMr8YzUlCtjE4grwh3XgKCmYdlWCTUb2xaKTxhxfJrLK4cjsJlBP/
 UFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257544; x=1696862344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9d8vWgoJe22IYAld81YZ4mtbQgSVMhoRd/0ohTdhkoY=;
 b=bbMWgIkZjZOadgk22yVPBJz8o12/0l+14I8wgJMbZ8Ii3fK7lEcQtfXsUm2qGehGVx
 cC3EfOPIDPz2yBoF5SF+QeyJFWDUA/HPYcCEFWY73udAL2+PPH5CTAMdclqBOYigviWK
 kWlU3WvW1b66pEcjvB4VCxYLMDLGjlYIkNodiYDH3lyMUhYcbx6vvq92piywZ8KVrshL
 csCXQapVBf/PcA5hhcihzne8INkuIbUxkF4ESBrfYDKfRphw0Qx7/QlBTrCH+E4SGIbU
 yb3I2HPWPk+8iWaWMEDa5Lth/is6rtvJYfF4WUlNV3+mm3CPCECDqYxxkVo1P+KztEXt
 Xppw==
X-Gm-Message-State: AOJu0YxwohpCaxsYDVgOidXNZNqsbyVMXYKsRNPiBkjaiz0NkEbCXMUQ
 77gCo3iHs/cI5pSmpnboFd8gtiiLyfaqwS/UVgfPZw==
X-Google-Smtp-Source: AGHT+IFhzkQFGJnXNUZU8owVy7oYeNd+nZPjuDw5sHP+ObNdi889GdPtg4/abxvlSO6jGHbgDEk/HQ==
X-Received: by 2002:a05:600c:5118:b0:406:599f:f934 with SMTP id
 o24-20020a05600c511800b00406599ff934mr8746281wms.12.1696257544167; 
 Mon, 02 Oct 2023 07:39:04 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b004042dbb8925sm7375187wmo.38.2023.10.02.07.39.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:39:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/ppc/spapr: Add missing license
Date: Mon,  2 Oct 2023 16:38:51 +0200
Message-ID: <20231002143855.50978-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002143855.50978-1-philmd@linaro.org>
References: <20231002143855.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 9fdf0c2995 ("Start implementing pSeries logical partition
machine") added hw/ppc/spapr_hcall.c, then commit 962104f044
("hw/ppc: moved hcalls that depend on softmmu") extracted the
system code to hw/ppc/spapr_softmmu.c. Take the license and
copyrights from the original spapr_hcall.c at commit 9fdf0c2995.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_softmmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_softmmu.c
index 278666317e..26d50d6543 100644
--- a/hw/ppc/spapr_softmmu.c
+++ b/hw/ppc/spapr_softmmu.c
@@ -1,3 +1,12 @@
+/*
+ * QEMU sPAPR hypercalls for TCG
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2010 David Gibson, IBM Corporation.
+ *
+ * SPDX-License-Identifier: MIT
+ */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
-- 
2.41.0


