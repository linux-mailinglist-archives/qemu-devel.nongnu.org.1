Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D974FEE2
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 07:53:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJSlr-0006io-L1; Wed, 12 Jul 2023 01:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJSln-0006if-9h
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 01:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJSll-000605-MD
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 01:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689141127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C5+Gk+KszylirU+LE5YPTnvk05gjmTVzwEJGcwDBelU=;
 b=JE8PoRwioH6mru674oBtv5K5LyBY0zYFCrmoF4Ldt9Pe+2BflptX2eIxBvq958aWxDjWCr
 vKhzRXKkv0HaMa9d3m+msG8So0Rpr6PcIo178RWQd8GqZwKFJSqeRILOiQAx/p8DMOYigR
 LDHs3Tf+4sx50IIJbs0w2AaeOSYkYEc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-J9s84K2_Nk24j4bQSXSahQ-1; Wed, 12 Jul 2023 01:52:03 -0400
X-MC-Unique: J9s84K2_Nk24j4bQSXSahQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D39093815EEF;
 Wed, 12 Jul 2023 05:52:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A99B7492C13;
 Wed, 12 Jul 2023 05:52:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C5D821E6A1F; Wed, 12 Jul 2023 07:52:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: <qemu-devel@nongnu.org>,  <kraxel@redhat.com>,  <berrange@redhat.com>,
 <philmd@linaro.org>,  <marcandre.lureau@redhat.com>,
 <vivek.kasireddy@intel.com>
Subject: Re: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
References: <20230621004355.19920-1-dongwon.kim@intel.com>
 <20230621004355.19920-7-dongwon.kim@intel.com>
 <87h6r1mkhc.fsf@pond.sub.org>
 <46dc1ac2-2ab5-48f7-73da-4160c26c3171@intel.com>
 <878rbrizmo.fsf@pond.sub.org>
 <6351a85a-db49-7d6b-2a55-1ea7c65b3a8e@intel.com>
 <87r0pgb8su.fsf@pond.sub.org>
 <ed732fc3-bb1d-42da-e179-0dcd08c663a8@intel.com>
 <878rbnymxf.fsf@pond.sub.org>
 <2d40fd7a-0f94-6aa1-32e6-3060d20dda33@intel.com>
Date: Wed, 12 Jul 2023 07:52:01 +0200
In-Reply-To: <2d40fd7a-0f94-6aa1-32e6-3060d20dda33@intel.com> (Dongwon Kim's
 message of "Tue, 11 Jul 2023 10:19:15 -0700")
Message-ID: <87edldu16m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

"Kim, Dongwon" <dongwon.kim@intel.com> writes:

> On 7/10/2023 11:36 PM, Markus Armbruster wrote:
>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>
>>> On 7/9/2023 11:05 PM, Markus Armbruster wrote:
>>>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>>>
>>>>> On 7/7/2023 7:07 AM, Markus Armbruster wrote:

[...]

>>>>>> Old question not yet answered: Using a list for the mapping means the
>>>>>> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
>>>>>> what we want?
>>>>>
>>>>> No, it doesn't have to be dense. In your example, you can just leave the place for VC1 blank. For example, you could do connectors.0=DP-1,connectors.2=HDMI-1. But in this case, VC1 won't be activated and stay as disconnected from guest's perspective. I think this info is also needed in v2.
>>>>
>>>> Have you tried this?  I believe it'll fail with something like
>>>> "Parameter 'connectors.1' missing".
>>>
>>> Just tested it. Yeah you are correct. I think I had a bad assumption. Let me take a look to see if I can make it work as I assumed.
>>
>> If sparse mappings make sense, we should provide for them, I think.
>>
>> An array like '*connectors': ['str'] maps from integers 0, 1, ...  It
>> can't do sparse (you can't omit integers in the middle).
>
> Yeah, I understand this now. Despite of my initial intention was different, I am wondering if we don't allow the sparse mapping in this implementation. Any thought on that?

Repeating myself: if sparse mappings make sense, we should provide for
them, I think.

So, do they make sense?  Or asked differently, could a user conceivably
want to *not* place a VC?

> The V2 patch is with that change in the description. Another thing I think is to change QAPI design little bit to make it fill the element with null (0) if it's not given. Would this be a feasible option?

A 'str' cannot be NULL.  In fact, no QAPI type can be null, except for
'null' (which is always NULL), alternates with a 'null' branch, and
pointer-valued optionals (which are null when absent).

>> Instead of omitting them, we could map them to null: '*connectors':
>> ['StrOrNull'].  JSON input looks like [null, "HDMI-A-0"].  Since dotted
>> key syntax does not support null at this time, you'd have to use JSON.
>>
>> Only an object can do sparse.  However, the QAPI schema language can't
>> express "object where the keys are integers and the values are strings".
>> We'd have to use 'any', and check everything manually.
>>
>> Hmm.  Thoughts?
>>
>>>>>> [...]


