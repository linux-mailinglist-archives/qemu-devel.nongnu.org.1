Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454EDB1B978
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 19:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWd-0000J4-Lg; Tue, 05 Aug 2025 13:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWW-00007x-Rv
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWS-0004yZ-Ob
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so3894008f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415141; x=1755019941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLuT5ufmLt3XqNS5X9fXVmklfwye/hfpmkjpVA3qSZM=;
 b=UmQQZBDhsqGU2anwakYjwuN/hIxQa7JehU2NPfC/nv9QOv/jykGeiZKBuRpjNXYWbp
 gnXWe338uaa6t9De1311jnTQ5yt+nn6F5z5mOHiZln+Z02JoIyNlEsUiKn51n+Js4yi4
 lubnvQgKm/E6sfUlzuAs/Jia24OpKGTmHHh9BwFGIWpxlTVjllnpBy7sZQwqCD640tZq
 uo29gT5scYxlpt1BBGggX1dL2o0G11AdCjYjLwJ8hn91OJZ2CO/F1HW4kR7DvfA0Ce93
 dQBu/0BiDeeMynui3cybcUxMhMw72Yu7KRTNyadIrDVTx161lMwj4tXiVrNaV71aggkX
 HtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415141; x=1755019941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLuT5ufmLt3XqNS5X9fXVmklfwye/hfpmkjpVA3qSZM=;
 b=QQypsFGGuWPBOLPqxdwZvlJm02MGw/NtsxlNSaOBk+J05R1YY2btkU75fLkWHfZTcu
 oUkE/3EsgWMEXHWRI5v1ZRpvPfAz9RiMtlS/7iPDHygziRS1VYa26t8TWRL2Z45bjpAG
 1vUoc2UM6jkeo+gvdK7YmvJJZ+6jA8jTL1Uo8jzaTt52izJT3KcGM6At5O0SmnUi7PYe
 9u7FehLiIQd2sC8Eo+nZfbm2tSoHKvg1shq0Jk2zfL4+Fs3l9DffYTrE7z32yeRKtZPd
 Hqf+C8uLATiuz4NPcthQa8HCWBQqTmeGcW2RTc8jv1znt4+Y7NtFORCXR4n4BEHxK/CB
 VjiQ==
X-Gm-Message-State: AOJu0YzTFUYHqVcfvmIn3pucmDynYQHtiaA7MAYlohjKIUdviwH+IRoQ
 Ai65EcKZoVUIxbLJJ06/vgrbZP7HJKYnPaJu/qCTQuj55q3aCCal9x0yjBXOLFXQrR90S3vmZlv
 ioTBn
X-Gm-Gg: ASbGncu4S3tDd6PfqxL6VuRSrxXF2kPm79fr9/W8+pYUB3GvzGHjcdjCkxQYReQmyEA
 Rk89OaD5EXN265mcIhdU6kdp+xH5H+OgY1W7rmllHt2XgG+8AZ/ZDDFgDtfCn80XL42rFV3WbYa
 bNi/8UpLM3KFg84la5EseO0PCVVg35s5slLLek0dYZ9vrK5qNYumwXN0Wael2W5/0GXov2pz5Pf
 FUpsTYRpa/1kt8gU+b/efUFbuJ3e30yZjJePhj2lF9lxjj1IuFuXtjIdH/YYz+07NNrGLD4Xfk6
 klWMgOKNdHW2GECfhP2BiLgG29sJGexSvPo3B+gao1GeMRw0RHY0Kl/VDwSOA8ItdgqK9SX03G0
 ffq84owLdiDCNy3igKGF0Wrw7j8C2jdgNAdr5VaeSXZN1y54oKH/8t71mL2JUNkLkj66lZPvbuy
 mFcQxtgOM=
X-Google-Smtp-Source: AGHT+IEnCC6ZIuaILMTqORMFskeGZ0dwVgnAQpASEI9gITTx3lpcdDhM6OtL0IAlTN8592ThU+w52w==
X-Received: by 2002:a5d:64ef:0:b0:3b4:9b82:d432 with SMTP id
 ffacd0b85a97d-3b8d940aac5mr10878545f8f.0.1754415141327; 
 Tue, 05 Aug 2025 10:32:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm20047887f8f.12.2025.08.05.10.32.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 09/13] hw/sd/sdcard: Disable checking STBY mode in SPI
 SEND_CSD/CID
Date: Tue,  5 Aug 2025 19:31:30 +0200
Message-ID: <20250805173135.38045-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
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

The card should be in STANDBY mode to process SEND_CSD or SEND_CID,
but is still in IDLE mode.

Unfortunately I don't have enough time to keep debugging this issue,
so disable the check for the time being and the next release, as it
blocks Linux. I'll keep looking.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-10-philmd@linaro.org>
---
 hw/sd/sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ee81dc09991..22f30997713 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1591,9 +1591,20 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
 static sd_rsp_type_t spi_cmd_SEND_CxD(SDState *sd, SDRequest req,
                                       const void *data, size_t size)
 {
+    /*
+     * XXX as of v10.1.0-rc1 command is reached in sd_idle_state,
+     * so disable this check.
     if (sd->state != sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
+    */
+
+    /*
+     * Since SPI returns CSD and CID on the DAT lines,
+     * switch to sd_transfer_state.
+     */
+    sd->state = sd_transfer_state;
+
     return sd_cmd_to_sendingdata(sd, req, 0, data, size);
 }
 
-- 
2.49.0


