Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A57067FA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGAa-0002eq-J6; Wed, 17 May 2023 08:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzGAQ-0002eZ-35
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzGAO-0006Yp-9j
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684326122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHUfvFJhkDz3DqKJFkj3rngWOHllKoZuVNXQlgQ6EjQ=;
 b=Fdft2xanKgoCNgKcdQC9HbsEji8eVqy0kjS/ORgVZp2RqPs/NZflVQYG6/UghmqJtJqmzV
 KBkoENkoOXx6j+VnYOM9U4FocT9EIEgHywEnuYZYxx4cLz0wPRqQaJP6JgfnvdBmK3wlh7
 vYfXa5WddeD3VEa++o2SZ62YHYYWykA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670--KuSUMsvPjCPB18WYzceaA-1; Wed, 17 May 2023 08:22:00 -0400
X-MC-Unique: -KuSUMsvPjCPB18WYzceaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40881867955;
 Wed, 17 May 2023 12:21:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB3040C2063;
 Wed, 17 May 2023 12:21:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 526FE21E66E3; Wed, 17 May 2023 14:21:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yishai
 Hadas <yishaih@nvidia.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Maor
 Gottlieb <maorg@nvidia.com>,  Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>,  Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH 1/8] migration: Add precopy initial data capability
References: <20230501140141.11743-1-avihaih@nvidia.com>
 <20230501140141.11743-2-avihaih@nvidia.com>
 <87lehn71wm.fsf@pond.sub.org>
 <1836389d-0774-08a1-ef54-8487d238fe73@nvidia.com>
Date: Wed, 17 May 2023 14:21:54 +0200
In-Reply-To: <1836389d-0774-08a1-ef54-8487d238fe73@nvidia.com> (Avihai Horon's
 message of "Wed, 17 May 2023 13:16:00 +0300")
Message-ID: <87lehn2lnh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 17/05/2023 12:17, Markus Armbruster wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Avihai Horon <avihaih@nvidia.com> writes:
>>
>>> Migration downtime estimation is calculated based on bandwidth and
>>> remaining migration data. This assumes that loading of migration data in
>>> the destination takes a negligible amount of time and that downtime
>>> depends only on network speed.
>>>
>>> While this may be true for RAM, it's not necessarily true for other
>>> migration users. For example, loading the data of a VFIO device in the
>>> destination might require from the device to allocate resources, prepare
>>> internal data structures and so on. These operations can take a
>>> significant amount of time which can increase migration downtime.
>>>
>>> This patch adds a new capability "precopy initial data" that allows the
>>> source to send initial precopy data and the destination to ACK that this
>>> data has been loaded. Migration will not attempt to stop the source VM
>>> and complete the migration until this ACK is received.
>>>
>>> This will allow migration users to send initial precopy data which can
>>> be used to reduce downtime (e.g., by pre-allocating resources), while
>>> making sure that the source will stop the VM and complete the migration
>>> only after this initial precopy data is sent and loaded in the
>>> destination so it will have full effect.
>>>
>>> This new capability relies on the return path capability to communicate
>>> from the destination back to the source.
>>>
>>> The actual implementation of the capability will be added in the
>>> following patches.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   qapi/migration.json |  9 ++++++++-
>>>   migration/options.h |  1 +
>>>   migration/options.c | 20 ++++++++++++++++++++
>>>   3 files changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 82000adce4..d496148386 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -478,6 +478,13 @@
>>>   #                    should not affect the correctness of postcopy migration.
>>>   #                    (since 7.1)
>>>   #
>>> +# @precopy-initial-data: If enabled, migration will not attempt to stop source
>>> +#                        VM and complete the migration until an ACK is received
>>> +#                        from the destination that initial precopy data has
>>> +#                        been loaded. This can improve downtime if there are
>>> +#                        migration users that support precopy initial data.
>>> +#                        (since 8.1)
>>> +#
>> Please format like
>>
>>     # @precopy-initial-data: If enabled, migration will not attempt to
>>     #     stop source VM and complete the migration until an ACK is
>>     #     received from the destination that initial precopy data has been
>>     #     loaded.  This can improve downtime if there are migration users
>>     #     that support precopy initial data.  (since 8.1)
>>
>> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
>> to conform to current conventions).
>
> Sure.
>
>>
>> What do you mean by "if there are migration users that support precopy
>> initial data"?
>
> This capability only provides the framework to send precopy initial data and ACK that it was loaded in the destination.
> To actually benefit from it, migration users (such as VFIO devices, RAM, etc.) must implement support for it and use it.
>
> What I wanted to say here is that there is no point to enable this capability if there are no migration users that support it.
> For example, if you are migrating a VM without VFIO devices, then enabling this capability will have no effect.

I see.

Which "migration users" support it now?

Which could support it in the future?

Is the "initial precopy data" feature described in more detail anywhere?

>> Do I have to ensure the ACK comes by configuring the destination VM in a
>> certain way, and if yes, how exactly?
>
> In v2 of the series that I will send later you will have to enable this capability also in the destination.

What happens when you enable it on the source and not on the
destination?

[...]


