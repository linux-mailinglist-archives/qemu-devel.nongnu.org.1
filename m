Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A637D01A5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXg7-00078W-56; Thu, 19 Oct 2023 14:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXew-00060N-BB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeu-0000jT-NC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH9s3dhQtNiDAB8BBK8PkL20rbeESKgpLRTsvRZX/ME=;
 b=R/DVBFnVxAEqIkAa3rfzOZFrmcsa8Y2BKCQaB0x7c/ljWAh0MtG1Qch69vLLMMDPN7UY4U
 RgItZRX0A0+dBRutpCrSlRKWParVzuhJ70QPfPXKirTJjz7z1EV2jo3+Cb5hTks1ZIizEc
 zfMWLTHDJrSIabdKhCLP0+tV67CIjys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Q0zfG-jNM1-6-JGJ_9OX-w-1; Thu, 19 Oct 2023 14:22:10 -0400
X-MC-Unique: Q0zfG-jNM1-6-JGJ_9OX-w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso5011058f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739728; x=1698344528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH9s3dhQtNiDAB8BBK8PkL20rbeESKgpLRTsvRZX/ME=;
 b=jcdK2u/AEtg8I9BxNmCaLA7VkZwRq1oi+p3T5WwrDQZGSuhqEZOhEUJeW6AAAqmA4B
 vB0LkmuLAsSZI19yVOUfhW+5he8xe/+sYoucrntM+VGltvREKxstoTFhUb5nmwsvfJ+T
 Zdu7jVVinyvRVn+38qi6kdFWWp7fuN/mgBouqvkAROVuu0J6VrKYeP+qxL/d06oXjj0t
 VSbsJO7TCRCr8yBmqHsB4Zj22JSd7EeoqoEbtCZKUHBoE+3N/DYRbUQjYZbGq9CyG2ab
 X8ErVewfjc4Ax8aMfoQwjyeZB4gcV0Gcvt1fmDfrYq0hG2/yGlVPIdE6r7QEN72njlvD
 BKcQ==
X-Gm-Message-State: AOJu0YyVttb43YK0TktWBw7EQeASFbJg4+ZBgDRQWBVC5H7pI76THQVF
 tLy+aBG0qrgiYWU9C02KvUToC9TLSMebVIdUvCwShoFnThDP4ouAjyUggYgZimZbtREyRfIGCii
 h93AgDSqq25Seg5Y6h+ISrN7n8DzhWs18d8S7/SEkqzpHuKS661MRC5aICxY0WTltWX73
X-Received: by 2002:adf:fa04:0:b0:32d:a129:4f44 with SMTP id
 m4-20020adffa04000000b0032da1294f44mr1964684wrr.70.1697739728690; 
 Thu, 19 Oct 2023 11:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnDkN2mHTdvvIGLjyZzM7r3GBnmP3A2F9kRGQhkzHEUofCC1lDs3g7HmdHQhiAXtaB3d9t7w==
X-Received: by 2002:adf:fa04:0:b0:32d:a129:4f44 with SMTP id
 m4-20020adffa04000000b0032da1294f44mr1964668wrr.70.1697739728349; 
 Thu, 19 Oct 2023 11:22:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 r12-20020adfce8c000000b0032d9caeab0fsm5042185wrn.77.2023.10.19.11.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:07 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 21/78] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 thread count2 test
Message-ID: <edefabefa082a693434ed07a34fcc2b7580dbb3d.1697739629.git.mst@redhat.com>
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


