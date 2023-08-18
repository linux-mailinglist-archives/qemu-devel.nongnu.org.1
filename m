Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58478118A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39f-0004Zk-4Z; Fri, 18 Aug 2023 13:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39H-0004N9-3P
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:36 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39E-0001oh-Ul
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-991c786369cso150621966b.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379231; x=1692984031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDDiUObgQlqnPEjumWcjcKFBdygOD4fC1QpRcXk6j3k=;
 b=tApuWAVlN1MtgISqy2WC8FafcdIJ9bADz/SLym8mhNl5XlTKnOFBQiEQB//eg5uTXe
 khfYNw7iCnk1mFmoHZRzxNp1HRg6zIAba3debOO2YwFsYwBgL6TAFP7ZCjv0MYj5rLcc
 RGJp8dD8DZaqiDxzAKH5IA05zYOIkkDv8qzXSPIvcpSXHBc2zesXmFHRzPkDsWWRxcxw
 zCaecx6qeRwVghCleb/T8GiMR6t9cD+Oy6j+qjX96w1VTKHzeRi9k+JzVgaPOhRLaS/K
 Dn6Jewi/xNiSn7Z0ZNVxoHUX76GSNs1eIgD0csMA0jXvaR1GqO2WFG960HHcFBTtcNOn
 T6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379231; x=1692984031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDDiUObgQlqnPEjumWcjcKFBdygOD4fC1QpRcXk6j3k=;
 b=UFKOqacEd6T+lu51sJjMwrS3F82zRPP8r/4ChDq3NttfxU96Q+tnXB+7tXzxf4UA/n
 vMkitbTQ2KbDBRxA1Z289CL9Y4Cfgz0oSbnPrr+ewrQ7KNBZArvux1lFFZh462LoRC8m
 WetW6qRY8u9xzeK9CBhAbrddFcQRhyq1yi59lejbXY0xXN+HpWfb8S8SIec3nFhZ8Dzr
 /xDeQKg4I2c2fmmOmLKTHWoodvtrq7OWmXDXQe1GXHAyDW8jBQcLgOhNVOkAq8gSQMD5
 TZjHBLqARFTtJQI4A0oK8danxaqQ1n2deA3MAtJ+XaLStblSkkavuckGLsB6u33hdZQC
 +0Ow==
X-Gm-Message-State: AOJu0Yw5Lb859ItVhFlLzIQA2zrUTZKuCBaZw7xBgwPXZheMU07jlO8+
 g39HI8cjNP0y8z7n6VkKcXwMmEYI5j/nUbfL3YY=
X-Google-Smtp-Source: AGHT+IGhchCXhW+ENJ4JMk7qZjoPNw1B4ZsdR9VqJejGsqrtB4bqzR3JjX163npFdyZhOEjhzsJTsw==
X-Received: by 2002:a17:906:9bf6:b0:99c:e3b6:eafe with SMTP id
 de54-20020a1709069bf600b0099ce3b6eafemr2428252ejc.64.1692379231077; 
 Fri, 18 Aug 2023 10:20:31 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 c17-20020a1709060fd100b0098ce63e36e9sm1444269ejk.16.2023.08.18.10.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/8] target/loongarch: Remove duplicated disas_set_info
 assignment
Date: Fri, 18 Aug 2023 19:20:10 +0200
Message-ID: <20230818172016.24504-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Commit 228021f05e ("target/loongarch: Add core definition") sets
disas_set_info to loongarch_cpu_disas_set_info. Probably due to
a failed git-rebase, commit ca61e75071 ("target/loongarch: Add gdb
support") also sets it to the same value. Remove the duplication.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7107968699..dc617be36f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -723,7 +723,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->disas_set_info = loongarch_cpu_disas_set_info;
     cc->gdb_read_register = loongarch_cpu_gdb_read_register;
     cc->gdb_write_register = loongarch_cpu_gdb_write_register;
-    cc->disas_set_info = loongarch_cpu_disas_set_info;
     cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_stop_before_watchpoint = true;
-- 
2.41.0


