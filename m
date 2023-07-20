Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982FD75B3BB
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMW3u-0000ZM-8I; Thu, 20 Jul 2023 11:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3X-0000Wn-Kx
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3V-00052y-BA
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso8050715e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689868743; x=1690473543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f7RhLlLTH9d/rakQ0mat86ivv784V49YQgNfkdu9jCY=;
 b=CzF84x3bmkGmHltnfALmFbYGmEjh1oBgXz2iA44zQ1WphWPyYY5ptxZtnEwrpxXmNg
 90zSSSRucP+gCPa8TsHEklFZU8uLed13TtWs1Y2ewiTVD0PBwGG3WWDFA2MjPLWjemOb
 DavTVkOtuoWk1Mq+n9TUnSfKtCWpDFLbExOWa5Jqf0UGBmo6oKD0RZEDu1JYlDHoZMfT
 qE29KC2sckDQqQeSkwIgMJ+850zOGB0iXDI7uhW8PeLi3+aaPhO/6C84+S//dHwO3rKO
 mWtvZK2T3Rrj24vwc25ibfbT6mVkI//Epnww8+th25cGh1WWUOo/D68qSZ+d2pszFXph
 Y+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689868743; x=1690473543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f7RhLlLTH9d/rakQ0mat86ivv784V49YQgNfkdu9jCY=;
 b=Ds/FcSS6xoYwoLRif9vFvKpgJbqriEBuwUVm+x4SA1soTb9CVeUsxjryxfCmlyyyV9
 q/NKaTw7FYiwRIQAHxDcpk3BwHxCL/zp1WXjlKhXcFbO5xfAAzxzRoBzZIKubYq+zwps
 UaGBJlbaKyExSF6qCIylHHmrSJonF4R8Wv8I67zZuQYQpwHBVNBrsJWORHWhUTXMlL8/
 TbqpsG2Jsqh1F+jFYRBwd47FOwDX/iG76CAYZ797S4rwT770h3bEzv1pYa/kqw/k3+hL
 q2NbsThBvmPpzo/ORkEa8bxdBw9XEqWP+YHR/7LFGt4qV/me2QsqMah4spBPzBHl1hJN
 3LSw==
X-Gm-Message-State: ABy/qLY/+icK7Ypeml+GCwRQj501ZCvsMyZsGi3PEaVa4cGy0U5wD/su
 sNMU5nHXnUbUCF5bI7f0huL0Bs6Ljp1PItYd64Y=
X-Google-Smtp-Source: APBJJlFKdv1MvTtiz3A8/Ckon3czs9szB1TlXy06rtcuxLTPsEPOJOlCahE/X88XL/Bgd6kCyW/07A==
X-Received: by 2002:a05:600c:2218:b0:3fc:1f0:a66e with SMTP id
 z24-20020a05600c221800b003fc01f0a66emr6980142wml.1.1689868743316; 
 Thu, 20 Jul 2023 08:59:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c220500b003fc02a410d0sm4187572wml.48.2023.07.20.08.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 08:59:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
Date: Thu, 20 Jul 2023 16:58:58 +0100
Message-Id: <20230720155902.1590362-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

This patchset was prompted by a couple of Coverity warnings
(CID 1507157, 1517772) which note that in the m48t59 RTC device model
we keep an offset in a time_t variable but then truncate it by
passing it to qemu_get_timedate(), which currently uses an 'int'
argument for its offset parameter.

We can fix the Coverity complaint by making qemu_get_timedate()
take a time_t; we should also correspondingly make the
qemu_timedate_diff() function return a time_t. However this
will only push the issue out to callers of qemu_timedate_diff()
if they are putting the result in a 32-bit variable or doing
32-bit arithmetic on it.

Luckily there aren't that many callers of qemu_timedate_diff()
and most of them already use either time_t or int64_t for the
calculations they do on its return value. The first three
patches fix devices which weren't doing that; patch four then
fixes the rtc.c functions. If I missed any callsites in devices
then hopefully Coverity will point them out.

This patchset is a migration compat break for the aspeed boards,
because the offset field in aspeed_rtc is in its vmstate struct.
We could in theory make this a compatible migration change, but
I don't believe we care about migration compat for these boards.

I've only tested this with 'make check' and 'make check-avocado',
which probably do not exercise these RTC devices much.

I've tagged this as for-8.2 because the code has been like this
forever. We might as well give ourselves plenty of time to see
if there's any unforeseen consequences of widening the type.

thanks
-- PMM

Peter Maydell (4):
  hw/rtc/m48t59: Use 64-bit arithmetic in set_alarm()
  hw/rtc/twl92230: Use int64_t for sec_offset and alm_sec
  hw/rtc/aspeed_rtc: Use 64-bit offset for holding time_t difference
  rtc: Use time_t for passing and returning time offsets

 include/hw/rtc/aspeed_rtc.h | 2 +-
 include/sysemu/rtc.h        | 4 ++--
 hw/rtc/aspeed_rtc.c         | 5 ++---
 hw/rtc/m48t59.c             | 2 +-
 hw/rtc/twl92230.c           | 4 ++--
 softmmu/rtc.c               | 4 ++--
 6 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.34.1


