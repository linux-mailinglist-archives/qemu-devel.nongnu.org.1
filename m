Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376E7CE1E5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8uT-0003BR-9Y; Wed, 18 Oct 2023 11:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tQ-0002jz-BK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tH-0006iq-LM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH9s3dhQtNiDAB8BBK8PkL20rbeESKgpLRTsvRZX/ME=;
 b=Zc2yKBPYpPu+7niztnrimmUuYD6JKlJgdpZ8J1dIghPd+wa9nencyzoPedhjHUUvceNvNO
 y4XFkLIfj6+pc/74nS31MT8+VeeahS8d9WeYT9/8v89ZARqWPtTU06cX217FoCITTe0YSI
 9oW16Q/CMaTMNKf8hGPXWCnl0QGQrm8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-xa-fIXhVNTiaXR1Et6g1oQ-1; Wed, 18 Oct 2023 11:55:14 -0400
X-MC-Unique: xa-fIXhVNTiaXR1Et6g1oQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-406de77fb85so44701825e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644512; x=1698249312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH9s3dhQtNiDAB8BBK8PkL20rbeESKgpLRTsvRZX/ME=;
 b=DZoePu6D2NhPfeCFMr++a8uwRWgbBFmjSX9BW9UztT8cuv3ww08aBQn5iPXqNiNt57
 ChhdTqP0h2ktQIXDS4EuvyXbuKRArMSzL8Uzq2W44KEz3ALiA4i117PiTylkNQ9Tw7px
 CpLQ+zJyRAoz9y1SQk0yV+sL2C7o+IM7qfaTKIofOS2DSPEGk3ziVXZJHjNftkYCMbug
 IjSsQE5YVLs1Ap+emFZBOh85tbmqYqg5lbjjtEO/OlpQq7O8wja9FVXcmv6dx9adC59j
 B8A4RvDNqMvu0VtsI2sX9m9ujFF2DUvAG8K/8czGgjnY8R8DvAR1Rk6gHO1E8/ttbvDn
 EtwQ==
X-Gm-Message-State: AOJu0YycyZwHJMbVFnmwrcbSKIUl09U/DX4sv/5WyUofbVqSPJuRBlVA
 6QTt7CVUil6Gr9fiqTrjV+/uHnGwNsbHWvOEC8LuqdD3tNH46e4590JXN9vym9x19T+CPRroddb
 /QWhihTmLsgJ0p2cuGLewMyKB4GgngTt3LT/7IR8NQCVLXu8NmHXkHlRE4jQXhF2zFML0bSQ=
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe5 with SMTP id
 l34-20020a05600c1d2200b0040841b47fe5mr504224wms.16.1697644512523; 
 Wed, 18 Oct 2023 08:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Lv8frgzjDMxVODvtkuaDnt7oPgS5RMN+PSyuarkyH7Dsh6kTpizN9fX4uBulYz812YdWDQ==
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe5 with SMTP id
 l34-20020a05600c1d2200b0040841b47fe5mr504212wms.16.1697644512284; 
 Wed, 18 Oct 2023 08:55:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a05600c0a4400b0040775fd5bf9sm2090292wmq.0.2023.10.18.08.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:11 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 26/83] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 thread count2 test
Message-ID: <76869a486c0150cb66492bcd254e245d3d238161.1697644299.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the thread count2 field
of smbios type4 table.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-15-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 tests/data/acpi/q35/APIC.thread-count2      | 0
 tests/data/acpi/q35/DSDT.thread-count2      | 0
 tests/data/acpi/q35/FACP.thread-count2      | 0
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.thread-count2
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
 create mode 100644 tests/data/acpi/q35/FACP.thread-count2

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..d17d80e21a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.thread-count2",
+"tests/data/acpi/q35/DSDT.thread-count2",
+"tests/data/acpi/q35/FACP.thread-count2",
diff --git a/tests/data/acpi/q35/APIC.thread-count2 b/tests/data/acpi/q35/APIC.thread-count2
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.thread-count2 b/tests/data/acpi/q35/DSDT.thread-count2
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/FACP.thread-count2 b/tests/data/acpi/q35/FACP.thread-count2
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


