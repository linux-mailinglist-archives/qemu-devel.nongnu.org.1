Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E614F7D287D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 04:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qukdA-0004rY-Js; Sun, 22 Oct 2023 22:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qukd6-0004rO-6S
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:25:20 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qukd3-0002ve-KM
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698027917; x=1729563917;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k6G/hBw6NSgNoNteehGWLaMc8qX0Pvgn0GWBRb14L4M=;
 b=TN5KGWqPTYEIbyfsDkKIrwIYMuE9tZUi0QSVZlKuvF1X6ABn78IIFkd9
 xjCS1tHF+5xbIjv3NEuaBynRfvDsb36KSIseqiXnNn3ESpwzD4L9SCD0E
 lpgQyThqVmdOj+HKyvUUWOAOH6jwzud8O9Hr8MQ6jm5cnAstLsnFuyVAN
 Vn8jAMwX6YDeIv0+R5yukPzCnquIn6S5iEun7p5EB8/utFE3K5DTqsaMP
 fKNDduRjJOxsEUqm9HYB5hmpL6e3152S61l0iTBpBR8lE0xRAi+Kbts6V
 haY5vSWO9bJeTe1XF+/5XpHhT1v+/N7+YogND4bmnG9glSOTPmi4mXy7l A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="390639111"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="390639111"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2023 19:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="931549619"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="931549619"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 22 Oct 2023 19:25:06 -0700
Date: Mon, 23 Oct 2023 10:36:45 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v2 15/16] tests: bios-tables-test: Add test for smbios
 type4 thread count2
Message-ID: <ZTXcPT5mvqvHZzN8@intel.com>
References: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
 <20230928125943.1816922-16-zhao1.liu@linux.intel.com>
 <20231022051520-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022051520-mutt-send-email-mst@kernel.org>
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Hi Michael,

On Sun, Oct 22, 2023 at 05:17:29AM -0400, Michael S. Tsirkin wrote:
> Date: Sun, 22 Oct 2023 05:17:29 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: Re: [PATCH v2 15/16] tests: bios-tables-test: Add test for smbios
>  type4 thread count2
> 
> On Thu, Sep 28, 2023 at 08:59:42PM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> > type4").
> > 
> > In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
> > threads in the socket is more than 255, then smbios type4 table encodes
> > threads per socket into the thread count2 field.
> > 
> > So for the topology in this case, there're the following considerations:
> > 1. threads per socket should be more than 255 to ensure we could cover
> >    the thread count2 field.
> > 2. The original bug was that threads per socket was miscalculated, so
> >    now we should configure as many topology levels as possible (mutiple
> >    sockets & dies, no module since x86 hasn't supported it) to cover
> >    more general topology scenarios, to ensure that the threads per
> >    socket encoded in the thread count2 field is correct.
> > 3. For the more general topology, we should also add "cpus" (presented
> >    threads for machine) and "maxcpus" (total threads for machine) to
> >    make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
> >    does not affect the correctness of threads per socket for thread
> >    count2 field.
> > 
> > Based on these considerations, select the topology as the follow:
> > 
> > -smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2
> > 
> > The expected thread count2 = threads per socket = threads (2)
> > * cores (65) * dies (2) = 260.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> There's a problem here: not all hosts support such high
> number of vCPUs.
> Number of hotpluggable cpus requested (520) exceeds the maximum cpus
> supported by KVM (288)
> socket_accept failed: Resource temporarily unavailable
> **
> 
> Dropped for now pls come up with a solution.

I'll drop multiple sockets/dies for this case.
The previsou thread count test has already covered the complex topology
level case so that for thread count2 we can not configure so many
sockets/dies, just check that there are more than 255 threads in a
socket.

I'll refresh a new version.

Regards,
Zhao

> 
> 
> > ---
> > Changes since v1:
> >  * Dropped the extra variable: uint64_t thread_count2_addr. (Igor)
> >  * Added description of the consideration for topology selection of this
> >    case in commit message. (Igor)
> > ---
> >  tests/qtest/bios-tables-test.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index f8e3e349e09f..58119d8979c6 100644
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
> > @@ -680,6 +682,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> >          if (expected_core_count == 0xFF && expected_core_count2) {
> >              g_assert_cmpuint(core_count2, ==, expected_core_count2);
> >          }
> > +
> > +        thread_count2 = qtest_readw(data->qts,
> > +                            addr + offsetof(struct smbios_type_4,
> > +                            thread_count2));
> > +
> > +        /* Thread Count has reached its limit, checking Thread Count 2 */
> > +        if (expected_thread_count == 0xFF && expected_thread_count2) {
> > +            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
> > +        }
> >      }
> >  }
> >  
> > @@ -1050,6 +1061,7 @@ static void test_acpi_q35_tcg_thread_count(void)
> >          .required_struct_types = base_required_struct_types,
> >          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> >          .smbios_thread_count = 27,
> > +        .smbios_thread_count2 = 27,
> >      };
> >  
> >      test_acpi_one("-machine smbios-entry-point-type=64 "
> > @@ -1058,6 +1070,23 @@ static void test_acpi_q35_tcg_thread_count(void)
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
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_tcg_bridge(void)
> >  {
> >      test_data data = {};
> > @@ -2216,6 +2245,8 @@ int main(int argc, char *argv[])
> >                                 test_acpi_q35_tcg_core_count2);
> >                  qtest_add_func("acpi/q35/thread-count",
> >                                 test_acpi_q35_tcg_thread_count);
> > +                qtest_add_func("acpi/q35/thread-count2",
> > +                               test_acpi_q35_tcg_thread_count2);
> >              }
> >              if (qtest_has_device("virtio-iommu-pci")) {
> >                  qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> > -- 
> > 2.34.1
> 

