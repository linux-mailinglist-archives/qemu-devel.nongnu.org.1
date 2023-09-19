Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B07A639D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qia8e-0006L0-K4; Tue, 19 Sep 2023 08:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qia8W-0006Ge-Ou
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qia8U-0003g4-2d
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695127645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X06RByraQIvFTGqn7XZkIYlw1MEvKCP0Sd/rnRqXDhY=;
 b=VveQ6xa40woItrcSOpLrw1hkL6jeglWlYns3mPFTAjZPrv0AfJlGgHTEwIZzgxcf+JVBwm
 RJg+b2obOrpeXPbfB9zbisEseS994vrvZvpe01zCeeuO3K7yBW5+wb2hyuWpcXqhbPQAkJ
 WvKOrS7D+tp0/DNMvu4/VWOmCCi+G+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-q-jh00pnPQez2Z9sZaFm5A-1; Tue, 19 Sep 2023 08:47:21 -0400
X-MC-Unique: q-jh00pnPQez2Z9sZaFm5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E01A811E86;
 Tue, 19 Sep 2023 12:47:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB0E401025;
 Tue, 19 Sep 2023 12:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 882E021E6900; Tue, 19 Sep 2023 14:47:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Thomas
 Huth <thuth@redhat.com>,  Eric Blake <eblake@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Cleber Rosa
 <crosa@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v23 01/20] CPU topology: extend with s390 specifics
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com>
Date: Tue, 19 Sep 2023 14:47:18 +0200
In-Reply-To: <20230914120650.1318932-2-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 14 Sep 2023 14:06:31 +0200")
Message-ID: <87ediuwcrt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:

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
>  qapi/machine-common.json            | 21 +++++++++++++
>  qapi/machine.json                   | 19 ++++++++++--
>  include/hw/boards.h                 | 10 +++++-
>  include/hw/qdev-properties-system.h |  4 +++
>  target/s390x/cpu.h                  |  6 ++++
>  hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
>  hw/core/machine.c                   |  4 +++
>  hw/core/qdev-properties-system.c    | 13 ++++++++
>  hw/s390x/s390-virtio-ccw.c          |  4 +++
>  softmmu/vl.c                        |  6 ++++
>  target/s390x/cpu.c                  |  7 +++++
>  qapi/meson.build                    |  1 +
>  qemu-options.hx                     |  7 +++--
>  13 files changed, 137 insertions(+), 13 deletions(-)
>  create mode 100644 qapi/machine-common.json
>
> diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> new file mode 100644
> index 0000000000..e40421bb37
> --- /dev/null
> +++ b/qapi/machine-common.json

Why do you need a separate QAPI sub-module?

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
> index a08b6576ca..a63cb951d2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -9,6 +9,7 @@
   ##
   # = Machines
>  ##
>  
>  { 'include': 'common.json' }
> +{ 'include': 'machine-common.json' }

Section structure is borked :)

Existing section "Machine" now ends at the new "Machines S390 data
types" you pull in here.  The contents of below moves from "Machines" to
"Machines S390 data types".

Before I explain how to avoid this, I'd like to understand why we need a
new sub-module.

>  
>  ##
>  # @SysEmuTarget:
> @@ -71,7 +72,7 @@
   ##
   # @CpuInfoFast:
   #
   # Information about a virtual CPU
   #
   # @cpu-index: index of the virtual CPU
   #
   # @qom-path: path to the CPU object in the QOM tree
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> -# @props: properties describing to which node/socket/core/thread
> +# @props: properties describing to which node/drawer/book/socket/core/thread
>  #     virtual CPU belongs to, provided if supported by board

Is this description accurate?

@props is of type CpuInstanceProperties, shown below.  Its documentation
describes it as "properties to be used for hotplugging a CPU instance,
it should be passed by management with device_add command when a CPU is
being hotplugged."  Hmm.

I figure details ("node/drawer/book/socket/core/thread") are better left
to CpuInstanceProperties.

The "provided if supported by board" part makes no sense to me.  If
@props is there, it lists the properties we need to provide with
device_add.  What if it's not there?  Same as empty list, i.e. we don't
need to provide properties with device_add?

Not your patch's fault, but let's get this in shape if we can.

>  #
>  # @target: the QEMU system emulation target, which determines which
> @@ -901,7 +902,11 @@
>  #
>  # @node-id: NUMA node ID the CPU belongs to
>  #
> -# @socket-id: socket number within node/board the CPU belongs to
> +# @drawer-id: drawer number within node/board the CPU belongs to (since 8.2)
> +#
> +# @book-id: book number within drawer/node/board the CPU belongs to (since 8.2)

Long lines, please wrap:

   # @drawer-id: drawer number within node/board the CPU belongs to
   #     (since 8.2)
   #
   # @book-id: book number within drawer/node/board the CPU belongs to
   #     (since 8.2)

> +#
> +# @socket-id: socket number within book/node/board the CPU belongs to
>  #
>  # @die-id: die number within socket the CPU belongs to (since 4.1)
>  #
> @@ -912,7 +917,7 @@
   ##
   # @CpuInstanceProperties:
   #
   # List of properties to be used for hotplugging a CPU instance, it
   # should be passed by management with device_add command when a CPU is
   # being hotplugged.
   #
   # @node-id: NUMA node ID the CPU belongs to
   #
   # @socket-id: socket number within node/board the CPU belongs to
   #
   # @die-id: die number within socket the CPU belongs to (since 4.1)
   #
   # @cluster-id: cluster number within die the CPU belongs to (since
   #     7.1)
   #
   # @core-id: core number within cluster the CPU belongs to
>  #
>  # @thread-id: thread number within core the CPU belongs to
>  #
> -# Note: currently there are 6 properties that could be present but
> +# Note: currently there are 8 properties that could be present but
>  #     management should be prepared to pass through other properties
>  #     with device_add command to allow for future interface extension.
>  #     This also requires the filed names to be kept in sync with the
   #     properties passed to -device/device_add.

The last sentence is for developers, not for users, which means it
doesn't belong here.  Suggest to move it to a non-doc comment, and
rephrase the note like

   # Note: management should be prepared to pass through additional
   # properties with device_add.

> @@ -922,6 +927,8 @@
>  ##
>  { 'struct': 'CpuInstanceProperties',

Non-doc comment could go here:

     # Keep these in sync with the properties device_add accepts

Again, not your patch's fault, but your help improving this stuff would
be appreciated.

>    'data': { '*node-id': 'int',
> +            '*drawer-id': 'int',
> +            '*book-id': 'int',
>              '*socket-id': 'int',
>              '*die-id': 'int',
>              '*cluster-id': 'int',
               '*core-id': 'int',
               '*thread-id': 'int'
     }
   }
> @@ -1480,6 +1487,10 @@
>  #
>  # @cpus: number of virtual CPUs in the virtual machine
>  #
> +# @drawers: number of drawers in the CPU topology (since 8.2)
> +#
> +# @books: number of books in the CPU topology (since 8.2)
> +#
>  # @sockets: number of sockets in the CPU topology
>  #
>  # @dies: number of dies per socket in the CPU topology
> @@ -1498,6 +1509,8 @@
>  ##
>  { 'struct': 'SMPConfiguration', 'data': {
>       '*cpus': 'int',
> +     '*drawers': 'int',
> +     '*books': 'int',
>       '*sockets': 'int',
>       '*dies': 'int',
>       '*clusters': 'int',
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6c67af196a..6dcfc879eb 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -134,12 +134,16 @@ typedef struct {
>   * @clusters_supported - whether clusters are supported by the machine
>   * @has_clusters - whether clusters are explicitly specified in the user
>   *                 provided SMP configuration
> + * @books_supported - whether books are supported by the machine
> + * @drawers_supported - whether drawers are supported by the machine
>   */
>  typedef struct {
>      bool prefer_sockets;
>      bool dies_supported;
>      bool clusters_supported;
>      bool has_clusters;
> +    bool books_supported;
> +    bool drawers_supported;
>  } SMPCompatProps;
>  
>  /**
> @@ -310,7 +314,9 @@ typedef struct DeviceMemoryState {
>  /**
>   * CpuTopology:
>   * @cpus: the number of present logical processors on the machine
> - * @sockets: the number of sockets on the machine
> + * @drawers: the number of drawers on the machine
> + * @books: the number of books in one drawer
> + * @sockets: the number of sockets in one book
>   * @dies: the number of dies in one socket
>   * @clusters: the number of clusters in one die
>   * @cores: the number of cores in one cluster
> @@ -319,6 +325,8 @@ typedef struct DeviceMemoryState {
>   */
>  typedef struct CpuTopology {
>      unsigned int cpus;
> +    unsigned int drawers;
> +    unsigned int books;
>      unsigned int sockets;
>      unsigned int dies;
>      unsigned int clusters;

[...]

> diff --git a/qapi/meson.build b/qapi/meson.build
> index 60a668b343..f81a37565c 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -36,6 +36,7 @@ qapi_all_modules = [
>    'error',
>    'introspect',
>    'job',
> +  'machine-common',
>    'machine',
>    'machine-target',
>    'migration',

[...]


