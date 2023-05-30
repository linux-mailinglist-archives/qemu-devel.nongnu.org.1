Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671677155F6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tJz-0005Wc-9z; Tue, 30 May 2023 02:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3tJb-0005WM-9a
 for qemu-devel@nongnu.org; Tue, 30 May 2023 02:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3tJZ-0006Jy-Ba
 for qemu-devel@nongnu.org; Tue, 30 May 2023 02:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685429915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dF6AfVm0LBhbiyvpeo9Kgih9zaxzrt3wWJK3+EEGK1w=;
 b=VbTskPWxHIGeElcq9uTHU5B7bLowUCbQm2Wxyk83ZdeqCZ+qS2X6+2alt2x7pKAxfXhtYB
 ob7Oe3ymZQ35WjEFZ/WuQSMniF4UMPgguS3SJbSGSQWzNw5lcYeZjMwmNj0g4NyAumDygF
 OlaTecSZhwLHyZxsBKypGyQaX8xDcTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-9bhX8XgyM9WOSqfkDCCyLQ-1; Tue, 30 May 2023 02:58:18 -0400
X-MC-Unique: 9bhX8XgyM9WOSqfkDCCyLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB74B8060A6;
 Tue, 30 May 2023 06:58:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DD7B140E954;
 Tue, 30 May 2023 06:58:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A1CE21E692E; Tue, 30 May 2023 08:58:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com>
 <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
Date: Tue, 30 May 2023 08:58:15 +0200
In-Reply-To: <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com> (Het Gala's
 message of "Mon, 29 May 2023 15:07:17 +0530")
Message-ID: <87edmyuwzc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On 25/05/23 11:04 pm, Markus Armbruster wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> This patch introduces well defined MigrateAddress struct and its relate=
d child
>>> objects.
>>>
>>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' =
is of
>>> string type. The current migration flow follows double encoding scheme =
for
>>> fetching migration parameters such as 'uri' and this is not an ideal de=
sign.
>>>
>>> Motive for intoducing struct level design is to prevent double encoding=
 of QAPI
>>> arguments, as Qemu should be able to directly use the QAPI arguments wi=
thout
>>> any level of encoding.
>>>
>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>   qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 179af0c4d8..c500744bb7 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1407,6 +1407,47 @@
>>>   ##
>>>   { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'}=
 }
>>>   +##
>>> +# @MigrateTransport:
>>
>> I'd prefer MigrationTransport, because "migration" is a noun, while
>> migrate is a verb.  Verbs are for commands.  For types we use nouns.
>> More of the same below, not noting it again.
>>
>> Actually, I'd prefer MigrationAddressType, because it's purpose is to
>> serve as discriminator type in union MigrationAddress.
>>
> Okay got it. I kept it Transport as they are different transport mechanis=
ms. But 'MigrationAddressType' looks cleaner and comaptible with 'MigrateAd=
dress' union too. Will change that

Transport isn't bad, but I think a type that is only used for a union
discriminator is best named after the union type.

>>> +#
>>> +# The supported communication transport mechanisms for migration
>>> +#
>>> +# @socket: Supported communication type between two devices for migrat=
ion.
>>> +#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
>>> +#          'fd' already
>>
>> Migration is between hosts, not "two devices".
>
> Here we are just talking about socket communication right ? So I thought =
devices might also work.

In QEMU, "devices" are the things you create with device_add.

Sockets connect "endpoints".  Also called "peers".

> Will change that to 'hosts' as this is in context of migration i.e. Migra=
ttionAddressType
>
>> The second sentence confuses me.  What are you trying to say?
>
> I am trying to say that socket is a union in itslef right, so it covers c=
ommunication transport mechanisms like tcp, unix, vsock and fd already in i=
t.
>
>> Also, missing period at the end.
>
> Ack.
>
>>> +#
>>> +# @exec: Supported communication type to redirect migration stream int=
o file.
>>> +#
>>> +# @rdma: Supported communication type to redirect rdma type migration =
stream.
>> What about:
>>
>>     ##
>>     # @MigrationTransport:
>>     #
>>     # The migration stream transport mechanisms
>>     #
>>     # @socket: Migrate via socket
>>     #
>>     # @rdma: Migrate via RDMA
>>     #
>>     # @file: Direct the migration stream to a file
>
> Should I change from '@exec' to '@file' ?

Uh, that change happened somewhere between my conscious thought process
and the keyboard ;)

What about

       # @exec: Direct the migration stream to another process

> Other than that, it looks better than what I proposed. Will change it.
>
>>> +#
>>> +# Since 8.1
>>> +##
>>> +{ 'enum': 'MigrateTransport',
>>> +  'data': ['socket', 'exec', 'rdma'] }
>>> +
>>> +##
>>> +# @MigrateExecCommand:
>
>> Documentation of @args is missing.
>
> Ack. Should the naming '@args' be replaced by '@filepath' or @path' or so=
mething similar ?

Depends on what @args means.

I guess its [program, arg1, arg2, ...].

You could split off the program:

    'program: 'str',
    'args': [ 'str' ]

Try to write clear documentation for both alternatives.  Such an
exercise tends to lead me to the one I prefer.

>>> + #
>>> + # Since 8.1
>>> + ##
>>
>> Unwanted indentation.
>
> Not able to see any unwanted indentation here ?

Looks like it got eaten on the way.  The last three lines of the doc
comment are indented:

    +##
    +# @MigrateExecCommand:
    + #
    + # Since 8.1
    + ##
    +{ 'struct': 'MigrateExecCommand',
    +   'data': {'args': [ 'str' ] } }

>>> +{ 'struct': 'MigrateExecCommand',
>>> +   'data': {'args': [ 'str' ] } }
>>> +
>>> +##
>>> +# @MigrateAddress:
>>> +#
>>> +# The options available for communication transport mechanisms for mig=
ration
>> Not happy with this sentence (writing good documentation is hard).
>>
>> Is the address used for the destination only, or for the source as well?
>>
>> If destination only, could it be used for the source at least in theory?
>>
>> I'm asking because I need to understand more about intended use to be
>> able to suggest doc improvements.
>
> This address will be used on both destination and source. In code flow, i=
n later patches, changes on destination as well as source have been made to=
 incorporate same definition.

Does @exec work as source?

Maybe:

     # Endpoint address for migration

or

     # Migration endpoint configuration

>>> +#
>>> +# Since 8.1
>>> +##
>>> +{ 'union': 'MigrateAddress',
>>> +  'base': { 'transport' : 'MigrateTransport'},
>>> +  'discriminator': 'transport',
>>> +  'data': {
>>> +    'socket': 'SocketAddress',
>>> +    'exec': 'MigrateExecCommand',
>>> +    'rdma': 'InetSocketAddress' } }
>>> +
>> Aside: a more powerful type system would let us extend SocketAddress
>> with additional variants instead of wrapping it in a union.
>
> Markus, what do you mean by additional variants here in context of socket=
? Can you give a small example.

As is, we have a nest of two unions:

* The outer union has branches @socket, @exec, @rdma.

* Branch @socket is the inner union, it has branches @inet, @unix, ...

A more powerful type system would let us extend SocketAddress instead,
so MigrateAddress has everything SocketAddress has, plus additional
branches @exec, @rdma.  Naturally, the type of the discriminator also
needs to be extended, so that it has everything SocketAddress's
discriminator type has, plus additional members @exec, @rdma.


