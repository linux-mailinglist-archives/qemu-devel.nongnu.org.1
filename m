Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03C77FCBC
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 19:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWgVX-0003io-Dd; Thu, 17 Aug 2023 13:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWgVU-0003i0-MN
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 13:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWgVS-00070B-3x
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 13:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692292194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vURDXp09UJp3jnQSv4oI462DCEqA75tamyVcfwk4iz0=;
 b=D4/mttFDriNrDMjw7PUiImSitNGTHXf85DYaoOuJqiEubAzC2vr2Q4LHGLk1oXGUma3SmQ
 fPGMM5DPWHVWLs9bJpK7gzKFUz+1Gizf5bkGf0OdWZY5AWH3t3pCYImeDxYN9wnIT3QsIq
 TYkpoQpjsTtdg2A31p62POsOOLGhPWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-WMcvH5sQNo6uWJOF7jQEvA-1; Thu, 17 Aug 2023 13:09:52 -0400
X-MC-Unique: WMcvH5sQNo6uWJOF7jQEvA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe44619c97so6452295e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 10:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692292191; x=1692896991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vURDXp09UJp3jnQSv4oI462DCEqA75tamyVcfwk4iz0=;
 b=bCZioAaZ+qqEbRNeSKJm51rFxQ0a+rmOiyDkL/rwbPzxtGN9q6c6wFO6Q0BdiEXTQR
 +RM50yx+tITCOxm6WXO3SnXtGUxwN56SHz+LODKT0JiQB6OjKCiWKZ/mbGR6FiRUvto5
 yxaUEHq7MHVQ/igfww1FPVBnpEpSpQvAPO6RNgbpoXLxGG0w3jUB0XWiEkQuuQKGqERy
 gF/XUWf3yzOvIltAUVVUgQsqVdeCCR97RdcOK3QZkik6IaK2ZTSWEIveqG8Ik2M4Zxrq
 ORhbEhvIuW+IPHizUfCIEk9N8MX/+fX6HXcQ6gYviCKFkdPEZnnwyfd93ZKOEDtI8Wmp
 syNA==
X-Gm-Message-State: AOJu0Yz3RHxra/PPk4EGYvx1Awvd+/db+mt7L6xWzDo8qUYkMoiNiYtl
 fYbYfuMbLWYwoTkYiPB40K3CT1DAi7hjwhWN13TK9k0LEst0Fl2FoalyK4Lq+YYV1XpWhWw6rCo
 b97gY/5Kpii+1gmY=
X-Received: by 2002:a7b:cc96:0:b0:3fe:1b5e:82 with SMTP id
 p22-20020a7bcc96000000b003fe1b5e0082mr2543876wma.20.1692292191266; 
 Thu, 17 Aug 2023 10:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqOHHdvtrsXN3ai1KehA800QJL1F5WUeL8pWJmq98lkO3XzTK4agGn+6eW2jLtzadMVehABQ==
X-Received: by 2002:a7b:cc96:0:b0:3fe:1b5e:82 with SMTP id
 p22-20020a7bcc96000000b003fe1b5e0082mr2543853wma.20.1692292190928; 
 Thu, 17 Aug 2023 10:09:50 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-112-224.web.vodafone.de.
 [109.42.112.224]) by smtp.gmail.com with ESMTPSA id
 k21-20020a7bc315000000b003fe13c3ece7sm3606294wmj.10.2023.08.17.10.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 10:09:50 -0700 (PDT)
Message-ID: <a92823b2-6a95-3834-e33c-a7176c60ea2e@redhat.com>
Date: Thu, 17 Aug 2023 19:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20230816210743.1319018-1-thuth@redhat.com>
 <ZN33W+LhAn2FrFDT@redhat.com>
 <2bb2f8ac-43b4-9505-c163-d29964bf6a30@redhat.com>
 <ZN4bTLsw1bwLBEEz@redhat.com>
 <CAMxuvazrSy0Fi1rwj21RWmSWVPXDrFrcZ6266-EHcvgxTzFfeg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAMxuvazrSy0Fi1rwj21RWmSWVPXDrFrcZ6266-EHcvgxTzFfeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17/08/2023 15.47, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Aug 17, 2023 at 5:06 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Aug 17, 2023 at 02:00:26PM +0200, Thomas Huth wrote:
>>> On 17/08/2023 12.32, Daniel P. Berrangé wrote:
>>>> On Wed, Aug 16, 2023 at 11:07:43PM +0200, Thomas Huth wrote:
>>>>> When starting a guest via libvirt with "virsh start --console ...",
>>>>> the first second of the console output is missing. This is especially
>>>>> annoying on s390x that only has a text console by default and no graphical
>>>>> output - if the bios fails to boot here, the information about what went
>>>>> wrong is completely lost.
>>>>>
>>>>> One part of the problem (there is also some things to be done on the
>>>>> libvirt side) is that QEMU only checks with a 1 second timer whether
>>>>> the other side of the pty is already connected, so the first second of
>>>>> the console output is always lost.
>>>>>
>>>>> This likely used to work better in the past, since the code once checked
>>>>> for a re-connection during write, but this has been removed in commit
>>>>> f8278c7d74 ("char-pty: remove the check for connection on write") to avoid
>>>>> some locking.
>>>>>
>>>>> To ease the situation here at least a little bit, let's check with g_poll()
>>>>> whether we could send out the data anyway, even if the connection has not
>>>>> been marked as "connected" yet. The file descriptor is marked as non-blocking
>>>>> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this should
>>>>> not cause any trouble if the other side is not ready for receiving yet.
>>>>>
>>>>> With this patch applied, I can now successfully see the bios output of
>>>>> a s390x guest when running it with "virsh start --console" (with a patched
>>>>> version of virsh that fixes the remaining issues there, too).
>>>>>
>>>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    chardev/char-pty.c | 22 +++++++++++++++++++---
>>>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>>>>> index 4e5deac18a..fad12dfef3 100644
>>>>> --- a/chardev/char-pty.c
>>>>> +++ b/chardev/char-pty.c
>>>>> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
>>>>>    static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
>>>>>    {
>>>>>        PtyChardev *s = PTY_CHARDEV(chr);
>>>>> +    GPollFD pfd;
>>>>> +    int rc;
>>>>> -    if (!s->connected) {
>>>>> -        return len;
>>>>> +    if (s->connected) {
>>>>> +        return io_channel_send(s->ioc, buf, len);
>>>>>        }
>>>>> -    return io_channel_send(s->ioc, buf, len);
>>>>> +
>>>>> +    /*
>>>>> +     * The other side might already be re-connected, but the timer might
>>>>> +     * not have fired yet. So let's check here whether we can write again:
>>>>> +     */
>>>>> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
>>>>> +    pfd.events = G_IO_OUT;
>>>>> +    pfd.revents = 0;
>>>>> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>>>>> +    g_assert(rc >= 0);
>>>>> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>>>>
>>>> Should (can?) we call
>>>>
>>>>      pty_chr_state(chr, 1);
>>>>
>>>> here ?
>>>
>>> As far as I understood commit f8278c7d74c6 and f7ea2038bea04628, this is not
>>> possible anymore since the lock has been removed.
>>>
>>>>> +        io_channel_send(s->ioc, buf, len);
>>>>
>>>> As it feels a little dirty to be sending data before setting the
>>>> 'connected == 1' and thus issuing the 'CHR_EVENT_OPENED' event
>>>
>>> I didn't find a really better solution so far. We could maybe introduce a
>>> buffer in the char-pty code and store the last second of guest output, but
>>> IMHO that's way more complex and thus somewhat ugly, too?
>>
>> The orignal commit f8278c7d74c6 said
>>
>> [quote]
>>      char-pty: remove the check for connection on write
>>
>>      This doesn't help much compared to the 1 second poll PTY
>>      timer. I can't think of a use case where this would help.
>> [/quote]
>>
>> We've now identified a use case where it is actually important.
>>
>> IOW, there's a justification to revert both f7ea2038bea04628 and
>> f8278c7d74c6, re-adding the locking and write update logic.
> 
> Indeed. But isn't it possible to watch for IO_OUT and get rid of the timer?

It might be possible - Marc Hartmayer just sent me a draft patch today that 
uses qio_channel_add_watch() and gets rid of the timer ... I'll do some 
experiments with that and send it out if it works reliably.

  Thomas


