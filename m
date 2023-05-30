Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796B715654
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:15:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tXp-0007pb-Q8; Tue, 30 May 2023 03:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3tXo-0007pR-E1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3tXm-0007ve-Bj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685430799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oBoBSLJnjqZdX2BFSRWq6y3cLfvPWot5qpz31X4KC10=;
 b=MfP6IaW9Jw0xH74hCKSq/WuoiwYVn8UGObGEPZFUjJofHvmvSmSMO/O47duyeb85fzK2BL
 k8/aNIXRqfcRZGrcCgVwNtfbWbQ/gOX8DfjlYuQySFKr1Q8iYC2tCLvSMxfTCIX2rVW6RI
 FxZpP+KmFJGH0RujCCUw7dDAxKZmCF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-elLsXvsCOAijFLmtR14Ogw-1; Tue, 30 May 2023 03:13:15 -0400
X-MC-Unique: elLsXvsCOAijFLmtR14Ogw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4EBE80120A;
 Tue, 30 May 2023 07:13:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83DBE112132C;
 Tue, 30 May 2023 07:13:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7902121E692E; Tue, 30 May 2023 09:13:13 +0200 (CEST)
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
Date: Tue, 30 May 2023 09:13:13 +0200
In-Reply-To: <2837b5c4-2f70-c6b2-8309-13c40540ec1d@nutanix.com> (Het Gala's
 message of "Mon, 29 May 2023 17:03:45 +0530")
Message-ID: <875y8auwae.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On 25/05/23 11:20 pm, Markus Armbruster wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> MigrateChannelList allows to connect accross multiple interfaces. Added
>>> MigrateChannelList struct as argument to migration QAPIs.
>>>
>>> Future patchset series plans to include multiple MigrateChannels
>>> for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
>>> is the preferred choice of argument over 'MigrateChannel' and making
>>> migration QAPIs future proof.
>>>
>>> For current patchset series, have limited the size of the list to single
>>> element (single interface) as runtime check.
>>>
>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>> ---
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index c500744bb7..86bbc916d1 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1448,12 +1448,47 @@
>>>       'exec': 'MigrateExecCommand',
>>>       'rdma': 'InetSocketAddress' } }
>>>   +##
>>> +# @MigrateChannelType:
>>
>> As mentioned in my review of PATCH 1, I prefer nouns to verbs for types,
>> i.e.  Migration, not Migrate.  More of the same below, not flagging it
>> again.
>>
> Ack.
>
> Also, I forgot ot mention in the 1st patch - even for union and struct namings - nouns are preffered over verbs ? or its just for enum types ?
> We use structs like - MigrateExecCommand, MigrateChannel --> MigrationExecCommand, MigrationChannel ?
> and union like - MigrateAddress --> MigrationAddress ?

The "types are things, and names of things are nouns" argument applies
to all types.

Yes, existing names use verbs in places.  Mildly annoying.

Renaming them would not create compatibility problems, as types are not
part of the external interface.  Up to migration maintainers.

>>> +#
>>> +# The supported options for migration channel type requests
>>> +#
>>> +# @main: Support request for main outbound migration control channel
>>> +#
>>> +# Since 8.1
>>> +##
>>> +{ 'enum': 'MigrateChannelType',
>>> +  'data': [ 'main' ] }
>>> +
>>> +##
>>> +# @MigrateChannel:
>>> +#
>>> +# Information regarding migration Channel-type for transferring packets,
>>> +# source and corresponding destination interface for socket connection
>>> +# and number of multifd channels over the interface.
>>> +#
>>> +# @channeltype: Name of Channel type for transfering packet information
>>
>> @channel-type, because "channeltype" is not a word.
>
> Ack.
>
>>> +#
>>> +# @addr: Information regarding migration parameters of destination interface
>>> +#
>>> +# Since 8.1
>>> +##
>>> +{ 'struct': 'MigrateChannel',
>>> +  'data': {
>>> +       'channeltype': 'MigrateChannelType',
>>> +       'addr': 'MigrateAddress' } }
>>> +
>>>   ##
>>>   # @migrate:
>>>   #
>>>   # Migrates the current running guest to another Virtual Machine.
>>>   #
>>>   # @uri: the Uniform Resource Identifier of the destination VM
>>> +#       for migration thread
>>> +#
>>> +# @channels: Struct containing list of migration channel types, with all
>>> +#            the information regarding destination interfaces required for
>>> +#            initiating a migration stream.
>>
>> Please format like
>>
>>     # @uri: the Uniform Resource Identifier of the destination VM for
>>     #     migration thread
>>     #
>>     # @channels: Struct containing list of migration channel types, with
>>     #     all the information regarding destination interfaces required
>>     #     for initiating a migration stream.
>>
>> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
>> to conform to current conventions).
>
> Ack. Will change that in the previous patch and will take care in future patches too. Thanks for informing regarding qapi documentation changes!

Gladly!  It's the only way to make the nicer formatting stick :)

>>>   #
>>>   # @blk: do block migration (full disk copy)
>>>   #
>>> @@ -1479,14 +1514,44 @@
>>>   # 3. The user Monitor's "detach" argument is invalid in QMP and should
>>>   #    not be used
>>>   #
>>> +# 4. The uri argument should have the Uniform Resource Identifier of default
>>> +#    destination VM. This connection will be bound to default network
>>> +#
>>> +# 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
>>> +#    of the two should be present.
>>> +#
>> Long lines.  Better:
>>
>>     # 4. The uri argument should have the Uniform Resource Identifier of
>>     #    default destination VM.  This connection will be bound to default
>>     #    network
>>     #
>>     # 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly
>>     #    one of the two should be present.
> Ack.
>>>   # Example:
>>>   #
>>>   # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>>>   # <- { "return": {} }
>>> +# -> { "execute": "migrate",
>>> +#      "arguments": {
>>> +#          "channels": [ { "channeltype": "main",
>>> +#                          "addr": { "transport": "socket", "type": "inet",
>>> +#                                    "host": "10.12.34.9",
>>> +#                                    "port": "1050" } } ] } }
>>> +# <- { "return": {} }
>>> +#
>>> +# -> { "execute": "migrate",
>>> +#      "arguments": {
>>> +#          "channels": [ { "channeltype": "main",
>>> +#                          "addr": { "transport": "exec",
>>> +#                                    "args": [ "/bin/nc", "-p", "6000",
>>> +#                                              "/some/sock" ] } } ] } }
>>> +# <- { "return": {} }
>>> +#
>>> +# -> { "execute": "migrate",
>>> +#      "arguments": {
>>> +#          "channels": [ { "channeltype": "main",
>>> +#                          "addr": { "transport": "rdma",
>>> +#                                    "host": "10.12.34.9",
>>> +#                                    "port": "1050" } } ] } }
>>> +# <- { "return": {} }
>>> +#
>>>   ##
>>>   { 'command': 'migrate',
>>> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
>>> -           '*detach': 'bool', '*resume': 'bool' } }
>>> +  'data': {'*uri': 'str', '*channels': [ 'MigrateChannel' ], '*blk': 'bool',
>>> +           '*inc': 'bool', '*detach': 'bool', '*resume': 'bool' } }
>>>     ##
>>>   # @migrate-incoming:
>>> @@ -1497,6 +1562,10 @@
>>>   # @uri: The Uniform Resource Identifier identifying the source or
>>>   #     address to listen on
>>>   #
>>> +# @channels: Struct containing list of migration channel types, with all
>>> +#            the information regarding destination interfaces required for
>>> +#            initiating a migration stream.
>>> +#
>>
>> The list doesn't contain migration channel types, it contains migration
>> channels.
>
> Yes, my bad. Will update it.

Writing good documentation is hard!

>> I'm not sure what you're trying to say by "with all the information ..."
>>
>> What does it mean to have multiple channels?
>
> In future patchset series, we will be introducing channels over different interfaces (src-dest pair), with each channel having multiple multifd channels. For now we will restrict the size of the list to 1.

Please document this restriction right here.

When you add support for multiple channels, will each channel have a
unique channel type?

[...]


