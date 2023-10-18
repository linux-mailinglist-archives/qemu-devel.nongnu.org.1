Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C057CE1E0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:56:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8uC-000365-Rs; Wed, 18 Oct 2023 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sp-0002Fy-7c
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sl-0006Uy-Di
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sr5apWx/ScK9oB1nRm3T8OXKBnRMu7sHdlMje9yDWyM=;
 b=OvunazprAv3RUEkpajfM3AiM+i5Gu+uvnzLq0fX6e284+0FKMi5aaAe1qlGMu1bOS79IB3
 07mJAN0ltOYL8XSKpxOvK9NzwzvmYOoFVOckH4LHn5b3bAyicEwViEIkSWBiG9301vF0J4
 Sa3i28X05fSu5IgI/xvU15Wis/plojI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ZbQdVtuANcSrGPnMLREJww-1; Wed, 18 Oct 2023 11:54:49 -0400
X-MC-Unique: ZbQdVtuANcSrGPnMLREJww-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40554735995so52005205e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644488; x=1698249288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sr5apWx/ScK9oB1nRm3T8OXKBnRMu7sHdlMje9yDWyM=;
 b=j01uLWH6fq9VfIMFHNqnslj9v31bYtPPyVMakyCSLDtxNDLS3gOx3iNjMxUGF/6KHb
 3+DmGZl7dTrrmfb3h3m7DyyKehJQnv0MPTU/EFYiD3FKVP5g/TgwsaF5kAhymVsiH3oi
 BFy54OPgR3w65iRyzJe9VsDf1qUKE03YqX16pLc9k0XTopsNHJOwMrGzIGcXoGqM6Q26
 nJz6Qtl/gt1xmyUHV8efbaW5ECik8C1lbGL7J8DMH4hUYBXaDuuB/sWEJdDsBcBaOHVt
 3plBtxfqta+2U0XWHVLZ+R+03mRLygGKhqCH2V9S6fpxqsUomrTWPzprQ4gJ3GCffEV5
 qd7Q==
X-Gm-Message-State: AOJu0YzI3e7p/ShagZ0MFnjTufGEJqQojMmZm0G+M3fJg7OS/fPivebX
 WvsG6Kqlhxpta84AOc20F3kMxLHSzkyIrNOIilVjfF47Ua6x9LRBo2+3NvB+aV5jRTD1yrWd6Cv
 rEisr3NXdLEb8AwAhVICHkaWDq60aIpKtGcYerKc8jXbnygE/4Zdh0aH8B4ul9eHBaesIaWg=
X-Received: by 2002:a05:600c:5251:b0:406:411f:742e with SMTP id
 fc17-20020a05600c525100b00406411f742emr4447007wmb.34.1697644487793; 
 Wed, 18 Oct 2023 08:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbQtUl+ym/B431elIpSmuOJkiL2wQuZ3F/CELEczzm7uo7bmIGPNPC8yGifDLgwufgwqNUfw==
X-Received: by 2002:a05:600c:5251:b0:406:411f:742e with SMTP id
 fc17-20020a05600c525100b00406411f742emr4446990wmb.34.1697644487469; 
 Wed, 18 Oct 2023 08:54:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a05600c06d800b004064e3b94afsm1995242wmn.4.2023.10.18.08.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:46 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 21/83] tests: bios-tables-test: Extend smbios core count2 test
 to cover general topology
Message-ID: <4d47fd5f5bdc030b1c6054c43e932d69a1c7580f.1697644299.git.mst@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

The commit 196ea60a734c3 ("hw/smbios: Fix core count in type4") fixed
the miscalculation of cores per socket.

The original core count2 test (with the topology configured by
"-smp 275") didn't recognize that topology-related but because it just
created a special topology with only one socket and one die by default,
ignoring the effect of more topology levels (between socket and core) on
the cores per socket calculation.

So for the topology in this case, there're the following considerations:
1. cores per socket should be more than 255 to ensure we could cover
   the core count2 field.
2. The original bug was that cores per socket was miscalculated, so now
   we should include as many topology levels as possible (mutiple
   sockets or dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the cores per socket
   encoded in the core count2 field is correct.

Based on these considerations, select the topology with multiple dies:

-smp 260,dies=2,cores=130,threads=1

Note, here we doesn't configure multiple sockets to avoid the error
("kvm_init_vcpu: kvm_get_vcpu failed (*): Too many open files") if user
uses the default ulimit seeting on his machine.

And the cores per socket calculation for multiple sockets has already
been covered by the core count test case, so that only multiple dies
configuration is enough.

The expected core count2 = cores per socket = cores (130) * dies (2) =
260.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230928125943.1816922-10-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c20f6f73d0..f3af20cf2c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1024,10 +1024,12 @@ static void test_acpi_q35_tcg_core_count2(void)
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
         .smbios_core_count = 0xFF,
-        .smbios_core_count2 = 275,
+        .smbios_core_count2 = 260,
     };
 
-    test_acpi_one("-machine smbios-entry-point-type=64 -smp 275", &data);
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp 260,dies=2,cores=130,threads=1",
+                  &data);
     free_test_data(&data);
 }
 
-- 
MST


