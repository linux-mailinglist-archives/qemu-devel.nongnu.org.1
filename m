Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 700207B6455
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:36:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnapM-0004u0-CZ; Tue, 03 Oct 2023 04:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoK-0002Lk-Dd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoF-0000JS-GO
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CORtctayitClxawrdYJ5GiASnRAV4m5SygYmlM2tjSY=;
 b=iOnxlFgUfy6C7qngHuvDMWe3EqHHey+/Fzyv1+YOTxY1w9jDT328RE1FFHgRWEkfO8sGwC
 HjNKmlMI1SZ2gUE4///inpqTaVQczM/NKiMVsaatAYUi9zbgxizNB3/OVHmDzNma84a5Un
 Wb3SsonCmyqvcopJ1k24VtvsfDxbn3U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-p3AMWHaSPuinCsSjy2dsJA-1; Tue, 03 Oct 2023 04:31:02 -0400
X-MC-Unique: p3AMWHaSPuinCsSjy2dsJA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so52522566b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321861; x=1696926661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CORtctayitClxawrdYJ5GiASnRAV4m5SygYmlM2tjSY=;
 b=P/gQLjPc+QDQT0LSbDtUHSHfPgC/mY06GQvrrmzn+gF0a+GDPi/QNSqGWdL3z4FyQj
 p4vsnyxpW1mmyTf8/8RY5x4FpscNnfwoDnelRm+Q0s3IdS4lIHeejxjRYG5rbSHuMJMO
 +7vTRWj5SdHF/YGvpnoPfOxrwWO5d5995Ydef8bu8eVSYbzLQwitHqqkpsM2zxng4oC1
 L3dFe+ncivWAs4a9UjhG+Ig2K5wVJNjMhbA5pV0DnpEL7R27tqT8IDmp2KhBdZhpl7hQ
 eN+CaAIlya5Q66cWEhrB1NtYicD22+h7RX6WG9eyNOwMIK8Nd1NoY8W2OCFP5Ro1je0D
 zf5w==
X-Gm-Message-State: AOJu0YwWcRyjSlzI5x3Eyg/JA0z7AZo112RHivfaHw1oITo7CiA7hJsI
 dAyVBMuFM3kqq3aLwCH9kRMh7B3DyarJC+PftMjKTORQfjXrMaHQy+4QVVQMxjvMbZAxoV9Xy1U
 lGE3pSI8rHFFtuiShJj12bTuhD8x81y9H7/w82ljjFGyVNl3HhV7epYEJwVPhgRqDyQou3LW1QJ
 4=
X-Received: by 2002:a17:906:8b:b0:9a5:846d:d823 with SMTP id
 11-20020a170906008b00b009a5846dd823mr14512996ejc.45.1696321861191; 
 Tue, 03 Oct 2023 01:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhrgSdRpmOcxmV7M01tAK0arkf022edU22M9sfuYEAZ318glorHMbnQoNVLrTHPYm9YugdkA==
X-Received: by 2002:a17:906:8b:b0:9a5:846d:d823 with SMTP id
 11-20020a170906008b00b009a5846dd823mr14512978ejc.45.1696321860880; 
 Tue, 03 Oct 2023 01:31:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 v27-20020a170906339b00b0099cb1a2cab0sm657858eja.28.2023.10.03.01.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 09/24] esp: restrict non-DMA transfer length to that of
 available data
Date: Tue,  3 Oct 2023 10:30:26 +0200
Message-ID: <20231003083042.110065-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the case where a SCSI layer transfer is incorrectly terminated, it is
possible for a TI command to cause a SCSI buffer overflow due to the
expected transfer data length being less than the available data in the
FIFO. When this occurs the unsigned async_len variable underflows and
becomes a large offset which writes past the end of the allocated SCSI
buffer.

Restrict the non-DMA transfer length to be the smallest of the expected
transfer length and the available FIFO data to ensure that it is no longer
possible for the SCSI buffer overflow to occur.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1810
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230913204410.65650-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4218a6a9605..9b11d8c5738 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -759,7 +759,8 @@ static void esp_do_nodma(ESPState *s)
     }
 
     if (to_device) {
-        len = MIN(fifo8_num_used(&s->fifo), ESP_FIFO_SZ);
+        len = MIN(s->async_len, ESP_FIFO_SZ);
+        len = MIN(len, fifo8_num_used(&s->fifo));
         esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
         s->async_buf += len;
         s->async_len -= len;
-- 
2.41.0


