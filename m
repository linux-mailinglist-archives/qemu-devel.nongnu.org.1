Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815097CE1F6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8tm-0002hU-PY; Wed, 18 Oct 2023 11:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sm-00026u-Kx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sj-0006Uj-Gy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnWheI9RHYepJZYu2SMx1IQcZHnuNqLDKqzr9JSiyUY=;
 b=Lj/JtRF1p8tPoR8bKiaLvYVwcjx2PNCpZSugz4bJAfO2Sn/bG3Ov9IM0eZzQAMO7tjnxbC
 /Z5xokiS8AlgLWXHhq+hDVGg1o29wCAq1yS0gQ9rC5tRovKYYI4PGauUnF3Cs/Z8/g8Avb
 Lgp5aKSRx0BqIZL95x+/vRcenLiGRRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-M-t_hTBwPratIOcMP4rJVg-1; Wed, 18 Oct 2023 11:54:46 -0400
X-MC-Unique: M-t_hTBwPratIOcMP4rJVg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40570ccc497so54263405e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644483; x=1698249283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnWheI9RHYepJZYu2SMx1IQcZHnuNqLDKqzr9JSiyUY=;
 b=q3OI189bi9fCYWAf7NGVubcDtR3Nri+cnovKD1u5d1t/We1b9HrcUMxGBJSSscrQBo
 tcsIMOuvly3TJD9cufkmNGBYWOiLr8bvceqBZC5GPP1rhqJxYikPyNkCUGJ6hs2d1JTi
 XoeR90J9Uf19YQBJ6tQuEOQfSRlAW4Xl6ytvEHGCQTMUqwDAerc8LTWfa3gGLVIFkgzQ
 e0a/2mCSbJuynHBbWusjKAkDqBE2vNem11pil3qmrEPxwn/595lgoVkpEg3wcfgmHaRs
 cSSCb8c+nlQ+E4ZmQKx9dsMtdZj2hrgcp0MnmJpCwd36WDVo98BONiJ0cSVQip18WyQQ
 z5TA==
X-Gm-Message-State: AOJu0YwoExoKmnr5uZdp7Uzl7kBB0MBdxM8ZKYKDwmFPjOg61p1v7L5c
 ymXZsxz9BLB7jpCtq+oELMc+CrWQ1RjArQ4JMGI/EKHytDAxn4bjBifIEVXztGeBqisTBjgsT/w
 FaZ++1Nsc8LOL4JDN/8EfdcELq7D/jhtMguLZXZh3gYZVVP7kdUKJDwonuhz9ZWQ9p0AEcBc=
X-Received: by 2002:a7b:c8da:0:b0:403:31a:77b9 with SMTP id
 f26-20020a7bc8da000000b00403031a77b9mr4674051wml.37.1697644483475; 
 Wed, 18 Oct 2023 08:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQXOnQjs8l8rO9Isdo0FwSgeRZJ9gBiKaFjiQGxTFWI4aOQKwif59LGxANz9ygPXIJYv5Ngg==
X-Received: by 2002:a7b:c8da:0:b0:403:31a:77b9 with SMTP id
 f26-20020a7bc8da000000b00403031a77b9mr4674037wml.37.1697644483110; 
 Wed, 18 Oct 2023 08:54:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 az15-20020a05600c600f00b00406447b798bsm2012295wmb.37.2023.10.18.08.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:42 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 20/83] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 core count2 test
Message-ID: <5a91859db1e0d2909c454d45a5b6696814db24b0.1697644299.git.mst@redhat.com>
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

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 1 - 3.

List the ACPI tables that will be changed about the type 4 core count2
test case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-9-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..0f95d1344b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.core-count2",
+"tests/data/acpi/q35/DSDT.core-count2",
-- 
MST


