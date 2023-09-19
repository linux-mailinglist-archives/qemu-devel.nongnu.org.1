Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC57A5A6C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUlI-0005Hh-LS; Tue, 19 Sep 2023 03:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUlG-0005Gv-Cq
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:03:06 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUlE-00080Y-DN
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695106984; x=1726642984;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qwaXPcl2fhAYl2ToP9/WvlJYQURfqkI1XI6Xtwhze6o=;
 b=kuEqXBUFdzTsa9b1ItTrog0TYKo1+DOL8SnjcTwQFCk1AVRFm2gaOY7w
 0ZYgntPbxns/wyIK9huc2cYanuF9TWbeZSQSZnhHGdJHitFQlvIDRtTYR
 F+jY5++hyJJpItVPniFkoSPGSox9LcpBVQU5Czh06U3Hs0ZIvuzl2rJNe
 WeCCWb+emz3tAAF/JWPYfPOab9ReRTsCimrrpsM2jJSwPSt7z7J+fK0EP
 Lrysq4Lsrc+D3MeSKlPcXbIe9IdT3vNxauurXHWm/nnLPZDf9glHnk+2w
 CZ7lVg4lNrsEQo04jgQ97FnAwEISeHKdmQeCEFFW87KRiFNpcEo0T+XdJ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359269770"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="359269770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 00:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889390786"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="889390786"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2023 00:02:14 -0700
Date: Tue, 19 Sep 2023 15:14:04 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 09/16] tests: bios-tables-test: Extend core count2 test
 to cover general topology
Message-ID: <ZQlKPK9u0aE31Aey@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-10-zhao1.liu@linux.intel.com>
 <20230915151157.41e85004@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915151157.41e85004@imammedo.users.ipa.redhat.com>
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

On Fri, Sep 15, 2023 at 03:11:57PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 15:11:57 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 09/16] tests: bios-tables-test: Extend core count2 test
>  to cover general topology
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 25 Aug 2023 11:36:12 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Currently, this case just covers the topology with only core and smt
> > levels, and doesn't consider more topology layers between socket and
> > core.
> > 
> > To cover the fixed case in the commit 196ea60a734c3 ("hw/smbios: Fix
> > core count in type4"), add the "die" level in "-smp" as the more
> > general topology case.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Thanks!

> 
> PS:
> I'd still explain in commit message relations between
> -smp and .smbios_core_count2

Ok.

-Zhao

> 
> > ---
> >  tests/qtest/bios-tables-test.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index a35c753a3a00..8cba1d8126f2 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -1024,10 +1024,12 @@ static void test_acpi_q35_tcg_core_count2(void)
> >          .required_struct_types = base_required_struct_types,
> >          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> >          .smbios_core_count = 0xFF,
> > -        .smbios_core_count2 = 275,
> > +        .smbios_core_count2 = 260,
> >      };
> >  
> > -    test_acpi_one("-machine smbios-entry-point-type=64 -smp 275", &data);
> > +    test_acpi_one("-machine smbios-entry-point-type=64 "
> > +                  "-smp 260,dies=2,cores=130,threads=1",
> > +                  &data);
> >      free_test_data(&data);
> >  }
> >  
> 

