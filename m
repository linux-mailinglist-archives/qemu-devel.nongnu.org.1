Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98FB7CE1FC
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xT-000299-7s; Wed, 18 Oct 2023 11:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xK-00026q-Sb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xJ-0007lr-Ah
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzMBUbudylul0FJkLWku7UAionEGDwih3IlnCHi1rwI=;
 b=Nm2gOCTnsPeO2PVsj6MyftMyay4Gm7cWOEdNAYCDf8Hur7OeNGDtFPgu2nt+oK4L1xrEIW
 e9G8izHdDmvXFyaxl1VAuDMWSMg6Xjh1UyouWrgLD6g37RBhZUrEIq50yIxJKMN1PW0me4
 /KQg7lwy6qOwhaOBL5LOMd4PVohMXdo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-ZEes34kBOMuv4pUri_msuw-1; Wed, 18 Oct 2023 11:59:26 -0400
X-MC-Unique: ZEes34kBOMuv4pUri_msuw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so1651161f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644765; x=1698249565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzMBUbudylul0FJkLWku7UAionEGDwih3IlnCHi1rwI=;
 b=fhTLUzomrPCrQUKJmdN3/AdlQy4WvGsUSEs6+5+w7dh9Lc1uEpnfcBOFoMeQKxId51
 1/HSvo9LPHKeUzADeTILHpsN3Lxe4bqaEFKjvVuF6nZi5oX9pu5RjXutM0IZM6cnk7e0
 T+uRTvejpBR8wJeOIvGrllMCUAjWeKpU/XuDjjaGEhAXD6fOkq8TFht4SEmFJaGwXgE+
 p5sNw3FgbtN3Pa/KB3ROUrOhleWo8ow/8zvfam6W6bV2nwBjEoxGy1s0uGxnLOMyv8hF
 55KViEKUU2GK5kJqNokR42kHhO+QPcDCPjmupxi5+zCGaPHIZuh6Qo2wNQqRAdKFiHNZ
 zdUw==
X-Gm-Message-State: AOJu0YwNmL866IYeqBwvh+lXmk/Cu/QF+pPDx7eTU8CrP4RzRQKeeBMx
 m0/daNMyJY7f00iFk3fa8rLEioelo1AOvGHQylqtklTzRkxOF7T/1HZnCBg+zSHWsxx3zSrepyq
 SvzbCNzNogWUkgZYicsNrgFUrmMKwLO9DltHkRIJQLlfd0WjZON1y3OeO+1O7DIiV9qTnWNU=
X-Received: by 2002:adf:b1d1:0:b0:32d:a366:7073 with SMTP id
 r17-20020adfb1d1000000b0032da3667073mr5165683wra.14.1697644765066; 
 Wed, 18 Oct 2023 08:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEydfYwc5YqRRwMcFbOjylKnkyezyIBzEC5juEGbVbGMo9X3+YUd2G49AbWr3FO3Edd3bnr7w==
X-Received: by 2002:adf:b1d1:0:b0:32d:a366:7073 with SMTP id
 r17-20020adfb1d1000000b0032da3667073mr5165665wra.14.1697644764811; 
 Wed, 18 Oct 2023 08:59:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 t22-20020a05600c41d600b004083996dad8sm1971001wmh.18.2023.10.18.08.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:24 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 77/83] hw/i386/cxl: ensure maxram is greater than ram size for
 calculating cxl range
Message-ID: <5c725185bd332203c070440b230450cbefa80c69.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


