Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E01CE7159B7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vTy-0007gk-1i; Tue, 30 May 2023 05:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3vTw-0007g8-Hv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3vTu-0000KH-TZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685438249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yBvfAmhfL5FU5im1u3fkxBKnJooDQ7aAFgr5mgNjgw=;
 b=hM9/JeV7PTOR3rU6Qm630KrQmWwpknpAfnx5/r6MoroKhXCaYIExgMQSnpoiugbzTI3JCg
 hAfLGFi3oYPXaHnuLLz32XW5Ua+rr0eX9wcymxZNBJ9F6XLSZDkuuSvKj0atIjwIvmZWyd
 b+xU06jWt9EbsAVkEwjA9P9ohoTaN4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-COI66MV1P5eZtU47swsQKw-1; Tue, 30 May 2023 05:17:18 -0400
X-MC-Unique: COI66MV1P5eZtU47swsQKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5261C800969;
 Tue, 30 May 2023 09:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 310A3140E955;
 Tue, 30 May 2023 09:17:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2218121E692E; Tue, 30 May 2023 11:17:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-7-het.gala@nutanix.com>
 <875y8gjo5h.fsf@pond.sub.org>
 <2837b5c4-2f70-c6b2-8309-13c40540ec1d@nutanix.com>
 <875y8auwae.fsf@pond.sub.org>
 <31b8fffe-ea87-9d5c-a601-0f873d1c31c1@nutanix.com>
Date: Tue, 30 May 2023 11:17:17 +0200
In-Reply-To: <31b8fffe-ea87-9d5c-a601-0f873d1c31c1@nutanix.com> (Het Gala's
 message of "Tue, 30 May 2023 14:15:00 +0530")
Message-ID: <875y8arxeq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> writes:

> On 30/05/23 12:43 pm, Markus Armbruster wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> On 25/05/23 11:20 pm, Markus Armbruster wrote:
>>>> Het Gala <het.gala@nutanix.com> writes:
>>>>
>>>>> MigrateChannelList allows to connect accross multiple interfaces. Added
>>>>> MigrateChannelList struct as argument to migration QAPIs.
>>>>>
>>>>> Future patchset series plans to include multiple MigrateChannels
>>>>> for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
>>>>> is the preferred choice of argument over 'MigrateChannel' and making
>>>>> migration QAPIs future proof.
>>>>>
>>>>> For current patchset series, have limited the size of the list to single
>>>>> element (single interface) as runtime check.
>>>>>
>>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>

[...]

>>>>> @@ -1497,6 +1562,10 @@
>>>>>    # @uri: The Uniform Resource Identifier identifying the source or
>>>>>    #     address to listen on
>>>>>    #
>>>>> +# @channels: Struct containing list of migration channel types, with all
>>>>> +#            the information regarding destination interfaces required for
>>>>> +#            initiating a migration stream.
>>>>> +#
>>>> The list doesn't contain migration channel types, it contains migration
>>>> channels.
>>>
>>> Yes, my bad. Will update it.
>>
>> Writing good documentation is hard!
>>
>>>> I'm not sure what you're trying to say by "with all the information ..."
>>>>
>>>> What does it mean to have multiple channels?
>>>
>>> In future patchset series, we will be introducing channels over different interfaces (src-dest pair), with each channel having multiple multifd channels. For now we will restrict the size of the list to 1.
>>
>> Please document this restriction right here.
>
> Ack. But it is mainly an implementation point that's the reason I did not mention it here but have mentioned it in the migration code flow path. Will add one more point to note down.

Documenting temporary restrictions is work that's useful only
temporarily.

When a restriction goes away within the same patch series, not doing
that work can make sense.  I'd still want it mentioned in the commit
message.

It's tempting treat restrictions expected to go away before we release
the same.  But when lifting the restriction misses the release, it's
easy to forget we still have a restriction to document.  Better document
it right away.

>> When you add support for multiple channels, will each channel have a
>> unique channel type?
>
> Not every channel will have a unique channel type but mixture like, for multifd in future : (main, data, data, data) --> the first connection will be migration main connection, other three will be multifd connections.

Got it, thanks!


