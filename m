Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B117B6445
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoV-0002Wj-3Q; Tue, 03 Oct 2023 04:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoK-0002Ll-Oa
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao3-0000Hk-45
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYyqjxmMIyCWgEK6pYjK962SrBGTEF8AIbddXhlTQ/o=;
 b=e4YTegu0ljgxaezcZnp+QKv0nybvEiHMrATFaB9EzktCqhwSbb+YhG0Pfes8sTJvnJzAnR
 dGaj9dyqUoFB3uK/naoeMq+17B+r7fl+bMQ11kPo8W0nTLtJvsg80AMkgXDGFt85ln03Tp
 PQm6M14T6HVOto+qwFYLBt3fOQ7j19g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Glpapzv_MCynKLiRb42HUw-1; Tue, 03 Oct 2023 04:31:01 -0400
X-MC-Unique: Glpapzv_MCynKLiRb42HUw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9f282713fso53926766b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321859; x=1696926659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYyqjxmMIyCWgEK6pYjK962SrBGTEF8AIbddXhlTQ/o=;
 b=u1rz4EmW7txkSIfXFvlxPWfisvRhviFBco7lcmxXLcWqiezSz5ZONiOq6oryDY55s8
 /p8PpWVFGfi9R5ABdURhegdKDrA0qM2oAdK0ciUdCwOVQ0HTbtXaRtSFC9Sl7/AzAaRV
 rCdstyy4hO09kB02yJLqo+XC7/45PDfCFaYyw/4tXKgEME4t3MVbialHyw9d2PlGr3oh
 O0JH6qvSbJgX+1Fm3JcpyIFjZiWFdQbB5b9z/CXoxnxf1vKiiDxvTXssAPySQhnVcvsm
 7CIjF1llpQ0KF5xbeOYz3uB9d3z531GlPmEiIcr5vdvE97jWhVDJvAqAdF5FyJ2vQ7Nx
 USVw==
X-Gm-Message-State: AOJu0YxCOMMAasuO27McY9oXMUnzaB78V37fCGCE6WH6AcpbKuWiVUpd
 mkOozpLhNjQdNYOUyOXrtsyekTFvKjCgaHWYZ5mER44HfjSfGYGDsfSFun7sH/GvVQr2IYqWHVe
 3cBnTXUTiQFlCvG2REGka3diYroUWcgCMpqViFEsora5jZJ6ml4Asr64VjcLE/6tjA8BfOED4dA
 g=
X-Received: by 2002:a17:906:74c4:b0:9a9:e5bb:eddc with SMTP id
 z4-20020a17090674c400b009a9e5bbeddcmr11290582ejl.16.1696321859361; 
 Tue, 03 Oct 2023 01:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvh2QzZm/LAv14NsYoYu98BBvQSKj9f5dTV/WnyaD4U1dVS02hmj51gOcxTofzNg24hfHH/w==
X-Received: by 2002:a17:906:74c4:b0:9a9:e5bb:eddc with SMTP id
 z4-20020a17090674c400b009a9e5bbeddcmr11290565ejl.16.1696321859029; 
 Tue, 03 Oct 2023 01:30:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 ss26-20020a170907039a00b009a5f1d15644sm635190ejb.119.2023.10.03.01.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 08/24] esp: use correct type for esp_dma_enable() in
 sysbus_esp_gpio_demux()
Date: Tue,  3 Oct 2023 10:30:25 +0200
Message-ID: <20231003083042.110065-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The call to esp_dma_enable() was being made with the SYSBUS_ESP type instead of
the ESP type. This meant that when GPIO 1 was being used to trigger a DMA
request from an external DMA controller, the setting of ESPState's dma_enabled
field would clobber unknown memory whilst the dma_cb callback pointer would
typically return NULL so the DMA request would never start.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230913204410.65650-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index e52188d0228..4218a6a9605 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1395,7 +1395,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
         parent_esp_reset(s, irq, level);
         break;
     case 1:
-        esp_dma_enable(opaque, irq, level);
+        esp_dma_enable(s, irq, level);
         break;
     }
 }
-- 
2.41.0


