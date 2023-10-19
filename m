Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D817D7D03B7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRo-0000sQ-Bj; Thu, 19 Oct 2023 17:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRm-0000mO-6p
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRk-0005c1-0I
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so991425e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750442; x=1698355242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+goD7LWLLFlekg91oCfVK0c1MbYgJUFGIQyLFSXN/qg=;
 b=xqWe5ihyuk0+TNFL5KnXF2wwqxS3v0AJvdzp3rw95bQk3FssjmYF9m3nz6rAJBI6bv
 PnOa13ojUMHUtUMfOHm0Qhp6KbuhMPW+nAsl3E1vvEuThYa0ir2z4DpVOAm52W7M/VIm
 5vre2mF1ReaTR4Ns9yZWcFNIuQilw48YdO2reuh3MhHFAK02TgCzxGQ439mdugqmSNlY
 anIspcu7Ra9HBES2fWlK+uaP+x+sF9fTtVs/kq3zRx6z9vQdodSQpJEvJFfbKuvBULO/
 HYa/oIz2drtoHaXPYlsSETyaCS0vDx0dnnvCQFG5JJ0Vw5tulTEel/rSnETs+WcPwL5h
 Phyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750442; x=1698355242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+goD7LWLLFlekg91oCfVK0c1MbYgJUFGIQyLFSXN/qg=;
 b=Ji8aAuX7i1U4c4X0hv2vxCYNg8PAUVerk9YDMhgBcc90iAxDbld7JwOmWIF/19P9hb
 73iLPnN3wv4t1rX3ivBaProykm6icwUVXz7glFShP/KAQBPgPtoRAiH5hXc1JVrOn0OP
 6hjpNZt4lg/+pHxvOgyevXRrm/z9MY7YvChfBEH3BqAGjYepIpdoi0/HYr6m63jaFEkv
 oqTExuDYbMA+XjHjRpQPYi6z3K3qlzWzt7fIzM2X/xisUX4JhmJek0dWsUrbb5qddSuw
 BtsLx2Vy3dxrZaaVF7F3AH/kZahGKgPNfrDtcmPMhvq3MAiTNDXpo9cGWtSQFiQo9uKQ
 2Q0w==
X-Gm-Message-State: AOJu0YwHnyylX7nS5y1AoSrLZfwnOpMmlSAi4aSYyZ0CKXbsK9yWwsrg
 7lHQaJSTmwc4qs1xlx0SjPx7fGOis+/jB6UelKpaIQ==
X-Google-Smtp-Source: AGHT+IFatdTNTq0UHD5Q5955XeoWvrhhnFKOBSwcpYmcAdt9HraU+f+/vbYvqrZVHi5IZvG2YZIvgw==
X-Received: by 2002:a05:600c:35ca:b0:405:3955:5872 with SMTP id
 r10-20020a05600c35ca00b0040539555872mr15966wmq.18.1697750442279; 
 Thu, 19 Oct 2023 14:20:42 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 fm12-20020a05600c0c0c00b004030e8ff964sm5346723wmb.34.2023.10.19.14.20.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/46] hw/intc/apic: Use ERRP_GUARD() in apic_common_realize()
Date: Thu, 19 Oct 2023 23:17:47 +0200
Message-ID: <20231019211814.30576-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

APICCommonClass::realize() is a DeviceRealize() handler which
take an Error** parameter and can fail. Do not proceed further
on failure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20231003082728.83496-2-philmd@linaro.org>
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


