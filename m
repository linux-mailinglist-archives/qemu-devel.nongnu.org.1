Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A442B78EB09
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:49:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBO-00042d-SB; Thu, 31 Aug 2023 06:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBB-0003db-Bx
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-000453-Cl
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401d2e11dacso11782565e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478729; x=1694083529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MCjuA8VpBXu0MenkuxVKPe+uHxER/DcfJ0S9UzL2X1E=;
 b=hBgAZB2WBTZ2sMBlxcDudK5djuP0XJW0zDaXg/NK3MFwnOndMqMSrzdJ66dv9l5XWx
 rpp+Smun2er8hJ75/4AY+gz13jNbr9EOCSH9RKKdyAa4yAjkyuJBvJ/NH3zD4uDcWbnL
 B3C6nYf59rNzbvsMEQZNn7Xu/gIqJrL1OqbJDXlpXeyEsEwwAK5xUoH1O+jMB7DwO9BD
 TS0jAG04+ok0MllTA2UVYNVXrBwN3SWhGj52sdT0A/RSJoeQ9isGndiHBTADhtWVFKgN
 Gaeg31cejjEQ/GJamrrTI5f+RBBP0qWi5srKA1rCwbpIKPECp0mCsAcLzj3TD8chiKjB
 Nmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478729; x=1694083529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCjuA8VpBXu0MenkuxVKPe+uHxER/DcfJ0S9UzL2X1E=;
 b=KCzkeIX5G3ef4gEf0i/zLpfiHgwlXtiEzNi6iefx9H3lZHbnkmpfE6xOVnmiCzcqM1
 WTdBpXGflMSZHtK60u60VmffADmbkQlRDNLIXSlQx2FFfpxBcALTb10S6Aq6gxugtLAd
 7LCsXTRnsKFS30tYWVVL1iv0uBE13JqfrPUZPAJhcVoSQ8qjWMU6/TNxRqdQRZ+YTlGT
 ikNylh91BXKRvuH7JVXCEVqTXl7PlK22oN869yLgSF2eWQNphtjFFh0CexHVjojvzv37
 zzU66Y60dyygIe+kDfWQa54PeqIOGfKsomBA88ixuOvMqVTaz/8VhsnmyGMclA1drDML
 q7qg==
X-Gm-Message-State: AOJu0YylhiIIMfgfkDwn7J8UczTVX/A+ETzZOHnMQ+Pv/GKXxSjeOM1f
 XH8/2DsrbFICLItL2j48oC0NA3hRTr8CRoS9RSc=
X-Google-Smtp-Source: AGHT+IHZxCCrWiBn/JuMdyU3FarSQe3DnSF+as/hEw47asgYg0kuJb4Qnq/GpV3cT2yv7cgHAIdZWQ==
X-Received: by 2002:a7b:c84f:0:b0:401:b504:b6a8 with SMTP id
 c15-20020a7bc84f000000b00401b504b6a8mr1745176wml.2.1693478729209; 
 Thu, 31 Aug 2023 03:45:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] hw/rtc/aspeed_rtc: Use 64-bit offset for holding time_t
 difference
Date: Thu, 31 Aug 2023 11:45:15 +0100
Message-Id: <20230831104519.3520658-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In the aspeed_rtc device we store a difference between two time_t
values in an 'int'. This is not really correct when time_t could
be 64 bits. Enlarge the field to 'int64_t'.

This is a migration compatibility break for the aspeed boards.
While we are changing the vmstate, remove the accidental
duplicate of the offset field.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


