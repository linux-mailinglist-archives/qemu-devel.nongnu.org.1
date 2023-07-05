Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B882B74850B
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:33:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2co-0006TX-B5; Wed, 05 Jul 2023 09:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2cR-0006Mw-C4
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:32:31 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2cM-00021D-91
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:32:30 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e29964942so297423a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688563938; x=1691155938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5L5O6YuXvA1gkJxg2X5z0QB/Yl+Zb8DVDs3tCRC3SE=;
 b=smJuboJxZxqWVhq2qfGMiGBglMt5r/4wcLpj/V5ygXtpT/rzOyu7yFPnr1eNgVviIs
 TsOi44QXlc9o5XP5RWAdTuoOHEJVO7TOKcYfg4AY2cog87IDysIMMHSrz7d8wsoRCYOC
 p/rAm2IOKT45lVnnZecaGs6vUSBLz8O4Hu4Vo694upTmxMr4I30+J7fbqRzI26m26lvb
 OCo0quaefvK/laFKpXYv/2J/JueWU71eUBOy94O2MCzmfNA7fNoJJecLVNGeq1jIHoz/
 x3n8GhqGfXhnTVusKa3ghhyqKp8jn+KUANJSDAjSQx3OS9201/pmOSFSc0FG0zhRTWSB
 StzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688563938; x=1691155938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5L5O6YuXvA1gkJxg2X5z0QB/Yl+Zb8DVDs3tCRC3SE=;
 b=C+7vR+A1X5XwTbdjhtUPcyu6feOcJCF5kFk3X+F6kyFn4w0ju6zAeEsXpfLU2lWwZl
 jFtAnDkPsiYRw84w3doJxVM6PZMXhIx1x10F6aTH2vDGAjVp2H+SHUyaSbgV2vMFjLzG
 K74PwCETJpXu2CrjKVeaD+gIWuu0FUJYR4s4SHRnHUs27RcEn0dJcQLN4wtgkZk+aWmO
 vbNUQni9h62yDtGFhUuPptZz9HnKxKFywAfi3YC+2Rgf28lnD95bZAkijFZIA4H2ePww
 yCSUaDRjZx0kmr08imsnjOo3bBMiF3X3idr4x9BNV56YEda3TGJM0Gchlybl5xFWCC9H
 ZmqA==
X-Gm-Message-State: ABy/qLbYsSQRBCt/8IuURv8ii7IVWWFWc3wkYNfGqkGXpTZb2OdifHnv
 4WKqUQoByMJSKPKEnroQ4bMSbJF5LST8AHBO4e0=
X-Google-Smtp-Source: APBJJlHcEF944JFWKrYI+x3EBMMELL9ufOQEeTctIC13D6wloxn9B5IpbmO4fS8/6GNKGiToDJpF3A==
X-Received: by 2002:aa7:c644:0:b0:51e:29e1:b6c7 with SMTP id
 z4-20020aa7c644000000b0051e29e1b6c7mr392572edr.33.1688563938463; 
 Wed, 05 Jul 2023 06:32:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 b5-20020aa7cd05000000b0051da8fd7570sm7823672edw.41.2023.07.05.06.32.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Jul 2023 06:32:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Laurent Vivier <lvivier@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] chardev/char-fe: Clarify qemu_chr_fe_add_watch
 'condition' arg is a mask
Date: Wed,  5 Jul 2023 15:31:37 +0200
Message-Id: <20230705133139.54419-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705133139.54419-1-philmd@linaro.org>
References: <20230705133139.54419-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

qemu_chr_fe_add_watch() can poll for multiple conditions.
It's @cond argument is a combination of all the condition bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char-fe.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 8c420fa36e..309960046a 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -179,8 +179,8 @@ typedef gboolean (*FEWatchFunc)(void *do_not_use, GIOCondition condition, void *
 
 /**
  * qemu_chr_fe_add_watch:
- * @cond: the condition to poll for
- * @func: the function to call when the condition happens
+ * @cond: bitwise combination of conditions to poll for
+ * @func: the function to call when the conditions are satisfied
  * @user_data: the opaque pointer to pass to @func
  *
  * If the backend is connected, create and add a #GSource that fires
-- 
2.38.1


