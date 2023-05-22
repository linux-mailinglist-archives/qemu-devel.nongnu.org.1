Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB60E70BD39
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14Q6-0003yk-64; Mon, 22 May 2023 08:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q14Q2-0003yK-MO
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q14Q0-0004ZE-GT
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684757618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QV1k4H/wDVVFm/Go5OzXEukJIYy1vNrLfnJMs4XiTn8=;
 b=gEbKylPf3ZlqPRcsUveEZLDIaStDDFlPNvDgIIriv6QekwMRfui6enqDbhMJoZb6YmhY8m
 MsF+yaWmXw9CoFuSgU2FJJt8mlFNrBBcTv5uk77B3aXJzSSun88sEJocEFH2iUOpjrcVrD
 39I+Ph/VR5kgRQnIJFV80ZXVkGcdTTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-PYU0x__jNQ6prcaKMNzTJg-1; Mon, 22 May 2023 08:13:35 -0400
X-MC-Unique: PYU0x__jNQ6prcaKMNzTJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4349A800141;
 Mon, 22 May 2023 12:13:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F4AC575E2;
 Mon, 22 May 2023 12:13:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C507D21E692E; Mon, 22 May 2023 14:13:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,
 eblake@redhat.com,  eduardo@habkost.net,  berrange@redhat.com,
 pbonzini@redhat.com,  marcel.apfelbaum@gmail.com,  philmd@linaro.org,
 antonkuchin@yandex-team.ru,  den-plotnikov@yandex-team.ru
Subject: Re: [PATCH v7 1/4] qapi/qdev.json: unite DEVICE_* event data into
 single structure
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-2-vsementsov@yandex-team.ru>
 <20230518160434-mutt-send-email-mst@kernel.org>
 <87a5xwogw0.fsf@pond.sub.org>
 <0b692f6f-4d9a-60be-e1c0-9aa0f7869eed@yandex-team.ru>
Date: Mon, 22 May 2023 14:13:33 +0200
In-Reply-To: <0b692f6f-4d9a-60be-e1c0-9aa0f7869eed@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 22 May 2023 14:43:07 +0300")
Message-ID: <87h6s4k1hu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 22.05.23 12:27, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>>> On Fri, Apr 21, 2023 at 01:32:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> DEVICE_DELETED and DEVICE_UNPLUG_GUEST_ERROR has equal data, let's
>>>> refactor it to one structure. That also helps to add new events
>>>> consistently.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>
>>> Can QAPI maintainers please review this patchset?
>>> It's been a month.
>> 
>> It's been a busy month; sorry for the delay.
>> 
>>>> ---
>>>>   qapi/qdev.json | 39 +++++++++++++++++++++++++++------------
>>>>   1 file changed, 27 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>>> index 2708fb4e99..135cd81586 100644
>>>> --- a/qapi/qdev.json
>>>> +++ b/qapi/qdev.json
>>>> @@ -114,16 +114,37 @@
>>>>   { 'command': 'device_del', 'data': {'id': 'str'} }
>>>>   
>>>>   ##
>>>> -# @DEVICE_DELETED:
>>>> +# @DeviceAndPath:
>>>>   #
>>>> -# Emitted whenever the device removal completion is acknowledged by the guest.
>>>> -# At this point, it's safe to reuse the specified device ID. Device removal can
>>>> -# be initiated by the guest or by HMP/QMP commands.
>>>> +# In events we designate devices by both their ID (if the device has one)
>>>> +# and QOM path.
>>>> +#
>>>> +# Why we need ID? User specify ID in device_add command and in command line
>>>> +# and expects same identifier in the event data.
>>>> +#
>>>> +# Why we need QOM path? Some devices don't have ID and we still want to emit
>>>> +# events for them.
>>>> +#
>>>> +# So, we have a bit of redundancy, as QOM path for device that has ID is
>>>> +# always /machine/peripheral/ID. But that's hard to change keeping both
>>>> +# simple interface for most users and universality for the generic case.
>> 
>> Hmm.  I appreciate rationale, but I'm not sure it fits here.  Would
>> readers be worse off if we dropped it?
>
> Is there a syntax to add comment to the QAPI structure, which doesn't go into compiled public documentation?

Yes!  qapi-code-gen.rst: "A multi-line comment that starts and ends with
a ``##`` line is a documentation comment."  All other comments are not,
and won't be included in generated documentation.

Example: qapi/qapi-schema.json has

    { 'include': 'pragma.json' }

    # Documentation generated with qapi-gen.py is in source order, with
    # included sub-schemas inserted at the first include directive
    # (subsequent include directives have no effect).  To get a sane and
    # stable order, it's best to include each sub-schema just once, or
    # include it first right here.

    { 'include': 'error.json' }

Not a documentation comment, thus not included in generated
documentation.

Additionally, TODO sections in documentation comments are omitted from
generated documentation.  qapi-code-gen.rst again: "TODO" sections are
not rendered at all (they are for developers, not users of QMP).

> I agree that we don't need this in compiled documentation, but this place in the code really good for the rationale, to avoid starting the discussion from the beginning again.

Saving rationale so we can refer to it later is good.  We tend to use
commit messages for that.  I'd say use comments when the rationale needs
to be more visible.

[...]


