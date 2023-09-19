Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E783F7A5A68
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUja-0004LJ-CD; Tue, 19 Sep 2023 03:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUjX-0004L0-WF
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:01:20 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUjT-0007pw-JG
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695106875; x=1726642875;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sFfrX5EoXvwq3F37tidW5fx/H1YC9j3BQ9L0/O8ERPo=;
 b=XhLI/EQuLTv41Jub2jO2gA/uRopf4eAIKAs6rKMO6bEOx5FnkFQPQPs0
 u3ft+0tN7l6aXIC8AsWVsdtL9HlU/KzYs3NZ3jmgt+AysfFYziR/O+zeW
 +vL8/V39Rc9D9KDoJGB0s8LjhJ2galA6kM3ZABPKIW4pUXzUh7Ipt7fBI
 59Vndu1ZIOX35zaHcgwmQxrlGNEO3qrgHWdZAxD8MNnrHBLg0v2vlAfa+
 6Hfr9jGDWDL5Q5mJXFlDmmISJkCt9oQU21ppTQ0sTGevPAriA+2H5uvhd
 TRXrYsio3OjCdrT8vPpqaW9Slg9jLW6y7hv8rHvUPaGyuAGMbpvTHYqFH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466199311"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="466199311"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 00:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="993052472"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="993052472"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2023 00:01:09 -0700
Date: Tue, 19 Sep 2023 15:12:13 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 15/16] tests: bios-tables-test: Add test for smbios type4
 thread count2
Message-ID: <ZQlJzc5n+1V6YEDf@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-16-zhao1.liu@linux.intel.com>
 <20230915152907.4b6e63bc@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915152907.4b6e63bc@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.43;
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

Hi Igor,

On Fri, Sep 15, 2023 at 03:29:07PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 15:29:07 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 15/16] tests: bios-tables-test: Add test for smbios
>  type4 thread count2
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 25 Aug 2023 11:36:18 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> > type4").
> > 
> > Add this test to cover 2 cases:
> > 1. Test thread count2 field with multiple sockets and multiple dies to
> >    confirm this field could correctly calculate threads per sockets.
> > 
> > 2. Confirm that field calculation could correctly recognize the
> >    difference between "-smp maxcpus" and "-smp cpus".
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  tests/qtest/bios-tables-test.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 26474d376633..1b0c27e95d26 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -96,6 +96,7 @@ typedef struct {
> >      uint8_t smbios_core_count;
> >      uint16_t smbios_core_count2;
> >      uint8_t smbios_thread_count;
> > +    uint16_t smbios_thread_count2;
> >      uint8_t *required_struct_types;
> >      int required_struct_types_len;
> >      int type4_count;
> > @@ -644,6 +645,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> >      uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
> >      uint16_t speed, expected_speed[2];
> >      uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
> > +    uint16_t thread_count2, expected_thread_count2 = data->smbios_thread_count2;
> >      int offset[2];
> >      int i;
> >  
> > @@ -673,6 +675,8 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> >      }
> >  
> >      if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> > +        uint64_t thread_count2_addr;
> > +
> >          core_count2 = qtest_readw(data->qts,
> >                            addr + offsetof(struct smbios_type_4, core_count2));
> >  
> > @@ -680,6 +684,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> >          if (expected_core_count == 0xFF && expected_core_count2) {
> >              g_assert_cmpuint(core_count2, ==, expected_core_count2);
> >          }
> > +
> > +        thread_count2_addr = addr +
> > +                             offsetof(struct smbios_type_4, thread_count2);
> > +        thread_count2 = qtest_readw(data->qts, thread_count2_addr);
> 
> I'd mimic the same code style as used for core_count2 and avoid introducing an extra variable

I'm not sure about the style of this case, since the code line is still
too long, so which style should I pick? ;-)

thread_count2 = qtest_readw(data->qts,
                    addr + offsetof(struct smbios_type_4,
		                    thread_count2));

or,

thread_count2 = qtest_readw(data->qts,
                    addr + offsetof(struct smbios_type_4,
                    thread_count2));


> 
> > +
> > +        /* Thread Count has reached its limit, checking Thread Count 2 */
> > +        if (expected_thread_count == 0xFF && expected_thread_count2) {
> > +            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
> > +        }
> >      }
> >  }
> >  
> > @@ -1050,6 +1063,7 @@ static void test_acpi_q35_tcg_thread_count(void)
> >          .required_struct_types = base_required_struct_types,
> >          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> >          .smbios_thread_count = 27,
> > +        .smbios_thread_count2 = 27,
> >      };
> >  
> >      test_acpi_one("-machine smbios-entry-point-type=64 "
> > @@ -1058,6 +1072,23 @@ static void test_acpi_q35_tcg_thread_count(void)
> >      free_test_data(&data);
> >  }
> >  
> > +static void test_acpi_q35_tcg_thread_count2(void)
> > +{
> > +    test_data data = {
> > +        .machine = MACHINE_Q35,
> > +        .variant = ".thread-count2",
> > +        .required_struct_types = base_required_struct_types,
> > +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> > +        .smbios_thread_count = 0xFF,
> > +        .smbios_thread_count2 = 260,
> > +    };
> > +
> > +    test_acpi_one("-machine smbios-entry-point-type=64 "
> > +                  "-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2",
> > +                  &data);
> 
> explain in commit message why abive -smp == 

Ok, this is used to test if we could correctly distinguish smp.cpus and smp.maxcpus.

Thanks,
Zhao

>   > +        .smbios_thread_count = 0xFF,
>   > +        .smbios_thread_count2 = 260,
> 
> 
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_tcg_bridge(void)
> >  {
> >      test_data data = {};
> > @@ -2216,6 +2247,8 @@ int main(int argc, char *argv[])
> >                                 test_acpi_q35_tcg_core_count2);
> >                  qtest_add_func("acpi/q35/thread-count",
> >                                 test_acpi_q35_tcg_thread_count);
> > +                qtest_add_func("acpi/q35/thread-count2",
> > +                               test_acpi_q35_tcg_thread_count2);
> >              }
> >              qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> >  #ifdef CONFIG_POSIX
> 

