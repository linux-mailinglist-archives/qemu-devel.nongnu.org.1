Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D445D7DA618
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 11:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwfQk-0004al-CZ; Sat, 28 Oct 2023 05:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQa-0004Xr-Qm
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:24 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQY-0007L6-B2
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso4536314a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698484576; x=1699089376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ka6L50tMkeS83/oFflbpxv4NcubY3eAUnuZsASjQAQc=;
 b=Ec3q77RprQSv9QgI7bbOWFMndWwEJVPCM+LhNl7UGQ2jF5cLIX/9QM8qz4RQyuz2J3
 IOJj8BeaJE+xa4yPQN2Ofkort6ykUz0dQdQGWTorXZ4jLj2fGjrwH88l8dWfdf5TaqI3
 cjOTIOWVvK/JdeRFF+u4SufuX2oQzhxgoU56Md+EnF4kb9AZdEfGP4aBtAeWDYoUN16z
 Rse1hraa/L30PYo65yIbH3BMuf111qTYz0qOafRYuvV4Y2Gyf88Awr3ue4+/y7jcMPaT
 HsupfcPbJgHI7lEzJuxoY/l0nnRAj+90MGI6poqftuzD6/iJKiRZbdNKt+oQg+LPj/h/
 BMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698484576; x=1699089376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ka6L50tMkeS83/oFflbpxv4NcubY3eAUnuZsASjQAQc=;
 b=d0C4mglUAPb2LZ7R90BHPY4G7stSoLxR566xZ3LUvNdHKGzgqbFyHddw5ONRVgkRAc
 skao3Ym5N0NsyxvS9BSM9MLJL1iyASJKB3HlylELU0NbkUh8zI0irB1QAABoOrNnt6PN
 BKrMdo0Dhg06Mgquw6C1IEVwBulobRWEpM8ax5hn6FLBMzgLUgSMnn8mnGUu7GVkg2JP
 DgJsvjP6uj9WL8qcWgTTBpwH95Vz2DCrW8QjSGzmAWAOIPxB6TOuwTAOc5+3DP9l26Hu
 sWUnqe3x2fVIJ3uxJO+JIZjkA54zZzS7t460HvODRvxi53CUoX4ddbLScx/lsN5/hsR5
 xWkA==
X-Gm-Message-State: AOJu0YxfVx/EMu+rQ40tWVkVpgRCKVSGP41uo0v/hxSmD1v4uLajBE4X
 QSTrrb0Yx/u/rf6VboLuc4bqyQOY3eU=
X-Google-Smtp-Source: AGHT+IFYFvvH64xZtFEjUCBPLvAYjfmt44OfTalSm6/98YAIjw4IHR/TO2EE8QigMqvlP2Mcpuk+cA==
X-Received: by 2002:a05:6402:174f:b0:53e:817e:488 with SMTP id
 v15-20020a056402174f00b0053e817e0488mr4266029edx.11.1698484576436; 
 Sat, 28 Oct 2023 02:16:16 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-012-044-170.89.12.pool.telefonica.de. [89.12.44.170])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a50c357000000b00542df4a03d0sm571444edb.16.2023.10.28.02.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 02:16:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 2/5] hw/isa/vt82c686: Add missing initialization of ACPI
 general purpose event registers
Date: Sat, 28 Oct 2023 11:16:03 +0200
Message-ID: <20231028091606.23700-3-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028091606.23700-1-shentey@gmail.com>
References: <20231028091606.23700-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

In order to be able to reuse acpi_update_sci(), these registers need to be
initialized.

In PIIX4, these registers are used to implement the Frankenstein hotplug
functionality and are mapped outside of the device's IO region. Don't do that
for VIA for now to avoid the Frankenstein functionality. Still, initialize them
to the size of the real VIA PM controller general purpose event registers but
stay conservative and don't map them for now.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index aeb9434a46..60ca781e03 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -40,6 +40,8 @@
 #define TYPE_VIA_PM "via-pm"
 OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
 
+#define VIA_PM_GPE_LEN 4
+
 #define VIA_PM_SCI_SELECT_OFS 0x42
 #define VIA_PM_SCI_SELECT_MASK 0xf
 
@@ -179,6 +181,7 @@ static void via_pm_reset(DeviceState *d)
     acpi_pm1_evt_reset(&s->ar);
     acpi_pm1_cnt_reset(&s->ar);
     acpi_pm_tmr_reset(&s->ar);
+    acpi_gpe_reset(&s->ar);
     pm_update_sci(s);
 
     pm_io_space_update(s);
@@ -205,6 +208,7 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
     acpi_pm_tmr_init(&s->ar, pm_tmr_timer, &s->io);
     acpi_pm1_evt_init(&s->ar, pm_tmr_timer, &s->io);
     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
+    acpi_gpe_init(&s->ar, VIA_PM_GPE_LEN);
 }
 
 static void via_pm_init(Object *obj)
-- 
2.42.0


