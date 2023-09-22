Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E67AB293
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:17:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjg1M-0006MS-DT; Fri, 22 Sep 2023 09:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjg12-0006KI-QJ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjg0l-0004c8-8E
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695388556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sTleQW0CKI+6lNs4EC9t0x5EFl6FCW0uYN0DYRhocSk=;
 b=TsOfGHmbqu0ofbH7Rv5DkeyMs66d4kaFu7DszMIDVB97MUWE8tiqtHi1fNGlOvlHT4y84a
 rmd9fWGJBo26mgo3w5N48ze3pcVO3Fc5fJfjQImRYm7GX1vxfifft9zLQH5JA12Vj5fU9t
 fJOyiSLvqoKfOkFxE9Y6yWNg75DWhHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-TBwkR-ZgMMy-MgOOeusF6g-1; Fri, 22 Sep 2023 09:15:53 -0400
X-MC-Unique: TBwkR-ZgMMy-MgOOeusF6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81003800883;
 Fri, 22 Sep 2023 13:15:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 313C9492C37;
 Fri, 22 Sep 2023 13:15:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 256CD21E6900; Fri, 22 Sep 2023 15:15:51 +0200 (CEST)
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
 <87jzsljdzc.fsf@pond.sub.org>
 <950415f4e4a742c959a03d18df9f6b83bde4004c.camel@linux.ibm.com>
Date: Fri, 22 Sep 2023 15:15:51 +0200
In-Reply-To: <950415f4e4a742c959a03d18df9f6b83bde4004c.camel@linux.ibm.com>
 (Nina Schoetterl-Glausch's message of "Fri, 22 Sep 2023 13:11:44
 +0200")
Message-ID: <87bkdutkl4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

> On Wed, 2023-09-20 at 13:11 +0200, Markus Armbruster wrote:
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
>> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
>> > new file mode 100644
>> > index 0000000000..e40421bb37
>> > --- /dev/null
>> > +++ b/qapi/machine-common.json
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
>> 
>> CPU entitlements
>> 
>> Would someone reasonably familiar with S390 understand this?  Because
>
> Well, someone familiar with s390 topology would, otherwise probably not tbh.

Good enough, I guess.

>> I'm not and I don't; I wonder what "a virtual CPU assuming an
>> entitlement" means.
>
> Basically, on s390x the OS is always running on some hypervisor.
> Even without KVM or z/VM you can slice up the machine, namely into logical
> partitions (LPARs). Therefore, there is a scheduling of virtual CPUs to the
> actual physical ones. "Entitlement" is a statement about how that scheduling
> works for a virtual CPU. The same concepts can then also be applied to KVM.

Thanks!

[...]


