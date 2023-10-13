Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0977C7FFC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5y-0001Lk-LV; Fri, 13 Oct 2023 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5Q-0007uY-6P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5O-0007Oh-H8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso18666835e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183992; x=1697788792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GPD0nD92kyhAvX/+7GtykcnaxIggVTiyJju9wfdc3Q=;
 b=d+Fkk8IsO8jyeFgbTuFs7gZEY6gtjqzDeuRF5Qv7lPGUaWckAJorWjWYkk73MpTKcA
 lvLXx+s/zqJQIDpTMbGg03XKUA76Oyuj6/MYpiLGE8vcMvkeboDzuTtB+RrnKROIa83X
 3eBL/h8Fhlk7Cnn/+wGt8kz0wNHZpt7M6uyc1pQgKgjtH/yeYY6dNsggqVWhmReg/46c
 U1PjyHrPgcglY0oGapnlHeVrdvvB+wxYoM8t+b6khp1qmv3dyCpEHkd+z/SmxdGKaLqD
 DJNcaNRoOckV9HgRvIWUkGVB3TNbm5od5+HMD2/uTXusVyFjYjeS3fgkXY8x1uCy0m0O
 tQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183992; x=1697788792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GPD0nD92kyhAvX/+7GtykcnaxIggVTiyJju9wfdc3Q=;
 b=SD2XpUFdwAlM6y98v/HbzGcXoLKR+tNaVOAhAQSrrGXfkM2cUHv5bcMjB9/yrpirnL
 R9/u8Tw0AQdMpcB3VmSiZuM4MDjFgm9s5RKNLdtb6ChNBC30+4Z2vCwDG+r42u6UUk8c
 wHFLe/rxGrPU8j/bdD6h9C7qqnuGkNbpMceCOChXxpRGg9xu7vbjMJdlToypsJNIyjmI
 Uq01zkQTFVtzPLH9m0CNfDJSQUF7AFiD7pgGF+KzppawCC5x59OOK17AoGniAWx3Y0aG
 EekUb5QwjXUNsI3JY2F0S89RIsNtmk+ngicTrG0QM/sgfKVc1Qd4PmYlKCgfhAgAwX8e
 SfLg==
X-Gm-Message-State: AOJu0YyYB8L1jjrhbu6Xnews5vi1Yi9K3RrYN196cbJCm/MsgShzGe7d
 Tz9LAvP1hMg02q/Ybfmss7I7/5F95sNhDb2k/w4=
X-Google-Smtp-Source: AGHT+IESIFi8BfAl95FSipsdloCbkvkj5aGkx/wZJS0XFI27c7v2KvkCkz50yDqBnJGlKPT6KM3JqQ==
X-Received: by 2002:a05:600c:3657:b0:405:7400:1e3d with SMTP id
 y23-20020a05600c365700b0040574001e3dmr22566025wmq.32.1697183992454; 
 Fri, 13 Oct 2023 00:59:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v2 66/78] hw/nvram/eeprom_at24c.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:33 +0300
Message-Id: <d04f2d4a754f0a9184ddf50917621f61600c142f.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/nvram/eeprom_at24c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 3272068663..aa3685db33 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -66,28 +66,28 @@ static
 int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
 {
     EEPROMState *ee = AT24C_EE(s);
 
     switch (event) {
     case I2C_START_SEND:
     case I2C_FINISH:
         ee->haveaddr = 0;
-        /* fallthrough */
+        fallthrough;
     case I2C_START_RECV:
         DPRINTK("clear\n");
         if (ee->blk && ee->changed) {
             int ret = blk_pwrite(ee->blk, 0, ee->rsize, ee->mem, 0);
             if (ret < 0) {
                 ERR(TYPE_AT24C_EE
                         " : failed to write backing file\n");
             }
             DPRINTK("Wrote to backing file\n");
         }
         ee->changed = false;
         break;
     case I2C_NACK:
         break;
     default:
         return -1;
     }
     return 0;
 }
-- 
2.39.2


