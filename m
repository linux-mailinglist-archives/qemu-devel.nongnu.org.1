Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 832DA7A5A92
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUsg-0000kh-Ku; Tue, 19 Sep 2023 03:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUse-0000cq-EZ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:10:44 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUsc-0001FG-Ia
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695107442; x=1726643442;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KeYq5AD76jOUIkgeV5EFUnARP8Uoss95X+qn8uwuH2Q=;
 b=lwPZPYVV5OdHlHoBvTEsoQh6s8tny1QdibRyRofkFylYOLa6hwBd0D/d
 o+LIz58JkvD7WA6OvzEMspyu0CDq8UkoFrSGfBTQsCLXq0JfPhlUZHXD6
 rHB7/wQGbWywjxxQZaSfdHe8Q4GVxWeo/Du24Un+BLgH4Cfx6GQN9Btcz
 QwAG5xlURlJePZs0JXzhX7PJA+ukmB2EE1Ysdpktf+UX9/G/9vWyA9hov
 h2utb4D0R34nNskl3cMB2SZi9OOQawyZMG4o2iSeBLzV6dmvzP8TkNEoy
 53ldKmpsHGEDLlsIOrfiiecg6iFOmHgzeDxtAZcOAoDDhYA/v06LHW56i Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359271301"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="359271301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 00:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889392329"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="889392329"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2023 00:09:51 -0700
Date: Tue, 19 Sep 2023 15:21:40 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 06/16] tests: bios-tables-test: Add test for smbios type4
 core count
Message-ID: <ZQlMBEI2svx2UOV+@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-7-zhao1.liu@linux.intel.com>
 <20230915150307.2934b0d4@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150307.2934b0d4@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.136;
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

On Fri, Sep 15, 2023 at 03:03:07PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 15:03:07 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 06/16] tests: bios-tables-test: Add test for smbios
>  type4 core count
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 25 Aug 2023 11:36:09 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > This tests the commit 196ea60a734c3 ("hw/smbios: Fix core count in
> > type4").
> > 
> > Test the core count field of type4 table for multiple sockets/dies case.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  tests/qtest/bios-tables-test.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 8679255449cf..a35c753a3a00 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -999,6 +999,23 @@ static void test_acpi_q35_tcg_type4_count(void)
> >      free_test_data(&data);
> >  }
> >  
> > +static void test_acpi_q35_tcg_core_count(void)
> > +{
> > +    test_data data = {
> > +        .machine = MACHINE_Q35,
> > +        .variant = ".core-count",
> > +        .required_struct_types = base_required_struct_types,
> > +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> > +        .smbios_core_count = 9,
> > +        .smbios_core_count2 = 9,
> > +    };
> > +
> > +    test_acpi_one("-machine smbios-entry-point-type=64 "
> > +                  "-smp 54,sockets=2,dies=3,cores=3,threads=3",
> 
> ditto as for 3/16
> It's not obvious why this topology is used and how it correlates to  smbios_core_*
> so describe setup in commit message

Ok. I'll.

Thanks,
Zhao

> 
> > +                  &data);
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_tcg_core_count2(void)
> >  {
> >      test_data data = {
> > @@ -2166,6 +2183,8 @@ int main(int argc, char *argv[])
> >                  qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
> >                  qtest_add_func("acpi/q35/type4-count",
> >                                 test_acpi_q35_tcg_type4_count);
> > +                qtest_add_func("acpi/q35/core-count",
> > +                               test_acpi_q35_tcg_core_count);
> >                  qtest_add_func("acpi/q35/core-count2",
> >                                 test_acpi_q35_tcg_core_count2);
> >              }
> 

