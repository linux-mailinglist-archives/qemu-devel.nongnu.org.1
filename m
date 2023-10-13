Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D497C870D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIOc-0008NN-3X; Fri, 13 Oct 2023 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrIOX-0008Lq-Bz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrIOU-0004gM-Jd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697204397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=apFByQpb8DPFnA+RYFga5dEKCrvFXOFvRv5L8Y5LCNg=;
 b=GIM78IPsGCFjkXBMSLHubWM7TYYb8PsEsq8Q0+svM3VlIhSLDYmZxfLSwPvSc4il/qIO/w
 Jka12v7hYeAD7n1x1GJKg5LeuaUoVMXbUUoKBR7Ev6QABHecQ+tb2RMtN/OJg3APm2DgNy
 cbnvSPlUdsA5W2iL6/jtv4P+rcHCgv8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-2Fp-XfPpN-mx9E1d1IN9TA-1; Fri, 13 Oct 2023 09:39:54 -0400
X-MC-Unique: 2Fp-XfPpN-mx9E1d1IN9TA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA11C3813BD1;
 Fri, 13 Oct 2023 13:39:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9E3E47CD2;
 Fri, 13 Oct 2023 13:39:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E444E21E6A21; Fri, 13 Oct 2023 15:39:51 +0200 (CEST)
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
 Yanan Wang <wangyanan55@huawei.com>,  "Daniel P." =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Cleber Rosa
 <crosa@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v25 02/21] CPU topology: extend with s390 specifics
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-3-nsg@linux.ibm.com>
 <87cyxkxfwz.fsf@pond.sub.org>
 <fc5f73d3084259a23af3c35cbc54fb6b6780fb7b.camel@linux.ibm.com>
Date: Fri, 13 Oct 2023 15:39:51 +0200
In-Reply-To: <fc5f73d3084259a23af3c35cbc54fb6b6780fb7b.camel@linux.ibm.com>
 (Nina Schoetterl-Glausch's message of "Fri, 13 Oct 2023 14:58:41
 +0200")
Message-ID: <87o7h2ej4o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

> On Thu, 2023-10-12 at 13:02 +0200, Markus Armbruster wrote:
>> Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
>> 
>> > From: Pierre Morel <pmorel@linux.ibm.com>
>> > 
>> > S390 adds two new SMP levels, drawers and books to the CPU
>> > topology.
>> > S390 CPUs have specific topology features like dedication and
>> > entitlement. These indicate to the guest information on host
>> > vCPU scheduling and help the guest make better scheduling decisions.
>> > 
>> > Let us provide the SMP properties with books and drawers levels
>> > and S390 CPU with dedication and entitlement,
>> 
>> This is vague.  Peeking at the patch, I can see it adds properties
>> "socket-id", "book-id", "drawer-id", "dedicated", and "entitlement" to
>> "s390x-cpu" objects.  Suggest to spell that out here.
>> 
>> > Add machine-common.json so we can later include it in
>> > machine-target.json also.
>> > 
>> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > ---
>> >  MAINTAINERS                         |  1 +
>> >  qapi/machine-common.json            | 21 +++++++++++++
>> >  qapi/machine.json                   | 17 +++++++++-
>> >  qapi/qapi-schema.json               |  1 +
>> >  include/hw/boards.h                 | 10 +++++-
>> >  include/hw/qdev-properties-system.h |  4 +++
>> >  target/s390x/cpu.h                  |  6 ++++
>> >  hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
>> >  hw/core/machine.c                   |  4 +++
>> >  hw/core/qdev-properties-system.c    | 13 ++++++++
>> >  hw/s390x/s390-virtio-ccw.c          |  4 +++
>> >  softmmu/vl.c                        |  6 ++++
>> >  target/s390x/cpu.c                  |  7 +++++
>> >  qapi/meson.build                    |  1 +
>> >  qemu-options.hx                     |  7 +++--
>> >  15 files changed, 139 insertions(+), 11 deletions(-)
>> >  create mode 100644 qapi/machine-common.json
>> > 
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 81625f036b..3f6888aa86 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -1775,6 +1775,7 @@ F: hw/core/null-machine.c
>> >  F: hw/core/numa.c
>> >  F: hw/cpu/cluster.c
>> >  F: qapi/machine.json
>> > +F: qapi/machine-common.json
>> >  F: qapi/machine-target.json
>> >  F: include/hw/boards.h
>> >  F: include/hw/core/cpu.h
>> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
>> > new file mode 100644
>> > index 0000000000..fa6bd71d12
>
> [...] 
>
>> >  ##
>> >  # @SysEmuTarget:
>> > @@ -904,7 +905,13 @@
>> >  #
>> >  # @node-id: NUMA node ID the CPU belongs to
>> >  #
>> > -# @socket-id: socket number within node/board the CPU belongs to
>> > +# @drawer-id: drawer number within node/board the CPU belongs to
>> > +#     (since 8.2)
>> > +#
>> > +# @book-id: book number within drawer/node/board the CPU belongs to
>> > +#     (since 8.2)
>> > +#
>> > +# @socket-id: socket number within book/node/board the CPU belongs to
>> >  #
>> >  # @die-id: die number within socket the CPU belongs to (since 4.1)
>> >  #
>>    # @cluster-id: cluster number within die the CPU belongs to (since
>>    #     7.1)
>>    #
>>    # @core-id: core number within cluster the CPU belongs to
>>    #
>>    # @thread-id: thread number within core the CPU belongs to
>> 
>> So...
>> 
>> * A thread can only be within a core
>> 
>> * A core can only be within a cluster
>> 
>> * A cluster can only be within a die
>> 
>> * A die can only be within a socket
>> 
>> * A socket can be within a book, node, or board
>> 
>> * A book can be within a drawer, node, or board
>> 
>> * A drawer can be within a node, or board
>> 
>> * A node is a NUMA node
>> 
>> * A board is what exactly?  can we have more than one?  is node always
>>   within a/the board?
>
> Yeah, the description is confusing.
>> 
>> Asked differently: what are the possible hierarchies of things?
>
> The way I understand things is:
> * Different architectures have different hierarchies, say
>   1. (thread, core, cluster, die, socket)
>   2. (thread, core, socket, book, drawer)
>
> We define a qemu artificial ordered super set
> (thread, core, cluster, die, socket, book, drawer)
> where architectures can choose a subset of, specifying that they
> support a certain level or not.
>
> Now if for example x86 wanted to support a book level between
> thread and core, we'd need to change a bunch of code and make
> things more complicated.
>
> The NUMA node-id maps a hierarchy tuple to a node, I don't think
> it's part of hierarchy itself.
>
> Now the question is how to document this.

Right.

> On s390x there is no cluster, so what does
>
> @core-id: core number within cluster the CPU belongs to
>
> mean?
>
> We could say, that within the qemu super set there is a virtual
> cluster of which there is one per die (and one die per socket).
>
> Or we rewrite the documentation to say
>
> @x-id: x number within the upper hierarchy container
>
> to account for the fact that the upper container is different
> on different architectures.

Perhaps a structure like this could work.

1. Define the most general hierarchy.

2. Explain the actual hierarchy is a subset.

3. Explain the members as "number within container", as you proposed.

Only works if a superset of all the actual hierarchies exists, and is
sufficiently easy explain.

>> > @@ -923,6 +930,8 @@
>> >  { 'struct': 'CpuInstanceProperties',
>> >    # Keep these in sync with the properties device_add accepts
>> >    'data': { '*node-id': 'int',
>> > +            '*drawer-id': 'int',
>> > +            '*book-id': 'int',
>> >              '*socket-id': 'int',
>> >              '*die-id': 'int',
>> >              '*cluster-id': 'int',
>> > @@ -1481,6 +1490,10 @@
>> >  #
>> >  # @cpus: number of virtual CPUs in the virtual machine
>> >  #
>> > +# @drawers: number of drawers in the CPU topology (since 8.2)
>> > +#
>> > +# @books: number of books in the CPU topology (since 8.2)
>> > +#
>> >  # @sockets: number of sockets in the CPU topology
>> 
>> Total numer of sockets?  Or number of sockets per whatever thing
>> contains sockets?
>
> The latter. I'll change this
>> 
>> Same question for @books, @drawers, and @cpus.
>
> Same for the first two, total for @cpus.
>> 
>> The documentation is less than clear before your patch; your patch
>> merely makes me look at it.  We may decide that addressing the lack of
>> clarity is not your patch's job, and leave it for later.
>
> Yeah, same problem here around different architectures using different sub sets.
>> 
>> >  #
>> >  # @dies: number of dies per socket in the CPU topology
>> > @@ -1499,6 +1512,8 @@
>> >  ##
>> >  { 'struct': 'SMPConfiguration', 'data': {
>> >       '*cpus': 'int',
>> > +     '*drawers': 'int',
>> > +     '*books': 'int',
>> >       '*sockets': 'int',
>> >       '*dies': 'int',
>> >       '*clusters': 'int',
>
> [...]

Thanks!


