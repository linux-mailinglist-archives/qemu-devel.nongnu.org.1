Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D870F986
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxy-0006Xs-Ni; Wed, 24 May 2023 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxp-0006Pv-84
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxm-0006UP-My
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30950eecc1eso965597f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940381; x=1687532381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SG+4qtQqEV95gLJ8RAujBOb32EOZfukr8uo1CCxUpw=;
 b=vO+3YZby3t6mHgWKph7afN9yFxbDrF5IvvP32Yo14fNXQ96X9GQMB9+9XQyaDjl2BD
 1FEMtC/QZ/F+MQ0zRcPp6C5dcu6UK1cPMFOKnRek2GqBNuYfQJXn2is1ZfrgO4wEzDyK
 Gv5bp2EFVdLfP3n/Bgz/fQaNluZ8OXi4bVy3cRECWE8SBKceVwPUN5SI1VEYdPEXvnZh
 GVxxQW9u0jUsCLKFdvrStEcrUdDKGvUcc1Kpzi+Lfi9LSjO5Qe0H3yiYR64nlOixjL5N
 s5ynd/r10YjK/5SgHoZuTA+UJ0V6WhsrgSRxiETN6OufoyCJcnXi6+CxhmeACLyM9g9b
 WUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940381; x=1687532381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SG+4qtQqEV95gLJ8RAujBOb32EOZfukr8uo1CCxUpw=;
 b=SWFxKCX1Hw1wmgdt+L4avfcVt9DSQpGFXGbzXfGL26Q7gjjrQXOe089FWtCmZYElEv
 VKpN5YTIGp7e9C2nr0FxIkN2Ele3Cya2TjnL26eBa+Y74wwMP1bUJKJRMB0GTyiiLLOd
 GFv7+/3Hb6vNgQnPTElJ6CRC938hzfXn+3w68l7ela6Exhc74SGaO19Jj0cSTkw8Ryoq
 johdQ7221MwMfmhQhhMQ87zig95CGks6jLbO3cVH8kyrjdCdwyT9NUqj1rHRy9Dy8hpH
 FGKjnSHCxXcMHkQ6RZoCcrWW6MIA7MJiNdS200a6fPf18o8WgY42Q3OKGqe/zyVbt8FC
 Cpmg==
X-Gm-Message-State: AC+VfDzyUoK9PhPGr7qj27mcrl6XHr5Cxhe+a58Z9zmlImh0RoQ3l3of
 1KDO0rgxkGvK0Crk2tY+vFdDzjVZzMLRDb2uzqgfBw==
X-Google-Smtp-Source: ACHHUZ4c7UwfZi1ZsCM+IeSRvrK3OJm80hvl21U/u2WcjJPEPkLWgjHYNDa9bfQPg8BwPbLUrrLJ6Q==
X-Received: by 2002:adf:dccc:0:b0:306:2cf5:79dc with SMTP id
 x12-20020adfdccc000000b003062cf579dcmr52483wrm.35.1684940381245; 
 Wed, 24 May 2023 07:59:41 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a05600012c900b003078354f774sm14618282wrx.36.2023.05.24.07.59.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/10] hw/arm/realview: Move 'is_pb' to RealviewMachineClass
Date: Wed, 24 May 2023 16:59:02 +0200
Message-Id: <20230524145906.33156-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of having each machine instance set whether EP/PB,
set it once in their class_init() handler.

Arguably this could be extracted from the board_id field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index c354ce0cfa..1a3a64e0ce 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -34,6 +34,7 @@ struct RealviewMachineClass {
     MachineClass parent_obj;
 
     int board_id;
+    bool is_pb;
 };
 typedef struct RealviewMachineClass RealviewMachineClass;
 
@@ -94,7 +95,7 @@ static void realview_init(MachineState *machine,
     unsigned int smp_cpus = machine->smp.cpus;
     qemu_irq cpu_irq[4];
     int is_mpcore = 0;
-    int is_pb = 0;
+    bool is_pb = rmc->is_pb;
     uint32_t proc_id = 0;
     uint32_t sys_id;
     ram_addr_t low_ram_size;
@@ -109,11 +110,9 @@ static void realview_init(MachineState *machine,
         periphbase = 0x10100000;
         break;
     case BOARD_PB_A8:
-        is_pb = 1;
         break;
     case BOARD_PBX_A9:
         is_mpcore = 1;
-        is_pb = 1;
         periphbase = 0x1f000000;
         break;
     }
@@ -446,6 +445,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->init = realview_pb_a8_init;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
     rmc->board_id = 0x769;
+    rmc->is_pb = true;
 }
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
@@ -458,6 +458,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
     rmc->board_id = 0x76d;
+    rmc->is_pb = true;
 }
 
 static const TypeInfo realview_machine_types[] = {
-- 
2.38.1


