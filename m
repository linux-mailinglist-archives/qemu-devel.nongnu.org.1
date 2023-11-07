Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E97E38A1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:16:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3n-0006tM-4z; Tue, 07 Nov 2023 05:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3e-0006OY-3e
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3b-0002aL-Pf
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CzJ70v10uwjo0/ajo+23xOd4j1emTdpwZ/Zn3TXa4uw=;
 b=fGl3OXo26c36yfc69R9SoPq5lT8uSNyxOpD7owSu9F6BR4G22/cEzI+OF2/RjiyusRaze3
 FO+93XmuauiC1ksTDTuDAe3hzqDhqq0vBlcBevyu+56U4wZGe3rmfu6vR0He3hD3nZmab3
 fURjCzw5TFmSKYVkgKT8L9/0vncLWl4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-9uxGWroMP86r-6kNUGfq_w-1; Tue, 07 Nov 2023 05:11:38 -0500
X-MC-Unique: 9uxGWroMP86r-6kNUGfq_w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4092164ed09so32755285e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351896; x=1699956696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzJ70v10uwjo0/ajo+23xOd4j1emTdpwZ/Zn3TXa4uw=;
 b=oKVzhXyYc9wzm+tEx7mhf5qFmABmgUAVL7c2UBsPNHb4+pTyF4C+PFFWb8NmJ70MD+
 4/oaE5jZnkd4DQVCMl1Ao8r+sqo0Ez16z5jyjNnc2ZxQJrzA+PDu+J5JAXnuzzcGRJij
 wQSKWksY8BNZsRjOl3/O8W3jtX8tgYsDiidbWAph2vbih5bCvSNOv9z3fm9Ms/oePTp/
 LhqmEROq3AxFeiNpm9XXMFXdrmCcjCwFbt4AosQTbJlqUga8w7g0uhi3FTnTmbZyimfI
 Mc7z7bcRg04SmtuzvhGdjdfwpRyXDM6xf5PpY8vGs5aH1JFGm35L3rbJlP2V8byjwy3g
 /OdA==
X-Gm-Message-State: AOJu0YyGk2K0/+aE6Q9Ao+vwKl0VKsbYb6Hxi2hwEfWaMs+S8qZ2iPdO
 ivnyYtj2kH/cpcGQtfo4y3YAMmyjsYWU2EVg6YErl436+po0pfuGR8k43+4yojiQy2hqlNujVFY
 iVfPhtu3CEpCEiGov1bBOzZy8Kq78LIPV+P31Vfiyr2BceKbZB/1QdgCCxpKU0fJZSV+R
X-Received: by 2002:a05:600c:5489:b0:409:404e:5ba6 with SMTP id
 iv9-20020a05600c548900b00409404e5ba6mr1652204wmb.35.1699351896398; 
 Tue, 07 Nov 2023 02:11:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR1/9hgPMHiEoVd5VNIHKyVgQafPFQy4IQbqZ6ehEWtP88k/gZ8xm6Req1SKgJMS+qxhKTmw==
X-Received: by 2002:a05:600c:5489:b0:409:404e:5ba6 with SMTP id
 iv9-20020a05600c548900b00409404e5ba6mr1652187wmb.35.1699351896072; 
 Tue, 07 Nov 2023 02:11:36 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c4e8d00b0040596352951sm14884901wmq.5.2023.11.07.02.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:35 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 28/63] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 core count test
Message-ID: <623d26ad9affaeca03633880623961434e60e77b.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the type 4 core count
field.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-6-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 tests/data/acpi/q35/APIC.core-count         | 0
 tests/data/acpi/q35/DSDT.core-count         | 0
 tests/data/acpi/q35/FACP.core-count         | 0
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.core-count
 create mode 100644 tests/data/acpi/q35/DSDT.core-count
 create mode 100644 tests/data/acpi/q35/FACP.core-count

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b9bc196130 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.core-count",
+"tests/data/acpi/q35/DSDT.core-count",
+"tests/data/acpi/q35/FACP.core-count",
diff --git a/tests/data/acpi/q35/APIC.core-count b/tests/data/acpi/q35/APIC.core-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.core-count b/tests/data/acpi/q35/DSDT.core-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/FACP.core-count b/tests/data/acpi/q35/FACP.core-count
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


