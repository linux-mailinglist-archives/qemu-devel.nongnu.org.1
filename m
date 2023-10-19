Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3337D0159
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:24:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXfW-0006ZS-9u; Thu, 19 Oct 2023 14:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXei-0005lw-NM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeg-0000hW-Sc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FZerVplP7gF2hzMNBoK9F/KJJRCWXJvDhhnD1MB+o4=;
 b=Ym0B4E7aHSwiG7smUzgQfP1R6eqhQjbdsvUN/09U7SgfDe90+vL9GlVvOZROTKddP8FvVr
 hHr3+kvKLruLmM5/cvdVmTqKFmiei5ngITco8Q2w/X288FTPOpwHTpNX80v+eVC5lnhhe1
 FlRITqHG3kQ//1Bg3oBfzTb3Cie42gI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-r3V4_GpnN5yrdi2pB-6FJg-1; Thu, 19 Oct 2023 14:21:46 -0400
X-MC-Unique: r3V4_GpnN5yrdi2pB-6FJg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso4977505f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739705; x=1698344505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FZerVplP7gF2hzMNBoK9F/KJJRCWXJvDhhnD1MB+o4=;
 b=WsITK30fs7wSa5ci8+Z4bjNvAZVsY1H4luQgN+Q71Hp2IaZamk6K7xePnSvhKGAuaG
 cAyWh8H8cZArVsNuWOZd2dWTslnp9aEaq9IIOCPHMcJ3IVCPoCrhgCIQhu4jkF5fdM2U
 gtfxkc5G4dvJkgaTNd93SzuFeG6N8YvIMslpVm9vYLjXTSUbNrtBo3ydLy05vOBohTB6
 x1D7RtSukuxND2iQu6tYm3ASVSa4Xsm2ZFygsdG4OrVfCGzpRgOfm1uAzOoe2G7L90RM
 lk3I9Sghk1jXI18hVtOBWbD0eVswrcj+F51TEpJGMGD4bu6xVTIFXwRpMstMjwTQlTdd
 tXaw==
X-Gm-Message-State: AOJu0Yzaj18G9MMnm0sfYao8ZMzgOghgI3QYZFjzAQWgiOmO6YMX2jwO
 fqQBOzNdD8cwl9lyTLyYPkZvaIePDPVv8ii7S/cwxI8aGRny2fQC7LDQrXpDktH3jdyD8miqGel
 fP0K8xu/1EJGlLutl9/D/SuF53EtFGr8kK8S5DwugRmnlA1qXsuBZTxPq9nQHMJGWxiIH
X-Received: by 2002:a5d:5191:0:b0:32d:a7c8:eaf7 with SMTP id
 k17-20020a5d5191000000b0032da7c8eaf7mr2130878wrv.20.1697739704963; 
 Thu, 19 Oct 2023 11:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpfb+EVz6l5thCOjkvwbuuP7Y/YLjrgmzhyUT39n26uIT8DEhRzatlm5iYGhOOi/48Jl0JJQ==
X-Received: by 2002:a5d:5191:0:b0:32d:a7c8:eaf7 with SMTP id
 k17-20020a5d5191000000b0032da7c8eaf7mr2130859wrv.20.1697739704610; 
 Thu, 19 Oct 2023 11:21:44 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adfe40f000000b0032d88e370basm5033835wrm.34.2023.10.19.11.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:44 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 12/78] tests: bios-tables-test: Prepare the ACPI table
 change for smbios type4 core count test
Message-ID: <c1ead6f56664f4b054600b866b3b5717c1b583c0.1697739629.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the type 4 core count
field.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-6-zhao1.liu@linux.intel.com>
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


