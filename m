Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBF76F5AA
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghT-0004Sx-1o; Thu, 03 Aug 2023 18:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghR-0004Sf-47
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghP-0000XQ-Kr
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVuqOt0marpKSqE9sEGY+DQ7kMdO14FEtpwntaCFVNY=;
 b=X4X1/FIcs7HoPVyVrG6joIffIpLabNHXVVConN03UdbigfgaZVYIbZbZuse1YcsgpIbuR/
 rv37N44mhJBXOix9WGLo55e6k1+YHSk3gn6zW6Dx4wUrGmALWE5Si+EnjirHSSPIzRx3HV
 RpspeS/bJamyGIq/vxGetF0M9+12TtA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-z4MnU7vkMWS9O-8xq5mnhg-1; Thu, 03 Aug 2023 18:21:37 -0400
X-MC-Unique: z4MnU7vkMWS9O-8xq5mnhg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51d8823eb01so864173a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101296; x=1691706096;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVuqOt0marpKSqE9sEGY+DQ7kMdO14FEtpwntaCFVNY=;
 b=WIKNa5H3QNiarJZNmSHYS54fvYmFC72egfPP+dFBxzuBB7KEiZ4+dRKRHibl9N4bDn
 kj0RBA2jHrW+JC09j7Da8+v/SesQYAHm8JF2qG3GVpwOAXTWIlESdXJ0av0A6AoVCM+5
 rYQ8ITaqjcwxGVT3jnt2oeve3LGMjDG9cFYESFXzlaDZ9HDy9BxenU8T+yyBYSmZbRO8
 cuJ4MwAVNvL2oJezpfkHQlkf7MzO2usOOCcdS960P9gjyBpvkj9uxZss/YuVmmP57L6F
 lwrsn5nZj3bMIzlyhDk3RvDogGgX8KgprW0Upx4Lsy711jUFIph9UwaSRGlvpLGYoxt/
 rYFg==
X-Gm-Message-State: AOJu0YzH+APMtVdtKuvKwm4pu5n6Kl7ud386oK+yzrHu+I9/R8iTWigy
 Z/f9oHLJ46l/iMcR65WkSM1AKnSIn3ovsfuDQK4iWzwkVEhFB6cSQLKl0ftOS5nABvadaWCl906
 YdayoDBbOB5rlw5aHDh0t8h1wBluK5uzko0UzK9nTh8kFtixLNvGpAi07EnDJTqruaEHe
X-Received: by 2002:a50:ee90:0:b0:522:203d:c9b1 with SMTP id
 f16-20020a50ee90000000b00522203dc9b1mr98592edr.11.1691101296455; 
 Thu, 03 Aug 2023 15:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU74j3MbAzUnyPB9qtD7vu2ksShX3aXjezzp6G7rMTcVM03zf54oUtFU0PK8trs7WnvFP94Q==
X-Received: by 2002:a50:ee90:0:b0:522:203d:c9b1 with SMTP id
 f16-20020a50ee90000000b00522203dc9b1mr98575edr.11.1691101296216; 
 Thu, 03 Aug 2023 15:21:36 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 m13-20020aa7c2cd000000b0051df54c6a27sm355860edp.56.2023.08.03.15.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:35 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: [PULL 15/22] hw/i386/intel_iommu: Fix trivial endianness problems
Message-ID: <cc2a08480e19007c05be8fe5b6893e20448954dc.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

After reading the guest memory with dma_memory_read(), we have
to make sure that we byteswap the little endian data to the host's
byte order.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-2-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..13fcde8e91 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -756,6 +756,8 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
         return -VTD_FR_PASID_TABLE_INV;
     }
 
+    pdire->val = le64_to_cpu(pdire->val);
+
     return 0;
 }
 
@@ -780,6 +782,9 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
                         pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
         return -VTD_FR_PASID_TABLE_INV;
     }
+    for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
+        pe->val[i] = le64_to_cpu(pe->val[i]);
+    }
 
     /* Do translation type check */
     if (!vtd_pe_type_check(x86_iommu, pe)) {
-- 
MST


