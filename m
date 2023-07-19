Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B607597A2
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:01:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7iQ-00035N-Sp; Wed, 19 Jul 2023 09:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7iO-00034r-92
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM7iM-0007Np-7t
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689775176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLJbgWQhdXeL0Z3JgA/7bbFIPyx4LL5211jJKHXRLwQ=;
 b=DlyL77s48SMGYmx2wReCsbTFT2r9P3DpH0GE6qbj41gPDKuikGGQtT4xI46d1+ZI2uIBmS
 mMhphCe7bmX50nVKQC40sRZaMjzw9TeLG9fO0fI9QWdFyz1/QRQ66fOCrY34X604+MG6Bv
 LmD/kFdzAZ4HEnWGYnIh+Pl4Je8X7zg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-R5AuntNZMVCET7qppKBZaQ-1; Wed, 19 Jul 2023 09:59:35 -0400
X-MC-Unique: R5AuntNZMVCET7qppKBZaQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso387640566b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689775174; x=1692367174;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PLJbgWQhdXeL0Z3JgA/7bbFIPyx4LL5211jJKHXRLwQ=;
 b=UFyJ0DF7TwX19GxAdxZ4qpuesdnxKTvViJCNJCvXZ1fo6cfwTC/0D2Sh/kqJDTUwel
 gMh6yHwnY14pTUkMsQfUrl4fODGXTa2wQqGKDGU5AjUq6cDm/Qrrlm3a027MWqjfWX/9
 kl5lH9NkYcY+/2XPaa/TkcfxWPEexM7mkEZI13NZTCbSFMoThBsXVtD47vRh02tpckWS
 kWsayfdJ3EF91VMbWpOTq2V/lQ0rH9tIIUfphD9Z/GtwuXX8SDJVO0nzwSzVfqUf34fQ
 pQSjBer5A3X1YQmrUecYXeibtg2wJKEmIuNIlrYo9RnzAb+6ZND7qoB5q7pP8f8O8FgN
 bc/Q==
X-Gm-Message-State: ABy/qLbINDQBwxZs3/myQy4Vvp1j7k5rFT7MvY1bqzCQI2v3H+Hn8d/3
 CSth9ju9LFA9TCV7fQ27mhHqGz48vOLv+1vxw1GJQPckkUl2mcLkrwrAvdyE2i/HwuBi3g4VkNB
 kK0IMYfllGo3IgIE=
X-Received: by 2002:a17:906:1041:b0:992:3ac7:a2da with SMTP id
 j1-20020a170906104100b009923ac7a2damr2299401ejj.30.1689775174025; 
 Wed, 19 Jul 2023 06:59:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGU6JMcn0Ga1iPhV5CMQdHcOTOT6gMd8lZfnW332DT0DgyWTK2+AcHCVnsn0wI/YIf3YFp6XQ==
X-Received: by 2002:a17:906:1041:b0:992:3ac7:a2da with SMTP id
 j1-20020a170906104100b009923ac7a2damr2299382ejj.30.1689775173665; 
 Wed, 19 Jul 2023 06:59:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 lw10-20020a170906bcca00b0098e2eaec395sm2386939ejb.130.2023.07.19.06.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:59:33 -0700 (PDT)
Message-ID: <a760479a-f623-1fa9-a557-70a857fe8dcf@redhat.com>
Date: Wed, 19 Jul 2023 15:59:32 +0200
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
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718142557.GB44841@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 16:25, Stefan Hajnoczi wrote:
> On Tue, Jul 11, 2023 at 05:52:23PM +0200, Hanna Czenczek wrote:
>> When stopping the VM, qemu wants all devices to fully cease any
>> operation, too.  Currently, we can only have vhost-user back-ends stop
>> processing vrings, but not background operations.  Add the SUSPEND and
>> RESUME commands from vDPA, which allow the front-end (qemu) to tell
>> back-ends to cease all operations, including those running in the
>> background.
>>
>> qemu's current work-around for this is to reset the back-end instead of
>> suspending it, which will not work for back-ends that have internal
>> state that must be preserved across e.g. stop/cont.
>>
>> Note that the given specification requires the back-end to delay
>> processing kicks (i.e. starting vrings) until the device is resumed,
>> instead of requiring the front-end not to send kicks while suspended.
>> qemu starts devices (and would just resume them) only when the VM is in
>> a running state, so it would be difficult to have qemu delay kicks until
>> the device is resumed, which is why this patch specifies handling of
>> kicks as it does.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   docs/interop/vhost-user.rst | 35 +++++++++++++++++++++++++++++++++--
>>   1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..ac6be34c4c 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -381,6 +381,10 @@ readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK``
>>   or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated,
>>   and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
>>   
>> +While the back-end is suspended (via ``VHOST_USER_SUSPEND``), it must
>> +never process rings, and thus also delay handling kicks until the
> If you respin this series, I suggest replacing "never" with "not" to
> emphasize that ring processing is only skipped while the device is
> suspended (rather than forever). "Never" feels too strong to use when
> describing a temporary state.

Sure.

>> +back-end is resumed again.
>> +
>>   Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>>   
>>   If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
>> @@ -479,8 +483,9 @@ supplied by ``VhostUserLog``.
>>   ancillary data, it may be used to inform the front-end that the log has
>>   been modified.
>>   
>> -Once the source has finished migration, rings will be stopped by the
>> -source. No further update must be done before rings are restarted.
>> +Once the source has finished migration, the device will be suspended and
>> +its rings will be stopped by the source. No further update must be done
>> +before the device and its rings are resumed.
> This paragraph is abstract and doesn't directly identify the mechanisms
> or who does what:
> - "the device will be suspended" via VHOST_USER_SUSPEND (or reset when
>    VHOST_USER_SUSPEND is not supported?) or automatically by the device
>    itself or some other mechanism?

OK, I’ll add VHOST_USER_SUSPEND.

So far I hadn’t considered making a note of resetting as a fallback 
right in the specification.  I don’t think I would want it in the 
specification, but on the other hand, it is probably important for 
back-end authors to know that if they do not implement SUSPEND, their 
device is going to be reset by qemu.

Can we make that a ”may”, i.e.:

```
Once the source has finished migration, the device will be suspended via 
VHOST_USER_SUSPEND and its rings will be stopped by the source. No 
further update must be done before the device and its rings are resumed. 
If and only if the back-end does not support VHOST_USER_SUSPEND, the 
front-end may reset it instead (via VHOST_USER_SET_STATUS, 
VHOST_USER_RESET_DEVICE, or VHOST_USER_RESET_OWNER).
```

I’m unsure about the “If and only if” – older qemu versions will break 
this, but I feel like we must promise back-end writers that if they 
implement SUSPEND, their back-end is not going to be reset; if it is, 
and something breaks because of it, it’s the front-end that must be 
updated to match the specification.

> - "before the device and its rings are resumed" via VHOST_USER_RESUME?
>    And is this referring to the source device?

Yes, via VHOST_USER_RESUME, and restarting the rings by starting them 
(i.e. a kick).

Whether this is referring to the source device…  Well, the text as it 
was before begs the exact same question, so honestly, I don’t know for 
sure.  “Restarting” only makes sense if the rings were stopped before, 
so I assume it’s referring to the source, e.g. for the case of a failed 
migration.  RESUME at least definitely will only happen after a prior 
SUSPEND, so this one will definitely only apply on the source side.

> Please rephrase the paragraph to identify the vhost-user messages
> involved.
>
>>   
>>   In postcopy migration the back-end is started before all the memory has
>>   been received from the source host, and care must be taken to avoid
>> @@ -885,6 +890,7 @@ Protocol features
>>     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>     #define VHOST_USER_PROTOCOL_F_STATUS               16
>>     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> +  #define VHOST_USER_PROTOCOL_F_SUSPEND              18
>>   
>>   Front-end message types
>>   -----------------------
>> @@ -1440,6 +1446,31 @@ Front-end message types
>>     query the back-end for its device status as defined in the Virtio
>>     specification.
>>   
>> +``VHOST_USER_SUSPEND``
>> +  :id: 41
>> +  :equivalent ioctl: VHOST_VDPA_SUSPEND
>> +  :request payload: N/A
>> +  :reply payload: N/A
>> +
>> +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
>> +  successfully negotiated, this message is submitted by the front-end to
>> +  have the back-end cease all operations except for handling vhost-user
>> +  requests.  The back-end must stop processing all virt queues, and it
>> +  must not perform any background operations.  It may not resume until a
> "background operations" are not defined. What does it mean:
> - Anything that writes to memory slots
> - Anything that changes the visible state of the device
> - Anything that changes the non-visible internal state of the device
> - etc
> ?

My best answer (honestly) is: You tell me.  This series is introducing 
SUSPEND/RESUME because qemu wants to reset devices to make them stop 
“background operations”, and this would break virtiofsd if any form of 
reset were actually implemented.  The implementation of SUSPEND/RESUME 
in virtiofsd on the other hand is supposed to basically be a no-op 
(besides delaying ring processing until a RESUME, but even if we 
processed them before, i.e. really make SUSPEND/RESUME no-ops, it would 
most likely work out fine), so I have no idea what kind of background 
operations we are even talking about, or whether any such actually exist 
in practice.

I don’t know what anyone had in mind when introducing the RESET.  It 
comes from vDPA (c3716f260bf moved it from vdpa into the common code), 
and exists since the code was originally added (108a64818e6), so there’s 
no comment explaining why it exists.  I can’t explain what the back-end 
is supposed to stop doing, because so far it isn’t explained anywhere in 
qemu, its git log, or in any documentation (there basically is no vdpa 
documentation).

I can only say what I just completely naïvely assumed it to mean so far: 
That the back-end basically should stop doing anything besides handling 
and replying to vhost-user messages.  If such a message requires 
changing any state, visible or not, then this state change is permissible.

>> +  subsequent ``VHOST_USER_RESUME`` call.
>> +
>> +``VHOST_USER_RESUME``
>> +  :id: 42
>> +  :equivalent ioctl: VHOST_VDPA_RESUME
>> +  :request payload: N/A
>> +  :reply payload: N/A
>> +
>> +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
>> +  successfully negotiated, this message is submitted by the front-end to
>> +  allow the back-end to resume operations after having been suspended
>> +  before.  The back-end must again begin processing rings that are not
> This can be made more concrete by referencing the vhost-user message
> used to suspend the device:
>
> "suspended before" -> "suspended with VHOST_USER_SUSPEND"

Alright.

Hanna

>> +  stopped, and it may resume background operations.
>> +
>>   
>>   Back-end message types
>>   ----------------------
>> -- 
>> 2.41.0
>>


