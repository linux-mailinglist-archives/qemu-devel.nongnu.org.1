Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766D7902A0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6P-0007nA-UK; Fri, 01 Sep 2023 15:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6N-0007mu-L3
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:43 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6L-0002vd-GV
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:43 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-56d8bc0d909so1428031eaf.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597600; x=1694202400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQilM6mPMPBt/et0RgnK1omGUy9pg15ijboQ1qTt70s=;
 b=TLs128JIepnH2tICxi/SNomxHGHfJf2zUwQLT1HrEODgnrsjWH6We0LP2rlz+Yn6EZ
 JiSwD+OTjctx1hyHx6sbsGdgO3YkAWCee/lJHzvPwFGYAWoDwPHFjFaZWwpvRF0xfrB3
 jnTzyYuHc8zSgdwI1iLq2nLBJXROBtbickt7Q2WHmKBg33GpUA6VgsDMRMfBMgXhchu6
 Fz9BrrxL9k05AfqcvKic6kL3FOHiLNuS8NKDAPbZck9VxQbbCTfuy7/v+LamsRv7Ekx8
 W1ydvLkOmhsPlDKjfBfpP09pYytTsKmrB033WHPGlNLJSGcsUFsUVIpc/H8auBl0P43h
 FVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597600; x=1694202400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQilM6mPMPBt/et0RgnK1omGUy9pg15ijboQ1qTt70s=;
 b=kq1/RF0po96N7MWDHuKylWE1S6z+gpPmEpMhHzdbGVC3m5iZ17OE24Z8Q+iW/Oa9OZ
 SgzcFIyhpUzvJuraWE1AejVGB97O0CuHWNQl/Vt4PVC7oDcMwZ/Wfaqg8OjhbxPcHNsj
 wSukR8/yNT6VqYyeJaJhXI0ve9ljUy+GK4t9i0vMUPBWZBCusr9H/kDIXJRJZ3GebKGu
 BBSpu/IIDc/CepELX3o+AQqMHE2SUYawV/UUte4goGcLqiHE3SiHrsL0BxLUCWULPSoY
 ThCk0lT3isoSnCoX5rEotsd674HWHbdoBKbm3qNk4UOYk6o4zXEXEd0QRF6DsfEA2hbr
 KSfw==
X-Gm-Message-State: AOJu0YwoToTFbXSX7kxujZT66z7gcMFZ+JqzYRe0gAIEu2Y1PkU0LBfN
 qXuMdf2ysjEhoBBg2Fx/Ovu3+chPIx/UslZdrjg=
X-Google-Smtp-Source: AGHT+IGwtjlRaYqxWuHsAttj4A84skLVst04AHEaIsW/ineDakiWgSxp/hf6PGwSwlPrqefS3mus8g==
X-Received: by 2002:a4a:92d5:0:b0:571:281a:ef7 with SMTP id
 j21-20020a4a92d5000000b00571281a0ef7mr3450585ooh.7.1693597599961; 
 Fri, 01 Sep 2023 12:46:39 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 02/20] target/riscv/cpu.c: skip 'bool' check when filtering
 KVM props
Date: Fri,  1 Sep 2023 16:46:08 -0300
Message-ID: <20230901194627.1214811-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc35.google.com
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


