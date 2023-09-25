Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCE7ADDBE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpF0-0001zL-U7; Mon, 25 Sep 2023 13:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkpEw-0001wM-Ea
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkpEt-0003nl-P0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695662358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmOFrXbMlviiqMRXHH+N4woAOKfsuuxvD2jXHPx4PyE=;
 b=Z7DNPpShH3PDJkIAM+rvGIGTo8Bu/aGkpTf6//BGgPp3exfg1l27PzSoOqe8JaXc1uCMBk
 IVq0aMG7UgFoah9VB3aG1eeqfIe8OAj6zu1I7zBFE7TRTbHJSogfIPja+ajJA4RY/7/7OG
 EQZzKp9c7Fefw1pZZh6RpqAXTdkG/vA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-uEn1-glhOme1y1DgeTLv5w-1; Mon, 25 Sep 2023 13:19:13 -0400
X-MC-Unique: uEn1-glhOme1y1DgeTLv5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2B008039D2;
 Mon, 25 Sep 2023 17:19:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6823751E3;
 Mon, 25 Sep 2023 17:19:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A65321E6900; Mon, 25 Sep 2023 19:19:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Eric Farman
 <farman@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,
 "Daniel P." =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ilya
 Leoshkevich
 <iii@linux.ibm.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Pierre
 Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v23 01/20] CPU topology: extend with s390 specifics
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com>
 <87ediuwcrt.fsf@pond.sub.org>
 <5f569e3a8b54e84b7302a565454a511bf79f76ba.camel@linux.ibm.com>
Date: Mon, 25 Sep 2023 19:19:11 +0200
In-Reply-To: <5f569e3a8b54e84b7302a565454a511bf79f76ba.camel@linux.ibm.com>
 (Nina Schoetterl-Glausch's message of "Mon, 25 Sep 2023 18:06:00
 +0200")
Message-ID: <87h6ninpbk.fsf@pond.sub.org>
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
>> 
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
>
> Should I just move the include statements above the section header?
> I assume I could also include it in qapi-schema.json before the machine.json
> include and that that is the reason we don't have
> the same problem with e.g. migration.json.
> But just moving the includes seems cleaner.

qapi-schema.json should include all sub-modules in the order desired for
the manual.

Do double-check the generated manual's section structure when adding
sections or moving include directives.


