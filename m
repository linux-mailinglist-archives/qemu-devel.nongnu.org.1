Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D27A88B1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 17:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qizLv-0004hK-DI; Wed, 20 Sep 2023 11:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qizLs-0004hA-M5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qizLr-0006sN-9R
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695224574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rtMdpkSRnWKJX3g+S2Yk7CLE8CxidI6NFqnp4cvM8tU=;
 b=L4p23PP1gPGU78ittTVlqWLQJ/REzv6ehH2r9Ra/Aqg9xn2kilI7nnK4UvHAEIXKloIXIR
 J1ueAO1AhpunBA6e4OBR9lQayQqQKIsVNrv0KjmUGtvDwq/LUc0ycM/EHUKJlnrsma6Rkq
 kK7eOOWbNPq68CCp8wCVNkZ6xLQqOFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-Y0O3N6D6N3OkRdvH90cUrw-1; Wed, 20 Sep 2023 11:42:51 -0400
X-MC-Unique: Y0O3N6D6N3OkRdvH90cUrw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 920FA8039C8;
 Wed, 20 Sep 2023 15:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA5B492B16;
 Wed, 20 Sep 2023 15:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A89F21E6900; Wed, 20 Sep 2023 17:42:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Cornelia Huck
 <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Michael Roth
 <michael.roth@amd.com>,  isaku.yamahata@gmail.com,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and
 associate it with RAM_KVM_GMEM
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com>
 <8734zazeag.fsf@pond.sub.org>
 <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
 <878r91nvy4.fsf@pond.sub.org>
 <da598ffc-fa47-3c25-64ea-27ea90d712aa@intel.com>
 <091a40cb-ec26-dd79-aa26-191dc59c03e6@redhat.com>
Date: Wed, 20 Sep 2023 17:42:49 +0200
In-Reply-To: <091a40cb-ec26-dd79-aa26-191dc59c03e6@redhat.com> (David
 Hildenbrand's message of "Wed, 20 Sep 2023 16:37:37 +0200")
Message-ID: <87msxgdf5y.fsf@pond.sub.org>
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

David Hildenbrand <david@redhat.com> writes:

> On 20.09.23 16:35, Xiaoyao Li wrote:
>> On 9/20/2023 3:30 PM, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> On 9/19/2023 5:46 PM, Markus Armbruster wrote:
>>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>>
>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>>
>>>>>> Add a new property "private" to memory backends. When it's set to true,
>>>>>> it indicates the RAMblock of the backend also requires kvm gmem.
>>>>> Can you add a brief explanation why you need the property?
>>>>
>>>> It provides a mechanism for user to specify whether the memory can serve as private memory (need request kvm gmem).
>>>
>>> Yes, but why would a user want such memory?
>>>
>> Because KVM demands it for confidential guest, e.g., TDX guest. KVM
>> demands that the mem slot needs to have KVM_MEM_PRIVATE set and has
>> valid gmem associated if the guest accesses it as private memory.

Commit messages should explain why we want the patch.  Documenting "why"
is at least as important as "what".  If "what" is missing, I can read
the patch to find out.  If "why" is missing, I'm reduced to guesswork.

> I think as long as there is no demand to have a TDX guest with this property be set to "off", then just don't add it.
>
> With a TDX VM, it will can be implicitly active. If we ever have to disable it for selective memory backends, we can add the property and have something like on/off/auto. For now it would be "auto".

Makes sense to me.


