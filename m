Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229476F5A0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRgha-0004t0-0c; Thu, 03 Aug 2023 18:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghY-0004gu-1O
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghW-0000ZC-CZ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=laQg5kxWKJ7/tyTA7x0YuEWfZWimTpJ1rnaPQY0+oxM=;
 b=UNV19sX3EHJQJZSCLSx7TuAsNd7nlKeGSpia2uREVNuY3XWKFKibFygJY/b77+2y/NIuBp
 rLSpuqUq686LuuwLnT4MhyuKrrCQlA+KomTKWE0ShAPmxuzh2P2NlgV4+LmnCGvgijsxlZ
 B8jPG5u3fPIxhAlHAMqPKJU199NreIw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-0CeY6DWkO2Ga3WAjZ06Urg-1; Thu, 03 Aug 2023 18:21:44 -0400
X-MC-Unique: 0CeY6DWkO2Ga3WAjZ06Urg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99beea69484so93778466b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101303; x=1691706103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laQg5kxWKJ7/tyTA7x0YuEWfZWimTpJ1rnaPQY0+oxM=;
 b=V+4T3ApxW7u1it0ymwn1Q/GWOHLy9XsQW7WMn42omDEzLQ5a/+o0SloU+TAJZYJUwb
 cJu9+i4dWNQNtzk0nG+2e/ShAkyOJUV84q9E2Fk9D5JL8JiON91vD0bFNMMWPRemg3N4
 gz8AzcYvkO8Q4NB63yHzZenvA0IEZvTRHoKLFsR7RX3IhUfVZZPb9ry+r7bAcsGu2X3f
 X108UPNrbjNPEkLne5lVZ1r7GGHooRtkCKNuX/pWxcK7CxcdfH70XzZBvM2gxEAnGJZ4
 XEinH/Nq1j6Pdmzha3x6LpzckUTq3TIy0EL/yfcA3hmCGnqg6Pgu9+0Nl08OWJ2vbplL
 El7A==
X-Gm-Message-State: AOJu0Yw/bhLHKwwzq1o/BlYUpmFUzYLm8aq65TjBpxCku1/Am0heJy/L
 aTva9I3wljdVkiIWg6VWr/RJXpfuc7aDJTNlvqec71heGXPSnEeiESf92Nxm37wtO35co/5O0Ux
 Qf5enhiPsiXUQ1nbyh2UsSEO7El07c+AdAfFF7UulQubSlh+h89/I11lzGKi9ehBCnVgf
X-Received: by 2002:a17:906:7695:b0:99b:cb78:8537 with SMTP id
 o21-20020a170906769500b0099bcb788537mr2049ejm.11.1691101303431; 
 Thu, 03 Aug 2023 15:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqZeOSwK2HKRzlXdOxtU8LE5LYBkC9Fv48Aob8xHfdKI/+ZM+UtF2PQ/ShsGY8+PeUyOTApg==
X-Received: by 2002:a17:906:7695:b0:99b:cb78:8537 with SMTP id
 o21-20020a170906769500b0099bcb788537mr2037ejm.11.1691101303262; 
 Thu, 03 Aug 2023 15:21:43 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 z25-20020a170906271900b0099b4d86fbccsm376818ejc.141.2023.08.03.15.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:42 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/22] hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big
 endian hosts
Message-ID: <4572b22cf9ba432fa3955686853c706a1821bbc7.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On big endian hosts, we need to reverse the bitfield order in the
struct VTDInvDescIEC, just like it is already done for the other
bitfields in the various structs of the intel-iommu device.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-4-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2e61eec2f5..e1450c5cfe 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -321,12 +321,21 @@ typedef enum VTDFaultReason {
 
 /* Interrupt Entry Cache Invalidation Descriptor: VT-d 6.5.2.7. */
 struct VTDInvDescIEC {
+#if HOST_BIG_ENDIAN
+    uint64_t reserved_2:16;
+    uint64_t index:16;          /* Start index to invalidate */
+    uint64_t index_mask:5;      /* 2^N for continuous int invalidation */
+    uint64_t resved_1:22;
+    uint64_t granularity:1;     /* If set, it's global IR invalidation */
+    uint64_t type:4;            /* Should always be 0x4 */
+#else
     uint32_t type:4;            /* Should always be 0x4 */
     uint32_t granularity:1;     /* If set, it's global IR invalidation */
     uint32_t resved_1:22;
     uint32_t index_mask:5;      /* 2^N for continuous int invalidation */
     uint32_t index:16;          /* Start index to invalidate */
     uint32_t reserved_2:16;
+#endif
 };
 typedef struct VTDInvDescIEC VTDInvDescIEC;
 
-- 
MST


