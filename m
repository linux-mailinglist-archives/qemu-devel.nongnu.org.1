Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86475B3BD
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMW3t-0000Yj-9V; Thu, 20 Jul 2023 11:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3Y-0000XI-9P
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3W-00054E-Ln
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so7825175e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689868745; x=1690473545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+fu3Hdhlxf6MgJgkEAusairljl/PpUC4pvYOeOu/ZE=;
 b=Ao525uJK2+OHzTfjR94YhIfsPC4vVvIYQP5BPwxLczfgvHgSPskJq6hrJUv/dexQr9
 dd31SY3nbLcSEcg3Dqs9ZjLvTmka1P2EuOZHC8cw6bCBoEDqVuDUQ7aM4KbDu5lo2diU
 0AGGdV5cnY/A4ICk688uZQXOHtcFvUmi29vM8tspQIhp8Cko83N5X4aM3XAOyUbKGQRH
 F+BUTGObiBsU/di/sWONylNDFhRwC+MIk9YfMUEqEouf/9rGQ6FJrpqr/O+nakCvdKH1
 RLT3D72YG50eqtWzJM4R0PBmeBJo9Rkjpv1O/76dFU21njLqOHVDNZikL0KAK4yLGd8F
 RHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689868745; x=1690473545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+fu3Hdhlxf6MgJgkEAusairljl/PpUC4pvYOeOu/ZE=;
 b=QwSCD333t6niRyzNbBaV6p8Ad6++ucKWbq4hwsCJSvGt+lzgSLS2XWiOsXGAvLdfHD
 1XjOTUdK4XgSrLE+JQe3e4So1MJrverDD6GDKVl7MCBVoW54U0sGrxbyo0NGDeVilGcP
 WY3Nj5Hzq7ROG7RqA3ey5oTdOAdyPW+CypiQm5PT4Yd4tkMNVxNna47qIC6RFp2zY7OX
 prF06z2fYD8NyY6cZfSAVBpzOxo0Te0uKtpxQ103MHL1Pk6PrV0bUtv3ZsdpqD66e9Ub
 HhqlpA7x1uYTq6Y/jI1vuw2wQZZceZvE9flg7joxS3r+lGo+HmpaLKH09GFFZd7QPZQ5
 ZaNQ==
X-Gm-Message-State: ABy/qLbUUeexpGexKCv6Z2RAaThDwgp9B5EjWGwfdFW4sOomJ/3bKuN0
 /KcQH8M2XJCiD/sxfZG1bNvG/ndacXZkJELHVJs=
X-Google-Smtp-Source: APBJJlFF+EU571plm4fQ3YtZZjUDXajpFnaY2l0+FSX9l4LyINyuY9HX1jNYiH6R94KGtgzdHHOyew==
X-Received: by 2002:a05:600c:d5:b0:3fb:b890:128b with SMTP id
 u21-20020a05600c00d500b003fbb890128bmr5148407wmm.27.1689868745257; 
 Thu, 20 Jul 2023 08:59:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c220500b003fc02a410d0sm4187572wml.48.2023.07.20.08.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 08:59:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH for-8.2 3/4] hw/rtc/aspeed_rtc: Use 64-bit offset for holding
 time_t difference
Date: Thu, 20 Jul 2023 16:59:01 +0100
Message-Id: <20230720155902.1590362-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In the aspeed_rtc device we store a difference between two time_t
values in an 'int'. This is not really correct when time_t could
be 64 bits. Enlarge the field to 'int64_t'.

This is a migration compatibility break for the aspeed boards.
While we are changing the vmstate, remove the accidental
duplicate of the offset field.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I took "bump the migration version" as the simplest approach
here, because I don't think we care about migration compat
in this case. If we do I can write the alternate version of
the patch...
---
 include/hw/rtc/aspeed_rtc.h | 2 +-
 hw/rtc/aspeed_rtc.c         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/rtc/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc.h
index df61e46059e..596dfebb46c 100644
--- a/include/hw/rtc/aspeed_rtc.h
+++ b/include/hw/rtc/aspeed_rtc.h
@@ -18,7 +18,7 @@ struct AspeedRtcState {
     qemu_irq irq;
 
     uint32_t reg[0x18];
-    int offset;
+    int64_t offset;
 
 };
 
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index f6da7b666d6..fa861e2d494 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -136,11 +136,10 @@ static const MemoryRegionOps aspeed_rtc_ops = {
 
 static const VMStateDescription vmstate_aspeed_rtc = {
     .name = TYPE_ASPEED_RTC,
-    .version_id = 1,
+    .version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, AspeedRtcState, 0x18),
-        VMSTATE_INT32(offset, AspeedRtcState),
-        VMSTATE_INT32(offset, AspeedRtcState),
+        VMSTATE_INT64(offset, AspeedRtcState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.34.1


