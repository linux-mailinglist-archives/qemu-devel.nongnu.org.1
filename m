Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AFE7D9A43
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwN6L-0003Qz-Av; Fri, 27 Oct 2023 09:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwN6F-0003Q9-S7
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:42:07 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwN6D-0000I6-R8
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:42:07 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so331540166b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698414123; x=1699018923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pJwLySfUF35zlxa5YOPsnj4pWWz4vwyKayb5dbl6BxU=;
 b=CkxAnJ+jndz9+lFtKAyo6cPzz4naivMtJ8SL1YlVEL+bbIyd/rtnP4DuhKjtUER2Cs
 sP5UzeJw/GXO5uYUWVd2Wn7KdYOT34u3kdSMnWHeA/iqwyOzVYYyellPatWCGsMNwN0Q
 S8d3TRi5MNrouuJthAlWEv6G+I05gQy9ruV4/l2bjjGvko0NqwnACZLr8VnYTQWdyPZW
 SGnpEdyGmp6W/ma8HveC9EmLtxbD03v/Gvp0Wtn39/5EIsGxaKKm25bKWnvSazofYm8S
 uxpUV0u9uYxQaYmXRPq9whE9f90gQMdqxLwB00BKR56a/7TLu9xLWDbUI06C/50gHd+t
 8VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698414123; x=1699018923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJwLySfUF35zlxa5YOPsnj4pWWz4vwyKayb5dbl6BxU=;
 b=OMoLyM5LeVrhJAR/Ip9Wu9hVbb0YXbC8Qi/7lXwwc410Q8ty4IgaoQ1kH3DPjzt4R7
 Dtz6KF2EF2nHdcTx6XxPBgjGzPGznmRkcpRg004xnpNSDMJwuRjwp705XShE9aVG2qcT
 RO9Tixh8TS56ad1PKGAvszxkxZ+TMG7UuxJtO60Z9/hJ7zyWItRuKI+wvRTQ0EgfIpSP
 NsbU9M6vh6szZyjdGOoBxKG3xRn3MSuK1O9MlsJDOtyBpqwR8MgOGbot3RGeK+3vbcJg
 /Jjv2Lfz3ty0Pdbw7cSk1W9QlBpP1DPidEn6+dT/ibQKzgMG1bJXohs72M0DtxJeMliS
 bUmQ==
X-Gm-Message-State: AOJu0YyPi3PB1Tz8/RcT0F0EBJt4bZ/T90Y60JfPPz4Sasm/aDgLUudQ
 biGMRCaWZkhx3NK2hB3r6h/L96ObOsId+KYFyOg=
X-Google-Smtp-Source: AGHT+IHqvgyWMTNBQ3jZO134+fVbmX/Nv6XxmsrDVpQaBhllf7BoJndpMT+7syHF3aGtxG/c7NybGw==
X-Received: by 2002:a17:907:360a:b0:9c7:dc4e:1a22 with SMTP id
 bk10-20020a170907360a00b009c7dc4e1a22mr2305798ejc.48.1698414123642; 
 Fri, 27 Oct 2023 06:42:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 mf19-20020a170906cb9300b0099ddc81903asm1222768ejb.221.2023.10.27.06.42.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Oct 2023 06:42:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/watchdog/wdt_aspeed: Remove unused 'hw/misc/aspeed_scu.h'
 header
Date: Fri, 27 Oct 2023 15:42:00 +0200
Message-ID: <20231027134200.29906-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Aspeed watchdog doesn't use anything from the System Control Unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/watchdog/wdt_aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index d267aa185c..273a49d360 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -14,7 +14,6 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
-#include "hw/misc/aspeed_scu.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/watchdog/wdt_aspeed.h"
-- 
2.41.0


