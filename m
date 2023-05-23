Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0770D1A8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I28-0007OC-QO; Mon, 22 May 2023 22:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I20-0006gO-0O
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1y-0004dg-Hk
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ae408f4d1aso51937185ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809945; x=1687401945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEjjvd+G8XYA3XvnRGiLdyd1rlGIdrf7XY1Tz2qaqB4=;
 b=ZQzDdCRJVNnZwwmfY9fRcqPV1bKQ2vKEMJiTbDEC2a5/+A+9+ZTyLEedbg+PUVk/gv
 YPxugMvZS4mK6quJH0qNo0KKlUSbDXA0Uk6M/e6WNV2Gc/QV2CSN8JL4zHnMbAFe9QHe
 ep8GDSRQ0Ml8ElYVLwsYcusiFEK8jQcun/4jPI6PfOI1+0xc+npNz9wXREswGEBlYNrd
 rVs9LNTaEJuqbj42OZZgE3BOlu/VpMeAUVg/3z1bGkVptJgv36NdRDnMK+uDkM39K4zR
 TEnrs2zCre++7YcAH1olCxy6+wKdufn8QOf46OC3Gd2te8sSEUMPsJQyu2vZsvG/481y
 4wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809945; x=1687401945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEjjvd+G8XYA3XvnRGiLdyd1rlGIdrf7XY1Tz2qaqB4=;
 b=BidagOYSBRaCu6Ww6+CcKHFSxOv8Zh/tpxkmhCkfFfxWFXdx8u65xAP/H7rYfyR1c7
 v6XIL32mSEvNl0Cu+3gFFEQaKqeBQco2DViIJVyxfsBpHsV6DYwKdw5hYZiBRtLMDT+E
 a396tB4+JWxSpUHJctDbV2Q3TtJQuEFsNeS/aGOpQGBuZtm2pHdToCki9x2IveNIgX8E
 iLCjv8mJnAFGyh/ot0R31bMTZolmZfVFWxYNLHe+k2RDrT+zfMHmXoeXHetMIVdwYjsa
 1S7yxGGb1xrdp25LXaeoXegfXcDba5pQrVEVOKFhTo7ClLltIwDszHK71i7tR7jPvfVb
 o5pA==
X-Gm-Message-State: AC+VfDyH/baLRRCVuWe1HxwySlXd7uPhPZwH4PnyjzebUu442jkL05Ho
 YuUCbn0Nov0s61KLPnWWP9CR1ZpdRl3eWB178Cc=
X-Google-Smtp-Source: ACHHUZ5vRCfBQVjj61h8QDxoBaq+WDRPD2lS40aOHBYXDZIHosdNnAoaBzHYGmOYgxWz3+pyGe7p1w==
X-Received: by 2002:a17:902:a589:b0:1ad:dd21:2691 with SMTP id
 az9-20020a170902a58900b001addd212691mr14205141plb.10.1684809945104; 
 Mon, 22 May 2023 19:45:45 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 33/48] tests/qtest/libqos/igb: Set GPIE.Multiple_MSIX
Date: Tue, 23 May 2023 11:43:24 +0900
Message-Id: <20230523024339.50875-34-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

GPIE.Multiple_MSIX is not set by default, and needs to be set to get
interrupts from multiple MSI-X vectors.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 tests/qtest/libqos/igb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index 12fb531bf0..a603468beb 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -114,6 +114,7 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
     e1000e_macreg_write(&d->e1000e, E1000_RCTL, E1000_RCTL_EN);
 
     /* Enable all interrupts */
+    e1000e_macreg_write(&d->e1000e, E1000_GPIE,  E1000_GPIE_MSIX_MODE);
     e1000e_macreg_write(&d->e1000e, E1000_IMS,  0xFFFFFFFF);
     e1000e_macreg_write(&d->e1000e, E1000_EIMS, 0xFFFFFFFF);
 
-- 
2.40.1


