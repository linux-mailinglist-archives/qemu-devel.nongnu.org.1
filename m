Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1EE7D017B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiM-0002nD-Ln; Thu, 19 Oct 2023 14:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhB-0000AS-D3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXh8-0002WX-OJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzMBUbudylul0FJkLWku7UAionEGDwih3IlnCHi1rwI=;
 b=BLjowySFaXwppJufb1mUVSMWgTa0mbYcRH2p5iRAQVXkznNFDK/ug1D8mu3BPg/ruEyVI1
 Iuh3RRcMbdzMBR7dL1nCvTgPLekG5sjatUElueY4VxoJwNRZGcRpU+4nKIuLPxqRVoJoFH
 3sE8KdTSInYQYpAeESx7yoXhUWnOKE4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-g5X_kCGXPKmab_wek0-ZeA-1; Thu, 19 Oct 2023 14:24:28 -0400
X-MC-Unique: g5X_kCGXPKmab_wek0-ZeA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407558fe418so54926385e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739866; x=1698344666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzMBUbudylul0FJkLWku7UAionEGDwih3IlnCHi1rwI=;
 b=qPdGyjyX1A5uc2M8jDYUsmmzJyXeY4nN5uqmxRdcv4hWRb29yn2tJ9wIIZQgH6y5jg
 6TVvq4FjqNumGeK8bMJufuKRHrL0K6q7+M4dy3SGAYfeWZ3X5ipmX2FqQlZcgiMHyyzb
 mLrkBRu/VriDfLxT7CXCDQ8u0h2bCqzqUrdQJcp/Xs/NF3h7MoH5uXX0LO3iq036Ihz9
 /qpfsTqEca0pu9ArvW7Rl6anNBgBVtBeJNCLlcIDo6zzLJFgVGnidkAxcPoVk8IyvqZA
 v44Z01VBZ26YBkx9V97yZ0/8+rNyhKHuMCq2gbrZu8z8eZDNXsNzRIXwawUEy8sPqGWg
 XMhg==
X-Gm-Message-State: AOJu0YxcIaiWQp2XfjIe9dqEEEKWT1mrngZ4wevm5u3NKZNMWNKZ0CcB
 4LopYbvUb0ppAtZgXauQQEkwq9uQKYtXDmuRIfQcMm/KZC56/pAyNuQFyTqh1IVUpQjLAMH1Uva
 dKZgiu3l506aIVgpaI1NBSNzVAkAj3vlFm7aWUVSsxf1iF3aasEYnmnM+za5sWv7LtqoQ
X-Received: by 2002:a05:600c:3b8a:b0:3ff:ca80:eda3 with SMTP id
 n10-20020a05600c3b8a00b003ffca80eda3mr2340851wms.10.1697739866254; 
 Thu, 19 Oct 2023 11:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Wt17pbKsItcCjqS1vZev2/DFOLJ0yQ5YafPAKfRVDlg4Vgn2OCFoJ0EmilqGpdbJLt+PxA==
X-Received: by 2002:a05:600c:3b8a:b0:3ff:ca80:eda3 with SMTP id
 n10-20020a05600c3b8a00b003ffca80eda3mr2340836wms.10.1697739865880; 
 Thu, 19 Oct 2023 11:24:25 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c4ec900b004064ac107cfsm200652wmq.39.2023.10.19.11.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:25 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 72/78] hw/i386/cxl: ensure maxram is greater than ram size
 for calculating cxl range
Message-ID: <e9a5ce6265c31a11f8da17c3b09f0a65ec96ac66.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


