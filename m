Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7E7CE204
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vB-0004TE-QB; Wed, 18 Oct 2023 11:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tQ-0002jy-Ae
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tO-0006j0-AY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjlVrUeczLAR03pwd1/U1KMehdm4BwsDcIjYnYLYaqM=;
 b=ac+WZFCawuvKsmaMhfhsblxfRBdmbXTF7Bmw49iXkfUgdJsului82smK7yPKe2jrLrAsof
 lhSfOut/UqjhoWwa3E4XSZljvQIeuUtYOnid1f2H8V5vtdtiqPPdQAS+s5OF7hme1m3lT3
 yeDZ7Kh//kQ0UbjPeVnuO1A06pQphFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Y52Nofr2NlSIck_AAF6cfw-1; Wed, 18 Oct 2023 11:55:00 -0400
X-MC-Unique: Y52Nofr2NlSIck_AAF6cfw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso44807815e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644498; x=1698249298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjlVrUeczLAR03pwd1/U1KMehdm4BwsDcIjYnYLYaqM=;
 b=fPDLNqccZ8k7OlRMWhrs1QUX+M84Q8DZaxCk4Zet1LGgX7b99najAcvIYaw5Rv1h6G
 3F1pXnzWcherlDJG/mYraYfBDZNUX6gf2D8WYO0nwjQK2iX4CDc9WC7MZs2DNf+jwFGs
 ayhzbQSYViG3askQuGbtQV5puZXTh0YZmIkdjn6YzVEz5mqymerYwZ+kRtYyaYLuaP62
 gYMG/L0VJFcZez1pSaVxw696M0s7UFviSsvgcbW01aWozQ7dCNn50F0IwRYeeshNvQzX
 QFhjzcCfW/Qf1t/n6sI0RCTKgmQYXDFsdjIydwkvrIb7nQK1hYVldTCmN+OMk5NAIrW9
 nXeg==
X-Gm-Message-State: AOJu0Yyy/hkq84lPIMP0GHhxx4Js2+mj31tFMxDl/dshXdsxURw69tfU
 ee7gm6dInvNatG+Qi4zE6kXIUD4slmSiKcEkH8P7+iJkDWnT02MzRDHZCAOnvmBjkCohLROrK6T
 yNhssgcvN5d97HwjX25Xg7jVEJsDWVG2tUE8kVZLeaXPS1/vxVjZSOi9jwWRghC8yHAOePRg=
X-Received: by 2002:a05:600c:4f42:b0:405:3455:d603 with SMTP id
 m2-20020a05600c4f4200b004053455d603mr4396920wmq.17.1697644498561; 
 Wed, 18 Oct 2023 08:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzyGp+tGeKXR6M4a+hA14WZPqTVDqKSrYDJp4l3AmRx1ix9Uwai9xEUdFLuelRv2e20FOKsg==
X-Received: by 2002:a05:600c:4f42:b0:405:3455:d603 with SMTP id
 m2-20020a05600c4f4200b004053455d603mr4396907wmq.17.1697644498228; 
 Wed, 18 Oct 2023 08:54:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a05600c00d900b004068495910csm1970175wmm.23.2023.10.18.08.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:57 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 23/83] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 thread count test
Message-ID: <03a8efb80813ef2a77be59de9ce41f2399b371d2.1697644299.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the thread count field
of smbios type4 table.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-12-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 tests/data/acpi/q35/APIC.thread-count       | 0
 tests/data/acpi/q35/DSDT.thread-count       | 0
 tests/data/acpi/q35/FACP.thread-count       | 0
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.thread-count
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count
 create mode 100644 tests/data/acpi/q35/FACP.thread-count

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..4d139d7f6b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.thread-count",
+"tests/data/acpi/q35/DSDT.thread-count",
+"tests/data/acpi/q35/FACP.thread-count",
diff --git a/tests/data/acpi/q35/APIC.thread-count b/tests/data/acpi/q35/APIC.thread-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.thread-count b/tests/data/acpi/q35/DSDT.thread-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/FACP.thread-count b/tests/data/acpi/q35/FACP.thread-count
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


