Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE167CE1C9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8sL-00082K-2b; Wed, 18 Oct 2023 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sJ-0007ya-1M
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sH-0006RT-Fv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqm+3g2pVOW5m/nVt88A5JfMQVm/PoWF4WmYjiRU9/k=;
 b=hpX5ABc4q4ZjwU8nwOpB+NOGzEs6h3clbZcPAbJnSqTZGTrCdeY+Uiw8nLK2qiv/1jr/Ay
 I6xt19n7IjweOa4y6eLt6+li17CF3idrtbu9hEGp0Z0v9qH6Nb3wLMS8V/CbhOcuoLjEGE
 AcCZ3FfBngVE64rtWCM+lS0HUo5asdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-J1bwyj6HPAusUa3RC36h6Q-1; Wed, 18 Oct 2023 11:54:19 -0400
X-MC-Unique: J1bwyj6HPAusUa3RC36h6Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40590e6bd67so51796485e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644458; x=1698249258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqm+3g2pVOW5m/nVt88A5JfMQVm/PoWF4WmYjiRU9/k=;
 b=cToeOBxQ2Aw9PHdpGYjUhwbXr9QiubCaux0BRuLMS2cFEiDrhI46d+YWcjp24pwb5Y
 Xj3jiJBlthPsA8WmIna3FKrAd3r71wy+UzOgHtLmNofivdBT9hGAbwftPUjR3qJW4Eaz
 A4nTnXhhriAYbtOIrWHmNLLBn1k+xTo7p7Exb3ZDWbagyXJWAc888uHt2jGLnkZOGmxM
 YuJl3G4xE4VvAqEZDlMuDZHsILrMWswLyg15hAmoAjS9xElGC/CyoTCQfT+1wgd8cbIt
 f+5+el3StOKk+jhXANVrcVVuG/TwilZIVQy5+DQKMPnZ5h35tseaEZRYQOBkzybdyID6
 dsJQ==
X-Gm-Message-State: AOJu0YxJ0IsOYALSLZgh/bQzDiniKTHzyXdiMY23tCVrSvOhJCgs+ZrZ
 101opvIOJlKfbWp+ykxNX4Ro3PsrLgL4V4lCU1A28LQN+xx8I6EyHwnfuaW2gx6xBRIDWn5FXz8
 +nRddUAdm+ctM5eOePzQLbTAyap3DImR2tUK3XX47zNG8hT5kKWhGPuc3qRo1UYYXkhcPOzg=
X-Received: by 2002:a05:600c:3ba8:b0:402:ea83:45cf with SMTP id
 n40-20020a05600c3ba800b00402ea8345cfmr4747209wms.2.1697644457931; 
 Wed, 18 Oct 2023 08:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYLnTmVWTHJJ50DwAlFv3IxetsIVnH2hgB0/eVkbrFDsdSAFwOog0tEI1JKJKRwQBrB6nHEA==
X-Received: by 2002:a05:600c:3ba8:b0:402:ea83:45cf with SMTP id
 n40-20020a05600c3ba800b00402ea8345cfmr4747189wms.2.1697644457554; 
 Wed, 18 Oct 2023 08:54:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c4f1200b00407752f5ab6sm2021363wmq.6.2023.10.18.08.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:17 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 14/83] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 count test
Message-ID: <a70daba18aff95f0f3a29d4d80eabe35510dae1e.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the type 4 count.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-3-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 tests/data/acpi/q35/APIC.type4-count        | 0
 tests/data/acpi/q35/DSDT.type4-count        | 0
 tests/data/acpi/q35/FACP.type4-count        | 0
 4 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.type4-count
 create mode 100644 tests/data/acpi/q35/DSDT.type4-count
 create mode 100644 tests/data/acpi/q35/FACP.type4-count

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..0ce6f8fc72 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.type4-count",
+"tests/data/acpi/q35/DSDT.type4-count",
+"tests/data/acpi/q35/FACP.type4-count",
diff --git a/tests/data/acpi/q35/APIC.type4-count b/tests/data/acpi/q35/APIC.type4-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.type4-count b/tests/data/acpi/q35/DSDT.type4-count
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/FACP.type4-count b/tests/data/acpi/q35/FACP.type4-count
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


