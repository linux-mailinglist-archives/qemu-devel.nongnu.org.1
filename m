Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758D7D70A0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfb4-0005fv-7v; Wed, 25 Oct 2023 11:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfay-0005ef-Bt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:56 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfax-0003jD-0o
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso49429365ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246893; x=1698851693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7L+eMQC/hP6kOAoEfxyL11NalUi4Lht4i6fwiKN8tz4=;
 b=I39uIJOnxTIXSee3ioxKqvFbap1qMmzQipvZqYJV7hjbIsPK+tY9wIIwNAj3RRjUbN
 3uGCU/EIvLb1c2VrdoD/Y6b3sSLcVLhiC+eKL97hFfwIwirfBraszAwiqz2tYr0LcYTq
 TnySAbpg34KOHRXfW0ulYaBeGzLjo0+uOzcYE35mtLrKTKgq5P6rsRkMvh84XknnScD/
 dRysMQisU/1/CR3coODERyJWtGkHE+uRgLZP4jOEWUF0X3cqqrUe5OBptW5yDKdDj5LD
 Aj6mHnP9TdDYtt7bS8z0NmHHjpElYteYnCF43wVMG36Cxt25thnoT5gnaUSL2TS7FBSU
 BYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246893; x=1698851693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7L+eMQC/hP6kOAoEfxyL11NalUi4Lht4i6fwiKN8tz4=;
 b=Kvkr1UHZgWRMOdr56lkbrWlGOklNYyiPdQZ3t2ai7o5O5G97nudKXdlWxHNLDs9/60
 CRCBqfHVuiikEVal8h7DbGdkqauXlKYP6/paSiDGlOEkRU+z5xL7Z2JqvHMYjxY7VMkd
 IxCBI92pCQbUMb0x71extOpzUnx+0Wcz/u6yqOGjoiZP5ZftHTUdd4mwuPJoJzFmLc/x
 wHhJYzTZJ/cRZ+XKguAcoHUpQZQG3HTAIQjtBwIMxKBZ5trQtHB3KJjqC2/ArZ8TmIVH
 TUoFFAOj1y46F/Y9HJdzAzGY6UdLZWbvYVfNjA4p/n9/e+R03VUff3qULqA92BUNbiir
 exXA==
X-Gm-Message-State: AOJu0YwAtKokEwbOgPgT0J5oARZWHbJ0HWPWaA/5QKXrXQmTpaYYXyVN
 naT1SmmkakibqE0IvVE+Zgwv2o3tKdF53e9a94pczoA/c52j1ZaLO/Osh125gHXMo2wa1Jg7lds
 rwVNaGGh3U3OkE4dlvnwMLZuqRF16CYk3pTF14Wa+XGri3e656uI7Hpmh/HelqeUrExm3voayoF
 CM
X-Google-Smtp-Source: AGHT+IFDsns5jiki7uY7BOPx8QXLgbO1yLricUgKvvEghnb56xEFytmDpk0+G6/40sqWppXjSWFQAA==
X-Received: by 2002:a17:903:23cd:b0:1ca:7086:60ec with SMTP id
 o13-20020a17090323cd00b001ca708660ecmr14467656plh.65.1698246893341; 
 Wed, 25 Oct 2023 08:14:53 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:53 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 11/14] disas/riscv: Add rv_fmt_vd_vs2_uimm format
Date: Wed, 25 Oct 2023 23:13:35 +0800
Message-Id: <20231025151341.725477-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
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

Add rv_fmt_vd_vs2_uimm format for vector crypto instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disas/riscv.h b/disas/riscv.h
index 8abb578b515..b242d73b25e 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -274,6 +274,7 @@ enum {
 #define rv_fmt_vd_vs2_fs1_vm          "O\tD,F,4m"
 #define rv_fmt_vd_vs2_imm_vl          "O\tD,F,il"
 #define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
+#define rv_fmt_vd_vs2_uimm            "O\tD,F,u"
 #define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
 #define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
 #define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
-- 
2.34.1


