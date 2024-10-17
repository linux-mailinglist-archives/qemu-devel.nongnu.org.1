Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C69A2699
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 17:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SSO-0006SM-Ka; Thu, 17 Oct 2024 11:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1SSJ-0006Q6-4C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1SSE-00039m-KX
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729179020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=t1Xf++nCYGqvn/3bHmYFDtUgvJ4VAkFrA294hdhwlUo=;
 b=HvZj2vshIAS/qeRj6Xi7DQmDf2duD+sBaX5f79CRMFDb1XT0JaKAQpyqGtlkCd3NAXwIfB
 Aq5TLlySyG/wH4MlzxBH4h8vHqOdZEi5rIVtxQk5hIfMHnMbxI0Ch0+qUfJjvE9zuJCAd6
 EsWXWgPI7KU51isyU7OTnjrvriUtDLA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-84ov-eGgM-6A_V_UMaU9cw-1; Thu,
 17 Oct 2024 11:30:17 -0400
X-MC-Unique: 84ov-eGgM-6A_V_UMaU9cw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3453819560BA; Thu, 17 Oct 2024 15:30:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE6E519560A2; Thu, 17 Oct 2024 15:30:06 +0000 (UTC)
Date: Thu, 17 Oct 2024 16:30:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZxEte1KBwWuCdkb1@redhat.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-2-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241012104429.1048908-2-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, Oct 12, 2024 at 06:44:23PM +0800, Zhao Liu wrote:
> Cache topology needs to be defined based on CPU topology levels. Thus,
> define CPU topology enumeration in qapi/machine.json to make it generic
> for all architectures.
> 
> To match the general topology naming style, rename CPU_TOPO_LEVEL_* to
> CPU_TOPOLOGY_LEVEL_*, and rename SMT and package levels to thread and
> socket.
> 
> Also, enumerate additional topology levels for non-i386 arches, and add
> a CPU_TOPOLOGY_LEVEL_DEFAULT to help future smp-cache object to work
> with compatibility requirement of arch-specific cache topology models.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> ---
> Changes since Patch v2:
>  * Updated version of new QAPI structures to v9.2. (Jonathan)
> 
> Changes since Patch v1:
>  * Dropped prefix of CpuTopologyLevel enumeration. (Markus)
>  * Rename CPU_TOPO_LEVEL_* to CPU_TOPOLOGY_LEVEL_* to match the QAPI's
>    generated code. (Markus)
> 
> Changes since RFC v2:
>  * Dropped cpu-topology.h and cpu-topology.c since QAPI has the helper
>    (CpuTopologyLevel_str) to convert enum to string. (Markus)
>  * Fixed text format in machine.json (CpuTopologyLevel naming, 2 spaces
>    between sentences). (Markus)
>  * Added a new level "default" to de-compatibilize some arch-specific
>    topo settings. (Daniel)
>  * Moved CpuTopologyLevel to qapi/machine-common.json, at where the
>    cache enumeration and smp-cache object would be added.
>    - If smp-cache object is defined in qapi/machine.json, storage-daemon
>      will complain about the qmp cmds in qapi/machine.json during
>      compiling.
> 
> Changes since RFC v1:
>  * Used QAPI to enumerate CPU topology levels.
>  * Dropped string_to_cpu_topo() since QAPI will help to parse the topo
>    levels.
> ---
>  hw/i386/x86-common.c       |   4 +-
>  include/hw/i386/topology.h |  22 +-----
>  qapi/machine-common.json   |  46 +++++++++++-
>  target/i386/cpu.c          | 144 ++++++++++++++++++-------------------
>  target/i386/cpu.h          |   4 +-
>  5 files changed, 124 insertions(+), 96 deletions(-)
> 

> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index dff49fce1154..bf740383038b 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -39,7 +39,7 @@

>      unsigned threads_per_core;
>  } X86CPUTopoInfo;
>  
> -/*
> - * CPUTopoLevel is the general i386 topology hierarchical representation,
> - * ordered by increasing hierarchical relationship.
> - * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
> - * or AMD (CPUID[0x80000026]).
> - */
> -enum CPUTopoLevel {
> -    CPU_TOPO_LEVEL_INVALID,
> -    CPU_TOPO_LEVEL_SMT,
> -    CPU_TOPO_LEVEL_CORE,
> -    CPU_TOPO_LEVEL_MODULE,
> -    CPU_TOPO_LEVEL_DIE,
> -    CPU_TOPO_LEVEL_PACKAGE,
> -    CPU_TOPO_LEVEL_MAX,
> -};
> -

snip

> @@ -18,3 +18,47 @@
>  ##
>  { 'enum': 'S390CpuEntitlement',
>    'data': [ 'auto', 'low', 'medium', 'high' ] }
> +
> +##
> +# @CpuTopologyLevel:
> +#
> +# An enumeration of CPU topology levels.
> +#
> +# @invalid: Invalid topology level.

Previously all topology levels were internal to QEMU, and IIUC
this CPU_TOPO_LEVEL_INVALID appears to have been a special
value to indicate  the cache was absent ?

Now we're exposing this directly to the user as a settable
option. We need to explain what effect setting 'invalid'
has on the CPU cache config.

> +#
> +# @thread: thread level, which would also be called SMT level or
> +#     logical processor level.  The @threads option in
> +#     SMPConfiguration is used to configure the topology of this
> +#     level.
> +#
> +# @core: core level.  The @cores option in SMPConfiguration is used
> +#     to configure the topology of this level.
> +#
> +# @module: module level.  The @modules option in SMPConfiguration is
> +#     used to configure the topology of this level.
> +#
> +# @cluster: cluster level.  The @clusters option in SMPConfiguration
> +#     is used to configure the topology of this level.
> +#
> +# @die: die level.  The @dies option in SMPConfiguration is used to
> +#     configure the topology of this level.
> +#
> +# @socket: socket level, which would also be called package level.
> +#     The @sockets option in SMPConfiguration is used to configure
> +#     the topology of this level.
> +#
> +# @book: book level.  The @books option in SMPConfiguration is used
> +#     to configure the topology of this level.
> +#
> +# @drawer: drawer level.  The @drawers option in SMPConfiguration is
> +#     used to configure the topology of this level.
> +#
> +# @default: default level.  Some architectures will have default
> +#     topology settings (e.g., cache topology), and this special
> +#     level means following the architecture-specific settings.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


