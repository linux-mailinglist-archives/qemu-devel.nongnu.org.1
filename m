Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5514788424
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 11:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTYS-0005Hd-Gz; Fri, 25 Aug 2023 05:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZTYQ-0005Gp-A3
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZTYM-0008E5-TZ
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692957390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvN6Uo7ikcbi51OMRTPCYgMggTwGr8dnUllq2gPWpn0=;
 b=H15v7gRiM+x+pgUw4GvPLabeS2e8+pIArDaRaMPGZOF8gsOT2zlfEnw85i8jt+FMDroT1M
 A06QNtTXniRzAEyWE2XXe7CUEn5sdnPsv3V1V7mv0lm7cQhcd/tHax9OyWM2DvXYLf8YW1
 Xps8JjP9FD0LvloPbWd7gk3mKRDAHCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-ksbRS9uUPZOyutnxwDiNgQ-1; Fri, 25 Aug 2023 05:56:26 -0400
X-MC-Unique: ksbRS9uUPZOyutnxwDiNgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ECAD185A791;
 Fri, 25 Aug 2023 09:56:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCAFB6B2B4;
 Fri, 25 Aug 2023 09:56:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D56C021E690D; Fri, 25 Aug 2023 11:56:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,  qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel =?utf-8?Q?P?=
 =?utf-8?Q?=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  Greg Kurz
 <groug@kaod.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
 <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
 <e81b5069-e49a-cfb4-bea9-3c7ab6a358ca@redhat.com>
 <87msyfo5b0.fsf@pond.sub.org>
 <bd8f7f13-b982-6cf6-1ef7-16b4738b94ac@redhat.com>
Date: Fri, 25 Aug 2023 11:56:24 +0200
In-Reply-To: <bd8f7f13-b982-6cf6-1ef7-16b4738b94ac@redhat.com> (David
 Hildenbrand's message of "Fri, 25 Aug 2023 11:13:02 +0200")
Message-ID: <87sf87momv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

David Hildenbrand <david@redhat.com> writes:

> On 25.08.23 11:10, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 25.08.23 08:57, ThinerLogoer wrote:
>>>> Hello,
>>>>
>>>> At 2023-08-23 23:34:11, "David Hildenbrand" <david@redhat.com> wrote:
>>>>> For migration purposes, users might want to reuse the default RAM
>>>>> backend id, but specify a different memory backend.
>>>>>
>>>>> For example, to reuse "pc.ram" on q35, one has to set
>>>>>      -machine q35,memory-backend=pc.ram
>>>>> Only then, can a memory backend with the id "pc.ram" be created
>>>>> manually.
>>>>>
>>>>> Let's improve the error message.
>>>>>
>>>>> Unfortuantely, we cannot use error_append_hint(), because the caller
>>>>> passes &error_fatal.
>>>>>
>>>>> Suggested-by: ThinerLogoer <logoerthiner1@163.com>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>> hw/core/machine.c | 4 +++-
>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>> index f0d35c6401..dbcd124d45 100644
>>>>> --- a/hw/core/machine.c
>>>>> +++ b/hw/core/machine.c
>>>>> @@ -1382,7 +1382,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>>>>                                    machine_class->default_ram_id)) {
>>>>>               error_setg(errp, "object name '%s' is reserved for the default"
>>>>>                   " RAM backend, it can't be used for any other purposes."
>>>>> -                " Change the object's 'id' to something else",
>>>>> +                " Change the object's 'id' to something else or disable"
>>>>> +                " automatic creation of the default RAM backend by setting"
>>>>> +                " the 'memory-backend' machine property",
>>>>>                   machine_class->default_ram_id);
>>>>>               return;
>>>>>           }
>>>>
>>>> I'd suggest a more explicit version:
>>>>
>>>>                   " Change the object's 'id' to something else or disable"
>>>>                   " automatic creation of the default RAM backend by appending"
>>>>                   "  'memory-backend={machine_class->default_ram_id}' in '-machine' arguments",
>>>
>>>
>>> Thanks, I'll do:
>>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index f0d35c6401..cd0fd6cdd1 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -1382,8 +1382,10 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>>                                     machine_class->default_ram_id)) {
>>>                error_setg(errp, "object name '%s' is reserved for the default"
>>>                    " RAM backend, it can't be used for any other purposes."
>>> -                " Change the object's 'id' to something else",
>>> -                machine_class->default_ram_id);
>>> +                " Change the object's 'id' to something else or disable"
>>> +                " automatic creation of the default RAM backend by appending"
>>> +                " 'memory-backend=%s' in '-machine' arguments",
>>> +                machine_class->default_ram_id, machine_class->default_ram_id);
>>>                return;
>>>            }
>>>            if (!create_default_memdev(current_machine, mem_path, errp)) {
>> 
>
> Hi Markus,
>
>> error_setg()'s function comment specifies:
>>   * The resulting message should be a single phrase, with no newline or
>>   * trailing punctuation.
>> Please use error_append_hint(), like so
>
> Please see the patch description: "Unfortunately, we cannot use error_append_hint(), because the caller passes &error_fatal."
>
> How should I deal with that?

qapi/error.h tells you :)

 * = Creating errors =
 [...]
 * Create an error and add additional explanation:
 *     error_setg(errp, "invalid quark");
 *     error_append_hint(errp, "Valid quarks are up, down, strange, "
 *                       "charm, top, bottom.\n");
 * This may require use of ERRP_GUARD(); more on that below.
 [...]
 * = Why, when and how to use ERRP_GUARD() =
 *
 * Without ERRP_GUARD(), use of the @errp parameter is restricted:
 * - It must not be dereferenced, because it may be null.
 * - It should not be passed to error_prepend() or
 *   error_append_hint(), because that doesn't work with &error_fatal.
 * ERRP_GUARD() lifts these restrictions.
 *
 * To use ERRP_GUARD(), add it right at the beginning of the function.
 * @errp can then be used without worrying about the argument being
 * NULL or &error_fatal.
 *
 * Using it when it's not needed is safe, but please avoid cluttering
 * the source with useless code.
 *
 * = Converting to ERRP_GUARD() =
 *
 * To convert a function to use ERRP_GUARD():
 *
 * 0. If the Error ** parameter is not named @errp, rename it to
 *    @errp.
 *
 * 1. Add an ERRP_GUARD() invocation, by convention right at the
 *    beginning of the function.  This makes @errp safe to use.
 *
 * 2. Replace &err by errp, and err by *errp.  Delete local variable
 *    @err.
 *
 * 3. Delete error_propagate(errp, *errp), replace
 *    error_propagate_prepend(errp, *errp, ...) by error_prepend(errp, ...)
 *
 * 4. Ensure @errp is valid at return: when you destroy *errp, set
 *    *errp = NULL.
 *
 * Example:
 *
 *     bool fn(..., Error **errp)
 *     {
 *         Error *err = NULL;
 *
 *         foo(arg, &err);
 *         if (err) {
 *             handle the error...
 *             error_propagate(errp, err);
 *             return false;
 *         }
 *         ...
 *     }
 *
 * becomes
 *
 *     bool fn(..., Error **errp)
 *     {
 *         ERRP_GUARD();
 *
 *         foo(arg, errp);
 *         if (*errp) {
 *             handle the error...
 *             return false;
 *         }
 *         ...
 *     }
 *
 * For mass-conversion, use scripts/coccinelle/errp-guard.cocci.

Questions?

>>               error_setg(errp, "object name '%s' is reserved for the default"
>>                   " RAM backend, it can't be used for any other purposes",
>>                   machine_class->default_ram_id);
>>               error_append_hint(errp,
>>                   "Change the object's 'id' to something else or disable"
>>                   " automatic creation of the default RAM backend by appending"
>>                   " 'memory-backend=%s' in '-machine' arguments\n",
>>                   machine_class->default_ram_id);
>> Moreover:
>> * "object name" feels off, we're talking about IDs, aren't we?
>
> Yes, I think so.
>
>> * "appending X in Y" should be "appending X to Y".  Consider "setting
>>    'memory-backend=%s' with -machine".
>> 
>
> Can do, thanks.


