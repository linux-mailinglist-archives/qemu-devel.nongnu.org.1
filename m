Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F3A7D0179
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXfG-0006A0-Px; Thu, 19 Oct 2023 14:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeh-0005ll-HZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXef-0000hE-Nm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnWheI9RHYepJZYu2SMx1IQcZHnuNqLDKqzr9JSiyUY=;
 b=ZQDG7DxwQAJHjyd/efm2uWRTFZiyhyQfriObWpJQg7ZF/w9hbl8SFZ0t9PeCILpcJzqP5n
 lO2KhnFCv64mJD16h6ilptsU/rqJkfpEAX0PHjM8bsz27zLXHbG1/2N8oFc+wNK0kDA1C8
 PCe7gScb1WGEXbdYIw+vTckXb5VXQaU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-yMoa5pcFPNSX_QQm4_X17A-1; Thu, 19 Oct 2023 14:21:55 -0400
X-MC-Unique: yMoa5pcFPNSX_QQm4_X17A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so1812665e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739713; x=1698344513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnWheI9RHYepJZYu2SMx1IQcZHnuNqLDKqzr9JSiyUY=;
 b=iE2N1DUJv5uzmc7xK4gmZHxZNwcPMNAt99DMctlTVm7ymQvwy0rAbopzezWIBrRFx3
 ClX6irslF4gNfSDBjDe1V8/Dy7mDgPTFThUhsfR/HMQKWDgiQNh6L0I2FG7aowJY0i2h
 IkKVIOEZAudQPIObMtf+7fyXjBBAejL2B93h6zn4jmh1lhtuwcqy20lMhj4xspYT1yp9
 b8eIMdUaMYaLsLic0XeSSIgiCqyADMYR9RwIh2egwtk3prCaNP54n/gDNYuqqP1JzCi/
 xI7wJ4JyZIXVyvfu2ELnMiZoucB+Dq4XxmPznbGOeoErfI3Q6e2XRl3XfQV2KPwtBM0T
 5LaA==
X-Gm-Message-State: AOJu0Yxl/8HxEP4QFk4omwb4XR2IJ2jiO2sQEZSOSQDw6ukObtcC0nOS
 Z2p99W3XmzO7/jxHosdwP68oeCdXZgiyUbuBRo56CFgocii5LgnEIRwLW0U5dCb146qidJHeq2V
 WfsATKrtUNoy1PldWyGFxhXmxN33Ev0hfCQjOsnBJlQMusFQqQFqolZzRlpAvDQSgclBw
X-Received: by 2002:a05:600c:4fce:b0:405:3455:d603 with SMTP id
 o14-20020a05600c4fce00b004053455d603mr2463633wmq.17.1697739713570; 
 Thu, 19 Oct 2023 11:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq1JNI/+DDegb+RVvXa8oHt0fxk+4WrsC8Jw2rntdKZWhkmxCZhNVfSUU1jN/vO5A0EiEYlA==
X-Received: by 2002:a05:600c:4fce:b0:405:3455:d603 with SMTP id
 o14-20020a05600c4fce00b004053455d603mr2463613wmq.17.1697739713210; 
 Thu, 19 Oct 2023 11:21:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 q15-20020adff78f000000b0032da6f17ffdsm5031508wrp.38.2023.10.19.11.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:52 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 15/78] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 core count2 test
Message-ID: <cdfb71f1aea337087effd1abe088fa3e366eff49.1697739629.git.mst@redhat.com>
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


