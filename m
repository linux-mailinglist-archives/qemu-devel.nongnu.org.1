Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844807B640D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnal6-0005UB-6K; Tue, 03 Oct 2023 04:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnal3-0005TT-NS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnako-0007yq-Vd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:57 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3226b8de467so673200f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696321660; x=1696926460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRhqgq+/HO+RE2gqPE65MUPAQhpDQoUdG/Y8TtFPzOY=;
 b=PYcbIXDiHkLVLsolrjncON52MbPB2FzSXqAmInNeuUnn16Cq1iUBY639vKC/kswt39
 r7D6PzLeZBbSSoDY4Gn1iN50YcBrvPmGfglAq5twOi8kpbJpO2BGf8Y2AmmftabzPJhY
 sEvfNVBQmELSr3BvOcYiSObowHqkj+U5KLPxJUcuY7ehVe92ASdlkPITL2w75t8I3eZP
 ZATOXTSGz2ihth7LKEpJG+vyMkHU+kjL6QMSD+HDxEb1tGadnsY5iEO2I60cp7ttbNtw
 NO3vccXDFZa2OQgBB7O/5C7EJl4woYkMHv/GP9quZhsLnzppimm435/L1Grt04nTr4Yt
 6INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321660; x=1696926460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRhqgq+/HO+RE2gqPE65MUPAQhpDQoUdG/Y8TtFPzOY=;
 b=RP8ZkviI8ciHFYRh2HHTSfShdch+62aCn2rKepOIOGCbc+AdSP228TRvZM+2AhKEP1
 IGGV2FBos6Mv0CD3S5kgTYK2t9b0DVEobi6KUWErBIG0sUSV9PQ2C97komeee/ZnRkjN
 IMeE2Vchs+K8KSB5J3sLQn6cHUVbxlf4MsGB0wvnEYe5pvtQY4fpJcmimoDB6P0ndk1n
 qcP4/xlTJVJdqxaOHthx+5dl3tpIUtIbKCGd4YCvrdHAydmUUV2+VajzBdqml9cFNW3A
 s5U8ZbxJBus5vzJiFQA8txcEu/gka9KeB6nQyVFd98Rw52Ft/dOxVOiI83U/cY1Jpo6E
 IqGw==
X-Gm-Message-State: AOJu0Yxp0QhwuFDMroDsM3lhWvWGUr8ZWqoJjTRzvrl5H5H0xJciOh/P
 UHtG3iyFGZX/tCQqU1H0Zw0gi3bAB+C9r5vA20hJfg==
X-Google-Smtp-Source: AGHT+IGeawFXlCzlrqXl3i276PzO3XBlgMoopqAhl7sP+5lb+A6miKNxcm0+9LQ3Kpsuwq5cjAUlIQ==
X-Received: by 2002:a5d:6447:0:b0:324:8239:2872 with SMTP id
 d7-20020a5d6447000000b0032482392872mr10993136wrw.71.1696321659445; 
 Tue, 03 Oct 2023 01:27:39 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b00326f5d0ce0asm997037wrx.21.2023.10.03.01.27.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 01:27:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] hw/intc/apic: Use ERRP_GUARD() in apic_common_realize()
Date: Tue,  3 Oct 2023 10:27:24 +0200
Message-ID: <20231003082728.83496-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003082728.83496-1-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

APICCommonClass::realize() is a DeviceRealize() handler which
take an Error** parameter and can fail. Do not proceed further
on failure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 68ad30e2f5..bccb4241c2 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -257,6 +257,7 @@ static const VMStateDescription vmstate_apic_common;
 
 static void apic_common_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info;
     static DeviceState *vapic;
@@ -267,6 +268,9 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
 
     info = APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     /* Note: We need at least 1M to map the VAPIC option ROM */
     if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
-- 
2.41.0


