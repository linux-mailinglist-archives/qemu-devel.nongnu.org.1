Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2665F7A79D8
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 12:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiutU-0003oS-3C; Wed, 20 Sep 2023 06:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiutJ-0003o4-KN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 06:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiutH-0005E8-J8
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 06:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695207426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UCuwSTwW+smACABwKLQFVe5ZvoTc4YxsB+GotFIMzjU=;
 b=YaGoxrdAlSW4nEfQh/Rs5Y5fuEAvR4agRhI0oQBnpKoSabNptP5dXIW/ePDQIsdAEK41jK
 LZ0Zm95yx41IdlQNLZcc9Gkhbcdxn45uf8s0cdu+PtCBHnDCYBuqbXBegmLYG701qxNkPc
 CTAyHPh/UOsTlOp5gG0XkAXvQXVVdq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-xbnmLaVIMveeNIT9Yn9QGw-1; Wed, 20 Sep 2023 06:57:03 -0400
X-MC-Unique: xbnmLaVIMveeNIT9Yn9QGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B83D7101A550;
 Wed, 20 Sep 2023 10:57:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F52F2156A27;
 Wed, 20 Sep 2023 10:57:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4161221E6900; Wed, 20 Sep 2023 12:57:01 +0200 (CEST)
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
Subject: Re: [PATCH v23 01/20] CPU topology: extend with s390 specifics
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com>
 <87ediuwcrt.fsf@pond.sub.org>
 <e6ab27f4ef55d88f9585101434f900bd066145d6.camel@linux.ibm.com>
Date: Wed, 20 Sep 2023 12:57:01 +0200
In-Reply-To: <e6ab27f4ef55d88f9585101434f900bd066145d6.camel@linux.ibm.com>
 (Nina Schoetterl-Glausch's message of "Tue, 19 Sep 2023 19:51:34
 +0200")
Message-ID: <875y45kt8i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Tue, 2023-09-19 at 14:47 +0200, Markus Armbruster wrote:
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
>> > 
>> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > ---
>> >  qapi/machine-common.json            | 21 +++++++++++++
>> >  qapi/machine.json                   | 19 ++++++++++--
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
>> >  13 files changed, 137 insertions(+), 13 deletions(-)
>> >  create mode 100644 qapi/machine-common.json
>> > 
>> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
>> > new file mode 100644
>> > index 0000000000..e40421bb37
>> > --- /dev/null
>> > +++ b/qapi/machine-common.json
>> 
>> Why do you need a separate QAPI sub-module?
>
> See here https://lore.kernel.org/qemu-devel/d8da6f7d1e3addcb63614f548ed77ac1b8895e63.camel@linux.ibm.com/

Quote:

    CpuS390Entitlement would be useful in both machine.json and machine-target.json

This is not obvious from this patch.  I figure this patch could add it
to machine.json just fine.  The use in machine-target.json in appears
only in PATCH 08.

    because query-cpu-fast is defined in machine.json and set-cpu-topology is defined
    in machine-target.json.

    So then the question is where best to define CpuS390Entitlement.
    In machine.json and include machine.json in machine-target.json?
    Or define it in another file and include it from both?

You do the latter in this patch.

I figure the former would be tolerable, too.

That said, having target-specific stuff in machine.json feels... odd.
Before this series, we have CpuInfoS390 and CpuS390State there, for
query-cpus-fast.  That command returns a list of objects where common
members are target-independent, and the variant members are
target-dependent.  qmp_query_cpus_fast() uses a CPU method to populate
the target-dependent members.

I'm not sure splitting query-cpus-fast into a target-dependent and a
target-independent part is worth the bother.

In this patch, you work with the structure you found.  Can't fault you
for that :)

>> > @@ -0,0 +1,21 @@
>> > +# -*- Mode: Python -*-
>> > +# vim: filetype=python
>> > +#
>> > +# This work is licensed under the terms of the GNU GPL, version 2 or later.
>> > +# See the COPYING file in the top-level directory.
>> > +
>> > +##
>> > +# = Machines S390 data types
>> > +##
>> > +
>> > +##
>> > +# @CpuS390Entitlement:
>> > +#
>> > +# An enumeration of cpu entitlements that can be assumed by a virtual
>> > +# S390 CPU
>> > +#
>> > +# Since: 8.2
>> > +##
>> > +{ 'enum': 'CpuS390Entitlement',
>> > +  'prefix': 'S390_CPU_ENTITLEMENT',
>> > +  'data': [ 'auto', 'low', 'medium', 'high' ] }
>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index a08b6576ca..a63cb951d2 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>> > @@ -9,6 +9,7 @@
>>    ##
>>    # = Machines
>> >  ##
>> >  
>> >  { 'include': 'common.json' }
>> > +{ 'include': 'machine-common.json' }
>> 
>> Section structure is borked :)
>> 
>> Existing section "Machine" now ends at the new "Machines S390 data
>> types" you pull in here.  The contents of below moves from "Machines" to
>> "Machines S390 data types".
>> 
>> Before I explain how to avoid this, I'd like to understand why we need a
>> new sub-module.
>> 
>> >  
>> >  ##
>> >  # @SysEmuTarget:
>> > @@ -71,7 +72,7 @@
>>    ##
>>    # @CpuInfoFast:
>>    #
>>    # Information about a virtual CPU
>>    #
>>    # @cpu-index: index of the virtual CPU
>>    #
>>    # @qom-path: path to the CPU object in the QOM tree
>> >  #
>> >  # @thread-id: ID of the underlying host thread
>> >  #
>> > -# @props: properties describing to which node/socket/core/thread
>> > +# @props: properties describing to which node/drawer/book/socket/core/thread
>> >  #     virtual CPU belongs to, provided if supported by board
>> 
>> Is this description accurate?
>
> Kinda, although the wording might not be the best.
> All the CpuInstanceProperties fields are optional, it's like a superset of possible
> properties across architectures.
> Only a subset might be returned by query-cpus-fast.

Let's see whether I got this right...

The members of CpuInstanceProperties are properties you can pass to
device_add for some targets.

The members present in a response from query-cpus-fast are properties
you must pass to device_add in this VM.  Or is that a "may pass"?

On what exactly does the set of present members depend?  Just the
target?  The machine type?  The CPU?  Anything else?

> Also die and cluster are missing.

Does this need fixing?

>> @props is of type CpuInstanceProperties, shown below.  Its documentation
>> describes it as "properties to be used for hotplugging a CPU instance,
>> it should be passed by management with device_add command when a CPU is
>> being hotplugged."  Hmm.
>> 
>> I figure details ("node/drawer/book/socket/core/thread") are better left
>> to CpuInstanceProperties.
>> 
>> The "provided if supported by board" part makes no sense to me.  If
>> @props is there, it lists the properties we need to provide with
>> device_add.  What if it's not there?  Same as empty list, i.e. we don't
>> need to provide properties with device_add?
>
> There are default values/default logic.
> For s390x, socket, book, drawer are calculated from the core id
> if not provided with device_add.
> Partial specifications are rejected.

Undocumented magic?

>> Not your patch's fault, but let's get this in shape if we can.

[...]


