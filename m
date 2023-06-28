Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A628740818
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 04:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEKdS-0005A4-WD; Tue, 27 Jun 2023 22:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEKdM-00059n-HQ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:10:17 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEKdK-0003Pt-2m
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687918214; x=1719454214;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WMFBzsM30QFcx39XYY10y+M6enHa3PfonqH7FN32sro=;
 b=F2Oqjz8gTdwADkHdBfV2VAhTKLTXz8RC5WOTeIuYQ4Q/DgooJtf4B6E/
 gqgjgGclGIHD4KIyHIFJcft8ZkoULp3H3hcNBUNE7sCmueKNUqxgMc1mU
 /VOttFEF/mIGqOW1RrAKgyclKguhHLdjceijJa1oODdXehLcNDU4nN3Ju
 njbWPRFhGvyJLZipJdkRdDlGRNSTuURhwahZSIEUpvgtSdvZV2BfHaU2w
 JA6pncpqNZb7+Mktp70zJSbQd8nU/rmH8yh1oZTIjH24YcaGmYJgWUPa6
 k1GTWqF1c1uZju5VoicLlKfU63WytYrU9n8DbUGmPINsgkqaj+YAmbJ9A g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361770943"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="361770943"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 19:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694108461"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="694108461"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 19:10:07 -0700
Date: Wed, 28 Jun 2023 10:20:05 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/4] machine: Add helpers to get cores/threads per
 socket
Message-ID: <ZJuY1SXS7kX6BnA/@liuzhao-OptiPlex-7080>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
 <20230620103958.3907565-2-zhao1.liu@linux.intel.com>
 <20230626154325.28697e88@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626154325.28697e88@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga14.intel.com
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

On Mon, Jun 26, 2023 at 03:43:25PM +0200, Igor Mammedov wrote:
> Date: Mon, 26 Jun 2023 15:43:25 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v3 1/4] machine: Add helpers to get cores/threads per
>  socket
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Tue, 20 Jun 2023 18:39:55 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The number of cores/threads per socket are needed for smbios, and are
> > also useful for other modules.
> > 
> > Provide the helpers to wrap the calculation of cores/threads per socket
> > so that we can avoid calculation errors caused by other modules miss
> > topology changes.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > v3:
> >  * The new patch to wrap the calculation of cores/threads per socket.
> > ---
> >  include/hw/boards.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index a385010909d5..40ee22fd93e3 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -384,6 +384,18 @@ struct MachineState {
> >      } \
> >      type_init(machine_initfn##_register_types)
> >  
> > +static inline
> > +unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
> > +{
> > +    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
> > +}
> > +
> > +static inline
> > +unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
> > +{
> > +    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
> > +}
> 
> I'd put those before/after machine_parse_smp_config
> , just declarations.
> 
> And put definitions into hw/core/machine-smp.c again close to machine_parse_smp_config

Okay, thanks!

> 
> > +
> >  extern GlobalProperty hw_compat_8_0[];
> >  extern const size_t hw_compat_8_0_len;
> >  
> 

