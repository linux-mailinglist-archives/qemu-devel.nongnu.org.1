Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934967C63C6
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:13:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn2e-0000vF-FL; Thu, 12 Oct 2023 00:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2c-0000v7-Dn
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2a-00025H-TD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so3970435ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083875; x=1697688675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1O+LUQaq4zM1pCT4MlGHQbdt/TTdje7M5o30kshgqZI=;
 b=fEA5pVALQYaCgO4zwapaPUuvsW9Hj61Rs/mVE/8aM3C1uxd9C4betALd4m3LSEiMj6
 2r33/bTkUdYz1FD5Xyc0/CJ4A1jobQ/xrwv6Z3ONWCW398cebGDVJbcHWIzfCsqvgO56
 e3ybTTlmoKbPrVHn1cCc4QBt9s2SiPPHEdqggCCJU0g9iuPPoc6Q2wgnLyqsNSin0ECd
 v3OHcaZWoGtBXTsoYACMWa/OV5rkYY6XzTMmWNNqRkkLGRN+cvBlcuX6kIZJHM3ylxnr
 Nb5TD4Hequp4/RgsSgVZPF+5ZQpwA3SwRE3jM5buDmFuFs91gBf27gG8YX1BTIKJEs1G
 2Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083875; x=1697688675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1O+LUQaq4zM1pCT4MlGHQbdt/TTdje7M5o30kshgqZI=;
 b=vqLKlr2O+ouQFPZ9P5u2LwtgceWeIgh4LC+vT4DgejiygFI34xfMKsze7iXiSSc1H3
 O8EF9LJgLl5SeUPqhJ/4xD5kwNH076AkZixMOB1/uAqbe15cFYJ7uDfBAeHHdCa4SR7b
 Z+FVI15RDcvsr9Vv1W8bL8qkwxbO8jDycleJb1JdHcODdMob7RbIearAUzC28WdJ+UBZ
 f+QuUIx8CIAv3pc7AGIZlVr5T4FDJElQR6dRaracpCAbag6aFFSWfZtcVqwWZhtzqAgw
 Jmk438vnPzUtlQYwiuJgo2a/DgADdL1OtDyI0a1Z+N9mL7sx0W6iKj5tP1RgpFwYv3GH
 gC0g==
X-Gm-Message-State: AOJu0YyMpAYL68xQU+HJmbzFiEhF8BlRtCLI1PQ7ZSBN8FxXGQwlM/32
 zJcZHVCZexN6Jxc8pSbTt0mF6x+U2fAcYQ==
X-Google-Smtp-Source: AGHT+IGgCqrjwKC7gRrdF+sEZNoSEGhtzZeoMGgATBNW5oNAKtQmzAWna4yBp7ix3zAubM9GC39iMw==
X-Received: by 2002:a17:902:f54e:b0:1c4:65d5:34ce with SMTP id
 h14-20020a170902f54e00b001c465d534cemr28308996plf.31.1697083872701; 
 Wed, 11 Oct 2023 21:11:12 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 02/54] target/riscv/cpu.c: skip 'bool' check when filtering KVM
 props
Date: Thu, 12 Oct 2023 14:09:59 +1000
Message-ID: <20231012041051.2572507-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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
Message-ID: <20230912132423.268494-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 03143c3686..e02f399c81 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1972,17 +1972,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


