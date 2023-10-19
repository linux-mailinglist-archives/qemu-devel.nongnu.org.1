Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB4D7D0168
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXfv-00075s-Jd; Thu, 19 Oct 2023 14:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXet-0005yk-RF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXes-0000iu-5q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sr5apWx/ScK9oB1nRm3T8OXKBnRMu7sHdlMje9yDWyM=;
 b=VRkqcitiO7JTvX+xh+mjLSilNB0Zwz6ftUj5lpDKlpYc18ttdYTvXY8+HncjIeSIzin7HQ
 amgSFnPDiIpODN5Es3H4iX9i8E3t9gTMveAxzy65T0dMKuzmjWzve55AY01/161TGg+LNi
 B0KVo85yj1FD4DO8FtpVovOjQ51yvy8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-dPUASFgnOCGd_JmiuKq1Ag-1; Thu, 19 Oct 2023 14:21:58 -0400
X-MC-Unique: dPUASFgnOCGd_JmiuKq1Ag-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so30146331fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739716; x=1698344516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sr5apWx/ScK9oB1nRm3T8OXKBnRMu7sHdlMje9yDWyM=;
 b=B7KqJS/r/HK2JVfPdCD5PtQLso2z8vkzr0RQ1t3lXgNaIte+auV8Vz0RM73OYDBqyu
 wIaWCRAutiSEdmypeyFuIku3H+MgQ7NMDLRsn4k6t/9lCUeAelRdJmOwwPVmaY/yqtB5
 JII756ZwEEqVMB+pzEVtuOWXi0/QC/S8Jmy1gCbMOVcaSUa/0aQPkvzaM2GZHPQqV5BG
 l5pkflgII9FkvAIaZa6z22881ps44m3NzmDNWN6cGLOer8KFilaMefnocTwR9C/S1E+L
 /xEy7Uv1wsDntjJUr5/iulzshQrj6mQ06bhHLMfx+wxtGqOBJ+NNQcKd1FREnKio0NpA
 UO5g==
X-Gm-Message-State: AOJu0Ywlr2wlcblqZJXBTxdN4mz4ggGlZZXxfWMZKXmJFyVFpX9yd++y
 0pM4Vbvif517UHF+8B7avKXwN88kWI2NcF47Bw0TnikvshJD+zOYuIS9Pe7GtmNqjcGLutDtLm+
 ktlYcRQNDjpvasf9XAGi9ZE0zEPeIr3LvPQ1HgouH2oaMJwLMLO7lprr30ZK6tSmJrlaQ
X-Received: by 2002:a2e:a404:0:b0:2c5:21e3:f21a with SMTP id
 p4-20020a2ea404000000b002c521e3f21amr2379162ljn.53.1697739715977; 
 Thu, 19 Oct 2023 11:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP/hvfJpIk8QJ9qYf3OdrKC24LPhl9iNS/yykjljN/jsUTAH9cIsRgqdQjrudo2ISEZNWunA==
X-Received: by 2002:a2e:a404:0:b0:2c5:21e3:f21a with SMTP id
 p4-20020a2ea404000000b002c521e3f21amr2379152ljn.53.1697739715694; 
 Thu, 19 Oct 2023 11:21:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a5d5388000000b0032da8fb0d05sm4955595wrv.110.2023.10.19.11.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:55 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 16/78] tests: bios-tables-test: Extend smbios core count2
 test to cover general topology
Message-ID: <9b6eed0a425c164e69043631695fe49923ba3aa3.1697739629.git.mst@redhat.com>
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


