Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786457D0DFD
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtn9o-0006Mp-Qk; Fri, 20 Oct 2023 06:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9l-0006M9-EK
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9j-00057F-UD
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so5266155e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697799302; x=1698404102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jj0YHZoSu3dkacuU/y9YufW6rMNDzfwPVB4J+L/F+h4=;
 b=QtUtQN/GvfvoatgimD+m1jB2SjMBnNrqAgyJ1P85qZdxQxBpySUOUjx8gvZZDmD704
 5hKvLs1hnDvMojhg4MOKWzqsIiErWRpL/TJKkhjLmz+xqPbPwxA+3miBk0Dz3Q25/fYP
 9aB6kKs4AjM0f7D12R8A7gy90IGsRfg1MalFXaIHN2OzjTMLnjfr7P/8RwXrfov+iQoA
 0nKNdDALudV1WGHmF+np+TVvsL9suaHsu9IxQzYZWAqH5IPPA+kS1vuwyjDB8wm1Hvpk
 20M9VM4bnAsjCj0e3C91aoH53EoyVNzeWwXb2PExrAuqzfem5fexYuj8X0Zc4WqGK7d4
 pHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697799302; x=1698404102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jj0YHZoSu3dkacuU/y9YufW6rMNDzfwPVB4J+L/F+h4=;
 b=MJNI6ZmgVgQPI+U/HFC+Ytpri8blvkLydd3VNrWdbLpwYpFji1E7IxEkV0omXFm8is
 F+jEJxqyp5t/Ed2G1+BVthKcSpyoJ2x6th1N7DVOxPoZLF9DE97aMsBDQKfPdvyJbkuw
 5zSRXPOq4qvyTWlPwtXgkpSxK3yh5ilE1H8aKfa6xayw/xqlh9iV2v7KfH0D0/r6wCyS
 ZfsMUFVOV74qyHZu1zRgiHMfEPnrrdRHZHsYZIcQJ0kDkZXpmTN5x8XcCo/yTtSI9dC4
 xwBnGdWBWWTaFM78fAxDKIER9dPuq/wOL0cU4Uwn2UNbsAva6NCc0MwsNz5CtAnFa+eb
 r4kw==
X-Gm-Message-State: AOJu0YxPSyHkjueRvU1XN8vupQ+TqvaZwhgxrBJdbwFrDmO+mo9kHRPa
 voYKMZ57kqTaQdnzXeKhlp9dvQJxxgXfx72ZD30=
X-Google-Smtp-Source: AGHT+IFEn5/UONrqx8dbjo3XDMG1vy/IZeNOvP3NetoeVi0i9ViNOTHRCL5fGoOI9ujxO/qdBy9wYQ==
X-Received: by 2002:a05:600c:45cb:b0:406:5359:769f with SMTP id
 s11-20020a05600c45cb00b004065359769fmr1202132wmo.0.1697799301988; 
 Fri, 20 Oct 2023 03:55:01 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 l3-20020a5d5603000000b0032ddf2804ccsm1415684wrv.83.2023.10.20.03.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 03:55:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 2/5] hw/i386/pc: Propagate error if HPET device creation
 failed
Date: Fri, 20 Oct 2023 12:54:43 +0200
Message-ID: <20231020105447.43482-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020105447.43482-1-philmd@linaro.org>
References: <20231020105447.43482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c0477f0141..c58a15182e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1235,7 +1235,9 @@ bool pc_basic_device_init(struct PCMachineState *pcms,
         if (!compat) {
             qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
         }
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);
+        if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), errp)) {
+            return false;
+        }
         sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
 
         for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-- 
2.41.0


