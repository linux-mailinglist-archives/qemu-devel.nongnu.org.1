Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C983055B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:34:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ56M-0007RF-MF; Wed, 17 Jan 2024 07:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ56C-0007Qq-LT
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ56A-0000OS-Rz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705494769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88mwxirlwTxTeHU1PhzyCcmQ43qaOo2lNSyRkPSgI5I=;
 b=KBhaK7o0NjwpS2+Qxrv7QeWHrJEd1USV9GFFqsjVPv3DEci+4IClZGLmNdUBIhpExeRT+K
 TfEPFoDk9VXzljA4YzhC2fjiEKdLOe6gdJzXjIEArF/GfK+nMOqOACvDCPUDTkr5h3QECs
 jWH9oqLNNggPNksgvFCLzDCmNZ4rSzM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-ihlpQbqjMdacmCiF8FmD2Q-1; Wed,
 17 Jan 2024 07:32:46 -0500
X-MC-Unique: ihlpQbqjMdacmCiF8FmD2Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43FBE1C04336;
 Wed, 17 Jan 2024 12:32:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2180F492BE6;
 Wed, 17 Jan 2024 12:32:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A0DE21E66F1; Wed, 17 Jan 2024 13:32:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org,  aliang@redhat.com,  stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] string-output-visitor: Fix (pseudo) struct handling
In-Reply-To: <ZaVKzg9PxyqvXh5A@redhat.com> (Kevin Wolf's message of "Mon, 15
 Jan 2024 16:10:06 +0100")
References: <20240109181717.42493-1-kwolf@redhat.com>
 <87mstcxfdx.fsf@pond.sub.org> <ZaVKzg9PxyqvXh5A@redhat.com>
Date: Wed, 17 Jan 2024 13:32:45 +0100
Message-ID: <87r0igjg2a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 11.01.2024 um 12:45 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Commit ff32bb53 tried to get minimal struct support into the string
>> > output visitor by just making it return "<omitted>". Unfortunately, it
>> > forgot that the caller will still make more visitor calls for the
>> > content of the struct.
>> >
>> > If the struct is contained in a list, such as IOThreadVirtQueueMapping,
>> > in the better case its fields show up as separate list entries. In the
>> > worse case, it contains another list, and the string output visitor
>> > doesn't support nested lists and asserts that this doesn't happen.
>> 
>> What it actually asserts, or rather tries to assert is this constraint
>> from visit_end_list()'s contract:
>> 
>>  * @list must match what was passed to the paired visit_start_list().
>> 
>> Since it's not prepared for nested lists, it actually asserts "match
>> what was passed the last visit_start_list() for this visitor", which is
>> correct only as long as there is no nesting.
>> 
>> I'm not sure whether this is relevant enough to justify tweaking your
>> commit message.
>
> Ah, yes, I see the assertion in end_list() that you mean. That one looks
> like it would indeed fail if we didn't already crash on the nested
> start_list():
>
>     /* we can't traverse a list in a list */
>     assert(sov->list_mode == LM_NONE);

True.

>> > doesn't support nested lists and asserts that this doesn't happen. So as
>> > soon as the optional "vqs" field in IOThreadVirtQueueMapping is
>> > specified, we get a crash.
>> >
>> > This can be reproduced with the following command line:
>> >
>> >   echo "info qtree" | ./qemu-system-x86_64 \
>> >     -object iothread,id=t0 \
>> >     -blockdev null-co,node-name=disk \
>> >     -device '{"driver": "virtio-blk-pci", "drive": "disk",
>> >               "iothread-vq-mapping": [{"iothread": "t0", "vqs": [0]}]}' \
>> >     -monitor stdio
>> 
>> Appreciate the easy reproducer.
>> 
>> > Fix the problem by counting the nesting level of structs and ignoring
>> > any visitor calls for values (apart from start/end_struct) while we're
>> > not on the top level.
>> >
>> > Fixes: ff32bb53476539d352653f4ed56372dced73a388
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2069
>> > Reported-by: Aihua Liang <aliang@redhat.com>
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

[...]

>> @struct_nesting is what its name suggests: the *struct* nesting level.
>> 
>> The patch's idea is to turn all methods into no-ops inside a struct.  To
>> make that work, start_struct() and end_struct() aren't actually no-ops;
>> they track the nesting level.
>> 
>> What about nested lists that are not inside any struct?
>
> They remain forbidden, we don't currently have a use case for them.
>
> Nesting inside of structs is easy to "support" because we don't actually
> print any of the values inside of them anyway. If you wanted to support
> list nesting where the value is actually meant to be printed, you'd
> first need to define what the output should look like and then implement
> that. I consider that a separate problem from what this patch fixes.

Fair enough.  Mention it in the commit message?  Perhaps "Lists nested
within lists remain unimplemented, as we don't currently have a use case
for them."

>> Ceterum censeo: the struct visitors need to go.  But I'm *not* asking
>> you to do that now.
>
> I assume you mean string visitors.

Yes.  I blame dabbrev-expand :)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


