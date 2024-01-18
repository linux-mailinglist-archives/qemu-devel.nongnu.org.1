Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0648831AA6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:33:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSVS-0004wB-2M; Thu, 18 Jan 2024 08:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVN-0004s9-9i; Thu, 18 Jan 2024 08:32:26 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVK-00021X-6o; Thu, 18 Jan 2024 08:32:23 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dbb26ec1deso135921b3a.0; 
 Thu, 18 Jan 2024 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705584740; x=1706189540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFCXVTcmuilSkmSKJd/6D+1Ho9O5iJCIW5d0ENXqJY4=;
 b=a27uHmtRlU391PB8tIhxh5Azle2d6GhleBl4FnJQJUT9oSY7NWmncuHJYImV14KQx+
 QR0saEOQYUX00coUF3APRH/o+z6n6LiAd2IhVRxEnSqDnzmlHB/6IKxT6qBaAyaD3w9B
 GKXWIWxoxxq0hl3UD6Helg5ByREYv3hrdpFg9AiVQ5UIxJ9MzmjqId0m2pLti7Z9qtlc
 1QJAW9pfl8HPENPnukeRZKDVHQAj+/I1/US6i91i1RaUtQ8eXMYjDBq0R2/rr4y5k8hP
 HS3LrxbjNOrKrRQwpFkrlH8df3NkxF+SRu+qTLD45rGeE0cIJWQN2BliZlMuvcfSO/sN
 FhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705584740; x=1706189540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFCXVTcmuilSkmSKJd/6D+1Ho9O5iJCIW5d0ENXqJY4=;
 b=KuYMCTSDmL5Qu/FQ9ruWpzSmSsKl3x2AJVvgY/YCvG3uOZlgACTuNqEPIDNgWzDgEc
 Uy1/r5j/KgVsKcP1dYFJEMTa4duFJitIQdnBIY0VyR5I6a/tTui983CowiYoDqD+3Nfz
 uwnh2lilgynN+1iusurf15njhQjjpCCxRrcA4FL8+ddDR1d9SL9y/dCHkoYt6NMzZglB
 zIQWCEQkakM3Z85GIszwYm+bdDw71tG78Mm7LgfFXueywDShG37SklzpNwuj+m0ei+9E
 O9hJNbgWQFTmo2axeueNuddulVh0smN3mJB4KMpSWjxTv15Gp1KbVhVvhIDTeSSb2N2m
 DtzA==
X-Gm-Message-State: AOJu0YyPt+aeuPV+/MLDKp2pEiQs9tAcl3X3tSwU1JuYpuKda3h0YtVF
 GYyeFREf3kTUj7mfqkPJlKAk+6MJ7Kc+8o0TiRG2t1MWfrRhBf9cBIFLzYS4
X-Google-Smtp-Source: AGHT+IHO9LiXhA8iEveqM4eD4RJ8tTzj4MgPCUpoQ8pVDauBgz25UwRIAbknRbykoRJH8gDJK+lxWQ==
X-Received: by 2002:a05:6a00:13a7:b0:6db:722c:cdfb with SMTP id
 t39-20020a056a0013a700b006db722ccdfbmr886194pfg.22.1705584739923; 
 Thu, 18 Jan 2024 05:32:19 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa780d3000000b006daf1ded817sm3282551pfn.209.2024.01.18.05.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:32:19 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hw/ppc/spapr: Add missing license
Date: Thu, 18 Jan 2024 23:32:03 +1000
Message-ID: <20240118133206.158453-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118133206.158453-1-npiggin@gmail.com>
References: <20240118133206.158453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 9fdf0c2995 ("Start implementing pSeries logical partition
machine") added hw/ppc/spapr_hcall.c, then commit 962104f044
("hw/ppc: moved hcalls that depend on softmmu") extracted the
system code to hw/ppc/spapr_softmmu.c. Take the license and
copyrights from the original spapr_hcall.c at commit 9fdf0c2995.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[npiggin: Update file description.]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_softmmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_softmmu.c
index fc1bbc0b61..2fade94029 100644
--- a/hw/ppc/spapr_softmmu.c
+++ b/hw/ppc/spapr_softmmu.c
@@ -1,3 +1,12 @@
+/*
+ * MMU hypercalls for the sPAPR (pseries) vHyp hypervisor that is used by TCG
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
2.42.0


