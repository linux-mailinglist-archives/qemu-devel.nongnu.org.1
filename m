Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0597D0178
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:28:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXi4-0001lz-IB; Thu, 19 Oct 2023 14:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfE-0006P5-7z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfC-0000lo-Pz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjlVrUeczLAR03pwd1/U1KMehdm4BwsDcIjYnYLYaqM=;
 b=BBVZq5l0J00tKvTPTEOdzyCtInzlfr3eNmgeHglbbLG3OCJ761LHD1e8Z1S6tnO52qlcBa
 qxMArwQTlNSE0y5d8B29KjyEH5CNN77f6ci5MQbhpKWCPZmTkSTdKqmmpo3Y2DyR4bHTWE
 88eKT5KOYUwD9e2pf+eFbisZ7GvyyWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1p6XgSI4M_mJeSrFYCfMyA-1; Thu, 19 Oct 2023 14:22:03 -0400
X-MC-Unique: 1p6XgSI4M_mJeSrFYCfMyA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d879cac50so5348f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739721; x=1698344521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjlVrUeczLAR03pwd1/U1KMehdm4BwsDcIjYnYLYaqM=;
 b=ZiVECUq12NT1tlIZrlV0CdWtEJjS8ERrhnF0IAxOqAa2D6hJV39esjY0bJ9EHkUlL4
 9zQYc4FQoID5kPVV8auJbpPZSXPiSexnhZfE0tL28kiCzJWThli4xnqhUzwbH7pmiyEp
 XKMH0lJRtZCDdJSEtZZyujdNqG7HpoXrzCypA+nqh8/+jLrM3zt1do9bBwfT8lbYbhVz
 FvkrGUd9t1SsgrnfbruIfmGb3vGDyEQr/ueEVDurqiqjRNyFd79zEWg4W9BmSG228QuH
 O8tqsD39iLVhND7B7LjQpoEoPKh0v3yZ4UmvuVoMVb8fn4rME44rDVNhADfDVk0e52HB
 zq8A==
X-Gm-Message-State: AOJu0YzzE89ZPs85VcfsjC6yqNjZpSFChzm/bhLCRyeXyqgina7e2Gol
 Ym8PbFafVAVIRL5zIDcHrB0Z1wzqT4dQQUImf8ZeWmhvL/9P2nOrAG8CreqUTGwDuJv3I5vjjII
 931mq4uTp6wcSEVFxNd5mctV8MvdAmqVib64+HUTiG4SkpY6e5uBXsY03O24y1OtSUdbQ
X-Received: by 2002:a05:6000:b46:b0:32d:be57:795f with SMTP id
 dk6-20020a0560000b4600b0032dbe57795fmr2247099wrb.6.1697739721376; 
 Thu, 19 Oct 2023 11:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJpGFE200UHi4BqzUT+fBhuRDIzhsZrT7o5foLATOqXxSUvPpad+4KHTiFSrAPaR124yobSw==
X-Received: by 2002:a05:6000:b46:b0:32d:be57:795f with SMTP id
 dk6-20020a0560000b4600b0032dbe57795fmr2247081wrb.6.1697739720896; 
 Thu, 19 Oct 2023 11:22:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 q15-20020adff78f000000b0032da6f17ffdsm5031714wrp.38.2023.10.19.11.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:00 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 18/78] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 thread count test
Message-ID: <ec535cbbcabafc55d851a5684a58d74375b5fe03.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


