Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA70792141
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRwW-0005JR-In; Tue, 05 Sep 2023 05:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdRwU-0005J2-6W
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdRwR-0000yP-Cr
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693904506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1FkB6rypapvBafeGNSD8Lj0FpvgwAymBEwM3OGKb9E=;
 b=fqo7xj1eEpBzI1t5PErKDu3rdaujfxgMeTc88ewNgzDOOYbNoVwvPbyWlGd4UaOryncrpT
 L3hdmXk3gs4lBhhk2TYB9orfpWBnqeIE0RQxA8ESlA9eEvxtKu2Rzl/8XfY3rhNaikARbT
 OQitH4pKsO6KbcWKhBPWrZOyAc4qrW0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-G8pfmifNOgeBUdT_kHvWyA-1; Tue, 05 Sep 2023 05:01:45 -0400
X-MC-Unique: G8pfmifNOgeBUdT_kHvWyA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5cc3b512so1163773f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904504; x=1694509304;
 h=content-transfer-encoding:in-reply-to:subject:from:content-language
 :references:cc:to:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1FkB6rypapvBafeGNSD8Lj0FpvgwAymBEwM3OGKb9E=;
 b=cpIpdWWVsUtiv2uiyFXOREVoRtJmgZwuU88fzy25/qhDKHWGFuU0TaGnawx2qIM00P
 dNGIgj77/k8AdKg4Az78J2HJEuPb2ca79+FSRKIVi6GeGzp9pifObKLBu2TSrNW3p4Sn
 k+hDOh86/6t2zXxtE9ohAXYyzGTrPrQ7hX0M3B/pT9Gh8G+HkaeziatJhuOko1lVFXnn
 jpBjruiXk++NXKFWzC5k6PETZ5y9Jk1Vu+ALpXWovu55EcxeZogD5HSwQmRoGttvgRz/
 ZO5suw7TcdlPcZLQvPOFdpikgWV+rp8I3i5oxeO0N9qaTQlwzcNAHN4tDHftjZjOeS7m
 6Glw==
X-Gm-Message-State: AOJu0YwqGDSjuR8t1xiPu8fWecoX5oUsRRoPSz76ljPqXMHzooefWriI
 py9hpX0p4c251KvSjrrukm3TdM5uM+o8fSWHKAoWKrTGa1kUMGzFgUsnwchnrjn9WHFJdNFASmr
 q7kzLvLO+UWE3Pak=
X-Received: by 2002:a5d:6591:0:b0:317:70cb:4f58 with SMTP id
 q17-20020a5d6591000000b0031770cb4f58mr8741766wru.63.1693904503080; 
 Tue, 05 Sep 2023 02:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi/XtvY6mwXtFpftOi8McTjoWARE8JtVeCcUcKv3i7f8bZapjSAf5Oep72EznQcUK5ZuJDKQ==
X-Received: by 2002:a5d:6591:0:b0:317:70cb:4f58 with SMTP id
 q17-20020a5d6591000000b0031770cb4f58mr8741746wru.63.1693904502656; 
 Tue, 05 Sep 2023 02:01:42 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5d4e8d000000b0031c6cc74882sm16892432wru.107.2023.09.05.02.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:01:41 -0700 (PDT)
Message-ID: <f1cad011-bae0-c75f-1693-b971de938c55@redhat.com>
Date: Tue, 5 Sep 2023 11:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-2-nsg@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v22 01/20] CPU topology: extend with s390 specifics
In-Reply-To: <20230901155812.2696560-2-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/09/2023 17.57, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> S390 adds two new SMP levels, drawers and books to the CPU
> topology.
> S390 CPUs have specific topology features like dedication and
> entitlement. These indicate to the guest information on host
> vCPU scheduling and help the guest make better scheduling decisions.
> 
> Let us provide the SMP properties with books and drawers levels
> and S390 CPU with dedication and entitlement,
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   qapi/machine-common.json            | 21 +++++++++++++
>   qapi/machine.json                   | 21 ++++++++++---
>   include/hw/boards.h                 | 10 +++++-
>   include/hw/qdev-properties-system.h |  4 +++
>   target/s390x/cpu.h                  |  6 ++++
>   hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
>   hw/core/machine.c                   |  4 +++
>   hw/core/qdev-properties-system.c    | 13 ++++++++
>   hw/s390x/s390-virtio-ccw.c          |  2 ++
>   softmmu/vl.c                        |  6 ++++
>   target/s390x/cpu.c                  |  7 +++++
>   qapi/meson.build                    |  1 +
>   qemu-options.hx                     |  7 +++--
>   13 files changed, 136 insertions(+), 14 deletions(-)
>   create mode 100644 qapi/machine-common.json
> 
> diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> new file mode 100644
> index 0000000000..e40421bb37
> --- /dev/null
> +++ b/qapi/machine-common.json
> @@ -0,0 +1,21 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# = Machines S390 data types
> +##
> +
> +##
> +# @CpuS390Entitlement:
> +#
> +# An enumeration of cpu entitlements that can be assumed by a virtual
> +# S390 CPU
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'CpuS390Entitlement',
> +  'prefix': 'S390_CPU_ENTITLEMENT',
> +  'data': [ 'auto', 'low', 'medium', 'high' ] }
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a08b6576ca..54f99f4ac1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -9,6 +9,7 @@
>   ##
>   
>   { 'include': 'common.json' }
> +{ 'include': 'machine-common.json' }
>   
>   ##
>   # @SysEmuTarget:
> @@ -71,8 +72,8 @@
>   #
>   # @thread-id: ID of the underlying host thread
>   #
> -# @props: properties describing to which node/socket/core/thread
> -#     virtual CPU belongs to, provided if supported by board
> +# @props: properties describing to which node/drawer/book/socket/core/thread
> +#         virtual CPU belongs to, provided if supported by board

The QAPI docs recently switched to 4 spaces indentation, see commit 
08349786c8430 ... so please do not re-indent the second line here.

>   #
>   # @target: the QEMU system emulation target, which determines which
>   #     additional fields will be listed (since 3.0)
> @@ -901,7 +902,11 @@
>   #
>   # @node-id: NUMA node ID the CPU belongs to
>   #
> -# @socket-id: socket number within node/board the CPU belongs to
> +# @drawer-id: drawer number within node/board the CPU belongs to (since 8.2)
> +#
> +# @book-id: book number within drawer/node/board the CPU belongs to (since 8.2)
> +#
> +# @socket-id: socket number within book/node/board the CPU belongs to
>   #
>   # @die-id: die number within socket the CPU belongs to (since 4.1)
>   #
> @@ -912,7 +917,7 @@
>   #
>   # @thread-id: thread number within core the CPU belongs to
>   #
> -# Note: currently there are 6 properties that could be present but
> +# Note: currently there are 8 properties that could be present but
>   #     management should be prepared to pass through other properties
>   #     with device_add command to allow for future interface extension.
>   #     This also requires the filed names to be kept in sync with the
> @@ -922,6 +927,8 @@
>   ##
>   { 'struct': 'CpuInstanceProperties',
>     'data': { '*node-id': 'int',
> +            '*drawer-id': 'int',
> +            '*book-id': 'int',
>               '*socket-id': 'int',
>               '*die-id': 'int',
>               '*cluster-id': 'int',
> @@ -1480,6 +1487,10 @@
>   #
>   # @cpus: number of virtual CPUs in the virtual machine
>   #
> +# @drawers: number of drawers in the CPU topology (since 8.2)
> +#
> +# @books: number of books in the CPU topology (since 8.2)
> +#
>   # @sockets: number of sockets in the CPU topology
>   #
>   # @dies: number of dies per socket in the CPU topology
> @@ -1498,6 +1509,8 @@
>   ##
>   { 'struct': 'SMPConfiguration', 'data': {
>        '*cpus': 'int',
> +     '*drawers': 'int',
> +     '*books': 'int',
>        '*sockets': 'int',
>        '*dies': 'int',
>        '*clusters': 'int',
...
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 0f4d9b6f7a..25019c91ee 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -33,6 +33,14 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       GString *s = g_string_new(NULL);
>   
> +    if (mc->smp_props.drawers_supported) {
> +        g_string_append_printf(s, "drawers (%u) * ", ms->smp.drawers);
> +    }
> +
> +    if (mc->smp_props.books_supported) {
> +        g_string_append_printf(s, "books (%u) * ", ms->smp.books);
> +    }
> +
>       g_string_append_printf(s, "sockets (%u)", ms->smp.sockets);
>   
>       if (mc->smp_props.dies_supported) {
> @@ -75,6 +83,8 @@ void machine_parse_smp_config(MachineState *ms,
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       unsigned cpus    = config->has_cpus ? config->cpus : 0;
> +    unsigned drawers = config->has_drawers ? config->drawers : 0;
> +    unsigned books   = config->has_books ? config->books : 0;
>       unsigned sockets = config->has_sockets ? config->sockets : 0;
>       unsigned dies    = config->has_dies ? config->dies : 0;
>       unsigned clusters = config->has_clusters ? config->clusters : 0;
> @@ -87,6 +97,8 @@ void machine_parse_smp_config(MachineState *ms,
>        * explicit configuration like "cpus=0" is not allowed.
>        */
>       if ((config->has_cpus && config->cpus == 0) ||
> +        (config->has_drawers && config->drawers == 0) ||
> +        (config->has_books && config->books == 0) ||
>           (config->has_sockets && config->sockets == 0) ||
>           (config->has_dies && config->dies == 0) ||
>           (config->has_clusters && config->clusters == 0) ||
> @@ -113,6 +125,19 @@ void machine_parse_smp_config(MachineState *ms,
>       dies = dies > 0 ? dies : 1;
>       clusters = clusters > 0 ? clusters : 1;
>   
> +    if (!mc->smp_props.books_supported && books > 1) {
> +        error_setg(errp, "books not supported by this machine's CPU topology");
> +        return;
> +    }
> +    books = books > 0 ? books : 1;
> +
> +    if (!mc->smp_props.drawers_supported && drawers > 1) {
> +        error_setg(errp,
> +                   "drawers not supported by this machine's CPU topology");
> +        return;
> +    }
> +    drawers = drawers > 0 ? drawers : 1;
> +
>       /* compute missing values based on the provided ones */
>       if (cpus == 0 && maxcpus == 0) {
>           sockets = sockets > 0 ? sockets : 1;
> @@ -126,33 +151,41 @@ void machine_parse_smp_config(MachineState *ms,
>               if (sockets == 0) {
>                   cores = cores > 0 ? cores : 1;
>                   threads = threads > 0 ? threads : 1;
> -                sockets = maxcpus / (dies * clusters * cores * threads);
> +                sockets = maxcpus /
> +                          (drawers * books * dies * clusters * cores * threads);
>               } else if (cores == 0) {
>                   threads = threads > 0 ? threads : 1;
> -                cores = maxcpus / (sockets * dies * clusters * threads);
> +                cores = maxcpus /
> +                        (drawers * books * sockets * dies * clusters * threads);

Assuming that we forbid the drawers and books for older machine types, I 
think you could drop the above two changes. (But I also don't mind if you 
keep them)

>               }
>           } else {
>               /* prefer cores over sockets since 6.2 */
>               if (cores == 0) {
>                   sockets = sockets > 0 ? sockets : 1;
>                   threads = threads > 0 ? threads : 1;
> -                cores = maxcpus / (sockets * dies * clusters * threads);
> +                cores = maxcpus /
> +                        (drawers * books * sockets * dies * clusters * threads);
>               } else if (sockets == 0) {
>                   threads = threads > 0 ? threads : 1;
> -                sockets = maxcpus / (dies * clusters * cores * threads);
> +                sockets = maxcpus /
> +                          (drawers * books * dies * clusters * cores * threads);
>               }
>           }
>   
>           /* try to calculate omitted threads at last */
>           if (threads == 0) {
> -            threads = maxcpus / (sockets * dies * clusters * cores);
> +            threads = maxcpus /
> +                      (drawers * books * sockets * dies * clusters * cores);
>           }
>       }
>   
> -    maxcpus = maxcpus > 0 ? maxcpus : sockets * dies * clusters * cores * threads;
> +    maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
> +                                      clusters * cores * threads;
>       cpus = cpus > 0 ? cpus : maxcpus;
>   
>       ms->smp.cpus = cpus;
> +    ms->smp.drawers = drawers;
> +    ms->smp.books = books;
>       ms->smp.sockets = sockets;
>       ms->smp.dies = dies;
>       ms->smp.clusters = clusters;
> @@ -163,7 +196,8 @@ void machine_parse_smp_config(MachineState *ms,
>       mc->smp_props.has_clusters = config->has_clusters;
>   
>       /* sanity-check of the computed topology */
> -    if (sockets * dies * clusters * cores * threads != maxcpus) {
> +    if (drawers * books * sockets * dies * clusters * cores * threads !=
> +        maxcpus) {
>           g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
>           error_setg(errp, "Invalid CPU topology: "
>                      "product of the hierarchy must match maxcpus: "
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index da699cf4e1..363ddafc89 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -843,6 +843,8 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
>       MachineState *ms = MACHINE(obj);
>       SMPConfiguration *config = &(SMPConfiguration){
>           .has_cpus = true, .cpus = ms->smp.cpus,
> +        .has_drawers = true, .drawers = ms->smp.drawers,
> +        .has_books = true, .books = ms->smp.books,
>           .has_sockets = true, .sockets = ms->smp.sockets,
>           .has_dies = true, .dies = ms->smp.dies,
>           .has_clusters = true, .clusters = ms->smp.clusters,
> @@ -1108,6 +1110,8 @@ static void machine_initfn(Object *obj)
>       /* default to mc->default_cpus */
>       ms->smp.cpus = mc->default_cpus;
>       ms->smp.max_cpus = mc->default_cpus;
> +    ms->smp.drawers = 1;
> +    ms->smp.books = 1;
>       ms->smp.sockets = 1;
>       ms->smp.dies = 1;
>       ms->smp.clusters = 1;
...
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index bfcf64d007..3b34aa0e35 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -733,6 +733,8 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>       mc->no_sdcard = 1;
>       mc->max_cpus = S390_MAX_CPUS;
>       mc->has_hotpluggable_cpus = true;
> +    mc->smp_props.books_supported = true;
> +    mc->smp_props.drawers_supported = true;
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = s390_get_hotplug_handler;
>       mc->cpu_index_to_instance_props = s390_cpu_index_to_props;

I think we should forbid the books and drawers in older machine types to 
avoid problems with migrating such guests between older and newer QEMU versions.

So please add books_supported = false and drawers_supported = false to the 
ccw_machine_8_1_class_options() function.

  Thomas


