Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D708970A5C0
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 07:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FPS-0007NV-Fg; Sat, 20 May 2023 01:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPH-0007GC-Ua
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPG-0007c1-Cq
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so26269575e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684561529; x=1687153529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9CmwAgDvj3Ddgy+Sh+yZXxS5mPQZ+cjq5z84zBdlHE=;
 b=Hw6L/nZYiuaevh/ccfzTW0UM+ugEhuzW7l/8EVTF2v/L0rh+hpP6WUx8O6ExRzY6IM
 yy/HUuoJyf6J9FvbgwT2Il9iw6JkOz2NSe2ExEWZ8qMfUZN9WOF6ZrSOZRg3572v6Ocw
 T2z+MPrBd7uB8eRI04DymxOMiagvresxopXyVjDebib5JxZ17fEP82/e4dosyRXjh+IX
 whK3cjQ8x4vXMvLcncTxaBN1/7yUfBkOulYJajfltfl/IOLuVcht91E5wGeqTjp+BpHT
 oJ8GdLbi4vq8+AnL0J0tXGJSF21z3sfiyvKinCEAZhgiAfTAy/bqur46vH3RMsRJ5ORH
 vlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684561529; x=1687153529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9CmwAgDvj3Ddgy+Sh+yZXxS5mPQZ+cjq5z84zBdlHE=;
 b=OExJe7mIDzDlajxUjq1AA3BOHlr32hD3vN3PBN943sRAi8Onwj9StNyvu2vzeEq6ec
 ub/xzXx4Ytu4omJ18MRIJC0xfYAzu759qQY2jrjZ9KoZzAI/rlWEMJFmpXKpXvRZhQQJ
 oPVpaYg8jdKWfrMKbw+l3p5rPwnFfKRxhTxYF7Tk7HX140mrF6dUYN9wYzGpqAxyyOts
 P3SSXPP5gZJAMg7bEe8RWmHWPTKMYeiO3A8dOJaH/bL/qmR+t3wMGLyzn45qXzZoNF/q
 a/wSr37YvmO8JEtT0X8Q+QVJx9oQEfs2B6/zApkiUlKkLMrhdb+tOLL7Nnf5ZpYrG7ZN
 rq8w==
X-Gm-Message-State: AC+VfDyrPfTRw/ahI0r7JEhgR3pZPLT9GefoD4RgGE9eQnJg1KyXh9NJ
 oN4Jxcg2tNKUHZ5KVxsiB+fNmsi+LbmdNs+EvAA=
X-Google-Smtp-Source: ACHHUZ7lHds296hhh4Usq+CAkKRaqx0UI/ko25lo0dw8dtC2tL7bmEfp1MM0TLDzRPo1XNAHhMam5w==
X-Received: by 2002:a7b:ca45:0:b0:3f5:d70:440f with SMTP id
 m5-20020a7bca45000000b003f50d70440fmr2929027wml.19.1684561529545; 
 Fri, 19 May 2023 22:45:29 -0700 (PDT)
Received: from localhost.localdomain
 (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a1cf30a000000b003f423508c6bsm1086791wmq.44.2023.05.19.22.45.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 May 2023 22:45:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE definition
Date: Sat, 20 May 2023 07:45:08 +0200
Message-Id: <20230520054510.68822-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230520054510.68822-1-philmd@linaro.org>
References: <20230520054510.68822-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

QOM type names are usually defined as TYPE_FOO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.38.1


