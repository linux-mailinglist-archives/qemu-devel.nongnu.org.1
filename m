Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB217BD69F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmSL-0007sh-Tz; Mon, 09 Oct 2023 05:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmSE-0007rl-9Y
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:21:35 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmSC-00018s-Lm
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:21:34 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so7360990a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696843290; x=1697448090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DkY2Js0F8feI+eDewmK7f1DkRmkJTMBbTxH6PGU0fdY=;
 b=L/N9Aiv3JaGMHuzrKQZs7uMmh4T3z+QjmlrmJW/WDI36DjDb6bzj52q6eR+KZ/iGBw
 2xaWu3qPV4E2hLpDbheHmBaqHYuaWNgyvzQWk8RbUyd5ybnz7ZbbERrkm7x/LpMeUSjc
 TmDEOk7Xpn7AkAX41cxlLFu6yYGijkl6b89kfzkWXIqiVQNMuY/T+H2o7pZC4Ec83n5C
 8vhiHGpUhSguuHTARmRWSfkI9mjSp1/er3GKkv2WxL/lbHGJEpvMLzqex9xuwh6eyxYq
 g5Y3zj6/y0g2AuC2SPwmiIMirV8oKijiH9iVBBXw8eOYF1UMFdnTYEAuCtNojA+hUDMc
 nFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843290; x=1697448090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DkY2Js0F8feI+eDewmK7f1DkRmkJTMBbTxH6PGU0fdY=;
 b=ReIT5euKJemBJ91FLBVLomlvW5XFVTna80VFFOHvXA1hfRRFojURmTTJZ0z8/mSpaz
 h0L5qRswSGAXxLig5NEGNhPkLL1QQXFZP/P2qaTTM58sXekf1AsQU4EDjPrj9+B1JyFT
 143E+1R9b47G5Rcbpz38TUp3KPw10ANximZArXfFeSQUjkeZQf5KV18LIwU8PeiJifes
 TBBPa9q2fGIrMqGSNeS8FpjymFilyLs0Aj8yLWHInJt4Qs7Ngqr3VapM2D4gHvmv7A5c
 sso3vo3IJ1ptN12AvhCR9r7HvJ5Qww/kUTNO9AqbaZWzRnKe1LDfoLsyFur0YOw0RJXc
 NVOA==
X-Gm-Message-State: AOJu0YwkjTaVSh530BVBZGqNO+NlNOj+AbBy+/t1t/BWpwnZUoryEU5v
 Vy2mNHdHjalVwDLtGxqzVWj1TiCZIv82Lg4fpIU=
X-Google-Smtp-Source: AGHT+IFd0BpmX/PHPE7PbyRs+oZjMI3xTiPondbYmegxdnwGD0M/q/kv9lu8oIcPcgg4cn9cwxCnpg==
X-Received: by 2002:aa7:d9d9:0:b0:538:8949:9e02 with SMTP id
 v25-20020aa7d9d9000000b0053889499e02mr13807053eds.30.1696843290015; 
 Mon, 09 Oct 2023 02:21:30 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 z21-20020aa7d415000000b005361a6da384sm5895820edq.19.2023.10.09.02.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:21:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Corey Minyard <cminyard@mvista.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/mips/malta: Use sdram_type enum from
 'hw/i2c/smbus_eeprom.h'
Date: Mon,  9 Oct 2023 11:21:27 +0200
Message-ID: <20231009092127.49778-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

Since commit 93198b6cad ("i2c: Split smbus into parts") the SDRAM
types are enumerated as sdram_type in "hw/i2c/smbus_eeprom.h".

Using the enum removes this global shadow warning:

  hw/mips/malta.c:209:12: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      enum { SDR = 0x4, DDR2 = 0x8 } type;
             ^
  include/hw/i2c/smbus_eeprom.h:33:19: note: previous declaration is here
  enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
                    ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index dac27fad9d..62d04ed113 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -206,7 +206,7 @@ static eeprom24c0x_t spd_eeprom = {
 
 static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
 {
-    enum { SDR = 0x4, DDR2 = 0x8 } type;
+    enum sdram_type type;
     uint8_t *spd = spd_eeprom.contents;
     uint8_t nbanks = 0;
     uint16_t density = 0;
-- 
2.41.0


