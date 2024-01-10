Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA782A1A0
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:56:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNefR-0002hh-Jl; Wed, 10 Jan 2024 14:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNefO-0002Xh-Bf
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:55:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNefL-0002k5-Ec
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:55:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5bso40927795e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916504; x=1705521304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdLxkKJBM9/8cO5ervTCmHlXNSnSwQGVSVS04z23rsg=;
 b=EKj+67dzGGcJEktekhv03Zfd9BBbQzSSHDeFy/cruLN3+OBpYmqK3djCAi3MVre7Mb
 8axhWD1eU/DaLnIrHveid3oimut5Q4bn+tP6LHutXZiy4LkVr3FENhEII1iH0Y6gFckl
 AMuhm6GqqSbUAe/JRyFcaXFhJDUCZ/iCsWoopt87ixMd/ewGndMkLIpWt4QTxAK7/Gj7
 YNOG9jJZWnya07JrrSl1OexPOHPu1DzCFUexEOPG6tZdlz1M4GeN1qahtinITcwFRF9e
 CJpDefS4feWllaF0hww//we1AkVyujGSyR61DgswvoD67b1Hnu8aP3k6WKkK1WABGMly
 QrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916504; x=1705521304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdLxkKJBM9/8cO5ervTCmHlXNSnSwQGVSVS04z23rsg=;
 b=nK8Bmr2YjfoW645q63R+tCb4+lyh47v96ZqZZ0DyKhPwOAJZXC37nN2qt63Ft13IHJ
 +ETKKzpEzyryYTMZF/7m4JsbfBK4B+6EvTiJEU+LgYzkGCTJRwSWLj2z1nvxKsjyzH72
 15K/HYnFWIsKSngJaqD2UNacWo88z29AxTJrx+UFAwuOd0EgPnTEsgcpQw46NdfwTE0W
 VPe0Lt2b1l946EP2NYIsUOCi/6ldscLzIpiSX3dFY/unGu1gpSZH9VMuV8O6ZKRuGWoF
 gP9CJH1iMIbDm2Qgq9Dh7FjZY4OTFShoXQxc1aBG9yESuc3NJ6rLm2WMz2IpyIUB5GrL
 +M7w==
X-Gm-Message-State: AOJu0Ywy++AF9OB2pRh07OWJcAu57W4T0F68jymvlfqbsP9M6HNQkIGy
 Hi+AR4g1K3JoUM0wzd/KbZIh7ljd3+J5kK1m5n1m8rQGIyg=
X-Google-Smtp-Source: AGHT+IFBq3SIKl//Nr9ItYDR3BjCPPqSfdupmfgRICMthFR5bjiXIpR3ELMN9whuDN7HLjO6jOiNlw==
X-Received: by 2002:a05:600c:4f85:b0:40d:4e28:43e8 with SMTP id
 n5-20020a05600c4f8500b0040d4e2843e8mr783060wmq.167.1704916503990; 
 Wed, 10 Jan 2024 11:55:03 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 w4-20020adfec44000000b0033662fb321esm5583482wrn.33.2024.01.10.11.55.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:55:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/14] hw/arm: Prefer arm_feature(AARCH64) over
 object_property_find(aarch64)
Date: Wed, 10 Jan 2024 20:53:27 +0100
Message-ID: <20240110195329.3995-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
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

The "aarch64" property is added to ARMCPU when the
ARM_FEATURE_AARCH64 feature is available. Rather than
checking whether the QOM property is present, directly
check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 49ed5309ff..a43e87874c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2140,7 +2140,7 @@ static void machvirt_init(MachineState *machine)
         numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
                           &error_fatal);
 
-        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
+        aarch64 &= arm_feature(cpu_env(cs), ARM_FEATURE_AARCH64);
 
         if (!vms->secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
-- 
2.41.0


