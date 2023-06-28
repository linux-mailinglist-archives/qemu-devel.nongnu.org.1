Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF817740815
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 04:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEKXN-00041c-NW; Tue, 27 Jun 2023 22:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEKXK-00041H-LC
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:04:02 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEKXH-00015E-PW
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687917839; x=1719453839;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nLuYKW3ITfnY44D6P3hPfsagfNW9bkO632gUq7sQ/rc=;
 b=QdQEp11jN9nQeVDvR3a9Zg0FhEH6i/8ncyhRLdvGNlzHYS+cAip0/fOA
 HaMfrZ8cLEj3hOcWLK/QErv0XkGQM9o+3MzjLIc3Xy/+01MY47YYTCPF3
 nbXS63OMSU86SVTAUTlpPDMpJnQ6N046gi5UGjPOZLXrlHN0wUEccMN0W
 3dWYM7z8fPy8mMNJvYTZ2FOLahAmbJ1/yZWI6jkrdFF6cD0djsC4XXg9w
 tbPwThEFjE+l35LpDJTcgIKoHZYAHA8xgrvAc4Zw2xKIBMFG9PmOZ2psm
 9TNJzj40hRHxgg1CIEne8+5acldGNpKzal9pJI01aLhBiksTT9YLF9GeT w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448111517"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="448111517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 19:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752030502"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="752030502"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 19:03:44 -0700
Date: Wed, 28 Jun 2023 10:13:42 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 3/4] hw/smbios: Fix thread count in type4
Message-ID: <ZJuXVvWZv+g2fPb+@liuzhao-OptiPlex-7080>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
 <20230620103958.3907565-4-zhao1.liu@linux.intel.com>
 <20230626154449.72874e21@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626154449.72874e21@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga05.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Mon, Jun 26, 2023 at 03:44:49PM +0200, Igor Mammedov wrote:
> Date: Mon, 26 Jun 2023 15:44:49 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v3 3/4] hw/smbios: Fix thread count in type4
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Tue, 20 Jun 2023 18:39:57 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > From SMBIOS 3.0 specification, thread count field means:
> > 
> > Thread Count is the total number of threads detected by the BIOS for
> > this processor socket. It is a processor-wide count, not a
> > thread-per-core count. [1]
> > 
> > So here we should use threads per socket other than threads per core.
> > 
> > [1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count
> > 
> > Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > v3:
> >  * Use the wrapped hepler to get threads per socket.
> > 
> > v2:
> >  * Rename cpus_per_socket to threads_per_socket.
> >  * Add the comment about smp.max_cpus. Thread count and core count will
> >    be calculated in 2 ways and will add a sanity check to ensure we
> >    don't miss any topology level.
> > ---
> >  hw/smbios/smbios.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index d67415d44dd8..3aae9328c014 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >  {
> >      char sock_str[128];
> >      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> > +    unsigned threads_per_socket;
> >  
> >      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> >          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > @@ -747,17 +748,19 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
> >      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
> >  
> > +    threads_per_socket = machine_topo_get_threads_per_socket(ms);
>                                 ^^^^
> Are there any other places we can clean up and reuse this wrapper?

Yes, in the struct CPUState of include/hw/core/cpu.h, the "nr_cores"
need this helper to wrap the calculation. Also there are scenarios in
the i386 CPUID emulation/MSR_CORE_THREAD_COUNT related things that
require these information.

I have another patchset that contains the related fixes/changes [1].
To avoid conflicts, I thought I would follow up and use our newly
added helper after that patchset has been fully received.

Add WHPX also need cores per socket, but I've used another way to fix
[2].

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07179.html
[2]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07196.html

- Zhao

> 
> > +
> >      t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> >      t->core_enabled = t->core_count;
> >  
> > -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> > +    t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
> >  
> >      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
> >      t->processor_family2 = cpu_to_le16(0x01); /* Other */
> >  
> >      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> >          t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> > +        t->thread_count2 = cpu_to_le16(threads_per_socket);
> >      }
> >  
> >      SMBIOS_BUILD_TABLE_POST;
> 

