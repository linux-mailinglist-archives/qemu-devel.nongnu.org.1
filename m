Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197F7981E8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUew-0001ek-6D; Fri, 08 Sep 2023 02:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUes-0001SI-Dj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeq-00087t-4T
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c3887039d4so556965ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153274; x=1694758074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUuPwbzWdYwAH4mFJmcOk/0YkSmA5lbZ2mPYnykgtP0=;
 b=Dy3K1NRyO/dFulMQ91IGrrnEjJidGFVyWW/22aEuGh/9dlAA1LGvrJM4eHrE2K0Foh
 bnHNcDoBTSVl9SfpHlpM14cvicxvEwGTjerlR2zY0XroGr4vZK6iuCOl51uZ3zVFokRw
 NF8wSTf656kxgnHaGQNdqO7y6+LBwPaWr+LROcYbKCSZGbZ9D8Nczs5UkdkpWnYror3d
 V9qg/hbYD4AmQ5ivPVeEaMQh8Pm/Mx3aeGpyuxoO3HxwL7Altfmq7HuB8DSyp8alfm2I
 kDayhOSz6qMGZ27LADdgXPiS1uskVoTEX6zZeU62oJpf3ajtuEt7Xz+QDKSk63J8AC8t
 LhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153274; x=1694758074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUuPwbzWdYwAH4mFJmcOk/0YkSmA5lbZ2mPYnykgtP0=;
 b=nTJBFVZ1HBigqdmesWk08FqzX7ZFm4QekQorKQn2UqN06gJB1C07uZM8wkF+8duc5H
 NO8HAv865cPj9nvx/QMN68uOhEv3FUAUqo79RX6cmOrrlYs5dra25mdbSc+0LiXVDwHg
 5u1zr0LT9gos15qeYdVDSZwIymJ+YsmJ2YiDTHPfUzzX1WSocegJU62UGDV+FayLtlyG
 B5at6oWgrz4RIHxHHHCxORf1CveTDH0xTCeq0p4GQQPx/BU5AOeZME59PyCCwDB1UHdh
 VxROnHqtZIczHPo2+dyHvlkwceR8e1OQqMHlAoJrx0u7ckFuVNyOjOC6oZwwjteoVuwm
 rQxg==
X-Gm-Message-State: AOJu0YxFJD+ODxp1mwBphSX7cPunHLRputlfxweRaqUCNR6K2YxgmU4D
 GUI+Vtem/0W3tk07M6DrqN/IndIdz1zICqtN
X-Google-Smtp-Source: AGHT+IEtcZsFZjSMiKSFCvfr41OBDhA+94T5rQtRyTQeTq4swXfyxaHvwNmq1pO2CPSjNCJ+KoYJQg==
X-Received: by 2002:a17:902:7483:b0:1bb:891b:8bd with SMTP id
 h3-20020a170902748300b001bb891b08bdmr1845363pll.34.1694153274336; 
 Thu, 07 Sep 2023 23:07:54 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 47/65] target/riscv/cpu.c: skip 'bool' check when filtering KVM
 props
Date: Fri,  8 Sep 2023 16:04:13 +1000
Message-ID: <20230908060431.1903919-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

After the introduction of riscv_cpu_options[] all properties in
riscv_cpu_extensions[] are booleans. This check is now obsolete.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230901194627.1214811-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fdbd8eb0b8..db640e7460 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1976,17 +1976,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
              * Set the default to disabled for every extension
              * unknown to KVM and error out if the user attempts
              * to enable any of them.
-             *
-             * We're giving a pass for non-bool properties since they're
-             * not related to the availability of extensions and can be
-             * safely ignored as is.
              */
-            if (prop->info == &qdev_prop_bool) {
-                object_property_add(obj, prop->name, "bool",
-                                    NULL, cpu_set_cfg_unavailable,
-                                    NULL, (void *)prop->name);
-                continue;
-            }
+            object_property_add(obj, prop->name, "bool",
+                                NULL, cpu_set_cfg_unavailable,
+                                NULL, (void *)prop->name);
+            continue;
         }
 #endif
         qdev_property_add_static(dev, prop);
-- 
2.41.0


