Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2397D0187
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhG-0008UC-F2; Thu, 19 Oct 2023 14:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfD-0006Ok-1a
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXf9-0000kL-K4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqm+3g2pVOW5m/nVt88A5JfMQVm/PoWF4WmYjiRU9/k=;
 b=hKMufRQDn/1D7ZhnqxgbvNwHyRa89wmUIn+YJr1Y3EODF1cDyGGoGVPA3x7xuJp9qwYS7y
 PlNzWJ+PH+ivhpfKmHHg4HZn8UA6MbKrdMUxBW6oL0uLmR6X1B6TiVnM66acHN4RFnP1U9
 tpkmGSRr3MVslmIDx53qIS2xnt8+olU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-k32ZZ2FTOHyn2ZZRET_xsQ-1; Thu, 19 Oct 2023 14:21:47 -0400
X-MC-Unique: k32ZZ2FTOHyn2ZZRET_xsQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084e263ec4so2528015e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739697; x=1698344497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqm+3g2pVOW5m/nVt88A5JfMQVm/PoWF4WmYjiRU9/k=;
 b=jsYX6xrFRSoatO7ria/Vs22MhaAdRZVU1+ruvZSqObhjYgEwq6nyj6vtRo2Y0YY2oT
 /uulYFeqDvB1tJG8LtCE1mW4LSL8Q+AiuSDcsAGIFZTdd5HIKU3GouSIqaGy7MTw1Roo
 rMup77Gt0kXvz0s+2og5hiuz0jQjzsSsupwy3B7EHfuKT2hkrOki1hYEhxm09P7O1CBE
 zVN6G5D+Y8A4l0YLSKZekr5IezsJLYT8cjYYxLvTtbJrj6+CCKKiREXAMFLI6Y/VCH2s
 ImINUMxlJ7Q5Top0j2G2zreud+NNMAFJEYip2jerp6kcxz/pSRpWa5d98g7VChv/WGde
 pZyw==
X-Gm-Message-State: AOJu0YxgeQm20uEAZ/zjjSz1TJBXwVWo0C+i0qjuoc/UH6EBnaJhfMHR
 q5J60amBEBF+WT+r8DG+DrlXdM6ebFRUlKcpyllPdR8LkOsaocTMfJM0pWUNDtuM/44sK2Qt6kX
 po0dYAVfM4J0pig3Bpv2asC50+gOgkqJdrUTZrpD9Ea9J2mRV+Fs3NE4exPT7sn4lU03N
X-Received: by 2002:a5d:5310:0:b0:32d:9395:dec2 with SMTP id
 e16-20020a5d5310000000b0032d9395dec2mr1905770wrv.71.1697739697551; 
 Thu, 19 Oct 2023 11:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmBKPb4ez6aUKkorBWiJGEbY3bLSTA7OB2wvhJS0KghwdCsA+2+ZUCVJFNU9zl99R91uYgTQ==
X-Received: by 2002:a5d:5310:0:b0:32d:9395:dec2 with SMTP id
 e16-20020a5d5310000000b0032d9395dec2mr1905756wrv.71.1697739697189; 
 Thu, 19 Oct 2023 11:21:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b0032d81837433sm5109606wrn.30.2023.10.19.11.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:36 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 09/78] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 count test
Message-ID: <9717aa04085e6c5f69e05a426b73386cd8bd9570.1697739629.git.mst@redhat.com>
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


