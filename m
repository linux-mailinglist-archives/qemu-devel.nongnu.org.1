Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277D7A5A69
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUl5-0005C5-GL; Tue, 19 Sep 2023 03:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUl1-0005BW-2W
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:02:51 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUkx-0007xk-SY
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695106967; x=1726642967;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zJAH9Nj/KAeYwWtOJdbIYe0x+pT7Nd7iHiZO7s7FycA=;
 b=fHxyrFSaFUbZDXg5rYwfUjWT5Ozl58Os03nki+b8vyvvSjJuVzxk+ihO
 ArllUJK/dNQzwT5wKnIA5xxRLKRyFky6uN8p+D9vM2GwNARGJJFJqlBj/
 SW23MBtzeLjWN7K/ryNla3WcJX/+7ov1peDekvNlan1ixqwBEzC7j/r3g
 Aw5tkqR5dYC8SWKRFVmckEjVFNnb8TSeC0fqr7ICdWepBw/ZZmqvNmEsK
 zNznivjUzvSGM+UyEcO12HWXH53ZLxO46U80wZ479LsN2/7QkyzyAkrxF
 UTTxQfLnEWGuPnNNfnCZjXEd7LEtj0UQ02ec2F5SPPNwICHRzr3PB+KOh g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359269607"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="359269607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 00:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="919760347"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="919760347"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 19 Sep 2023 00:02:28 -0700
Date: Tue, 19 Sep 2023 15:13:32 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 12/16] tests: bios-tables-test: Add test for smbios type4
 thread count
Message-ID: <ZQlKHIVd5IzbdeR8@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-13-zhao1.liu@linux.intel.com>
 <20230915151902.12e4cf1b@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915151902.12e4cf1b@imammedo.users.ipa.redhat.com>
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

On Fri, Sep 15, 2023 at 03:19:02PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 15:19:02 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 12/16] tests: bios-tables-test: Add test for smbios
>  type4 thread count
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 25 Aug 2023 11:36:15 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> > type4").
> > 
> > Add this test to cover 2 cases:
> > 1. Test thread count field with multiple sockets and multiple dies to
> >    confirm this field could correctly calculate threads per sockets.
> > 
> > 2. Confirm that field calculation could correctly recognize the
> >    difference between "-smp maxcpus" and "-smp cpus".
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Thanks!

> 
> PS:
> add to commit message an explanation how -smp maps into
> smbios_thread_count

Ok.

-Zhao

> 
> > ---
> >  tests/qtest/bios-tables-test.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 8cba1d8126f2..26474d376633 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -95,6 +95,7 @@ typedef struct {
> >      uint16_t smbios_cpu_curr_speed;
> >      uint8_t smbios_core_count;
> >      uint16_t smbios_core_count2;
> > +    uint8_t smbios_thread_count;
> >      uint8_t *required_struct_types;
> >      int required_struct_types_len;
> >      int type4_count;
> > @@ -640,6 +641,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> >                              SmbiosEntryPointType ep_type)
> >  {
> >      uint8_t core_count, expected_core_count = data->smbios_core_count;
> > +    uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
> >      uint16_t speed, expected_speed[2];
> >      uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
> >      int offset[2];
> > @@ -663,6 +665,13 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> >          g_assert_cmpuint(core_count, ==, expected_core_count);
> >      }
> >  
> > +    thread_count = qtest_readb(data->qts,
> > +                       addr + offsetof(struct smbios_type_4, thread_count));
> > +
> > +    if (expected_thread_count) {
> > +        g_assert_cmpuint(thread_count, ==, expected_thread_count);
> > +    }
> > +
> >      if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> >          core_count2 = qtest_readw(data->qts,
> >                            addr + offsetof(struct smbios_type_4, core_count2));
> > @@ -1033,6 +1042,22 @@ static void test_acpi_q35_tcg_core_count2(void)
> >      free_test_data(&data);
> >  }
> >  
> > +static void test_acpi_q35_tcg_thread_count(void)
> > +{
> > +    test_data data = {
> > +        .machine = MACHINE_Q35,
> > +        .variant = ".thread-count",
> > +        .required_struct_types = base_required_struct_types,
> > +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> > +        .smbios_thread_count = 27,
> > +    };
> > +
> > +    test_acpi_one("-machine smbios-entry-point-type=64 "
> > +                  "-smp cpus=15,maxcpus=54,sockets=2,dies=3,cores=3,threads=3",
> > +                  &data);
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_tcg_bridge(void)
> >  {
> >      test_data data = {};
> > @@ -2189,6 +2214,8 @@ int main(int argc, char *argv[])
> >                                 test_acpi_q35_tcg_core_count);
> >                  qtest_add_func("acpi/q35/core-count2",
> >                                 test_acpi_q35_tcg_core_count2);
> > +                qtest_add_func("acpi/q35/thread-count",
> > +                               test_acpi_q35_tcg_thread_count);
> >              }
> >              qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> >  #ifdef CONFIG_POSIX
> 

