Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE96C783AC1
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLh4-0007ac-Av; Tue, 22 Aug 2023 03:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLh1-0007Xs-Rx
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgz-0004qj-AE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so1015513f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688843; x=1693293643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONpA0UFQdSnkRLzqiVi2DjQGuL0JxDlhUKCdcQf7dH4=;
 b=yaDIFFJAldzZTa5bsVNpRAc6ZCFtVdkTBmhlJ4OeNC0opQPAL42/pHyS9KdncTlGKV
 IE5i5cr7lVb1saZxicUEn9mLjUQviKieWV7BGKCI+ZZzBgPE5z0dE6wGLQSvh7T9bSWx
 s7t3qaUd/dWLogFc31ISwaoIcrXRlspX4w+srSwybnyqYO1NwBi0H5x3Anpq78kugaPN
 f5sA6e/pf7T1VDLnCS1xc9YQ19h4v6Puw6jTa4KuwqiLhR1Hm1nV5CJPs0NE5IN2/mnl
 mhjSjzkRBDgQzKCblUKuSCZ8+NHllaaWpLTtxqNfFMDJ3p4k1xVdbpp2u0VaxWOW7zhY
 Mixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688843; x=1693293643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONpA0UFQdSnkRLzqiVi2DjQGuL0JxDlhUKCdcQf7dH4=;
 b=dDm+W+rRGRxDZKucyPEtu7I/VqekS0NhlbwNRCD4vMkikXWKjjijDs4lrWBeI7Rtto
 SaHgNW8a6SZ0kEmfhjbhygPlWOgN/ngyyLs4UL07Y1UzcDWW1Qk5hrBb5VTzA0DjriEh
 OEXqMcQFLZgg+kW2uDuLCrlH29bj+Eb+c149XEQXkHC5fV9WPx7IV2wWWjNOBsVgEINm
 zgMNgvharpm08cXN2NxXYicFyzR3tOeR5gYM0VCkA71Ss0un35sGbpNR3o3eyAcwxoFI
 BXwWyz30Hdpa2oz4WQu6jYVgAzYdvr4J7LSSjMfWSyc2NJXaCQ15VUJoX6Wokk+S1/Q0
 Md8w==
X-Gm-Message-State: AOJu0YzncNX9TCTgWOGg5xd+aIl0QgwJBcirEVpPFifWJrEg4wDesSRL
 eBwMlUlXklpPoq4EhhHxT1aqODRj5Hdht5AftcezZg==
X-Google-Smtp-Source: AGHT+IEeiGSlYMztqjUq8TlAY9dvOYpUz8Io50mlH17zWO+aWTOd3ilJInyXsCaoNVZIWdjAufeQRw==
X-Received: by 2002:a5d:4531:0:b0:317:ed01:dc48 with SMTP id
 j17-20020a5d4531000000b00317ed01dc48mr6518084wra.9.1692688843664; 
 Tue, 22 Aug 2023 00:20:43 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a056000100100b003141a3c4353sm14933500wrx.30.2023.08.22.00.20.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:20:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 14/19] hw/loongarch: Remove restriction of la464
 cores in the virt machine
Date: Tue, 22 Aug 2023 09:19:54 +0200
Message-ID: <20230822071959.35620-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Song Gao <gaosong@loongson.cn>

Allow virt machine to be used with la132 instead of la464.

Co-authored-by: Jiajie Chen <c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-11-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e19b042ce8..af15bf5aaa 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (!strstr(cpu_model, "la464")) {
-        error_report("LoongArch/TCG needs cpu type la464");
-        exit(1);
-    }
-
     if (ram_size < 1 * GiB) {
         error_report("ram_size must be greater than 1G.");
         exit(1);
-- 
2.41.0


