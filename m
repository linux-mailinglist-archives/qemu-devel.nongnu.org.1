Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07447B3E598
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 15:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4mg-0000pq-WF; Mon, 01 Sep 2025 09:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut4mV-0000d7-FF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:41:11 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut4mS-0003Lq-3U
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:41:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CDEC5C0159;
 Mon, 01 Sep 2025 16:41:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:12c::1:9] (unknown [2a02:6bf:8080:12c::1:9])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0feAhQ2GtGk0-IGhvbNOt; Mon, 01 Sep 2025 16:41:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756734061;
 bh=JFbhh1mNso9qiJBEMAV+rhp9j4e/TeRTDZBwq3no7q8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FG46Y3Qe1QY+m8SZaXkfW9HsaG79RJSeRWhjwkRcXyX67gkDDszXmezMmumY9vZs5
 FMgNJxa/UK4803keHARvZYe+t52AVtxEUsHwAHU4oBNMJ9jLPw3LMt+WB50XSeu9Pj
 mvdV7OqjPXSoChRcSKvTWLZthALgz6GaBwRWiIew=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <14fbc97a-a0e0-4847-8204-168ba94a5394@yandex-team.ru>
Date: Mon, 1 Sep 2025 16:41:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: net/tap: deprecate vhostforce option
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com,
 devel@lists.libvirt.org
References: <20250829125429.795595-1-vsementsov@yandex-team.ru>
 <87wm6lcjfx.fsf@pond.sub.org>
 <66837e31-6751-48bb-b2b0-827dfdec527c@yandex-team.ru>
 <87v7m25r33.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87v7m25r33.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01.09.25 14:50, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 30.08.25 11:17, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> This option simply duplicates the @vhost option since long ago
>>>> (10 years!)
>>>> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
>>>
>>> This isn't obvious to me.
>>>
>>> As far as I can see, their only use is in net_init_tap_one():
>>>
>>>       if (tap->has_vhost ? tap->vhost :
>>>           vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
>>>
>>> Can you take this apart for me?
>>
>> Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
>> (that don't have MSI-X support), you should hav set vhostforce=on
>> (with vhost=on or unset).
>>
>> Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
>> for vhost-enabling options logic.
>>
>> So we simply have redundant options:
>>
>> vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>>
>> vhost unset : vhostforce counts, enabling vhost
>>
>> So you may enable vhost several ways:
>> - vhost=on
>> - vhostforce=on
>> - vhost=on + vhostforce=on
>> - and even vhost=on + vhostforce=off
>>
>> - they are all equal.
> 
> So @vhostforce doesn't quite duplicate @vhost: if they conflict, @vhost
> silently takes precedence.

Right. My description was too simplified, I'll update and resend, thanks!

> 
>>>> Let's finally deprecate it.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    docs/about/deprecated.rst | 7 +++++++
>>>>    qapi/net.json             | 6 +++++-
>>>>    2 files changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>>> index d50645a071..d14cb37480 100644
>>>> --- a/docs/about/deprecated.rst
>>>> +++ b/docs/about/deprecated.rst
>>>> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>>>>    The ``reconnect`` option only allows specifying second granularity timeouts,
>>>>    which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>>>>    +TAP ``vhostforce`` (since 10.2)
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> +The ``vhostforce`` option just duplicates the main ``vhost`` option.
>>>> +Use ``vhost`` alone.
>>>
>>> Would "Use instead ``vhost`` instead" be clearer?
>>
>> I meant, that user should not use vhost=on + vhostforce=on anymore.
>>
>> My be just "Use ``vhost``", without "alone"/"instead"?
> 
> Suggest
> 
>       The ``vhostforce`` option is redundant with the ``vhost`` option.
>       If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
> 
> Thanks!
> 
> [...]
> 


-- 
Best regards,
Vladimir

