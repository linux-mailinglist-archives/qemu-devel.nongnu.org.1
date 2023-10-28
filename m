Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B07DA616
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 11:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwfQm-0004bS-FH; Sat, 28 Oct 2023 05:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQd-0004YD-Os
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:24 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQc-0007LV-7X
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:23 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so4437183a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698484578; x=1699089378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5vrwRUQXmhV2FmE/eFche3gCK9KU8MjSPmr8QXRFCg=;
 b=Oeoqa0YMxc/LRQQTcTD82K+uHAEbtiXkbKNxQm7/SdqvJGfS1tUgJJeNh0shiyFYwl
 xexKnVJhV4p3/4RVP89YoSNl1AMDqamtg0ojluoz7a6nzgZhbuPtJJgzMDw96zXp66dd
 Tx1j8K/NTN9rgFcY+M1H6/+13AjUDRDv9z4qk5fIdch+b/41A+kahN0UlRU5+sU/Wiui
 XGbWHYR0+npACXvax8nqHt1HiIyGuTx7Hu6FkHSHw0Mdu289oAHVukInrMpYDY1p0M+V
 2Y/Jhm6Cy7+IUzgTK2MFbVrFp7e7EOurkFBUIJSYqJQECY/jHhWH0EvPzHw9JiU0dpGs
 Jcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698484578; x=1699089378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5vrwRUQXmhV2FmE/eFche3gCK9KU8MjSPmr8QXRFCg=;
 b=R8JPDcxId9fxvX6E9EFMnptJ8PyTA5Q3LSF047Zu1ulUET/b8QqQFFDljFjYaCmSX6
 2GjEx7Ym55hcCgKQymFUMsh9FNQoINGqOJCMGNOOuSQ5l6hjUutAiNc9woveMQugaKgj
 9JVNxmTqkTINL6FPhBVkz1BngyB8ssGzgv2JqPvmAMLjoDToscLgAqRAOihLeCHl+lxF
 68k3aq3XPUvtJ0FOcaURQ2A9ZLSCEm6D55RUmmImWSBg725CmiZHgvvyT2lf7e4mDNzi
 Q/BtHjzD4ESf4DDXu36nRXQzI1cxEMZcVtBSZRSCJLW2wLDgsGYKRgfDU31zBZWzsW4H
 GJdQ==
X-Gm-Message-State: AOJu0YyVvF517vkh3w7Xb3dS2erqPdpPxpglYwXba+TJiP1hkI4man1I
 redIkJVDEVQtiD6snlVwdSGqNXHv51M=
X-Google-Smtp-Source: AGHT+IF7MNWU013FdkEnNBUZodOv8taTLn0gFDC/KtngOEhe4HzY3yMbbyLvtEXD5tzBEfZgCizgxA==
X-Received: by 2002:a05:6402:b52:b0:53d:b71d:34a7 with SMTP id
 bx18-20020a0564020b5200b0053db71d34a7mr3746082edb.6.1698484578368; 
 Sat, 28 Oct 2023 02:16:18 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-012-044-170.89.12.pool.telefonica.de. [89.12.44.170])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a50c357000000b00542df4a03d0sm571444edb.16.2023.10.28.02.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 02:16:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 4/5] hw/isa/vt82c686: Implement ACPI powerdown
Date: Sat, 28 Oct 2023 11:16:05 +0200
Message-ID: <20231028091606.23700-5-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028091606.23700-1-shentey@gmail.com>
References: <20231028091606.23700-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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

Allows guests to be powered off via an ACPI power button event which can be
triggered e.g. through the GTK GUI.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 7b44ad9485..e8ec63dea9 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -33,8 +33,10 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/notify.h"
 #include "qemu/range.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
 
 #define TYPE_VIA_PM "via-pm"
@@ -52,6 +54,8 @@ struct ViaPMState {
     APMState apm;
     PMSMBus smb;
 
+    Notifier powerdown_notifier;
+
     qemu_irq sci_irq;
 };
 
@@ -172,6 +176,13 @@ static void via_pm_reset(DeviceState *d)
     smb_io_space_update(s);
 }
 
+static void via_pm_powerdown_req(Notifier *n, void *opaque)
+{
+    ViaPMState *s = container_of(n, ViaPMState, powerdown_notifier);
+
+    acpi_pm1_evt_power_down(&s->ar);
+}
+
 static void via_pm_realize(PCIDevice *dev, Error **errp)
 {
     ViaPMState *s = VIA_PM(dev);
@@ -193,6 +204,9 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
     acpi_pm1_evt_init(&s->ar, pm_tmr_timer, &s->io);
     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
     acpi_gpe_init(&s->ar, VIA_PM_GPE_LEN);
+
+    s->powerdown_notifier.notify = via_pm_powerdown_req;
+    qemu_register_powerdown_notifier(&s->powerdown_notifier);
 }
 
 static void via_pm_init(Object *obj)
-- 
2.42.0


