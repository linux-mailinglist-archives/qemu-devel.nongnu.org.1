Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B17B11F2
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 07:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qljPf-0004IZ-63; Thu, 28 Sep 2023 01:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qljPc-0004IJ-Re
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qljPa-0006zX-VZ
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695878286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6igoVswNIayccjwLf/jcEgpr2AKSd7PjUgtt0pzUqDU=;
 b=ST0jJwFNdq6U50Q6e56gzF6qT3Po4vHfg8CdQ+xHbHu/6o5p8YNVymuRn9s7Z81F0OgjnL
 pKbKLOuuQzd6342WvoN5jnQnDRYOzM29XO+GaDIHIJZYwFu76viuNVHM5JSJSrVM/1aMEM
 ss9FEyVfPyZMBvPRpUDaEVAzn33z1FY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-sa0ZAmeWN5m4KYSH8oTRKQ-1; Thu, 28 Sep 2023 01:18:04 -0400
X-MC-Unique: sa0ZAmeWN5m4KYSH8oTRKQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bebfada8cso1065352166b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 22:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695878283; x=1696483083;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6igoVswNIayccjwLf/jcEgpr2AKSd7PjUgtt0pzUqDU=;
 b=OLZQ5HMILFJ0XbaX3zbyFhUuUAcBna+/eLkdeMIrEVd66aeerj+U8V5nq6tH27wLI7
 EJVHgYZgp2+o4Eq3RcvlnvB1OuZLuVRU3o0iy46mefNoUhp/KEiSnVVC+Xwjo5eppZgj
 egtqjvJhgeQYK99IVjmKIO7GzR5QA/JOegxUlN1wQxjZMm7E6c+el1UYrao8TbrkjuUB
 YNmi56C8zXptfAh6zUeuEmJTHrkCAGbcVOgRirNezgS1f31NlDh3J97pJYfAk9tiShtl
 An/St2m4xApPh5+MSD2kjbGp92+2gMaorqIUj1yUNRlEA0/Gs6/1c75IXwW/5t6cgnKS
 qJBQ==
X-Gm-Message-State: AOJu0Yw51fAA4T8BIIGPwTfUynfe0u3FeNBcRuIB0poPeVIqhqunpZpN
 s9oFbtXc+s26071oHxb0h6pEeqZyFbYvQX0EzTt0z82aW5QHP0iXvqShzdokiDGELiJI+5qGxDo
 ob3qc+GHdQo157A4=
X-Received: by 2002:a17:906:3150:b0:9a1:f5b1:c864 with SMTP id
 e16-20020a170906315000b009a1f5b1c864mr213978eje.10.1695878283015; 
 Wed, 27 Sep 2023 22:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Bs41RyIDczhhvrPMry2+1DD8jSb4oaBcaxc6JArMMfIQnl6r49a80vjtkKXbnpKXiXN52Q==
X-Received: by 2002:a17:906:3150:b0:9a1:f5b1:c864 with SMTP id
 e16-20020a170906315000b009a1f5b1c864mr213965eje.10.1695878282672; 
 Wed, 27 Sep 2023 22:18:02 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 bu24-20020a170906a15800b0098669cc16b2sm10122085ejb.83.2023.09.27.22.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 22:18:02 -0700 (PDT)
Message-ID: <640e768f-614e-53ee-dcea-3a1844c66c09@redhat.com>
Date: Thu, 28 Sep 2023 07:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
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
 <d78959a7-bc55-1022-d524-60ff0994aa42@redhat.com>
In-Reply-To: <d78959a7-bc55-1022-d524-60ff0994aa42@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 28/08/2023 14.23, Thomas Huth wrote:
> On 17/08/2023 19.09, Thomas Huth wrote:
>> On 17/08/2023 15.47, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Thu, Aug 17, 2023 at 5:06 PM Daniel P. Berrangé <berrange@redhat.com> 
>>> wrote:
>>>>
>>>> On Thu, Aug 17, 2023 at 02:00:26PM +0200, Thomas Huth wrote:
>>>>> On 17/08/2023 12.32, Daniel P. Berrangé wrote:
>>>>>> On Wed, Aug 16, 2023 at 11:07:43PM +0200, Thomas Huth wrote:
>>>>>>> When starting a guest via libvirt with "virsh start --console ...",
>>>>>>> the first second of the console output is missing. This is especially
>>>>>>> annoying on s390x that only has a text console by default and no 
>>>>>>> graphical
>>>>>>> output - if the bios fails to boot here, the information about what went
>>>>>>> wrong is completely lost.
>>>>>>>
>>>>>>> One part of the problem (there is also some things to be done on the
>>>>>>> libvirt side) is that QEMU only checks with a 1 second timer whether
>>>>>>> the other side of the pty is already connected, so the first second of
>>>>>>> the console output is always lost.
>>>>>>>
>>>>>>> This likely used to work better in the past, since the code once checked
>>>>>>> for a re-connection during write, but this has been removed in commit
>>>>>>> f8278c7d74 ("char-pty: remove the check for connection on write") to 
>>>>>>> avoid
>>>>>>> some locking.
>>>>>>>
>>>>>>> To ease the situation here at least a little bit, let's check with 
>>>>>>> g_poll()
>>>>>>> whether we could send out the data anyway, even if the connection has 
>>>>>>> not
>>>>>>> been marked as "connected" yet. The file descriptor is marked as 
>>>>>>> non-blocking
>>>>>>> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this 
>>>>>>> should
>>>>>>> not cause any trouble if the other side is not ready for receiving yet.
>>>>>>>
>>>>>>> With this patch applied, I can now successfully see the bios output of
>>>>>>> a s390x guest when running it with "virsh start --console" (with a 
>>>>>>> patched
>>>>>>> version of virsh that fixes the remaining issues there, too).
>>>>>>>
>>>>>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>> ---
>>>>>>>    chardev/char-pty.c | 22 +++++++++++++++++++---
>>>>>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>>>>>>> index 4e5deac18a..fad12dfef3 100644
>>>>>>> --- a/chardev/char-pty.c
>>>>>>> +++ b/chardev/char-pty.c
>>>>>>> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev 
>>>>>>> *chr)
>>>>>>>    static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, 
>>>>>>> int len)
>>>>>>>    {
>>>>>>>        PtyChardev *s = PTY_CHARDEV(chr);
>>>>>>> +    GPollFD pfd;
>>>>>>> +    int rc;
>>>>>>> -    if (!s->connected) {
>>>>>>> -        return len;
>>>>>>> +    if (s->connected) {
>>>>>>> +        return io_channel_send(s->ioc, buf, len);
>>>>>>>        }
>>>>>>> -    return io_channel_send(s->ioc, buf, len);
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * The other side might already be re-connected, but the timer 
>>>>>>> might
>>>>>>> +     * not have fired yet. So let's check here whether we can write 
>>>>>>> again:
>>>>>>> +     */
>>>>>>> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
>>>>>>> +    pfd.events = G_IO_OUT;
>>>>>>> +    pfd.revents = 0;
>>>>>>> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>>>>>>> +    g_assert(rc >= 0);
>>>>>>> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>>>>>>
>>>>>> Should (can?) we call
>>>>>>
>>>>>>      pty_chr_state(chr, 1);
>>>>>>
>>>>>> here ?
>>>>>
>>>>> As far as I understood commit f8278c7d74c6 and f7ea2038bea04628, this 
>>>>> is not
>>>>> possible anymore since the lock has been removed.
>>>>>
>>>>>>> +        io_channel_send(s->ioc, buf, len);
>>>>>>
>>>>>> As it feels a little dirty to be sending data before setting the
>>>>>> 'connected == 1' and thus issuing the 'CHR_EVENT_OPENED' event
>>>>>
>>>>> I didn't find a really better solution so far. We could maybe introduce a
>>>>> buffer in the char-pty code and store the last second of guest output, but
>>>>> IMHO that's way more complex and thus somewhat ugly, too?
>>>>
>>>> The orignal commit f8278c7d74c6 said
>>>>
>>>> [quote]
>>>>      char-pty: remove the check for connection on write
>>>>
>>>>      This doesn't help much compared to the 1 second poll PTY
>>>>      timer. I can't think of a use case where this would help.
>>>> [/quote]
>>>>
>>>> We've now identified a use case where it is actually important.
>>>>
>>>> IOW, there's a justification to revert both f7ea2038bea04628 and
>>>> f8278c7d74c6, re-adding the locking and write update logic.
>>>
>>> Indeed. But isn't it possible to watch for IO_OUT and get rid of the timer?
>>
>> It might be possible - Marc Hartmayer just sent me a draft patch today 
>> that uses qio_channel_add_watch() and gets rid of the timer ... I'll do 
>> some experiments with that and send it out if it works reliably.
> 
> I did quite a bunch of experiments with the code, but as far as I can see, 
> it's not so straight forward: IO_OUT keeps being enabled once IO_HUP occurs 
> since the kernel can still buffer some output before it de-asserts IO_OUT. 
> So there is no easy way to check for a re-connection without some kind of 
> regular polling, as far as I can see...
> 
> Well, maybe something like this might be possible: Add a watch for IO_HUP. 
> Once HUP occurs, don't signal CHR_EVENT_CLOSED yet, but set a flag variable 
> and in case the guest still writes something to the chardev and the flag is 
> true, we write the bytes to the pty one by one (to avoid locking in case the 
> buffer gets full) and check for IO_OUT via g_poll() after each write. Once 
> we see IO_OUT being gone, we can signal CHR_EVENT_CLOSED and add a watch for 
> IO_OUT being enabled again. Once that watch triggers, we know that the other 
> side re-connected and we can signal CHR_EVENT_OPENED and continue normally. 
> ... sounds all quite complicated, is it worth the effort? What do you think?

Ping!

Marc-André, Daniel, any thoughts on this? Would such a rewrite be worth the 
effort? Or could we just go ahead with my simple patch here? Or would you 
prefer reverting the locking patches?

  Thomas



