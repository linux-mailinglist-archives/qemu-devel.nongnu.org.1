Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC887A5A8A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUp9-000743-OC; Tue, 19 Sep 2023 03:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUp7-00073Q-7m
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:07:05 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUp5-0000QG-Cx
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695107223; x=1726643223;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QU54Nv9nQKFg1XXOsfjE2pPKOmovSMtVpSBNzftMR6s=;
 b=fmTJyPyTxAKrAK18UB1YtqG398ijhbXSe7EslMZxMTyA5g3PUW/MNVdV
 XBZzH7HPtVsSgHrzPhdI4RXwo26CbmArjCYcCsWW8bmCTVML3ksvnaeiu
 l+onqGp/oBFnCdv2ErJhvVAACkY0l7RDTKchTtJoUXy9ZrLy7YJAxwjSi
 vhIvMGBZfugfVGVnv7YdRTu8rXEiZZ4yvat1w2f+0ChheCTtl1TEWDdXa
 4BVb9nzPVvpAKNwlx/2bFzStHjxhLXXXEBqYgOB1exG4qUaMYSJVk19Ur
 kuL+1cEGbOAdhUXHPmZxQ1xKxyqPoioa/O+GrTuihf0LWGwkNAD9ApVaN Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446344833"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="446344833"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 00:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="781198267"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="781198267"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 19 Sep 2023 00:06:57 -0700
Date: Tue, 19 Sep 2023 15:18:02 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 01/16] tests: test-smp-parse: Add the test for
 cores/threads per socket helpers
Message-ID: <ZQlLKtN6/UdbMfm4@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-2-zhao1.liu@linux.intel.com>
 <20230915143138.7244c37a@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915143138.7244c37a@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=134.134.136.100;
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

On Fri, Sep 15, 2023 at 02:31:38PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 14:31:38 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 01/16] tests: test-smp-parse: Add the test for
>  cores/threads per socket helpers
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 25 Aug 2023 11:36:04 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Use the different ways to calculate cores/threads per socket, so that
> > the new CPU topology levels won't be missed in these 2 helpes:
> > 
> > * machine_topo_get_cores_per_socket()
> > * machine_topo_get_threads_per_socket()
> > 
> > Test the commit a1d027be95bc3 ("machine: Add helpers to get cores/
> > threads per socket").
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Thanks!

-Zhao

> 
> > ---
> >  tests/unit/test-smp-parse.c | 67 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 54 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> > index fdc39a846ca6..24972666a74d 100644
> > --- a/tests/unit/test-smp-parse.c
> > +++ b/tests/unit/test-smp-parse.c
> > @@ -394,20 +394,47 @@ static char *smp_config_to_string(const SMPConfiguration *config)
> >          config->has_maxcpus ? "true" : "false", config->maxcpus);
> >  }
> >  
> > -static char *cpu_topology_to_string(const CpuTopology *topo)
> > +/* Use the different calculation than machine_topo_get_threads_per_socket(). */
> > +static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
> > +{
> > +    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
> > +    if (!topo->sockets) {
> > +        return 0;
> > +    } else {
> > +        return topo->max_cpus / topo->sockets;
> > +    }
> > +}
> > +
> > +/* Use the different calculation than machine_topo_get_cores_per_socket(). */
> > +static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
> > +{
> > +    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
> > +    if (!topo->threads) {
> > +        return 0;
> > +    } else {
> > +        return cpu_topology_get_threads_per_socket(topo) / topo->threads;
> > +    }
> > +}
> > +
> > +static char *cpu_topology_to_string(const CpuTopology *topo,
> > +                                    unsigned int threads_per_socket,
> > +                                    unsigned int cores_per_socket)
> >  {
> >      return g_strdup_printf(
> >          "(CpuTopology) {\n"
> > -        "    .cpus     = %u,\n"
> > -        "    .sockets  = %u,\n"
> > -        "    .dies     = %u,\n"
> > -        "    .clusters = %u,\n"
> > -        "    .cores    = %u,\n"
> > -        "    .threads  = %u,\n"
> > -        "    .max_cpus = %u,\n"
> > +        "    .cpus               = %u,\n"
> > +        "    .sockets            = %u,\n"
> > +        "    .dies               = %u,\n"
> > +        "    .clusters           = %u,\n"
> > +        "    .cores              = %u,\n"
> > +        "    .threads            = %u,\n"
> > +        "    .max_cpus           = %u,\n"
> > +        "    .threads_per_socket = %u,\n"
> > +        "    .cores_per_socket   = %u,\n"
> >          "}",
> >          topo->cpus, topo->sockets, topo->dies, topo->clusters,
> > -        topo->cores, topo->threads, topo->max_cpus);
> > +        topo->cores, topo->threads, topo->max_cpus,
> > +        threads_per_socket, cores_per_socket);
> >  }
> >  
> >  static void check_parse(MachineState *ms, const SMPConfiguration *config,
> > @@ -415,14 +442,26 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
> >                          bool is_valid)
> >  {
> >      g_autofree char *config_str = smp_config_to_string(config);
> > -    g_autofree char *expect_topo_str = cpu_topology_to_string(expect_topo);
> > -    g_autofree char *output_topo_str = NULL;
> > +    g_autofree char *expect_topo_str = NULL, *output_topo_str = NULL;
> > +    unsigned int expect_threads_per_socket, expect_cores_per_socket;
> > +    unsigned int ms_threads_per_socket, ms_cores_per_socket;
> >      Error *err = NULL;
> >  
> > +    expect_threads_per_socket =
> > +                        cpu_topology_get_threads_per_socket(expect_topo);
> > +    expect_cores_per_socket =
> > +                        cpu_topology_get_cores_per_socket(expect_topo);
> > +    expect_topo_str = cpu_topology_to_string(expect_topo,
> > +                                             expect_threads_per_socket,
> > +                                             expect_cores_per_socket);
> > +
> >      /* call the generic parser */
> >      machine_parse_smp_config(ms, config, &err);
> >  
> > -    output_topo_str = cpu_topology_to_string(&ms->smp);
> > +    ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
> > +    ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
> > +    output_topo_str = cpu_topology_to_string(&ms->smp, ms_threads_per_socket,
> > +                                             ms_cores_per_socket);
> >  
> >      /* when the configuration is supposed to be valid */
> >      if (is_valid) {
> > @@ -433,7 +472,9 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
> >              (ms->smp.clusters == expect_topo->clusters) &&
> >              (ms->smp.cores == expect_topo->cores) &&
> >              (ms->smp.threads == expect_topo->threads) &&
> > -            (ms->smp.max_cpus == expect_topo->max_cpus)) {
> > +            (ms->smp.max_cpus == expect_topo->max_cpus) &&
> > +            (ms_threads_per_socket == expect_threads_per_socket) &&
> > +            (ms_cores_per_socket == expect_cores_per_socket)) {
> >              return;
> >          }
> >  
> 

