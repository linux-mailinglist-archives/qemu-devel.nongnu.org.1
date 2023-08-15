Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1777D641
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2fq-0004pu-4z; Tue, 15 Aug 2023 18:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2fn-0004pG-3D
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:37:59 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2fk-00066b-L3
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:37:58 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a80e665410so1484159b6e.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692139075; x=1692743875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9lSDeBryekDaWv/Vc78YEkpFPDXZkfJPoxtpTCKUds=;
 b=BXMjiSwsfjkLnabGqsDa05Sg+fR11HLaCewNOpy2OCkzCHpNab+0baHhI3kcclI997
 EXyo+PY1KmiHA3+E7X/fk0snUnrFSglxsksCV52UYUvk5wiKkqu06MA31dkACo/pxuMY
 OY0exDPTCbKmdm2+suM0Y4DwnitIjrybIKaD4ZBbhbVTUg7nSCovN0XGNMv4n3z5ZvqZ
 b6ZloKJDx6HHHFD91fIUyYXJ3c/3suQsX9Dsm79tWgHO0rUUcQKQHorOo0NxkoRa7jIU
 NWNNnAdSYjzBcD4b5QikdUyR7fogsgWSqEOiIrdqT/rv9ipD13vTjglacUVRdUuIcJWq
 XeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692139075; x=1692743875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9lSDeBryekDaWv/Vc78YEkpFPDXZkfJPoxtpTCKUds=;
 b=Q2iPYBEaMtZtMs4ogyBL+TE1ElpQDKAxDGYxvnHJiF7LS8iQL5XbrSc2/AAG9rVqRG
 /6AZS3477I9DPG2jg0Sb1ipfZBEbyuguZn5+d6OdpOEkZnPXT07frM0H/45ePH4kBdhQ
 kyn2o7ibZ6KEqzlCmiO7F5wlY/v3YVzQkj4m6PUzLe6oPikXCAcoCxTGknODw0A13VHw
 LSUbz3yZatN+Ssbjwl0ydftmSVXsgGAOXZ/XaxO10HjnzGpSdAPkB1QBA6N1pjBVpyny
 N9tCdBR/85K3LGJsbjKWfUh/gFjIqzzmjISdp4t8NOIJL1/WzWuxJwP5oWmGjPoAh7TE
 hZtQ==
X-Gm-Message-State: AOJu0YwyIpC2hbLt7ngrqpfaVyvqG292AqZXqDCwrZQS32G6npg1PI2K
 q69FBTL8Ax9zN5+QaPZEHQRSuGpPOnprrSOGBhM=
X-Google-Smtp-Source: AGHT+IGAswS5ZX6imJDIPlqKJviOea6/cqfLthXLSK0V8wmgDNJrztK1OAxCSaYT6PDlKNAqemLKwg==
X-Received: by 2002:a05:6808:1407:b0:3a7:96b4:cbe8 with SMTP id
 w7-20020a056808140700b003a796b4cbe8mr52906oiv.36.1692139074834; 
 Tue, 15 Aug 2023 15:37:54 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003a40b3fce01sm5903418oib.10.2023.08.15.15.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:37:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 02/12] target/riscv/cpu.c: skip 'bool' check when filtering
 KVM props
Date: Tue, 15 Aug 2023 19:37:31 -0300
Message-ID: <20230815223741.433763-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815223741.433763-1-dbarboza@ventanamicro.com>
References: <20230815223741.433763-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x235.google.com
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

After the introduction of riscv_cpu_options[] all properties in
riscv_cpu_extensions[] are booleans. This check is now obsolete.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9a3afc0482..f10d40733a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1907,17 +1907,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


