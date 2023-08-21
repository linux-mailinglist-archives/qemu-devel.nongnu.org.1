Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD27829D0
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4Wy-0000Mq-Eg; Mon, 21 Aug 2023 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Vx-0000BR-Ub
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Vv-00017A-OS
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so2025695e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622809; x=1693227609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajIy6AXOv6OC/kq7WdoBWCKBE4f90n/4gU5LLrh9Jio=;
 b=YNk3qs6nAFujYDmWCG9otiPJQYyQJYYIk0ky4VbhK63ao7MgP8S0cXOlJDsbT8GcB4
 vLOLoa7VoY8jrOeYl+LvIAxXNTMkrW1oiDBsdUNfYwDo5kYHr6Zj4QpS3YpdUEMxNPxv
 xfTC+CDuD2ryEEJg+Um++bwZz8PxTPG8Pch0LGPGI7GsOJL91rZmX5BLvTc+uxCcOzUq
 WyQsAmvPgx3ArX+XwfcLFviq02cfGmntnAZVuBUWf+tflRtO4U/xv9+cRvtYwsQzabWE
 iTO189anKlvxjj/3/+/XyKxABsx0Ur6tE5mnXKM4QTe5RDl97FaMPgVYuk+ln5MVN07b
 rZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622809; x=1693227609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajIy6AXOv6OC/kq7WdoBWCKBE4f90n/4gU5LLrh9Jio=;
 b=jiaJne9z2Agc4oOAySttB3RUWcdf8qrMI+rTGchm0nKzx/67BrUvDkpgZsnkbLyrzK
 o5YyT0tA/FPCGj0YAVuNlvDqdmScf1wY8w1AJZWP5rROsBCB8zGr+CJnEI8cVZf/UXNy
 C8YvpR2uwdmKB0Efu2rPIyUSKEqj8rABIlJp879jeJqZaEjXyOJ9zk2kwiIyQPxhdJZi
 E000OhE8yvQttGyzCrvipLkICigmCiAivJDx/m5QiwLbZFibiuhlF0Fn0/xDk1KEVxoU
 NPbe6N6b9OrZX6dlZmFwkSu+2qy+g4DzxphbOvI0Odhd4v6SMI81l3MBylaASaBahQyn
 Qj8A==
X-Gm-Message-State: AOJu0YzIBPaOJjCEKLxYzcYTP/s9P4eCwu+gphZzwhtboee+XpgfmYNd
 rLsosGsttwwnnphZh/u+WA0Nb9PFPKJ7VMTn4v0=
X-Google-Smtp-Source: AGHT+IEIZRcCmm5JrpWhMXuidj45Yu+1Rx05AJLJzmH4uT8xLv5AnfK+vzw3mH3rBtzRg4ad019l5g==
X-Received: by 2002:a05:600c:2901:b0:3fe:ef11:d79f with SMTP id
 i1-20020a05600c290100b003feef11d79fmr2830988wmd.36.1692622809174; 
 Mon, 21 Aug 2023 06:00:09 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 f8-20020adfdb48000000b0031934b035d2sm12570855wrj.52.2023.08.21.06.00.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v3 1/8] target/loongarch: Log I/O write accesses to CSR
 registers
Date: Mon, 21 Aug 2023 14:59:52 +0200
Message-ID: <20230821125959.28666-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Various CSR registers have Read/Write fields. We might
want to see guest trying to change such registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..7107968699 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -544,6 +544,8 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 static void loongarch_qemu_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
+    qemu_log_mask(LOG_UNIMP, "[%s]: Unimplemented reg 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
 }
 
 static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.41.0


