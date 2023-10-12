Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D47C6BE3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtSe-0007ZI-Vl; Thu, 12 Oct 2023 07:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqtST-0007YN-1Z
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqtSP-0007z3-AH
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697108540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nq85o8rSo5MqDhbtkaqacqIeZwzfU038Bu64rcNXORo=;
 b=IjLmNs2psXlm3kE3UMm0Zefx1YGO49SP+p4lW2eUjVq46z5GEldp1n0pWyOSUvqDkCUG/d
 EvB0Chl7K3rL8O+TLKTtgou7an1MPNXS/HwwcGf8gO+dAzSNyF640IireZ2jUg6v/WUpsj
 2qkwWO4nt5gpmOqkzgjAoxvX9rlm5es=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-gAJacwDWPSeMWqqnmfyq_g-1; Thu, 12 Oct 2023 07:02:06 -0400
X-MC-Unique: gAJacwDWPSeMWqqnmfyq_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8A983C0C893;
 Thu, 12 Oct 2023 11:02:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52E0E492B0C;
 Thu, 12 Oct 2023 11:02:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BDD721E6A21; Thu, 12 Oct 2023 13:02:04 +0200 (CEST)
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
Subject: Re: [PATCH v25 02/21] CPU topology: extend with s390 specifics
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-3-nsg@linux.ibm.com>
Date: Thu, 12 Oct 2023 13:02:04 +0200
In-Reply-To: <20231005160155.1945588-3-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 5 Oct 2023 18:01:36 +0200")
Message-ID: <87cyxkxfwz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is vague.  Peeking at the patch, I can see it adds properties
"socket-id", "book-id", "drawer-id", "dedicated", and "entitlement" to
"s390x-cpu" objects.  Suggest to spell that out here.

> Add machine-common.json so we can later include it in
> machine-target.json also.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  MAINTAINERS                         |  1 +
>  qapi/machine-common.json            | 21 +++++++++++++
>  qapi/machine.json                   | 17 +++++++++-
>  qapi/qapi-schema.json               |  1 +
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
>  15 files changed, 139 insertions(+), 11 deletions(-)
>  create mode 100644 qapi/machine-common.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81625f036b..3f6888aa86 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1775,6 +1775,7 @@ F: hw/core/null-machine.c
>  F: hw/core/numa.c
>  F: hw/cpu/cluster.c
>  F: qapi/machine.json
> +F: qapi/machine-common.json
>  F: qapi/machine-target.json
>  F: include/hw/boards.h
>  F: include/hw/core/cpu.h
> diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> new file mode 100644
> index 0000000000..fa6bd71d12
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
> +# An enumeration of CPU entitlements that can be assumed by a virtual
> +# S390 CPU
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'CpuS390Entitlement',
> +  'prefix': 'S390_CPU_ENTITLEMENT',
> +  'data': [ 'auto', 'low', 'medium', 'high' ] }
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 40b835e28e..7aacd26af0 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -9,6 +9,7 @@
>  ##
>  
>  { 'include': 'common.json' }
> +{ 'include': 'machine-common.json' }
>  
>  ##
>  # @SysEmuTarget:
> @@ -904,7 +905,13 @@
>  #
>  # @node-id: NUMA node ID the CPU belongs to
>  #
> -# @socket-id: socket number within node/board the CPU belongs to
> +# @drawer-id: drawer number within node/board the CPU belongs to
> +#     (since 8.2)
> +#
> +# @book-id: book number within drawer/node/board the CPU belongs to
> +#     (since 8.2)
> +#
> +# @socket-id: socket number within book/node/board the CPU belongs to
>  #
>  # @die-id: die number within socket the CPU belongs to (since 4.1)
>  #
   # @cluster-id: cluster number within die the CPU belongs to (since
   #     7.1)
   #
   # @core-id: core number within cluster the CPU belongs to
   #
   # @thread-id: thread number within core the CPU belongs to

So...

* A thread can only be within a core

* A core can only be within a cluster

* A cluster can only be within a die

* A die can only be within a socket

* A socket can be within a book, node, or board

* A book can be within a drawer, node, or board

* A drawer can be within a node, or board

* A node is a NUMA node

* A board is what exactly?  can we have more than one?  is node always
  within a/the board?

Asked differently: what are the possible hierarchies of things?

> @@ -923,6 +930,8 @@
>  { 'struct': 'CpuInstanceProperties',
>    # Keep these in sync with the properties device_add accepts
>    'data': { '*node-id': 'int',
> +            '*drawer-id': 'int',
> +            '*book-id': 'int',
>              '*socket-id': 'int',
>              '*die-id': 'int',
>              '*cluster-id': 'int',
> @@ -1481,6 +1490,10 @@
>  #
>  # @cpus: number of virtual CPUs in the virtual machine
>  #
> +# @drawers: number of drawers in the CPU topology (since 8.2)
> +#
> +# @books: number of books in the CPU topology (since 8.2)
> +#
>  # @sockets: number of sockets in the CPU topology

Total numer of sockets?  Or number of sockets per whatever thing
contains sockets?

Same question for @books, @drawers, and @cpus.

The documentation is less than clear before your patch; your patch
merely makes me look at it.  We may decide that addressing the lack of
clarity is not your patch's job, and leave it for later.

>  #
>  # @dies: number of dies per socket in the CPU topology
> @@ -1499,6 +1512,8 @@
>  ##
>  { 'struct': 'SMPConfiguration', 'data': {
>       '*cpus': 'int',
> +     '*drawers': 'int',
> +     '*books': 'int',
>       '*sockets': 'int',
>       '*dies': 'int',
>       '*clusters': 'int',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 6594afba31..c01ec335e6 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -66,6 +66,7 @@
>  { 'include': 'introspect.json' }
>  { 'include': 'qom.json' }
>  { 'include': 'qdev.json' }
> +{ 'include': 'machine-common.json' }
>  { 'include': 'machine.json' }
>  { 'include': 'machine-target.json' }
>  { 'include': 'replay.json' }

[...]

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index df167493c3..74405beb51 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -31,6 +31,7 @@
>  #include "qapi/qapi-types-machine.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "fpu/softfloat-helpers.h"
>  #include "disas/capstone.h"
>  #include "sysemu/tcg.h"
> @@ -292,6 +293,12 @@ static gchar *s390_gdb_arch_name(CPUState *cs)
>  static Property s390x_cpu_properties[] = {
>  #if !defined(CONFIG_USER_ONLY)
>      DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
> +    DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
> +    DEFINE_PROP_INT32("book-id", S390CPU, env.book_id, -1),
> +    DEFINE_PROP_INT32("drawer-id", S390CPU, env.drawer_id, -1),
> +    DEFINE_PROP_BOOL("dedicated", S390CPU, env.dedicated, false),
> +    DEFINE_PROP_CPUS390ENTITLEMENT("entitlement", S390CPU, env.entitlement,
> +                                   S390_CPU_ENTITLEMENT_AUTO),
>  #endif
>      DEFINE_PROP_END_OF_LIST()
>  };

[...]

I suspect the patch could be split into a part that updates
CpuInstanceProperties and SMPConfiguration, and a part that adds the
properties.  Since the series is at v25, I'm *not* asking you explore
that.


