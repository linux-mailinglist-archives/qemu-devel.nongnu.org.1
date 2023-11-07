Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE237E38C7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4D-0008Oh-W1; Tue, 07 Nov 2023 05:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J44-00083v-Uk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J43-0002el-Du
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LcAijS7Yd/T++Hyga8YX5w8OlX23Y/cXaSYo0SnpUO8=;
 b=fFI8Ll1CrCiWx/N93q8AdAyCPBDuMsSq7LRQpz4dx6Jm+O1vIb2Xru5DDAFcCdbwxGALTq
 ujSMucabq6OsPhl7laGGxMeJtD84Vl+JoR1XjNUkrZYfDbOkO6kf48n7SeX60j4gU7Ou6P
 nxpdNLjsCUhnl1b/vNhvioGwOmPUIBY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-dkgkyXkwNtCQIu_nfOfujA-1; Tue, 07 Nov 2023 05:12:05 -0500
X-MC-Unique: dkgkyXkwNtCQIu_nfOfujA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408f9e9e9b0so35072045e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351923; x=1699956723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcAijS7Yd/T++Hyga8YX5w8OlX23Y/cXaSYo0SnpUO8=;
 b=M/b6ifjbIjxMOzpR0b1odeNxnLtZsag0t8gpzQ+aDKJyB93v1JFA33605TGOv3CBN4
 ehWiDjnW0fFAwGNDbhohaSpmTeRx6qS1iEVZ8FAvCldQ0JTXBbS4BOA3mItdOhEUbbCw
 /ADjAkzuaEOPskVb1B4hp2Fz4oDMgcaHpi2zpOGM0DaAn6b0+utmSLbWPixKrAAmLEh4
 084aHAGTZU4NMMR385kSXBL06X2pP1qovayXqBcWZt8Es4ngYXqR/d0Si4EZSapGmwgF
 3HJTpjenr+s44rC5ezVojzYXAHV3h16WK+7zQKDPznvJr41z19bHQePXSotshqwopZvk
 nsjw==
X-Gm-Message-State: AOJu0Yzj096Xv2w1N6sCxWY+dIGV7TpSFDE3aEOVVMhW65IjvN0SLo7c
 DGYwzj1ORol0qQnVoaKGakZCQdMk3aaGgynGWkWfqyynSi/n8UhUJxwF5bV+SYAo847DC3NylPY
 n1YNGLqkJT5UzJA5RvBDlk0IEysKv1UUxPFonxk2LnNuG7ZBaHJc/ztGtfFAWSo30iMjR
X-Received: by 2002:a05:600c:4f16:b0:405:3885:490a with SMTP id
 l22-20020a05600c4f1600b004053885490amr1834949wmq.0.1699351923575; 
 Tue, 07 Nov 2023 02:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrW1+FTPOBRL7MRccwZW7EiKBMquD8iF2AiFs0ovUGbznxpUmzYINmxmNWCegt2AegHIQwcQ==
X-Received: by 2002:a05:600c:4f16:b0:405:3885:490a with SMTP id
 l22-20020a05600c4f1600b004053885490amr1834929wmq.0.1699351923280; 
 Tue, 07 Nov 2023 02:12:03 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 n30-20020a05600c501e00b00405442edc69sm15255050wmr.14.2023.11.07.02.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:02 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 34/63] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 thread count test
Message-ID: <85ccbe1275b58efe9e30d229c942d33144b5ef6f.1699351720.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the thread count field
of smbios type4 table.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-12-zhao1.liu@linux.intel.com>
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


