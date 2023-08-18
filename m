Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2D780DA3
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05v-000528-3K; Fri, 18 Aug 2023 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoY-0006Mi-Vo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoV-0002xA-Q2
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so7235045e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692354882; x=1692959682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymM53Ev0232IoCe+uLOGROzpIIU7OjxGy8keEyXRRBo=;
 b=xLu7PcdHMfuNwzZ0Mzv4tNdHLkrl5YILGI4QzYlzjaEJL8Tfgiu8wtGI51WoFQF0eW
 35/8Gyag7jrFo8ArapSj7PrZCiTcxcqrSAnNI0bdPzn9J4RoizUO7l1ZiF63WKw4yOr4
 c7YblFlFyr1RPNxgIsrNUZ1/3cYuKEnu58DpJXJg/x7dKapPgnVdQGSYt8eibgR5WM2r
 W2ROSmWozRZyuDu1swDDdE4v6w/eTTOlU8kkeq7egcZhDdx+8O70y6fPjPmtP5D+zeur
 ceAH8UsCS+ySDa8K9T7yo+1zUmS+K+f70jd6R22zxIZxoGolWXg2dfpM7xgaldaEkJ0Q
 +36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692354882; x=1692959682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymM53Ev0232IoCe+uLOGROzpIIU7OjxGy8keEyXRRBo=;
 b=cuIxGkPjTfnR0D2PWx5IiL1gbruFgM6DQBJC5FabLJsrOFwAwTre5Y6VWUgksx3KCd
 FQ616Lh1bxR+MzWAqmdjuBQB+GDFuwZrr9U9CCQIgvx5q9TDe8HUKVkwpQ0xGstIL22o
 Ulbk0uYQFYxIhWazruY5kOdzYVjpTzoK4xtD9rmqHnRVCQ2MBH9mKgb5j8oGHJMLp0Al
 RqFVW2+Uh3l5LtbNEUWgyieZiKCfFNvaKvokyjGQilH9BOBqYe3aDKw4il6w5lXU+uBM
 rQ7Igp3/8hirWakD+q+NjIzUcHc/0m6IReJ+XNMV4ZX3tg9dmc9zgu37gv6w2TkCPYbv
 LL9A==
X-Gm-Message-State: AOJu0YzlNztxKhhksU3Bj/G8tsQdH9dcSXAF5ay8EJTfCtgfZa9FLrez
 K8YIdjVk6RheOgMz+NFIeqw+T1U1NK7HT+xijDs=
X-Google-Smtp-Source: AGHT+IGyGCIdNMlNvgUVxtJGoJsSNMCKrCHtN4BZxna0QvBRwjfkhbOLKq1OHCeFPSFfPpFmfnNiaA==
X-Received: by 2002:a05:600c:28f:b0:3fe:26bf:6605 with SMTP id
 15-20020a05600c028f00b003fe26bf6605mr1700877wmk.26.1692354882279; 
 Fri, 18 Aug 2023 03:34:42 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.41])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a1c790b000000b003fbca942499sm5762728wme.14.2023.08.18.03.34.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 03:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/loongarch: Remove duplicated disas_set_info
 assignment
Date: Fri, 18 Aug 2023 12:34:23 +0200
Message-ID: <20230818103425.16271-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818103425.16271-1-philmd@linaro.org>
References: <20230818103425.16271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


