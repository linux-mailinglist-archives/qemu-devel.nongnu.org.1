Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF07C80D9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDsv-0007IZ-Ej; Fri, 13 Oct 2023 04:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsg-00077U-9v
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:52 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsU-0001Zc-TZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:43 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so3174049a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187036; x=1697791836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkXpvGHRShL27hGo//oRLPeZ/R70r+dcqj6ExBIw2Z0=;
 b=WUTe1ERMRSwk+R/g0zTaIcB+JTciiIAOgrIsac9HpJqhXxS5+okZ3y5VGeHmd66CA5
 WM2MV9WQvR/Ba1mSEZRHDwP+li2nUcznaPODJ4Rya7wfpAtvWlu/BUPoba/9hTsJC3zC
 Ta0GF3ySqd2n7/TbIu/t8RVLDX8Eu1yi9hEoLv2kh7b7xnsbgu5a0jH19Vvxc1+8JM1I
 eBTDsiBCiMTPINJ1WJcy22XTUhEfzpyaklRgyuZd6uB23nsgSuXEnY9nyO8Q1GLSveyC
 lAcxqFD18+AtFUFSjdpnqBKHKDdeuerqK075U2pkXmSML7CLGMpcGbhKYBO200gpD1D+
 Hy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187036; x=1697791836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkXpvGHRShL27hGo//oRLPeZ/R70r+dcqj6ExBIw2Z0=;
 b=bJWz3HPmz7xyvdimbkGfvXTuFxKT+VuK6fVHwV18NvbKQiN46SgBq+EEuWRgm7burn
 KqQUteBgirSGqupZq4CzrCEklYv3CQkBQjUg5PpqkGD/ZkIgvwFPo3YA/LicGUpBDqxZ
 9DSIbMahuv2YDQY5NapvtPWWjKqjIQBSVFSvH0x//Q/44HjNZG6RN1ZX47UhsIMTOTGg
 t5QnXL9kCgoG6x4F0xG/IHuu2I3GidcAsvSl9xoozLI5LZEiYCN3xTGW2YQkacri36um
 MO8ZCCSGgLPkP3WFJmTS3KRAt9mb5HUhdhvENykEh1gIccX3nuyV9qBzXBYCop27bpMX
 SKuQ==
X-Gm-Message-State: AOJu0YzD0t42EE4B0dllPH69483ywiRTtWdSVqs5HU+APYGKxeP1an3a
 8mSPtohIseqEufVRjwJBGZPLsbtl1MP6DQIYsNQ=
X-Google-Smtp-Source: AGHT+IEsvis1QS6J/EaJNLFBLM951oVyPnH3wZiTBvYnXUyU3U0qa2mOWDMxIZAJcYr3Ii/R0I1GsQ==
X-Received: by 2002:a17:906:314c:b0:9a5:d657:47e1 with SMTP id
 e12-20020a170906314c00b009a5d65747e1mr24122017eje.43.1697187036259; 
 Fri, 13 Oct 2023 01:50:36 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:35 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v3 66/78] hw/nvram/eeprom_at24c.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:34 +0300
Message-Id: <e567a0495cb481f7f9066438e114e97d84ad2376.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
@@ -71,7 +71,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
     case I2C_START_SEND:
     case I2C_FINISH:
         ee->haveaddr = 0;
-        /* fallthrough */
+        fallthrough;
     case I2C_START_RECV:
         DPRINTK("clear\n");
         if (ee->blk && ee->changed) {
-- 
2.39.2


