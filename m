Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8AA7D2248
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUjl-0001Nb-Pr; Sun, 22 Oct 2023 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjD-0000yT-LA
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjC-0000xV-6b
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzMBUbudylul0FJkLWku7UAionEGDwih3IlnCHi1rwI=;
 b=OQd8XIikK/HlJn6DFBS8Xqf/TxBqA6xFK2zaPhmFy6RW4/GFgu/82HmOoHV24O4I2FRxOe
 TL16csGEqtHW9mk2KE78U0bU9YlnuJUGH3RDJtCErN36I7E5ZUczrJ5yfJMJqoKu3nYLsd
 Xn/BLwEebRTTIjmpp0ugBlif33tIW88=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-3bPquIvtPWK9av6eZWPdOw-1; Sun, 22 Oct 2023 05:26:31 -0400
X-MC-Unique: 3bPquIvtPWK9av6eZWPdOw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31fd48da316so1013441f8f.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966790; x=1698571590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzMBUbudylul0FJkLWku7UAionEGDwih3IlnCHi1rwI=;
 b=H41Rz6nwKCrc960y6ITi5/CUNs5IM0vCgHlRMnUFyi0TA25V0Kwn6luTpW5ffgjaPc
 Rs6KnOuiU4MzqpG94axeSscNO0u7NFUj6dKbWiU08/Bg/SMpcDKib4iE1t2BCluEszOc
 B34Wk0levNjd4YmyboZ9iyF9+ePibufcwa5BBR2MZKR6QLD76qlpkrcoWLSyAdmRF0O5
 rddQAuNrw6MeI0IPZ7r5igquvz8DpO/p8pLiVSjOJqJuJfQ6g8rxCqKWiIwpno6cKuX2
 T+Ij9X8RAimvrRe2ck6Xg7+pV1sDHTFXO9EQ+SrsMUV5fhKTeddJKyZHn+OqCMo9ZW3p
 iUTA==
X-Gm-Message-State: AOJu0YwbJqJmvi6cgoJwZSruhuXxeTbn8FrxasVMGW1mBjHVivBwAfpa
 G9Clg0XGOs7hBid+2x6WE+1IMn09QGyp0v3DQjtk/q/p/Fdbc4LTKyNOJH0De3TE31fQxYrQ7AH
 /U7rLQ+qMjckwm8VoIUvzkCCOBVK62YqkAhbs/Ew6J7IKg6FfhdUANB8WHezI5nSZZG56
X-Received: by 2002:a5d:6b12:0:b0:31f:c1b5:d4c1 with SMTP id
 v18-20020a5d6b12000000b0031fc1b5d4c1mr4029562wrw.35.1697966790243; 
 Sun, 22 Oct 2023 02:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZnqf4mId1AUoCbk5tpcz8+gyU7wE57j9jYl6Nt2Puxou/5g3suYEuMIgS/1QvYFF4hQ9S+w==
X-Received: by 2002:a5d:6b12:0:b0:31f:c1b5:d4c1 with SMTP id
 v18-20020a5d6b12000000b0031fc1b5d4c1mr4029550wrw.35.1697966789946; 
 Sun, 22 Oct 2023 02:26:29 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 p17-20020a5d68d1000000b0032d687fd9d0sm5290422wrw.19.2023.10.22.02.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:29 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:26:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v3 56/62] hw/i386/cxl: ensure maxram is greater than ram size
 for calculating cxl range
Message-ID: <4076bc86a3afd626338f2e3d018f6b884a972143.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Ani Sinha <anisinha@redhat.com>

pc_get_device_memory_range() finds the device memory size by calculating the
difference between maxram and ram sizes. This calculation makes sense only when
maxram is greater than the ram size. Make sure we check for that before calling
pc_get_device_memory_range().

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20231011105335.42296-1-anisinha@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6293f57a0c..dbaefa7617 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -781,10 +781,12 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
 static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
     hwaddr cxl_base;
     ram_addr_t size;
 
-    if (pcmc->has_reserved_memory) {
+    if (pcmc->has_reserved_memory &&
+        (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &cxl_base, &size);
         cxl_base += size;
     } else {
-- 
MST


