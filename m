Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB4828C3D
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:13:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZ4-00035j-S5; Tue, 09 Jan 2024 13:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYL-0002bZ-6f
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGY4-00042h-E5
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:15 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336c8ab0b20so3083139f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823798; x=1705428598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znfL4d0kUd7PQLWgd/IbU4xVCADxWCmjPBLUUJRZlJU=;
 b=F+I7cVJ8cjXpHMo0gMAWgxLSZMD1wYIjQ0Ia7w6O6jjdkaRXthqRn+zqb/NxG5uLFu
 dTLew5+4/l3qUuUpqoh1+37rkogfh6TJDgobYT5EKOtbidcU5YOIgiaNamRvajBPCStx
 BKFTMUwsx3xOoVsEZbTIcHM2yUHIjOOx7ERbhlaGDl/zjwvOmuzs8v93aXsu/Z2ufpF/
 8MpZ1sy+L1eMgEXAbQq6J8rkCg1irQP/3JpkEzjhwn1cqox0Pq5NMLH7no1rm0oANEVV
 Nzd7GgfMGDUskc7s7au2JyHj1JaExUuvJ/cmKw53r3+rXMe9TJ8yKSEZs2HeZ7KNuQTu
 JPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823798; x=1705428598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znfL4d0kUd7PQLWgd/IbU4xVCADxWCmjPBLUUJRZlJU=;
 b=aDH7w2JXWR9VTJ5II7tgfM3AJYkJIHw+rMMymmqHq3FHPZIASpi/UAf4DjFmpmZIai
 XEhWddt/RpJ10oMNuGk3y5cIR+O7pTCUBm7IJy8aRWORlxwdDhvyZfVceeKzt0x+JU4Y
 eXN0EqTYaktDm63Fp3zOUTDaRXDi8t4XkGWe+LQp79qnu+JhYMOcl7LiHeVttmDFz3/5
 3FU007Hm4M4MMtoimiGujBjr/awkF1pcF09nZylDWg8kYNK3nxSROSdSarYpFmEnzVuo
 vH6ufdSOWjm+O3uibY5uFYZT5spBa8+j+wvtlr+ss52PFw9u/GpJU4fRS6H6NppJM7nN
 mOKg==
X-Gm-Message-State: AOJu0YyO71pPcIzLU/pXIExWTZbud4TkTOTKGJLkPRS0s6p9KXLSXrdh
 7RIbD4uXPnjiUK8OJACw9sfWF8XUzZ3RcEy/kkIR30Qsmy2aDQ==
X-Google-Smtp-Source: AGHT+IHadGAKCd5gSButumHgjloExnl9xj8kKKS1xRfyJwZ1NXHqvCwQv0MINefNrE/fapdxrbYdDA==
X-Received: by 2002:a05:6000:235:b0:333:2f1e:cbc4 with SMTP id
 l21-20020a056000023500b003332f1ecbc4mr852249wrz.13.1704823798697; 
 Tue, 09 Jan 2024 10:09:58 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 r14-20020a5d494e000000b003364a0e6983sm2975178wrs.62.2024.01.09.10.09.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:09:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/14] hw/arm/armv7m: Move code setting 'start-powered-off'
 property around
Date: Tue,  9 Jan 2024 19:09:19 +0100
Message-ID: <20240109180930.90793-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reorganize a bit by first setting properties which are not
dependent of CPU features (and can not fail).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8900730e53..b752049add 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -308,6 +308,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
+    qdev_prop_set_bit(cpudev, "start-powered-off", s->start_powered_off);
     if (object_property_find(OBJECT(s->cpu), "idau")) {
         object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
@@ -334,7 +335,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    qdev_prop_set_bit(DEVICE(s->cpu), "start-powered-off", s->start_powered_off);
 
     /*
      * Real M-profile hardware can be configured with a different number of
-- 
2.41.0


