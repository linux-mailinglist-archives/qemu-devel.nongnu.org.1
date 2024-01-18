Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D140E831BFF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:08:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzA-0007Ge-Dj; Thu, 18 Jan 2024 10:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTz8-0007GF-Bu; Thu, 18 Jan 2024 10:07:14 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTz6-0007rK-OT; Thu, 18 Jan 2024 10:07:14 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d5f5a2e828so18631725ad.3; 
 Thu, 18 Jan 2024 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590430; x=1706195230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buvXEUUp49L8zNFigYYuRL2j7b1rVNRKBxltWbuTA+I=;
 b=ML6veD8n6DCLcXI3774H37louJvPHl13mzRG5CbseS+/igqLH3TgFmANeAX0UTET55
 s4dGeGLY4KImxdXfnWncmpadVz0BybfbVylxBs82VUQR/UTnY6SnElmqRnJJOWYV7zvb
 GJ7Zdfn2T5AOnNrWYm93rK9SUvE/6eH+D0ZWs74pOeSKx9NwcrtqpQ8XbaatV9gbO2zf
 bsa7A5svpLP1q4VEMNVYNlikFXHk/bvyAsbnHWXAzSnKTYYHhGV78eC7PWm+fX9yA4b4
 CoJ3oG7QHei5b37Y9B24Xc79/CESOlMOiy9MFVhCjcioBgoKuvV6UCV5ciRg3Wc5GLIi
 93yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590430; x=1706195230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buvXEUUp49L8zNFigYYuRL2j7b1rVNRKBxltWbuTA+I=;
 b=Gj7B6i37LKW/Punr1rW5KxTFc+yhgBfI3omwHrlpbO9f6hXM0cow781VhRo88bXLGs
 eax7iAJ++2HcTnEw804F9Lh/hlzM+vt75fAkSm6cakN5hKsE0Vj+nKnmAqvBzD8RwToZ
 RL+tG/AKUb+NzU6vQSOPoS/qSwoIVhHvzNwADEWCbE1PG+BjCtZzLIZYEV+d1IOuCNXq
 CsoBTAC/HeS+OqJRY3kPQxsj9bGULIsQ0wm4g1mrDLqGY2I6E+FE5p1ONj4VOjZHZvLQ
 M6FQjF7gjiwiEiKoj6wddJJ0nME8Z1W3raC7dSNFsxLSC/AWbd2/DqT1AL2JQ3mKx/LR
 tMUg==
X-Gm-Message-State: AOJu0Yztv+Q4vfYe0URjC1LnU7VHvYNR0xsGrCM/d26ietIoTm9bGSvw
 LhaNyTooLxONKFusD14msfiEykDX3JY2OZGw+tlZ8rhiDFDzKUINSxH+JoEc
X-Google-Smtp-Source: AGHT+IFtyWyMDrQrssz+bmpEyjNavT1HY3Br4hzzQGdnMLMjgbAa9SuPQY7EsjGy7XUD4GAbra6APA==
X-Received: by 2002:a17:902:d904:b0:1d3:33b1:f57c with SMTP id
 c4-20020a170902d90400b001d333b1f57cmr832571plz.28.1705590430556; 
 Thu, 18 Jan 2024 07:07:10 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 03/26] spapr: set MSR[ME] and MSR[FP] on client entry
Date: Fri, 19 Jan 2024 01:06:21 +1000
Message-ID: <20240118150644.177371-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

The initial MSR state for PAPR specifies MSR[ME] and MSR[FP] are set.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 5aa1ed474a..452b266e8b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -42,6 +42,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
      * as 32bit (MSR_SF=0) in "8.2.1. Initial Register Values".
      */
     env->msr &= ~(1ULL << MSR_SF);
+    env->msr |= (1ULL << MSR_ME) | (1ULL << MSR_FP);
+
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
-- 
2.42.0


