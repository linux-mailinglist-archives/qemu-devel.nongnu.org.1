Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9847E38CD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4K-0001Ds-TS; Tue, 07 Nov 2023 05:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4J-00014O-GN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4G-0002h3-Uq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzjRcIcLJXTDDXAO5KcivGNPGYfMjX9ytJMlSvUQwkY=;
 b=DOJaZ8eFJmcqH9LQtbb/zNYepNc/FOIniWhup7fD/1o7cxXPLF+6H+NvMiHKimuljRmPsC
 b5IEUT8LCG+E8Gr5UCWfffcO8Lgn0zb5fP44PINuoxgKDLsbgnZcSODUF3lY/vLwVEGVVN
 7NNGnZKVrDTQOVxOfgcgf+Wo3+z8hVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-GjNmOPogP_qzwEDAQyliyg-1; Tue, 07 Nov 2023 05:12:19 -0500
X-MC-Unique: GjNmOPogP_qzwEDAQyliyg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so36283085e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351937; x=1699956737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzjRcIcLJXTDDXAO5KcivGNPGYfMjX9ytJMlSvUQwkY=;
 b=m1wbJtnJRSOsPyA41g7k45Hjiewp6LcpKI8JVNJC+Ciq03CbJzDNzIxGUyYolrnaS1
 zt+JezqLLUWQJ7hNnv+vSjwkXQ5wD0EqKDa5lufVHg+xVtot0m8YyjR8LstKdZ6vhXA0
 jJO7FqGm6BG4gQGZNpYLT8eY8e95FmVu5Vd9qOyA9QczQObAZfN8UOcdCUypc8TxOncu
 s9c3UzZ2x9Mo19+GNbwz91BtSkJfXr8N2iqXmyhowmQdMGIxuyW12noDCgce20Ha/XiI
 AkmhHQHX7mJKF60wCuDCANKMTMIMCy5yunFjGWEslpuIXz97DH1dCHP01d4MjSV8Dy4W
 NnxA==
X-Gm-Message-State: AOJu0Yz8PTT+nMI7qr63uMYGpBw932Seydui6A+mV6xSyED4foZUU6wk
 1bG6ZnSYEzhZm7eREespjZlTbzBG5P7cu4mFH2vbb5FhFYhqab8Lpz9+eRRx8gTJhJwtp8gh+f9
 4SJhlgIRQcZfd6GADuAq1Omf2f1ts8KPFPz95v0LAtZ9JAmNndpS4Wx9VP/uDoBZJUjTx
X-Received: by 2002:a05:600c:1d19:b0:409:5a92:470e with SMTP id
 l25-20020a05600c1d1900b004095a92470emr1863518wms.28.1699351937244; 
 Tue, 07 Nov 2023 02:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHU691etRFA2Y8LufSW9EIvaJ4kH/YMt0cHN8b9uiZqfamTj8VEZW4CA2v+vpDYQAorBv9VA==
X-Received: by 2002:a05:600c:1d19:b0:409:5a92:470e with SMTP id
 l25-20020a05600c1d1900b004095a92470emr1863496wms.28.1699351936876; 
 Tue, 07 Nov 2023 02:12:16 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 f9-20020a0560001b0900b0032db430fb9bsm1910650wrz.68.2023.11.07.02.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:16 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 37/63] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 thread count2 test
Message-ID: <7cb953ca1956d4ac5d8ad798321fe3fde765befc.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 1 - 3.

List the ACPI tables that will be added to test the thread count2 field
of smbios type4 table.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-15-zhao1.liu@linux.intel.com>
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


