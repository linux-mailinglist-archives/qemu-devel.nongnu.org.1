Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FAE760D0A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qODRg-00069o-7z; Tue, 25 Jul 2023 04:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qODRc-00069c-EX
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qODRZ-0002Jw-1u
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690273855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGHRnlyqVnnt5fWei9oKCMuYPvTnphu/xXHAfSfdWYU=;
 b=ZUWM2Ln4fS+FdTPH5uxkcbbVlKLvEGFWyTedVYMRTnkf/mO3AVpbCdu/z7WNLG08WiZ4wK
 iAP2M5D0gW1XSG+arh1b7WEbdhdE2WWc2WI0Cksg4sQvZ9j3SrPdKRqM4Vz2l+UcvXjwJe
 L+rH9Da2HoXoPMliV+/rCPRi7xf7ykg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-O5bVvSUfOZCBq5I7ipSvuw-1; Tue, 25 Jul 2023 04:30:53 -0400
X-MC-Unique: O5bVvSUfOZCBq5I7ipSvuw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbffd088a9so32306805e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 01:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690273852; x=1690878652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oGHRnlyqVnnt5fWei9oKCMuYPvTnphu/xXHAfSfdWYU=;
 b=lfcW7VUE5xaKH6Qi3tGvYAvDYBqNXtxgoWveYJP/DOd8a56Faq3Z7jx/XX0+H7MF+a
 eAlDurwTZ8K1BaPrc6npQaEjMBBgM7HqN71g4Mkw07z2ldT9Ja+2cbImrUD041j6jqBE
 plJtKOu6x++H+UAk5bx4vO1p2LAAjdvhTmKeDDGeME11g3vKi/hEMbY/1saxmJ3XWIG1
 YowVs+DVY2A4Rk8CoPPRYqatcK7SrJafH7cc/IOhG2zoj38wPu9NBxql8Z8LKCE+po1X
 TSlhQGRzf473Zber7XkCoPYrMe/2OhmlD0lMhs6CFZBQYhAaxgOR4DdG4zqpIHOghQvA
 T00Q==
X-Gm-Message-State: ABy/qLbWPEckSVDLgQ1J5c9LV4t+4kJPGvLy+waHbpxW1OGr1ocdzmJv
 LWapPantDaJ54rdWZ32TI/yzZHtIS6sUVz/uwDSqZPQ8zmVZNQDj8tQypsgbMRzs110FLcKRTQ6
 PRNVSO//0dHhk+9w=
X-Received: by 2002:a5d:6651:0:b0:317:5252:57e7 with SMTP id
 f17-20020a5d6651000000b00317525257e7mr6698558wrw.21.1690273851830; 
 Tue, 25 Jul 2023 01:30:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF99IFbV6eW8YOBmjdP0SAXQBd1W2GxpcF0UPlFc9XkaShGpK8GqO5zvjcVEFtO7e5ycFsP4w==
X-Received: by 2002:a5d:6651:0:b0:317:5252:57e7 with SMTP id
 f17-20020a5d6651000000b00317525257e7mr6698535wrw.21.1690273851332; 
 Tue, 25 Jul 2023 01:30:51 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 o5-20020adfcf05000000b003172510d19dsm15634109wrj.73.2023.07.25.01.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 01:30:50 -0700 (PDT)
Message-ID: <370fc01d-a090-e400-6ebe-a3e8df5b02b6@redhat.com>
Date: Tue, 25 Jul 2023 10:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] vhost-user.rst: Add suspend/resume
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-2-hreitz@redhat.com> <20230718142557.GB44841@fedora>
 <a760479a-f623-1fa9-a557-70a857fe8dcf@redhat.com>
 <20230724175532.GA222590@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230724175532.GA222590@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24.07.23 19:55, Stefan Hajnoczi wrote:
> On Wed, Jul 19, 2023 at 03:59:32PM +0200, Hanna Czenczek wrote:
>> On 18.07.23 16:25, Stefan Hajnoczi wrote:
>>> On Tue, Jul 11, 2023 at 05:52:23PM +0200, Hanna Czenczek wrote:
>>>> When stopping the VM, qemu wants all devices to fully cease any
>>>> operation, too.  Currently, we can only have vhost-user back-ends stop
>>>> processing vrings, but not background operations.  Add the SUSPEND and
>>>> RESUME commands from vDPA, which allow the front-end (qemu) to tell
>>>> back-ends to cease all operations, including those running in the
>>>> background.
>>>>
>>>> qemu's current work-around for this is to reset the back-end instead of
>>>> suspending it, which will not work for back-ends that have internal
>>>> state that must be preserved across e.g. stop/cont.
>>>>
>>>> Note that the given specification requires the back-end to delay
>>>> processing kicks (i.e. starting vrings) until the device is resumed,
>>>> instead of requiring the front-end not to send kicks while suspended.
>>>> qemu starts devices (and would just resume them) only when the VM is in
>>>> a running state, so it would be difficult to have qemu delay kicks until
>>>> the device is resumed, which is why this patch specifies handling of
>>>> kicks as it does.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    docs/interop/vhost-user.rst | 35 +++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 33 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>>>> index 5a070adbc1..ac6be34c4c 100644
>>>> --- a/docs/interop/vhost-user.rst
>>>> +++ b/docs/interop/vhost-user.rst
>>>> @@ -381,6 +381,10 @@ readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK``
>>>>    or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated,
>>>>    and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
>>>> +While the back-end is suspended (via ``VHOST_USER_SUSPEND``), it must
>>>> +never process rings, and thus also delay handling kicks until the
>>> If you respin this series, I suggest replacing "never" with "not" to
>>> emphasize that ring processing is only skipped while the device is
>>> suspended (rather than forever). "Never" feels too strong to use when
>>> describing a temporary state.
>> Sure.
>>
>>>> +back-end is resumed again.
>>>> +
>>>>    Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>>>>    If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
>>>> @@ -479,8 +483,9 @@ supplied by ``VhostUserLog``.
>>>>    ancillary data, it may be used to inform the front-end that the log has
>>>>    been modified.
>>>> -Once the source has finished migration, rings will be stopped by the
>>>> -source. No further update must be done before rings are restarted.
>>>> +Once the source has finished migration, the device will be suspended and
>>>> +its rings will be stopped by the source. No further update must be done
>>>> +before the device and its rings are resumed.
>>> This paragraph is abstract and doesn't directly identify the mechanisms
>>> or who does what:
>>> - "the device will be suspended" via VHOST_USER_SUSPEND (or reset when
>>>     VHOST_USER_SUSPEND is not supported?) or automatically by the device
>>>     itself or some other mechanism?
>> OK, I’ll add VHOST_USER_SUSPEND.
>>
>> So far I hadn’t considered making a note of resetting as a fallback right in
>> the specification.  I don’t think I would want it in the specification, but
>> on the other hand, it is probably important for back-end authors to know
>> that if they do not implement SUSPEND, their device is going to be reset by
>> qemu.
>>
>> Can we make that a ”may”, i.e.:
>>
>> ```
>> Once the source has finished migration, the device will be suspended via
>> VHOST_USER_SUSPEND and its rings will be stopped by the source.
> I'm not sure what "its rings will be stopped by the source" means
> exactly. Is it summarizing the effect of VHOST_USER_SUSPEND or is there
> an additional action after VHOST_USER_SUSPEND that stops rings? And I'm
> not sure whether "by the source" means by the front-end or back-end on
> the source machine?

This is pre-existing text and I assumed it (with not doubt) to refer to 
GET_VRING_BASE, because that is how rings are stopped.

I can improve the existing documentation and add the reference to 
GET_VRING_BASE, and say that it clearly must come from the front-end.

>> No further
>> update must be done before the device and its rings are resumed.
> "Update" to what? Guest RAM? Device state? Rings?
>
> I feel like this text is too vague for a spec. People may interpret it
> differently. Can you make rephrase this to more concrete?

Honestly, no.  This is pre-existing, and I have the same questions as 
you do.

I cannot “rephrase” this to make it more concrete.  I can try to 
actually specify that was was left unspecified, but that would be a 
change in specification that would require its own patch, separate from 
this series.

Personally, I’ve generally taken this sentence to be fluff.  If the 
rings are stopped, clearly, they should not be accessed at all. Probably 
the back-end should also refrain from writing to guest memory, because 
that is a logical conclusion from having the rings stopped.  But now 
it’s even clearer: The back-end ideally is suspended, which directly 
means not to modify guest memory, and not to perform “background 
operations”.  Updating device state of course is possible through 
vhost-user commands, because those must always be executed.

So basically it’s just “Device and rings are stopped (RESUME and 
GET_VRING_BASE, resp.), so you know, adhere to that.”

Or maybe I’m completely wrong and “Once the source has finished 
migration, rings will be stopped by the source. No further update must 
be done before rings are restarted.” is to be taken together and the 
second sentence just refers to the rings, i.e. the front-end stops the 
rings, and the back-end must not update them.  Or it means that the 
front-end must not send any commands to the back-end until restarting 
the rings, but that feels practically impossible.

Again, because this sentence currently doesn’t specify anything, really, 
changing it to carry any meaning would be to add to the specification, 
not just clarify it.

>> If and only
>> if the back-end does not support VHOST_USER_SUSPEND, the front-end may reset
>> it instead (via VHOST_USER_SET_STATUS, VHOST_USER_RESET_DEVICE, or
>> VHOST_USER_RESET_OWNER).
>> ```
>>
>> I’m unsure about the “If and only if” – older qemu versions will break this,
>> but I feel like we must promise back-end writers that if they implement
>> SUSPEND, their back-end is not going to be reset; if it is, and something
>> breaks because of it, it’s the front-end that must be updated to match the
>> specification.
> I this the trick is to say "if and only if VHOST_USER_F_SUSPEND has not
> been negotiated". That way really only new front-ends that support
> VHOST_USER_SUSPEND are required to use suspend instead of reset and
> older versions of QEMU will not violate this statement.

Ah, right, thanks!

>>> - "before the device and its rings are resumed" via VHOST_USER_RESUME?
>>>     And is this referring to the source device?
>> Yes, via VHOST_USER_RESUME, and restarting the rings by starting them (i.e.
>> a kick).
>>
>> Whether this is referring to the source device…  Well, the text as it was
>> before begs the exact same question, so honestly, I don’t know for sure.
>> “Restarting” only makes sense if the rings were stopped before, so I assume
>> it’s referring to the source, e.g. for the case of a failed migration.
>> RESUME at least definitely will only happen after a prior SUSPEND, so this
>> one will definitely only apply on the source side.
>>
>>> Please rephrase the paragraph to identify the vhost-user messages
>>> involved.
>>>
>>>>    In postcopy migration the back-end is started before all the memory has
>>>>    been received from the source host, and care must be taken to avoid
>>>> @@ -885,6 +890,7 @@ Protocol features
>>>>      #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>>>      #define VHOST_USER_PROTOCOL_F_STATUS               16
>>>>      #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>>>> +  #define VHOST_USER_PROTOCOL_F_SUSPEND              18
>>>>    Front-end message types
>>>>    -----------------------
>>>> @@ -1440,6 +1446,31 @@ Front-end message types
>>>>      query the back-end for its device status as defined in the Virtio
>>>>      specification.
>>>> +``VHOST_USER_SUSPEND``
>>>> +  :id: 41
>>>> +  :equivalent ioctl: VHOST_VDPA_SUSPEND
>>>> +  :request payload: N/A
>>>> +  :reply payload: N/A
>>>> +
>>>> +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
>>>> +  successfully negotiated, this message is submitted by the front-end to
>>>> +  have the back-end cease all operations except for handling vhost-user
>>>> +  requests.  The back-end must stop processing all virt queues, and it
>>>> +  must not perform any background operations.  It may not resume until a
>>> "background operations" are not defined. What does it mean:
>>> - Anything that writes to memory slots
>>> - Anything that changes the visible state of the device
>>> - Anything that changes the non-visible internal state of the device
>>> - etc
>>> ?
>> My best answer (honestly) is: You tell me.  This series is introducing
>> SUSPEND/RESUME because qemu wants to reset devices to make them stop
>> “background operations”, and this would break virtiofsd if any form of reset
>> were actually implemented.  The implementation of SUSPEND/RESUME in
>> virtiofsd on the other hand is supposed to basically be a no-op (besides
>> delaying ring processing until a RESUME, but even if we processed them
>> before, i.e. really make SUSPEND/RESUME no-ops, it would most likely work
>> out fine), so I have no idea what kind of background operations we are even
>> talking about, or whether any such actually exist in practice.
>>
>> I don’t know what anyone had in mind when introducing the RESET.  It comes
>> from vDPA (c3716f260bf moved it from vdpa into the common code), and exists
>> since the code was originally added (108a64818e6), so there’s no comment
>> explaining why it exists.  I can’t explain what the back-end is supposed to
>> stop doing, because so far it isn’t explained anywhere in qemu, its git log,
>> or in any documentation (there basically is no vdpa documentation).
>>
>> I can only say what I just completely naïvely assumed it to mean so far:
>> That the back-end basically should stop doing anything besides handling and
>> replying to vhost-user messages.  If such a message requires changing any
>> state, visible or not, then this state change is permissible.
> Okay, I suggest the following instead of "background operations":
>
> - Changes to the device state produced by SET_DEVICE_STATE_FD.

This is definitely something that I would absolutely allow after 
SUSPEND.  If the front-end does not wish the back-end to do this, it can 
just not send this command while the back-end is suspended.

> - Writing to memory regions.
> - Signalling that buffers have been used.

This feels both too tight and not concrete enough.  The only buffers I 
can think of are buffers supplied through virt queues, which I intended 
to already be included in “stop processing all virt queues”.  (I took 
this to mean the used-buffer ring, too, but I can of course be more 
explicit about this, e.g. “stop processing all virt queues, including 
returning buffers to the driver”.) “Signalling” sounds like triggering 
the callfd, but that also seems clear; if you can’t process virt queues, 
including returning buffers, you can never trigger the callfd (or send 
VHOST_USER_BACKEND_VRING_CALL), because there can never be a new buffer 
returned to the driver.

So too tight because it feels like a subset of virt queue processing, 
but not concrete enough because “buffers” makes me feel like I’m 
overlooking something besides virt queues.

> - Signalling that the configuration space has changed.

Maybe this could be more general, i.e. the back-end must not send any 
vhost-user messages to the front-end?

> The goal is to ensure the device state and memory regions are stable and
> that back-end doesn't trigger activity in the front-end.

If the goal is to ensure that the device state is stable, I feel like we 
must then specify precisely this, and not just to say it must not be 
mutable through SET_DEVICE_STATE_FD: In general, the state is more 
likely to be changed by other factors after all.

On the other hand, I also don’t see why that’s a goal.  For migration, 
it might seem desirable, but I don’t actually think so: The back-end is 
required to send a consistent device state anyway, so it is up to the 
back-end to ensure the state is consistent, we don’t need to make it a 
requirement for SUSPEND.  It is implicitly clear from the migration 
model that if the device state were to change after the back-end has 
sent it to the front-end, those change will be lost on the destination 
side, so it is clear that the back-end must anticipate this and work 
around it.

Other than migration, qemu doesn’t see the device state at all.  I don’t 
see why internal state should not change between stop/cont. If a device 
experience some signal that (for some reason) it can’t pause to receive 
only after the subsequent RESUME, it might need to make note of that 
signal to act on it after RESUME.  I would consider that a change in 
internal state, and I don’t immediately see a problem with it.  (It may 
be problematic when migrating, because receiving such signals on the 
source side after transferring the state would mean they’re lost, but 
again, this is something the device clearly has to solve, e.g. by 
redirecting the signals to the destination starting with the 
SET_TRANSFER_STATE_FD call.)

Hanna


