Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEB7821F33
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:06:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhGx-0006QC-6R; Tue, 02 Jan 2024 11:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGi-0006JI-07
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGg-0002eD-Ee
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:27 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d8909a6feso15060345e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704211524; x=1704816324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BwjC+ujFoVcnh1DxjxgU1C6te3MWe6aqORUUnNaIGM=;
 b=PMU2ZMTZF9/le816mASMlytGfTgze2mTIUiyDNIE2b4tFg1eEgGv3Lx3nTACUsoeAB
 WG8/c6M4jmL85IezF2nCXfonD7znmIqZ4PPkn7EtOqV+6VNM4PYRAhacGl4qUb/eQhCy
 YPDS7Go0HG0mc1EaXN/9JmIpXrRecZ8r8vAON9HB1LYZZTDf28znJuzra84XGoenWQhy
 m9nGm+UfrLXujOxUCypLsOq9BFTeEIp1Ca94D4TZuznHBG7zmb+f2wFk70dvAMR+XmV1
 uj/OnnyiwhBqRRnLsz4eNeuL+cOU3ViNHq+BfbzTjN3CTSeBcfQufBl91x9pX2e3rPmM
 rjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704211524; x=1704816324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BwjC+ujFoVcnh1DxjxgU1C6te3MWe6aqORUUnNaIGM=;
 b=K02uNwmeVTrga6rhU9Zoe7kv9r+EepyKJpCblmxgA5ovv2hOGicfJL8xfnGiZUA3U4
 6dGSlOw3s0I9EnwyaQg5ywMOzC5x4cPhT1/SKdfVilB3p9T25zD6IOM0gzuTuG4sWAfQ
 Bt1gZAppyZrCb5Mclf8U2xuN8T77ESEkRVRMP/aUCtkxhkQ50S3cD9NsDHDgJCnsW7Ze
 KCoHenx6+If+ojGyfxSHSRvO8ZFgyCOKZe8q2LBQ/zHcxWLmKFEuqrYooumfaCj1ngTC
 iqjgmLBgwuoLqpKluaT5XRe5D+GbyB2SPs29R3f58vco/4RmtxyG/lwN05P1/SnX7lrj
 ascA==
X-Gm-Message-State: AOJu0Yy4dh6gJoSfIuN1XY4vYg+GE6uz+6o7xGEawOu+Qm8dHfkp0MRg
 2GLA0gdAOyeSrNgLrNfy2yQv9mUWvTb+RlEahFuapEQKKCw=
X-Google-Smtp-Source: AGHT+IEr2Xaz+dnCGfu3Wh34558swFw/Oy2LhA/afKeYUi5+1wP3jjMtyLhrgd0jbz6osbxKK7xh4g==
X-Received: by 2002:a05:600c:a44:b0:40d:7822:bf54 with SMTP id
 c4-20020a05600c0a4400b0040d7822bf54mr2417553wmq.132.1704211524670; 
 Tue, 02 Jan 2024 08:05:24 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b0040d5f466deesm22836750wmo.38.2024.01.02.08.05.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 08:05:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 4/5] hw/arm/armv7m: Error if trying to set unavailable
 ARMCPU::vfp property
Date: Tue,  2 Jan 2024 17:04:53 +0100
Message-ID: <20240102160455.68612-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102160455.68612-1-philmd@linaro.org>
References: <20240102160455.68612-1-philmd@linaro.org>
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

Do not ignore impossible configuration requested by the user.
For example, when trying to enable VFP on a Cortex-M33 we now get:

  qemu-system-arm: 'cortex-m33-arm-cpu' does not support VFP

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3610f6f4a1..12cdad09f9 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -328,6 +328,9 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
             return;
         }
+    } else if (s->vfp == OPTIONAL_BOOL_TRUE) {
+        error_setg(errp, "'%s' does not support VFP", s->cpu_type);
+        return;
     }
     if (object_property_find(OBJECT(s->cpu), "dsp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
-- 
2.41.0


