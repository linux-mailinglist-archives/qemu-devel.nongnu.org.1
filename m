Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A6791B34
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDM-0004E8-4z; Mon, 04 Sep 2023 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCD8-0003QY-6I
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:59 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCD3-0007eN-EA
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:57 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bcb89b4767so24278021fa.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844031; x=1694448831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhyPLNQFlPI2Qtv/db+V50enbSRfShGobOGuQ5IYsJA=;
 b=nVskmaef1b2JOZgy+xR/QQJh0wkByhD7E4tPhNfHMFqevZlZ3dHa+8eZ0LV3PVqEaX
 NhGS0st3wk4Fj42IX4pIIzBYwZJgM6hCus2fEy5TO7UC+UkQv+t3NLxA6TDcpGgWHtZr
 IT48+2kBUn4FxQCDTWdQxFUDkfu+u9S5QJAM+GxVoIJnh02egOKkEBhbzGtsnvMTs5fK
 hIxMs5mkSFM8u770IyIldClz5+UmAJZi94soayyTcHFq4gFsmCLCXJwJsNk5LnmpE7x4
 xkGzbvQIHOprvtB7LiMcUG3fQGIGCpaOSS1kfGKBKIvLxogAhNt9J3lIvYAiaPPgD9pl
 yoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844031; x=1694448831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhyPLNQFlPI2Qtv/db+V50enbSRfShGobOGuQ5IYsJA=;
 b=SX8nuiHHWH9nSblxyyJWLUCd+YguGJFxhJws+xB9hT9R0Osla0DFvP5vXzDWYiU50F
 rRFuxZa0Ru+RK6ebugFr+9rrWwY8ItfnX0BXhxWyjv6RjE81ghXlX8rgQ7wjnLRdcT3n
 FfwZdJlMt5JFMBjDVH0t0R7Cqu80YV4d/Xn2WJ/BWPP8tV1lUISX27bH2Qrafg9HoOPw
 oJWvvZ5CF78AzYsHXgXCM5oS1YifNC7mpgtr2umvmigxQW9LBMUgYR4VrqaTkzH5cl7s
 JXtH1SEeRxrTEaeoOPo9sWv9HzuQepxCSi5GKx/WVkvmVnCJjBZNHD6pn53HkYh2sCCq
 3Zkg==
X-Gm-Message-State: AOJu0YxXRrbMuHStc2QNZEnu9mDAUf4IlowHA+cgeZYIXNTVEsSwi1/E
 zSzOpr49r/hO19K3pO7lZ0AqeQ==
X-Google-Smtp-Source: AGHT+IGm8EnghadDiWw2zM3Ocs7+8mVc7EoimMIFn1pE25jfyjf0plojjcFue2ncQ5k5l1m4T2B0bw==
X-Received: by 2002:a2e:864a:0:b0:2bc:c846:aa17 with SMTP id
 i10-20020a2e864a000000b002bcc846aa17mr7888614ljj.41.1693844031798; 
 Mon, 04 Sep 2023 09:13:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a170906c28a00b0099297782aa9sm6318128ejz.49.2023.09.04.09.13.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 13/22] hw/microblaze: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:25 +0200
Message-ID: <20230904161235.84651-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

Fix:

  hw/microblaze/petalogix_ml605_mmu.c: In function ‘petalogix_ml605_init’:
  hw/microblaze/petalogix_ml605_mmu.c:186:24: warning: declaration of ‘dinfo’ shadows a previous local [-Wshadow=compatible-local]
    186 |             DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
        |                        ^~~~~
  hw/microblaze/petalogix_ml605_mmu.c:78:16: note: shadowed declaration is here
     78 |     DriveInfo *dinfo;
        |                ^~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index babb053035..445509f699 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -183,7 +183,7 @@ petalogix_ml605_init(MachineState *machine)
         spi = (SSIBus *)qdev_get_child_bus(dev, "spi");
 
         for (i = 0; i < NUM_SPI_FLASHES; i++) {
-            DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
+            dinfo = drive_get(IF_MTD, 0, i);
             qemu_irq cs_line;
 
             dev = qdev_new("n25q128");
-- 
2.41.0


