Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83606748484
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH261-0008Qr-4M; Wed, 05 Jul 2023 08:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qH25k-0008JQ-Cy
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qH25i-0002CI-OR
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688561920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mV3vLJfyNbwGHOzrrh7qOLBeHUKTIh8A57p64L5haNY=;
 b=CyllTlM2w0Pq217vxE/LikOxKLrido5Gm+bYsmrRgHOTd1i/cV/TX3vwaZnhrzuvfcwiLk
 W0eCyQ8Sg5q1dlZcEJpOE7cq21i3DhsS4Z4zJEfx8Q0Bk7+rBJtZ1NJ042dMOqhY7kgEfd
 As4PAcC/uYuSFyv80SzW1exwBSU13Ro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-YWOlwGvZOLOXMwKhSN06hQ-1; Wed, 05 Jul 2023 08:58:37 -0400
X-MC-Unique: YWOlwGvZOLOXMwKhSN06hQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08DF9185A7B3;
 Wed,  5 Jul 2023 12:58:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D90EE4CD0C8;
 Wed,  5 Jul 2023 12:58:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC46E21E6A1F; Wed,  5 Jul 2023 14:58:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v6 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-2-het.gala@nutanix.com>
 <87cz16iox5.fsf@pond.sub.org>
 <696fa0ec-1c36-f245-80d1-e65fa60d5368@nutanix.com>
Date: Wed, 05 Jul 2023 14:58:35 +0200
In-Reply-To: <696fa0ec-1c36-f245-80d1-e65fa60d5368@nutanix.com> (Het Gala's
 message of "Wed, 5 Jul 2023 18:19:20 +0530")
Message-ID: <87jzvefrb8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> On 05/07/23 4:51 pm, Markus Armbruster wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>
>>> This patch introduces well defined MigrateAddress struct and its related
>>> child objects.
>>>
>>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
>>> is of string type. The current migration flow follows double encoding
>>> scheme for  fetching migration parameters such as 'uri' and this is
>>> not an ideal design.
>>>
>>> Motive for intoducing struct level design is to prevent double encoding
>>> of QAPI arguments, as Qemu should be able to directly use the QAPI
>>> arguments without any level of encoding.
>>>
>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>   qapi/migration.json | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 45 insertions(+)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 179af0c4d8..e61d25eba2 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1407,6 +1407,51 @@
>>> ##
>>> { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>>> +##
>>> +# @MigrationAddressType:
>>> +#
>>> +# The migration stream transport mechanisms.
>>> +#
>>> +# @socket: Migrate via socket.
>>> +#
>>> +# @exec: Direct the migration stream to another process.
>>> +#
>>> +# @rdma: Migrate via RDMA.
>>> +#
>>> +# Since 8.1
>>> +##
>>> +{ 'enum': 'MigrationAddressType',
>>> +  'data': ['socket', 'exec', 'rdma'] }
>>> +
>>> +##
>>> +# @MigrationExecCommand:
>>> +#
>>> +# @args: list of commands for migraton stream execution to a file.
>>
>> Typo: migration
>>
>>> +#
>>> +# Notes:
>>> +#
>>> +# 1. @args[0] needs to be the path to the new program.
>>
>> @args can't be a "list of commands", as we're spawning just one process.
>> So what is it?
>>
>> Digging through the code with the entire series applied...  Member @args
>> is used in two places:
>>
>> 1. qemu_start_incoming_migration() passes it to
>>     exec_start_incoming_migration(), which translates it into an array
>>     and passes it to qio_channel_command_new_spawn().
>>
>> 2. qmp_migrate() passes it to exec_start_outgoing_migration(), which
>>     does the same.
>>
>> qio_channel_command_new_spawn() passes it to
>> g_spawn_async_with_pipes().  A close read of the latter's documentation
>> leads me to:
>>
>> * args[0] is the excutable's file name.  As usual, a relative name is
>>    relative to the QEMU process's current working directory.
>>
>> * args[1..] are the arguments.
>>
>> Unlike POSIX interfaces like execv() and posix_spawn(), this doesn't
>> separate the executable's file name and 0-th argument.
>>
>> In short, the head of @args is the executable's filename, and the
>> remainder are the arguments.  The fact that the the executable's
>> filename is passed as 0-th argument to the child process is detail.
>>
>> Perhaps this could do:
>>
>>     ##
>>     # @MigrationExecCommand:
>>     #
>>     # @args: command and arguments to execute.
>>
>> If we want more detail, perhaps:
>>
>>     # @args: command (list head) and arguments (list tail) to execute.
>>
>> Not sure we need it.  Thoughts?
>
> From a user prespective, I think defining that command / executable's fil=
ename is the list head would be good ? something like
>
> @args: command (list head) and arguments to execute.

Works for me.

[...]


