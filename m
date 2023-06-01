Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4721F71907A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4XsN-0002tY-Mx; Wed, 31 May 2023 22:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4XsJ-0002px-L5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:17:15 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4XsH-000735-9z
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685585833; x=1717121833;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Dn3xDvHM6pmDpS85vpHKR5TlpNCGbhWu7rq7rCbdbHU=;
 b=ZJUTME88vhHCvRTh21dlq9AmgMME8Yl+BD8kgEQsL62cHMDwp3suUclo
 y73MpWYbCXIOeNHDqlte+sd/0nalJIlwd9qECy0R3vRnIdhruJ0upkoFE
 3HjeLCGdVdQv+DoMsbJNmXdpYoKMA6XywX5YI3UdFBEk9+0X4wQFfK5Pn
 bVApdNRdjK7xyNK+n9SfH1cJXxzNkXHOu+zvmG9rviLMsIO3wtRIlD6ED
 i+9mkaM1lEOc3q+KKLS979g2ZXqdkiGO+UX/zgUA+shEIZNvwcBv7VSyK
 xAdR81fNaWPgdkqJn+xCScQEeEraOwNd+apr6u/jfyBDDVbK5aaRlU/H4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="441785837"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="441785837"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 19:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="707133839"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="707133839"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga002.jf.intel.com with ESMTP; 31 May 2023 19:17:07 -0700
Date: Thu, 1 Jun 2023 10:26:40 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "bibo, mao" <maobibo@loongson.cn>
Cc: Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, gaosong@loongson.cn,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH] hw/smbios: fix thead count field in type 4 table
Message-ID: <ZHgB4DVk0pIEzuIS@liuzhao-OptiPlex-7080>
References: <20230530122034.547109-1-zhaotianrui@loongson.cn>
 <ZHcIcaQIlnQVsmbP@liuzhao-OptiPlex-7080>
 <9d514025-2b95-03c2-5391-662c392fe185@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d514025-2b95-03c2-5391-662c392fe185@loongson.cn>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga05.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 01, 2023 at 09:09:13AM +0800, bibo, mao wrote:
> Date: Thu, 1 Jun 2023 09:09:13 +0800
> From: "bibo, mao" <maobibo@loongson.cn>
> Subject: Re: [PATCH] hw/smbios: fix thead count field in type 4 table
> 
> 
> 
> ÔÚ 2023/5/31 16:42, Zhao Liu Ð´µÀ:
> > On Tue, May 30, 2023 at 08:20:34PM +0800, Tianrui Zhao wrote:
> > > Date: Tue, 30 May 2023 20:20:34 +0800
> > > From: Tianrui Zhao <zhaotianrui@loongson.cn>
> > > Subject: [PATCH] hw/smbios: fix thead count field in type 4 table
> > > X-Mailer: git-send-email 2.39.1
> > > 
> > > The thread_count value in smbios type_4 table should be
> > > (ms->smp.cores * ms->smp.threads). As according to smbios spec 7.5
> > > Processor Information (Type 4), the field "Thread Count" means the
> > > "Number of threads per processor socket" rather than number of
> > > threads per core.
> > > 
> > > When apply this patch, use "-smp 4,sockets=1,cores=2,threads=2" to
> > > boot VM, the dmidecode -t 4 shows like:
> > > 
> > > Handle 0x0400, DMI type 4, 48 bytes
> > > Processor Information
> > >          Socket Designation: CPU 0
> > >          ...
> > >          Core Count: 2
> > >          Core Enabled: 2
> > >          Thread Count: 4
> > >          Characteristics: None
> > > 
> > > Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> > > ---
> > >   hw/smbios/smbios.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > > index d2007e70fb..56aeaa069d 100644
> > > --- a/hw/smbios/smbios.c
> > > +++ b/hw/smbios/smbios.c
> > > @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> > >   {
> > >       char sock_str[128];
> > >       size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> > > +    int count;
> > >       if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> > >           tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > > @@ -749,15 +750,15 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> > >       t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> > >       t->core_enabled = t->core_count;
> > > -
> > > -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> > > +    count = ms->smp.cores * ms->smp.threads;
> > 
> > Hi Ani & Tianrui,
> > 
> >  From the comment of CpuTopology (include/hw/boards.h):
> > 
> > ms->cores means the "the number of cores in one cluster".
> > ms->threads means the "the number of threads in one core".
> > 
> > So ms->cores * ms->threads means the number of threads in one cluster
> > not one socket.
> > 
> > That's why I count the number of threads in a socket by "ms->smp.max_cpus
> > / ms->smp.sockets" in [1].
> > 
> > The other correct way is:
> > ms->smp.cluster * ms->smp.cores * ms->smp.threads.
> > 
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07229.html
> ohh, we do not notice your patch. Your patch is better than us. one small
> nit about core_count calcuation if cluster/die is support. core count should
> be core number
>  per package rather than per cluster or per die.
> 
> so it should be something like this?
>     t->core_count = cpus_per_socket / ms->smp.threads
> rather than ms->smp.cores

Yes, I also fixed this in the third patch of my patch series [2].

[2]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07231.html

Regards,
Zhao

> 
> 
> Regards
> Bibo, mao
> > 
> > Thanks,
> > Zhao
> > 
> > > +    t->thread_count = (count > 255) ? 0xFF : count;
> > >       t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
> > >       t->processor_family2 = cpu_to_le16(0x01); /* Other */
> > >       if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> > >           t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > > -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> > > +        t->thread_count2 = cpu_to_le16(count);
> > >       }
> > >       SMBIOS_BUILD_TABLE_POST;
> > > -- 
> > > 2.39.1
> > > 
> > > 
> 
> 

