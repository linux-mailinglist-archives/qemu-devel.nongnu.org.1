Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657572E31E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 14:34:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93D9-0002Fs-8S; Tue, 13 Jun 2023 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q93D6-0002Ef-7e
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q93D4-0005x4-94
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686659596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKSDkU2A7wmba1s6C9/Q8lVk50YwJgRZvIQeMwtVqBY=;
 b=UB9ymOIT+3+LhMoSXqUuQHza19Yu3+eIjpZScx/4gGufTfOQBEVYhZD7dWObe72tnqcYMe
 s4YV5rKocUlHw8BrvXdti4GB09La9eOWEUgoRDr27ZhHMG4pzggEuei/KdBQRJ5Rb6Tfl1
 11Lxys6w5ArjxlB4qaN6eZ40XyqJSh4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-YGG_jYxmNOKR3N7lMqGcxg-1; Tue, 13 Jun 2023 08:33:13 -0400
X-MC-Unique: YGG_jYxmNOKR3N7lMqGcxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C774F29AA2C5;
 Tue, 13 Jun 2023 12:33:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 883A940C20F5;
 Tue, 13 Jun 2023 12:33:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9914221E677D; Tue, 13 Jun 2023 14:33:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,  Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH V2 1/4] qapi: strList_from_string
References: <1675795727-235010-1-git-send-email-steven.sistare@oracle.com>
 <1675795727-235010-2-git-send-email-steven.sistare@oracle.com>
 <CAJ+F1CLFMUDvaOq2QXCKpb8Zj4PRr-tKV1q9L8m2EfgORPLj7A@mail.gmail.com>
 <32f34f74-213d-7107-907d-dda0a509878e@oracle.com>
 <87h6vwnstx.fsf@linaro.org> <87cz6j6tt0.fsf@pond.sub.org>
 <d25846e4-13fd-c683-b5e1-1660f4470d35@oracle.com>
 <875yca23dd.fsf@pond.sub.org>
 <7beaf84a-008e-c9a3-3698-2a230196acf9@oracle.com>
 <87cz6izmtz.fsf@pond.sub.org>
 <1bb65a74-d444-7601-47d3-290959239831@oracle.com>
 <87sffdvpmu.fsf@pond.sub.org>
 <555c8a46-a530-c258-8614-0485536c60ee@oracle.com>
Date: Tue, 13 Jun 2023 14:33:11 +0200
In-Reply-To: <555c8a46-a530-c258-8614-0485536c60ee@oracle.com> (Steven
 Sistare's message of "Wed, 7 Jun 2023 09:54:35 -0400")
Message-ID: <87legnee48.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 2/10/2023 4:25 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>> 
>>> On 2/9/2023 1:59 PM, Markus Armbruster wrote:
>>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>>> On 2/9/2023 11:46 AM, Markus Armbruster wrote:
>>>>>> Steven Sistare <steven.sistare@oracle.com> writes:
>> 
>> [...]
>> 
>>>>>>> For more context, this patch has been part of my larger series for live update,
>>>>>>> and I am submitting this separately to reduce the size of that series and make
>>>>>>> forward progress:
>>>>>>>     https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/
>>>>>>>
>>>>>>> In that series, strList_from_string is used to parse a space-separated list of args
>>>>>>> in an HMP command, and pass them to the new qemu binary.
>>>>>>>     https://lore.kernel.org/qemu-devel/1658851843-236870-16-git-send-email-steven.sistare@oracle.com/
>>>>>>>
>>>>>>> I moved and renamed the generalized function because I thought it might be useful
>>>>>>> to others in the future, along with the other functions in this 'string list functions'
>>>>>>> patch series.  But if you disagree, I can minimally modify hmp_split_at_comma() in its 
>>>>>>> current location.
>>>>>>
>>>>>> I'm fine with moving it out of monitor/ if there are uses outside the
>>>>>> monitor.  I just don't think qapi/ is the right home.
>>>>>
>>>>> I don't know where else it would go, as strList is a QAPI type.
>>>>> include/qapi/util.h already defines QAPI_LIST_PREPEND and QAPI_LIST_APPEND, so it
>>>>> seems like the natural place to add qapi strList functions.  I am open to
>>>>> suggestions.
>>>>
>>>> What about util/?  Plenty of QAPI use there already.
>>>>
>>>> Another thought.  Current hmp_split_at_comma() does two things:
>>>>
>>>>     strList *hmp_split_at_comma(const char *str)
>>>>     {
>>>>
>>>> One, split a comma-separated string into NULL-terminated a dynamically
>>>> allocated char *[]:
>>>>
>>>>         char **split = g_strsplit(str ?: "", ",", -1);
>>>>
>>>> Two, convert a dynamically allocated char *[] into a strList:
>>>>
>>>>         strList *res = NULL;
>>>>         strList **tail = &res;
>>>>         int i;
>>>>
>>>>         for (i = 0; split[i]; i++) {
>>>>             QAPI_LIST_APPEND(tail, split[i]);
>>>>         }
>>>>
>>>>         g_free(split);
>>>>         return res;
>>>>     }
>>>>
>>>> Part two could live in qapi/.
>>>
>>> Works for me.
>> 
>> Note that I'm not demanding such a split.  I'm merely throwing in
>> another idea for you to use or reject.
>
> I decided to not split the function.  IMO having part 2 free memory allocated
> by its caller is not clean.
>
> However, I will base it on your original function, slightly modified:
>
> strList *strList_from_string(const char *str, char *delim)
> {
>     g_autofree char **split = g_strsplit(str ?: "", delim, -1);
>     strList *res = NULL;
>     strList **tail = &res;
>
>     for (; *split; split++) {
>         QAPI_LIST_APPEND(tail, *split);
>     }
>
>     return res;
> }
>
>>> For future reference, what is your organizing principle for putting things in 
>>> qapi/ vs util/ ?  I see plenty of calls to g_str* functions from qapi/*, so I 
>>> don't know why removing g_strsplit changes the answer.
>>>
>>> Per your principle, where does strv_from_strList (patch 3) belong?  And if I
>>> substitute char ** for GStrv, does the answer change?
>> 
>> As is, qapi/qapi-util provides:
>> 
>> 1. Helpers for qapi/ and QAPI-generated code.  Some of them are
>>    used elsewhere, too.  That's fine.
>> 
>> 2. Tools for working with QAPI data types such as GenericList.
>> 
>> strv_from_strList() would fall under 2.  Same if you use char **
>> instead.
>> 
>> hmp_split_at_comma() admittedly also falls under 2.  I just dislike
>> putting things under qapi/ that contradict QAPI design principles.
>
> What design principle does strList_from_string contradict?  Are you OK with 
> putting the simplified version shown above in qapi-util?

The design principle is "use JSON to encode structured data as text in
QAPI/QMP".

Do: "mumble": [1, 2, 3]

Don't: "mumble": "1,2,3"

We violate the principle in a couple of places.  Some are arguably
mistakes, some are pragmatic exceptions.

The principle implies "the only parser QAPI needs is the JSON parser".

By adding other parsers to QAPI, we send a misleading signal, namely
that encoding structured data in a way that requires parsing is okay.
It's not, generally.

So, I'd prefer to find another home for code that splits strings at
comma / delimiter.

> (and apologies for my long delay in continuing this conversation).

I'm in no position to take offense there ;)

> - Steve
>
>> 
>> util/ is a bit of a grabbag, I feel.  Perhaps we could describe it as
>> "utilities that don't really fit into a particular subsystem".
>> 
>> Does this help you along?


