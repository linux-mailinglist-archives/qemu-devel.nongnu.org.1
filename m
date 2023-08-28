Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B478B005
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qabHo-0001gG-5M; Mon, 28 Aug 2023 08:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qabHf-0001fv-SE
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qabHd-0006wZ-6u
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693225431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/QsbftsTHlG7YkBTZeV3bE83PHsEXjMrzdBWeVri6KQ=;
 b=DBcFLvj7UFXUP49caEJKjMt9FFcBITEExMmJI/7ktUmd4XcXDmBntG45idzb/j+fb0Wfiz
 Y1hTNnmzzMcR4KKnN0ulA2czI+3VudVhZMXgt7Lz1lGP2PzJadILT/ULc9zalwr9YtSluG
 dkd0RpEuFYFPtN9ek6r6noDmKyOinsk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-moIxKEIPMuGJeYL-vd3B5Q-1; Mon, 28 Aug 2023 08:23:50 -0400
X-MC-Unique: moIxKEIPMuGJeYL-vd3B5Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso25432665e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693225429; x=1693830229;
 h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/QsbftsTHlG7YkBTZeV3bE83PHsEXjMrzdBWeVri6KQ=;
 b=QQkWQ4W8uXotSzyQKinNRMNtFMP0AP7jI6gvV4ITsA3AmtOx8GpgJxD5nLqTOJKpEu
 eGKElCvH11/+w6xX7vdqLt69iycQ1Wgv1YBnyY3agu64ZvSKnMY5bR61wgIW3pKCtId9
 ykwJW1TunKhU8v/94u6/7d43ocK7b7hiiWTUs/7yU/5S0SHWBBdLTEBqoVZPt84MvURI
 Z558BUh9pVl0exIwdtrX8d3Yxr4a17ZGIOlX2SeqPMJQMp/VpMeUBFcwIS58VgszguKA
 2vC9+m6syUAy4Bs7g6QmGjpcfpOiIw1VQi47ASv4MSwGZNd9EJ1QnXXKvFRAKS5eDPtR
 I3UA==
X-Gm-Message-State: AOJu0YyeCWbOG8wlE7znlqYRrtqsy16DwU61maUOMBzBrWqGyn4tktYO
 tUN9MA4Yc6sxCr6Krfq1gw4lbgodcTGkJ1S85wLSICpj6ZlMPvQdh7gOQxwQsVwdG9FapX23Quj
 NWPTDh9rZiTTs6Qw=
X-Received: by 2002:adf:dc86:0:b0:317:3d6c:5b27 with SMTP id
 r6-20020adfdc86000000b003173d6c5b27mr18600345wrj.46.1693225429090; 
 Mon, 28 Aug 2023 05:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgNVY/aPtlCf2ljfGPcO5c86Qf7n/DNWUjhLJFWAnUT3n+hUI1oWfc33Ffm5AV7jhTIwBsig==
X-Received: by 2002:adf:dc86:0:b0:317:3d6c:5b27 with SMTP id
 r6-20020adfdc86000000b003173d6c5b27mr18600328wrj.46.1693225428728; 
 Mon, 28 Aug 2023 05:23:48 -0700 (PDT)
Received: from [192.168.8.103] (tmo-098-91.customers.d1-online.com.
 [80.187.98.91]) by smtp.gmail.com with ESMTPSA id
 a12-20020adfe5cc000000b0030ada01ca78sm10450361wrn.10.2023.08.28.05.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:23:48 -0700 (PDT)
Message-ID: <d78959a7-bc55-1022-d524-60ff0994aa42@redhat.com>
Date: Mon, 28 Aug 2023 14:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Amaury Pouly <amaury.pouly@lowrisc.org>
References: <20230816210743.1319018-1-thuth@redhat.com>
 <ZN33W+LhAn2FrFDT@redhat.com>
 <2bb2f8ac-43b4-9505-c163-d29964bf6a30@redhat.com>
 <ZN4bTLsw1bwLBEEz@redhat.com>
 <CAMxuvazrSy0Fi1rwj21RWmSWVPXDrFrcZ6266-EHcvgxTzFfeg@mail.gmail.com>
 <a92823b2-6a95-3834-e33c-a7176c60ea2e@redhat.com>
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
In-Reply-To: <a92823b2-6a95-3834-e33c-a7176c60ea2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/08/2023 19.09, Thomas Huth wrote:
> On 17/08/2023 15.47, Marc-André Lureau wrote:
>> Hi
>>
>> On Thu, Aug 17, 2023 at 5:06 PM Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>>
>>> On Thu, Aug 17, 2023 at 02:00:26PM +0200, Thomas Huth wrote:
>>>> On 17/08/2023 12.32, Daniel P. Berrangé wrote:
>>>>> On Wed, Aug 16, 2023 at 11:07:43PM +0200, Thomas Huth wrote:
>>>>>> When starting a guest via libvirt with "virsh start --console ...",
>>>>>> the first second of the console output is missing. This is especially
>>>>>> annoying on s390x that only has a text console by default and no 
>>>>>> graphical
>>>>>> output - if the bios fails to boot here, the information about what went
>>>>>> wrong is completely lost.
>>>>>>
>>>>>> One part of the problem (there is also some things to be done on the
>>>>>> libvirt side) is that QEMU only checks with a 1 second timer whether
>>>>>> the other side of the pty is already connected, so the first second of
>>>>>> the console output is always lost.
>>>>>>
>>>>>> This likely used to work better in the past, since the code once checked
>>>>>> for a re-connection during write, but this has been removed in commit
>>>>>> f8278c7d74 ("char-pty: remove the check for connection on write") to 
>>>>>> avoid
>>>>>> some locking.
>>>>>>
>>>>>> To ease the situation here at least a little bit, let's check with 
>>>>>> g_poll()
>>>>>> whether we could send out the data anyway, even if the connection has not
>>>>>> been marked as "connected" yet. The file descriptor is marked as 
>>>>>> non-blocking
>>>>>> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this 
>>>>>> should
>>>>>> not cause any trouble if the other side is not ready for receiving yet.
>>>>>>
>>>>>> With this patch applied, I can now successfully see the bios output of
>>>>>> a s390x guest when running it with "virsh start --console" (with a 
>>>>>> patched
>>>>>> version of virsh that fixes the remaining issues there, too).
>>>>>>
>>>>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>    chardev/char-pty.c | 22 +++++++++++++++++++---
>>>>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>>>>>> index 4e5deac18a..fad12dfef3 100644
>>>>>> --- a/chardev/char-pty.c
>>>>>> +++ b/chardev/char-pty.c
>>>>>> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev 
>>>>>> *chr)
>>>>>>    static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int 
>>>>>> len)
>>>>>>    {
>>>>>>        PtyChardev *s = PTY_CHARDEV(chr);
>>>>>> +    GPollFD pfd;
>>>>>> +    int rc;
>>>>>> -    if (!s->connected) {
>>>>>> -        return len;
>>>>>> +    if (s->connected) {
>>>>>> +        return io_channel_send(s->ioc, buf, len);
>>>>>>        }
>>>>>> -    return io_channel_send(s->ioc, buf, len);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * The other side might already be re-connected, but the timer might
>>>>>> +     * not have fired yet. So let's check here whether we can write 
>>>>>> again:
>>>>>> +     */
>>>>>> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
>>>>>> +    pfd.events = G_IO_OUT;
>>>>>> +    pfd.revents = 0;
>>>>>> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>>>>>> +    g_assert(rc >= 0);
>>>>>> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>>>>>
>>>>> Should (can?) we call
>>>>>
>>>>>      pty_chr_state(chr, 1);
>>>>>
>>>>> here ?
>>>>
>>>> As far as I understood commit f8278c7d74c6 and f7ea2038bea04628, this is 
>>>> not
>>>> possible anymore since the lock has been removed.
>>>>
>>>>>> +        io_channel_send(s->ioc, buf, len);
>>>>>
>>>>> As it feels a little dirty to be sending data before setting the
>>>>> 'connected == 1' and thus issuing the 'CHR_EVENT_OPENED' event
>>>>
>>>> I didn't find a really better solution so far. We could maybe introduce a
>>>> buffer in the char-pty code and store the last second of guest output, but
>>>> IMHO that's way more complex and thus somewhat ugly, too?
>>>
>>> The orignal commit f8278c7d74c6 said
>>>
>>> [quote]
>>>      char-pty: remove the check for connection on write
>>>
>>>      This doesn't help much compared to the 1 second poll PTY
>>>      timer. I can't think of a use case where this would help.
>>> [/quote]
>>>
>>> We've now identified a use case where it is actually important.
>>>
>>> IOW, there's a justification to revert both f7ea2038bea04628 and
>>> f8278c7d74c6, re-adding the locking and write update logic.
>>
>> Indeed. But isn't it possible to watch for IO_OUT and get rid of the timer?
> 
> It might be possible - Marc Hartmayer just sent me a draft patch today that 
> uses qio_channel_add_watch() and gets rid of the timer ... I'll do some 
> experiments with that and send it out if it works reliably.

I did quite a bunch of experiments with the code, but as far as I can see, 
it's not so straight forward: IO_OUT keeps being enabled once IO_HUP occurs 
since the kernel can still buffer some output before it de-asserts IO_OUT. 
So there is no easy way to check for a re-connection without some kind of 
regular polling, as far as I can see...

Well, maybe something like this might be possible: Add a watch for IO_HUP. 
Once HUP occurs, don't signal CHR_EVENT_CLOSED yet, but set a flag variable 
and in case the guest still writes something to the chardev and the flag is 
true, we write the bytes to the pty one by one (to avoid locking in case the 
buffer gets full) and check for IO_OUT via g_poll() after each write. Once 
we see IO_OUT being gone, we can signal CHR_EVENT_CLOSED and add a watch for 
IO_OUT being enabled again. Once that watch triggers, we know that the other 
side re-connected and we can signal CHR_EVENT_OPENED and continue normally. 
... sounds all quite complicated, is it worth the effort? What do you think?

  Thomas


