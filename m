Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E737D2882
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 04:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qukf0-0006Py-2E; Sun, 22 Oct 2023 22:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qukey-0006Pp-Ls
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:27:16 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qukew-0003Am-Qc
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698028034; x=1729564034;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qCucney9IT7OfpvEFhrKY72hUGVtoS6K8Ue4BDmuxks=;
 b=JU1K+rvGNPeTrrhFFUMzWb+zT4t21yNHpjW+CPpCrX64afIoPi+lAj34
 Z62hYTwKdZ1GFwrxdkgVHXyaUFGauZVX8MqG6SYmFZxhsQtY/4DPPvBPX
 tvXXOU0qSEZ3PCKjk9Dhlfm1cKhuFT+UHmhw3UHy4mjGKWTT4u4y0jAgk
 b+7kqPr3YtSybNHKpxw36ndMvg+gxQPuyTcfACbUkO8602VRzGaOpNti6
 scBXO9meO8BffUpACoY7VySaUrpdUa24JMDzzYLu5Ex8ejU6nisZ3eaSR
 3eYSZ9fYmUCTz4yUazMAL3dSNv8x5dAUhITqdr7kaSa8QFz0T8dJpUeS5 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="450972935"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="450972935"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2023 19:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="931550045"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="931550045"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 22 Oct 2023 19:27:08 -0700
Date: Mon, 23 Oct 2023 10:38:47 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v2 00/16] tests: Add CPU topology related smbios test cases
Message-ID: <ZTXctwEzz1x1mISS@intel.com>
References: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
 <20231022051905-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022051905-mutt-send-email-mst@kernel.org>
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 22, 2023 at 05:19:30AM -0400, Michael S. Tsirkin wrote:
> Date: Sun, 22 Oct 2023 05:19:30 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: Re: [PATCH v2 00/16] tests: Add CPU topology related smbios test
>  cases
> 
> On Thu, Sep 28, 2023 at 08:59:27PM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi all,
> > 
> > This patchset is the v2 which adds more description about the topology
> > selection under Igor's comments.
> 
> 
> I dropped this due to CI failures.

Will refresh a new version to fix that failure case.

Regards,
Zhao

> 
> > In this patchset, add these test cases:
> > 
> > 1. Add the case to test 2 newly added topology helpers (patch 1):
> >    * machine_topo_get_cores_per_socket()
> >    * machine_topo_get_threads_per_socket()
> > 
> > 2. Add the cases in bios-tables-test.c to:
> >    * test smbios type4 table count (patch 2-4).
> >    * test smbios type4 core count field (patch 5-7).
> >    * update the test of smbios type4 core count2 field (patch 8-10).
> >    * test smbios type4 thread count (patch 11-13).
> >    * test smbios type4 thread count2 (patch 14-16).
> > 
> > With the above new cases, cover all commits of [1] in test.
> > 
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04420.html
> > 
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html
> > 
> > Regards,
> > Zhao
> > ---
> > Zhao Liu (16):
> >   tests: test-smp-parse: Add the test for cores/threads per socket
> >     helpers
> >   tests: bios-tables-test: Prepare the ACPI table change for smbios
> >     type4 count test
> >   tests: bios-tables-test: Add test for smbios type4 count
> >   tests: bios-tables-test: Add ACPI table binaries for smbios type4
> >     count test
> >   tests: bios-tables-test: Prepare the ACPI table change for smbios
> >     type4 core count test
> >   tests: bios-tables-test: Add test for smbios type4 core count
> >   tests: bios-tables-test: Add ACPI table binaries for smbios type4 core
> >     count test
> >   tests: bios-tables-test: Prepare the ACPI table change for smbios
> >     type4 core count2 test
> >   tests: bios-tables-test: Extend smbios core count2 test to cover
> >     general topology
> >   tests: bios-tables-test: Update ACPI table binaries for smbios core
> >     count2 test
> >   tests: bios-tables-test: Prepare the ACPI table change for smbios
> >     type4 thread count test
> >   tests: bios-tables-test: Add test for smbios type4 thread count
> >   tests: bios-tables-test: Add ACPI table binaries for smbios type4
> >     thread count test
> >   tests: bios-tables-test: Prepare the ACPI table change for smbios
> >     type4 thread count2 test
> >   tests: bios-tables-test: Add test for smbios type4 thread count2
> >   tests: bios-tables-test: Add ACPI table binaries for smbios type4
> >     thread count2 test
> > 
> >  tests/data/acpi/q35/APIC.core-count    | Bin 0 -> 544 bytes
> >  tests/data/acpi/q35/APIC.core-count2   | Bin 2478 -> 3238 bytes
> >  tests/data/acpi/q35/APIC.thread-count  | Bin 0 -> 544 bytes
> >  tests/data/acpi/q35/APIC.thread-count2 | Bin 0 -> 7398 bytes
> >  tests/data/acpi/q35/APIC.type4-count   | Bin 0 -> 1072 bytes
> >  tests/data/acpi/q35/DSDT.core-count    | Bin 0 -> 12913 bytes
> >  tests/data/acpi/q35/DSDT.core-count2   | Bin 32495 -> 33770 bytes
> >  tests/data/acpi/q35/DSDT.thread-count  | Bin 0 -> 12913 bytes
> >  tests/data/acpi/q35/DSDT.thread-count2 | Bin 0 -> 63671 bytes
> >  tests/data/acpi/q35/DSDT.type4-count   | Bin 0 -> 18589 bytes
> >  tests/data/acpi/q35/FACP.core-count    | Bin 0 -> 244 bytes
> >  tests/data/acpi/q35/FACP.thread-count  | Bin 0 -> 244 bytes
> >  tests/data/acpi/q35/FACP.thread-count2 | Bin 0 -> 244 bytes
> >  tests/data/acpi/q35/FACP.type4-count   | Bin 0 -> 244 bytes
> >  tests/qtest/bios-tables-test.c         | 116 ++++++++++++++++++++++++-
> >  tests/unit/test-smp-parse.c            |  67 +++++++++++---
> >  16 files changed, 167 insertions(+), 16 deletions(-)
> >  create mode 100644 tests/data/acpi/q35/APIC.core-count
> >  create mode 100644 tests/data/acpi/q35/APIC.thread-count
> >  create mode 100644 tests/data/acpi/q35/APIC.thread-count2
> >  create mode 100644 tests/data/acpi/q35/APIC.type4-count
> >  create mode 100644 tests/data/acpi/q35/DSDT.core-count
> >  create mode 100644 tests/data/acpi/q35/DSDT.thread-count
> >  create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
> >  create mode 100644 tests/data/acpi/q35/DSDT.type4-count
> >  create mode 100644 tests/data/acpi/q35/FACP.core-count
> >  create mode 100644 tests/data/acpi/q35/FACP.thread-count
> >  create mode 100644 tests/data/acpi/q35/FACP.thread-count2
> >  create mode 100644 tests/data/acpi/q35/FACP.type4-count
> > 
> > -- 
> > 2.34.1
> 

