Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5307E3882
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3k-0006ha-Fa; Tue, 07 Nov 2023 05:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3e-0006Ts-Nh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3c-0002aQ-Hz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PBJ1uvthAaidklul8YgcRjJtzKSz6MO46xKoN4oXPb0=;
 b=TQFIvvYncfZwsl1PBa5ymPPcpEZI3WP3zGcaigxKAKXubRYoCKg/RRsq17UhiBK0v1pB+C
 yBGryrM70ha4g2anl+LN9XvAhHcfEGek8Q+eSW5nuloXNl6zLxYL3P8yd/FnVP9svY7qfG
 wG9XQwOsatLPoXace31A1uOMxyOiD6E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-WpNppxxkMiqzUJj9mOUDRg-1; Tue, 07 Nov 2023 05:11:26 -0500
X-MC-Unique: WpNppxxkMiqzUJj9mOUDRg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c6f3cd892cso55321961fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351884; x=1699956684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBJ1uvthAaidklul8YgcRjJtzKSz6MO46xKoN4oXPb0=;
 b=S8h72Epcew9PKnexq246OS5Omov0PMCMwCuWmY7gUARWToUYGk25RqH365H/J9UaWq
 wuVamJZxaApCxeAELcSYkiasjVDz+R78Na0EokoHaU1nEibud+LW7eimPSz4DkdLJd7c
 2wOm720IyVH/C4vuH+fEQYDHBcYet2ASY+nQv8s3wDKWdpAZx1RacU4O7FI20E2td2Au
 8Xs0uLKKsaWaNLN66xU7fiCLwWW4T6UmtgsCujyJt6/uswhmU3OveUDl0eeU4zl0oaOq
 sJpEAgu/9mdBL665X61P54k2nnRqTfOrMNo1zR7H/bByca0Z55nvObBB+G4WxbImMZ7h
 jtWw==
X-Gm-Message-State: AOJu0Yw6LwhsRX0YKAOSJtpwiOF8gh4UsLYC+ouAyAlSqvRZc+ap+/tj
 xrKGI9t1jkPHiDAu9eUcPgYiuRpbAu//058EJGom1CCzP/vWHGDDiTIXl4/VNiBiVEBHbSw8oPA
 ttGd0UuH79Tc2ZgPY8KFSdoqyKClRZNe/ObNXglKWupjj21NLtzfWEboRB6z9hD9RkaEZ
X-Received: by 2002:a2e:9f08:0:b0:2bc:dab2:c7dc with SMTP id
 u8-20020a2e9f08000000b002bcdab2c7dcmr25059254ljk.47.1699351884732; 
 Tue, 07 Nov 2023 02:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjw9m3AgwD6wZwF8oH05VhBUEFtHKe7rSQmmq+vlleANiygt3MkLv5AskmeU2LkcdPgNGTog==
X-Received: by 2002:a2e:9f08:0:b0:2bc:dab2:c7dc with SMTP id
 u8-20020a2e9f08000000b002bcdab2c7dcmr25059220ljk.47.1699351884081; 
 Tue, 07 Nov 2023 02:11:24 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 o25-20020a1c7519000000b003fe1c332810sm14788257wmc.33.2023.11.07.02.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:23 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 25/63] tests: bios-tables-test: Prepare the ACPI table change
 for smbios type4 count test
Message-ID: <6c7937ece909d3df0d2b4e94909f57388f5ed666.1699351720.git.mst@redhat.com>
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

List the ACPI tables that will be added to test the type 4 count.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-3-zhao1.liu@linux.intel.com>
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


