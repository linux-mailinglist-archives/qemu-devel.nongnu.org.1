Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EAD7BB6C0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojE2-0003h8-KX; Fri, 06 Oct 2023 07:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qojDp-0003Np-Rm
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qojDn-0001xc-LQ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utKNw7A9wbDCsIdKn2zsctdKyMQV/80UbklP8vMxJJM=;
 b=dif1q2Up3WvhjHp354ifW0mh7Z9HIWtghWSTnso0ah1xyJQkeL6VgFNkk4jyxgZ3CHsVGB
 Lie5faq0/5tVpg8oTpW97gdXXmyMS6puFQRFJzTb9c/Cj6tMIG/p2WTgzTzoOJBHA7gsga
 PIPkHrgZUryOS5NUZahPBBmKR9618Bw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94--Ft3WvNYPHSmWKoXm__q1g-1; Fri, 06 Oct 2023 07:42:17 -0400
X-MC-Unique: -Ft3WvNYPHSmWKoXm__q1g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae42088b4bso161208266b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696592536; x=1697197336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=utKNw7A9wbDCsIdKn2zsctdKyMQV/80UbklP8vMxJJM=;
 b=apg6MPSzhl0bYqxrnbfHbvyIl1+gEJBYsHIXkCBRsrQM2lo/G3Rl7jolmCzVq5nCH8
 Y8GlFRv/Z1Io4kgvpJXJ7RdkKbcakf6JsJI0OX4Cro8bn+bxK/+tPP2FEnKno+8S8DxC
 Eva20YPbVuHSbJy4h6NzmBAUgerb3JBJnNN4gCWnK94Wr9BPfAkzqLC2Lm5m0EDULhhU
 snE2yzZTXPDl4wFU6nkBn4YZ681H8zcb6GU+YmcyC+Tg7a1haEy0jzqh40eazALSRk81
 xSd5+IE1mN5Lv96xg5XIRXXwvJyV2OcqOEwxeoP+AFZ4cUb8KkRbkLTzffTNMm1G6MG5
 jmGA==
X-Gm-Message-State: AOJu0YyPK5OXJ7Wltoxfp6ZsY5e3qFNjSUrNaGzwyRQjuGq10H6sRwMT
 D4r8F0CcA4oXT49dOyVGFtySAEcL+mdM5S8VDjm3oteyXNC4PWhzfecyQlKfncVTP+At4As4rev
 aHUWcPyZN4+QYpT4=
X-Received: by 2002:a17:906:154:b0:9a9:f2fd:2a2b with SMTP id
 20-20020a170906015400b009a9f2fd2a2bmr6094331ejh.73.1696592536242; 
 Fri, 06 Oct 2023 04:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVaTX074LaeSQ2vZ12mQibXDfxgHxNkFjvSELUbnQCyDb3lQIzK/T1lgcWmiFOmyGR8PRiUQ==
X-Received: by 2002:a17:906:154:b0:9a9:f2fd:2a2b with SMTP id
 20-20020a170906015400b009a9f2fd2a2bmr6094305ejh.73.1696592535821; 
 Fri, 06 Oct 2023 04:42:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a1709064ed900b009b947aacb4bsm2736103ejv.191.2023.10.06.04.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:42:15 -0700 (PDT)
Message-ID: <d9c2d2c4-5ab3-a3f3-8925-155e1c4ff73a@redhat.com>
Date: Fri, 6 Oct 2023 13:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Yajun Wu <yajunw@nvidia.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231006055229-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 06.10.23 12:34, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>>>>>>>> There is no clearly defined purpose for the virtio status byte in
>>>>>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
>>>>>>>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
>>>>>>>>> protocol extension, it is possible for SET_FEATURES to return errors
>>>>>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>>>>>>>>>
>>>>>>>>> As for implementations, SET_STATUS is not widely implemented.  dpdk does
>>>>>>>>> implement it, but only uses it to signal feature negotiation failure.
>>>>>>>>> While it does log reset requests (SET_STATUS 0) as such, it effectively
>>>>>>>>> ignores them, in contrast to RESET_OWNER (which is deprecated, and today
>>>>>>>>> means the same thing as RESET_DEVICE).
>>>>>>>>>
>>>>>>>>> While qemu superficially has support for [GS]ET_STATUS, it does not
>>>>>>>>> forward the guest-set status byte, but instead just makes it up
>>>>>>>>> internally, and actually completely ignores what the back-end returns,
>>>>>>>>> only using it as the template for a subsequent SET_STATUS to add single
>>>>>>>>> bits to it.  Notably, after setting FEATURES_OK, it never reads it back
>>>>>>>>> to see whether the flag is still set, which is the only way in which
>>>>>>>>> dpdk uses the status byte.
>>>>>>>>>
>>>>>>>>> As-is, no front-end or back-end can rely on the other side handling this
>>>>>>>>> field in a useful manner, and it also provides no practical use over
>>>>>>>>> other mechanisms the vhost-user protocol has, which are more clearly
>>>>>>>>> defined.  Deprecate it.
>>>>>>>>>
>>>>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>>>> ---
>>>>>>>>>      docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
>>>>>>>>>      1 file changed, 21 insertions(+), 7 deletions(-)
>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>> SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
>>>>>>> The fact current backends never check errors does not mean they never
>>>>>>> will. So no, not applying this.
>>>>>> Can this not be done with REPLY_ACK?  I.e., with the following message
>>>>>> order:
>>>>>>
>>>>>> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is
>>>>>> present
>>>>>> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>> 4. SET_FEATURES with need_reply
>>>>>>
>>>>>> If not, the problem is that qemu has sent SET_STATUS 0 for a while when the
>>>>>> vCPUs are stopped, which generally seems to request a device reset.  If we
>>>>>> don’t state at least that SET_STATUS 0 is to be ignored, back-ends that will
>>>>>> implement SET_STATUS later may break with at least these qemu versions.  But
>>>>>> documenting that a particular use of the status byte is to be ignored would
>>>>>> be really strange.
>>>>>>
>>>>>> Hanna
>>>>> Hmm I guess. Though just following virtio spec seems cleaner to me...
>>>>> vhost-user reconfigures the state fully on start.
>>>> Not the internal device state, though.  virtiofsd has internal state, and
>>>> other devices like vhost-gpu back-ends would probably, too.
>>>>
>>>> Stefan has recently sent a series
>>>> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.html) to
>>>> put the reset (RESET_DEVICE) into virtio_reset() (when we really need a
>>>> reset).
>>>>
>>>> I really don’t like our current approach with the status byte. Following the
>>>> virtio specification to me would mean that the guest directly controls this
>>>> byte, which it does not.  qemu makes up values as it deems appropriate, and
>>>> this includes sending a SET_STATUS 0 when the guest is just paused, i.e.
>>>> when the guest really doesn’t want a device reset.
>>>>
>>>> That means that qemu does not treat this as a virtio device field (because
>>>> that would mean exposing it to the guest driver), but instead treats it as
>>>> part of the vhost(-user) protocol.  It doesn’t feel right to me that we use
>>>> a virtio-defined feature for communication on the vhost level, i.e. between
>>>> front-end and back-end, and not between guest driver and device.  I think
>>>> all vhost-level protocol features should be fully defined in the vhost-user
>>>> specification, which REPLY_ACK is.
>>> Hmm that makes sense. Maybe we should have done what stefan's patch
>>> is doing.
>>>
>>> Do look at the original commit that introduced it to understand why
>>> it was added.
>> I don’t understand why this was added to the stop/cont code, though.  If it
>> is time consuming to make these changes, why are they done every time the VM
>> is paused
>> and resumed?  It makes sense that this would be done for the initial
>> configuration (where a reset also wouldn’t hurt), but here it seems wrong.
>>
>> (To be clear, a reset in the stop/cont code is wrong, because it breaks
>> stateful devices.)
>>
>> Also, note the newer commits 6f8be29ec17 and c3716f260bf.  The reset as
>> originally introduced was wrong even for non-stateful devices, because it
>> occurred before we fetched the state (vring indices) so we could restore it
>> later.  I don’t know how 923b8921d21 was tested, but if the back-end used
>> for testing implemented SET_STATUS 0 as a reset, it could not have survived
>> either migration or a stop/cont in general, because the vring indices would
>> have been reset to 0.
>>
>> What I’m saying is, 923b8921d21 introduced SET_STATUS calls that broke all
>> devices that would implement them as per virtio spec, and even today it’s
>> broken for stateful devices.  The mentioned performance issue is likely
>> real, but we can’t address it by making up SET_STATUS calls that are wrong.
>>
>> I concede that I didn’t think about DRIVER_OK.  Personally, I would do all
>> final configuration that would happen upon a DRIVER_OK once the first vring
>> is started (i.e. receives a kick).  That has the added benefit of being
>> asynchronous because it doesn’t block any vhost-user messages (which are
>> synchronous, and thus block downtime).
>>
>> Hanna
>
> For better or worse kick is per ring. It's out of spec to start rings
> that were not kicked but I guess you could do configuration ...
> Seems somewhat asymmetrical though.

I meant to take the first ring being started as the signal to do the 
global configuration, i.e. not do this once per vring, but once globally.

> Let's wait until next week, hopefully Yajun Wu will answer.

I mean, personally I don’t really care about the whole SET_STATUS 
thing.  It’s clear that it’s broken for stateful devices.  The fact that 
it took until 6f8be29ec17d to fix it for just any device that would 
implement it according to spec to me is a strong indication that nobody 
does implement it according to spec, and is currently only used to 
signal to some specific back-end that all rings have been set up and 
should be configured in a single block.

(By the way, our SET_STATUS call that adds ACKNOWLEDGE | DRIVER | 
DRIVER_OK is also completely against the spec, and any well-behaving 
device should reject it.  These flags must be set one after another, and 
specifically, features must be read and set after setting DRIVER, but 
before setting FEATURES_OK, and FEATURES_OK must be set before setting 
DRIVER_OK.  Any well-behaving device should error out when DRIVER_OK is 
set without FEATURES_OK set, or when FEATURES_OK is set without 
ACKNOWLEDGE | DRIVER set.)

I can just drop this patch from the migration series, because in my 
opinion it doesn’t affect it whatsoever (although I understood Stefan 
disagrees).  But honestly, I think any vhost-user back-end developer is 
well-advised to completely ignore the status byte.  Not ignoring it 
means relying on qemu’s implementation-defined behavior.

Hanna


