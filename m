Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F772F1B1
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDS-0000RH-WB; Tue, 13 Jun 2023 21:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDQ-0000Li-Ce
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDO-0004l6-Pu
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6664a9f0b10so91310b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705745; x=1689297745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I95LaG/FtIFLD5F+dP8UUbDdhOhOSJBukNQ5EzT+SA=;
 b=TMVENRoNJ9anUq780SqzGF4zBUaDbxUZhS3/6i9Tp6kGkNsPXuzvELAEs6bfj2kTRx
 XG4P9RRthQGrQXzl7tUY139PtDdR6RTe1ABrwsKJpgOjXljL2KYt8Ie4h6t8sK5j9Bt3
 rV30nFiOgLxWc5/CTiRNGha+APALVdwI+9FFTAsryoju982KWWJkQbANIA87jzTmKmOM
 q9iwzXdNgaSdyLcO2772q3IfOEZj1d8pmVW5a/w6fqqCx0wtNNVZqtEW04M9/8bw06L6
 1tYar5mM/8IE8ykqdaztx7mqS5WxLyeEdhapxFZyFS8dkShKNGF+mFeJk9b4xgvPNyNi
 YRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705745; x=1689297745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6I95LaG/FtIFLD5F+dP8UUbDdhOhOSJBukNQ5EzT+SA=;
 b=de2Nqp/2sJQUOitPt4hb3TUecZ0/31P1jwCU1DKa3RXQK4Py40DY+X5uBt0FzOI3r+
 CqFTlPQcq3l41/fI1zJaATinR1EZLljur+pG7bMaRJkU9Pv45OMt1EE2wezbKZFJ5pJ1
 0N9yNgUUgAdPG8O5cM5jBvuDflN4pEws5MvzCjWciuu64wQiJ0Joep4SUQwPyRbY0m2r
 bTPOQDOKUdZ3/SvVMxWF3J+V6rlb1SaZ19075CdOFj/DIFxxTTOdzKClB2C0+d8TvJGJ
 687LXaKpE/JUkfqy5sO28+rXX6FT8DltQ81DBFL9Qvvw9HVPE88qgL0iy/HZqAjH31tr
 8uvw==
X-Gm-Message-State: AC+VfDybo5qIOFaSZqNd38MZWk1ZtrOKr1omTSw8TuxhiVtGavlLc03T
 NStAQiUqnVkalolZa44otqQIBhD467jTag==
X-Google-Smtp-Source: ACHHUZ7PhFJk83nqLzw74VNB81Oh/gWwm2pweBlI3xuhYSgwd/6wO2ropm3zY3eAnqUa7FnCXpIgeg==
X-Received: by 2002:a05:6a00:2382:b0:64c:9b56:6215 with SMTP id
 f2-20020a056a00238200b0064c9b566215mr508374pfc.25.1686705745288; 
 Tue, 13 Jun 2023 18:22:25 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 28/60] hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE definition
Date: Wed, 14 Jun 2023 11:19:45 +1000
Message-Id: <20230614012017.3100663-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

QOM type names are usually defined as TYPE_FOO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230520054510.68822-4-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/opentitan.h | 2 ++
 hw/riscv/opentitan.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index c40b05052a..fd70226ed8 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -53,6 +53,8 @@ struct LowRISCIbexSoCState {
     MemoryRegion flash_alias;
 };
 
+#define TYPE_OPENTITAN_MACHINE "opentitan"
+
 typedef struct OpenTitanState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 294955eeea..7d7159ea30 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -118,7 +118,7 @@ static void opentitan_machine_class_init(MachineClass *mc)
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
 }
 
-DEFINE_MACHINE("opentitan", opentitan_machine_class_init)
+DEFINE_MACHINE(TYPE_OPENTITAN_MACHINE, opentitan_machine_class_init)
 
 static void lowrisc_ibex_soc_init(Object *obj)
 {
-- 
2.40.1


