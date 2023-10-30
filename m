Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C317DBBF7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:41:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTRL-0001PY-U7; Mon, 30 Oct 2023 10:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRK-0001PH-3I
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRC-0001nc-3g
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso35863205e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676815; x=1699281615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7ToXfUjeHh4GxTtDabuQxd+6LNHtLDODSscY/4+OEc=;
 b=m94c3oL4/LntiFxMjuRMRaKE0tv/HEIqFav9i8c8rEzauMy5d8tsoC3Gl8MdBTBy6J
 1Fcyv+/5UuL3E1g027oIuUW4vK4i7i4J68bYk3JHuhSzhLQX0BA7OrkYybGbEis07rB6
 cVckVawLIa+TOMLhI9EiuNF/5s1TwqmBkUnbTuBjlH/uCvuEl8HBStcT6HKYqH0LqAt6
 W76TvXzUip4PvsSFoQkhqz4I+e8n2UihDP8/Jr7TNeG8ij19aT+I4xp9bFS76i/MAxBu
 7NH5fFQmpTKI/EgTJKvo3UxtcLPMdfz+TKMyGxL6YixUThNceNbhWa79Kh8FpWg4vfm3
 Z8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676815; x=1699281615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7ToXfUjeHh4GxTtDabuQxd+6LNHtLDODSscY/4+OEc=;
 b=AMZT6VR/a0X/UejeANTHWKHptS4V+ZJKo0Rxwhb1sqMLDkH7lDjsUwyKHAKdBLVt+J
 fV6taoYyPQLCn/PfFp/Ulx6nIPf5DgwzAIm8rkDBJw3MWTIEGHU9EZ81twrm1tom8VSD
 ar6zP8AG86Q1OYRmQbq2K9WFbOzcLTTOrWLEN3UyAqYYcFCKq1WmugiHiAvJI8N3DgyL
 7dIahskcpYCD4E6Lz5pRGTKwwyJQ6SJ04ngwes4RYv7aMhm81hpJ9g88D/deLUaOM7K/
 KRJgVElMU3McEN/cskgaAGCyKw+gaWLrl6HnItydfvLzFdTvrWWDkksky9zscffkLXjh
 bwxw==
X-Gm-Message-State: AOJu0YydtPoHzC5/gDUs0u7L7OFXJHNuTg0bAnPDfuu26ltw5PiZ86OE
 oZdRfHu+APX0YtSKWxqeskB8ZN2lH2yjo3p9/To=
X-Google-Smtp-Source: AGHT+IEGTxn+ensEM5LebpXAKGauCyjliAphk7/jKhc8hoeQI2t3NWapb2OBWjZXSXdLqxGDCfjKCQ==
X-Received: by 2002:a05:600c:3ba5:b0:408:cd96:7179 with SMTP id
 n37-20020a05600c3ba500b00408cd967179mr8734464wms.9.1698676815397; 
 Mon, 30 Oct 2023 07:40:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a05600c3ba900b004060f0a0fdbsm13029498wms.41.2023.10.30.07.40.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 07:40:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/ppc/e500: Declare CPU QOM types using DEFINE_TYPES()
 macro
Date: Mon, 30 Oct 2023 15:39:53 +0100
Message-ID: <20231030143957.82988-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030143957.82988-1-philmd@linaro.org>
References: <20231030143957.82988-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I'm going to do that for each file I modify, so eventually
we'll get all converted.
---
 hw/ppc/ppce500_spin.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index bbce63e8a4..e3608d8c16 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -195,17 +195,14 @@ static void ppce500_spin_class_init(ObjectClass *klass, void *data)
     dc->reset = spin_reset;
 }
 
-static const TypeInfo ppce500_spin_info = {
-    .name          = TYPE_E500_SPIN,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SpinState),
-    .instance_init = ppce500_spin_initfn,
-    .class_init    = ppce500_spin_class_init,
+static const TypeInfo ppce500_spin_types[] = {
+    {
+        .name           = TYPE_E500_SPIN,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(SpinState),
+        .instance_init  = ppce500_spin_initfn,
+        .class_init     = ppce500_spin_class_init,
+    },
 };
 
-static void ppce500_spin_register_types(void)
-{
-    type_register_static(&ppce500_spin_info);
-}
-
-type_init(ppce500_spin_register_types)
+DEFINE_TYPES(ppce500_spin_types)
-- 
2.41.0


