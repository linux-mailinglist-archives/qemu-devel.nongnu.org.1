Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D619172ABB5
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yi2-00058g-W7; Sat, 10 Jun 2023 09:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhz-000571-Ud; Sat, 10 Jun 2023 09:32:48 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhy-0007ij-Bl; Sat, 10 Jun 2023 09:32:47 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39a3f26688bso1144015b6e.2; 
 Sat, 10 Jun 2023 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403964; x=1688995964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRT8QKCy67KWSILed1UYE9t0uEVbDDHAYQXTtdnc0h0=;
 b=ZjjODe9s3B6mT3aQhKf++4fdjHwFS93M89FkMEqcSxtIz+Am+5NfkdAxzVbgaP6LYH
 GEpmrbUp5jzcIsIgKplH22sfTRluNDU1VQGxKojxU4tjhTEvC3mG1fVaRoBWfVmYp851
 w1Tw3H1Vbx0V5+waOOeBvuugwbEPyfJ04ZZq9JvPiBHA+DTvYVI8E/gXP29c5IF/DEQp
 HY4ZlL+Jo39iScibOLSHMUXkV0XaUP1sWAIT+Zg/sRopURJi7RsQiwXaapFa/CRZ7i2W
 iXALe/bkapKhwwcKWWltS/2hY1c05cN4mP9mCLoS3gUF3slKqBCtzcvkQiStcoOHFkiV
 UfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403964; x=1688995964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRT8QKCy67KWSILed1UYE9t0uEVbDDHAYQXTtdnc0h0=;
 b=ejbZTLDzhmIWlv6dEsJIzlWMtKo9bOmKDkqp70xBIoyvD6lFY/1ALCHC66gfPHzH+F
 ZAZz2QLAICG805LlbHC7PxnsnIY60S+TGi8I/UswCmbqEs0j6MWvXGe5Eg/IkjataPLj
 yw0ItBGq4upDU1jLsnTi48t9GSWeG4Ey666v+8SD0l+xjmkE/t6jv0BiHNAXa9YgqX4e
 SyEkT6sF1WivMTQpwmof00gzZtLaPahhBO3xldyDf6TikGk9OFWTiCvfYv9cneGbujuy
 cHDERb6VRxLGqnB7uyFkRYnws4++wchWzp3nvvqj4cOjRy+m739Eg7hfe9f7+IGfSq7Z
 dHJA==
X-Gm-Message-State: AC+VfDyW+EKza88mMB8erQA1UGkIiQQHThVVLpeBM5d4UWZtsrTqaiWA
 +Wl7937ZNHzA4kEfpY91TODVETJmmXQ=
X-Google-Smtp-Source: ACHHUZ6SmjaT/75msv/f3vS49KCbrA7OnH7wmTW60HBWc7y2gPy/pBf5e7xUjXulhSVwfdCcOqg6Mg==
X-Received: by 2002:a05:6808:1281:b0:39a:ba14:3140 with SMTP id
 a1-20020a056808128100b0039aba143140mr1152127oiw.25.1686403964410; 
 Sat, 10 Jun 2023 06:32:44 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:44 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 26/29] hw/ppc/openpic: Do not open-code ROUND_UP() macro
Date: Sat, 10 Jun 2023 10:31:29 -0300
Message-Id: <20230610133132.290703-27-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

While reviewing, the ROUND_UP() macro is easier to figure out.
Besides, the comment confirms we want to round up here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230523061546.49031-1-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 include/hw/ppc/openpic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index ebdaf8a493..bae8dafe16 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -55,7 +55,7 @@ typedef enum IRQType {
  * Round up to the nearest 64 IRQs so that the queue length
  * won't change when moving between 32 and 64 bit hosts.
  */
-#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
+#define IRQQUEUE_SIZE_BITS ROUND_UP(OPENPIC_MAX_IRQ, 64)
 
 typedef struct IRQQueue {
     unsigned long *queue;
-- 
2.40.1


