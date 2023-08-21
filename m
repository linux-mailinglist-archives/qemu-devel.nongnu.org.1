Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A27829D7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:02:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4Wz-0000la-Mi; Mon, 21 Aug 2023 09:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4W6-0000GN-PN
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4W2-00017z-5S
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so1500728f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622816; x=1693227616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qcp2zjh0Kae/JSBm9k7FRLIsQxWf7QHOQrpHAvtUzg=;
 b=R+psxyLRTAvK6U4Ca3UnBWDC5fKvwr8WsPF2NzCTreZ3aIIsyPclM46TXe9dzqgHbW
 dUKpFtPOYX70VW51uzbgDKHVoQsR+GFwRoo4iLI+hLd1ncVRr2L4v7DWFXWGrKk7mkye
 8J5FB1Ss6QbnCoWxNtiIT0nvvu93NxtKr4GccB04e5zwzC6RfL5RPLtFePWCtWdghzTQ
 RjIfZRR4nfkfQ98LcBV9FhfgVm5teha8Gbph+J0e5kbHXUXmg00nYUEeaulsYEbyrNgb
 MOWkR+O8d+Dmj2xW81hKt13jqJcY/DrizSsictFzANDqMQJSUnWQGWCx76ghM1KkcDbd
 KZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622816; x=1693227616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qcp2zjh0Kae/JSBm9k7FRLIsQxWf7QHOQrpHAvtUzg=;
 b=TodSqvRA+6lphJeduPVG+0rb08tuykgTBekplfq2Y6wbznpVt7T8N+IlGIAmJ1nh4m
 5la6TXsN3/MhP7L0BNfohir5395eRB9oNBFlZEhf1TMKsNJ6DOmlQ7C++q39x+02UMnI
 EQZlxwv1zb6d9ECEtMKC8UmCeIn2TZLf1rMMiDsc2S2R+8WGQCOFV5NG9ffK+MJN80tS
 iuRkH9kAoLAiqTHxwQFti51+lvoyjU/Y3xeehBbibpqEucRPVCOy1rDjhb1oUM7VhEa/
 ZpvCr842zFKQusawt6+goE/ayqdyDjWQQAIfA1Z5rNyLQ9P2urRfc+8AUwSnROZ3w8Pq
 SgnA==
X-Gm-Message-State: AOJu0YyHSu4xROiNj5W7NVrBnC0uZN/pXnTpWI8MMBhQ3RlkTIhIMg8n
 Mts+c7DZ15kWPKK5MOFiYdLbogN/WdusmDuMQvM=
X-Google-Smtp-Source: AGHT+IGKLjjqCat6vSR9f0K1KK8CmbiWyHG8v4ykeFsp66OhI1AxNrhjjTYhkfYebLsPx8VjScFT6w==
X-Received: by 2002:a5d:51c1:0:b0:317:e18e:27bc with SMTP id
 n1-20020a5d51c1000000b00317e18e27bcmr4406693wrv.71.1692622815707; 
 Mon, 21 Aug 2023 06:00:15 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 j7-20020adfea47000000b00317731a6e07sm12502404wrn.62.2023.08.21.06.00.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/8] target/loongarch: Remove duplicated disas_set_info
 assignment
Date: Mon, 21 Aug 2023 14:59:53 +0200
Message-ID: <20230821125959.28666-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Song Gao <gaosong@loongson.cn>
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


