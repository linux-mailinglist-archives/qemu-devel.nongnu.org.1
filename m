Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E897BD509
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:22:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplWk-0002Xb-Ar; Mon, 09 Oct 2023 04:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qplWa-0002X4-9J
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qplWX-0007HB-SZ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696839716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIFS6mxABGWPpIYq+ZT6QmDcFOhxm0fPteNW+Tq2cjU=;
 b=CXHLyV4Y7wL8c57ogGpDkMfg8aXD7zQnNAtGdUHWuqRChWx7DDdI2TM/wYmuIeYwcsEMBv
 UTKPqblkgCt6ivTRaKg8jV8o48IHq5iOTSQWnyF+XUVNLgF+DjnHx9VO+Mx62hV5L6Vlve
 qEWulp1j81fz6UBazztaecxfn1okpjU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-s1Vh3gQrM7OME7vJ7zY_lg-1; Mon, 09 Oct 2023 04:21:55 -0400
X-MC-Unique: s1Vh3gQrM7OME7vJ7zY_lg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b2e030e4caso570333266b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 01:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696839714; x=1697444514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JIFS6mxABGWPpIYq+ZT6QmDcFOhxm0fPteNW+Tq2cjU=;
 b=Io/6Cnlm/e8Wjx1MCzTFStzd1OSAZy2Ttyjjqla2PFwz1+0+n6ST40yHRsRI+qD69Z
 4iuuHgMNDDe8ZY4L83J3Zp34qb0MZFnlKAyQ+G0riVCtLiv3vErLqCZpsDeEiXnKsUhE
 s+EkQfu+/0tnPbhrhiSUNnwR8+PEwXkHGwCDuP/oo9X85ut7aR0HSDMKjQyPxUNpJBYS
 z+a26bB6JQBnbNfnFH62DEepPWM7IxeunMxcKacbkInIP2J37prcK2HdUndcUZ0TKEeG
 XzJQijYMk2pGN/NPKNzu16dolRLQDu4u4XC0xuIDAqm5/3/RWVqxOfHQjnS5pEptTOVm
 t1+A==
X-Gm-Message-State: AOJu0Yxq6gwknfM00pRUd4ypXi3tvMT+KH9OIr90tHGBYHvSq55cE5HD
 RSEunz+N1zur0KGpYxgE1MNIQZIp+2c0iWkxK1I+SUAPHIfK0wa5jAPJzfJM+u7CtVsJdeVt+jp
 fODBHmUTPLiKOwH8=
X-Received: by 2002:a17:906:b80c:b0:9a2:295a:9bbc with SMTP id
 dv12-20020a170906b80c00b009a2295a9bbcmr8329866ejb.37.1696839714141; 
 Mon, 09 Oct 2023 01:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtFyX/z3hS4s/RLPRWRJzZRR0l+W/UYCQxadnTq20bXoSOlfKm27RPNkWzsxil6jw/tTKocA==
X-Received: by 2002:a17:906:b80c:b0:9a2:295a:9bbc with SMTP id
 dv12-20020a170906b80c00b009a2295a9bbcmr8329847ejb.37.1696839713618; 
 Mon, 09 Oct 2023 01:21:53 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a17090619cd00b009ae587ce135sm6415816ejd.223.2023.10.09.01.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:21:52 -0700 (PDT)
Message-ID: <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
Date: Mon, 9 Oct 2023 10:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
To: Yajun Wu <yajunw@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, parav@nvidia.com,
 maxime.coquelin@redhat.com
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 07.10.23 04:22, Yajun Wu wrote:
>
> On 10/6/2023 6:34 PM, Michael S. Tsirkin wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>>>>>>>>> There is no clearly defined purpose for the virtio status 
>>>>>>>>>> byte in
>>>>>>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and 
>>>>>>>>>> for virtio
>>>>>>>>>> feature negotiation, we have [GS]ET_FEATURES. With the REPLY_ACK
>>>>>>>>>> protocol extension, it is possible for SET_FEATURES to return 
>>>>>>>>>> errors
>>>>>>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>>>>>>>>>>
>>>>>>>>>> As for implementations, SET_STATUS is not widely 
>>>>>>>>>> implemented.  dpdk does
>>>>>>>>>> implement it, but only uses it to signal feature negotiation 
>>>>>>>>>> failure.
>>>>>>>>>> While it does log reset requests (SET_STATUS 0) as such, it 
>>>>>>>>>> effectively
>>>>>>>>>> ignores them, in contrast to RESET_OWNER (which is 
>>>>>>>>>> deprecated, and today
>>>>>>>>>> means the same thing as RESET_DEVICE).
>>>>>>>>>>
>>>>>>>>>> While qemu superficially has support for [GS]ET_STATUS, it 
>>>>>>>>>> does not
>>>>>>>>>> forward the guest-set status byte, but instead just makes it up
>>>>>>>>>> internally, and actually completely ignores what the back-end 
>>>>>>>>>> returns,
>>>>>>>>>> only using it as the template for a subsequent SET_STATUS to 
>>>>>>>>>> add single
>>>>>>>>>> bits to it.  Notably, after setting FEATURES_OK, it never 
>>>>>>>>>> reads it back
>>>>>>>>>> to see whether the flag is still set, which is the only way 
>>>>>>>>>> in which
>>>>>>>>>> dpdk uses the status byte.
>>>>>>>>>>
>>>>>>>>>> As-is, no front-end or back-end can rely on the other side 
>>>>>>>>>> handling this
>>>>>>>>>> field in a useful manner, and it also provides no practical 
>>>>>>>>>> use over
>>>>>>>>>> other mechanisms the vhost-user protocol has, which are more 
>>>>>>>>>> clearly
>>>>>>>>>> defined.  Deprecate it.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>      docs/interop/vhost-user.rst | 28 
>>>>>>>>>> +++++++++++++++++++++-------
>>>>>>>>>>      1 file changed, 21 insertions(+), 7 deletions(-)
>>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>> SET_STATUS is the only way to signal failure to acknowledge 
>>>>>>>> FEATURES_OK.
>>>>>>>> The fact current backends never check errors does not mean they 
>>>>>>>> never
>>>>>>>> will. So no, not applying this.
>>>>>>> Can this not be done with REPLY_ACK?  I.e., with the following 
>>>>>>> message
>>>>>>> order:
>>>>>>>
>>>>>>> 1. GET_FEATURES to find out whether 
>>>>>>> VHOST_USER_F_PROTOCOL_FEATURES is
>>>>>>> present
>>>>>>> 2. GET_PROTOCOL_FEATURES to hopefully get 
>>>>>>> VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>>> 4. SET_FEATURES with need_reply
>>>>>>>
>>>>>>> If not, the problem is that qemu has sent SET_STATUS 0 for a 
>>>>>>> while when the
>>>>>>> vCPUs are stopped, which generally seems to request a device 
>>>>>>> reset.  If we
>>>>>>> don’t state at least that SET_STATUS 0 is to be ignored, 
>>>>>>> back-ends that will
>>>>>>> implement SET_STATUS later may break with at least these qemu 
>>>>>>> versions.  But
>>>>>>> documenting that a particular use of the status byte is to be 
>>>>>>> ignored would
>>>>>>> be really strange.
>>>>>>>
>>>>>>> Hanna
>>>>>> Hmm I guess. Though just following virtio spec seems cleaner to 
>>>>>> me...
>>>>>> vhost-user reconfigures the state fully on start.
>>>>> Not the internal device state, though.  virtiofsd has internal 
>>>>> state, and
>>>>> other devices like vhost-gpu back-ends would probably, too.
>>>>>
>>>>> Stefan has recently sent a series
>>>>> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.html) 
>>>>> to
>>>>> put the reset (RESET_DEVICE) into virtio_reset() (when we really 
>>>>> need a
>>>>> reset).
>>>>>
>>>>> I really don’t like our current approach with the status byte. 
>>>>> Following the
>>>>> virtio specification to me would mean that the guest directly 
>>>>> controls this
>>>>> byte, which it does not.  qemu makes up values as it deems 
>>>>> appropriate, and
>>>>> this includes sending a SET_STATUS 0 when the guest is just 
>>>>> paused, i.e.
>>>>> when the guest really doesn’t want a device reset.
>>>>>
>>>>> That means that qemu does not treat this as a virtio device field 
>>>>> (because
>>>>> that would mean exposing it to the guest driver), but instead 
>>>>> treats it as
>>>>> part of the vhost(-user) protocol.  It doesn’t feel right to me 
>>>>> that we use
>>>>> a virtio-defined feature for communication on the vhost level, 
>>>>> i.e. between
>>>>> front-end and back-end, and not between guest driver and device.  
>>>>> I think
>>>>> all vhost-level protocol features should be fully defined in the 
>>>>> vhost-user
>>>>> specification, which REPLY_ACK is.
>>>> Hmm that makes sense. Maybe we should have done what stefan's patch
>>>> is doing.
>>>>
>>>> Do look at the original commit that introduced it to understand why
>>>> it was added.
>>> I don’t understand why this was added to the stop/cont code, 
>>> though.  If it
>>> is time consuming to make these changes, why are they done every 
>>> time the VM
>>> is paused
>>> and resumed?  It makes sense that this would be done for the initial
>>> configuration (where a reset also wouldn’t hurt), but here it seems 
>>> wrong.
>>>
>>> (To be clear, a reset in the stop/cont code is wrong, because it breaks
>>> stateful devices.)
>>>
>>> Also, note the newer commits 6f8be29ec17 and c3716f260bf.  The reset as
>>> originally introduced was wrong even for non-stateful devices, 
>>> because it
>>> occurred before we fetched the state (vring indices) so we could 
>>> restore it
>>> later.  I don’t know how 923b8921d21 was tested, but if the back-end 
>>> used
>>> for testing implemented SET_STATUS 0 as a reset, it could not have 
>>> survived
>>> either migration or a stop/cont in general, because the vring 
>>> indices would
>>> have been reset to 0.
>>>
>>> What I’m saying is, 923b8921d21 introduced SET_STATUS calls that 
>>> broke all
>>> devices that would implement them as per virtio spec, and even today 
>>> it’s
>>> broken for stateful devices.  The mentioned performance issue is likely
>>> real, but we can’t address it by making up SET_STATUS calls that are 
>>> wrong.
>>>
>>> I concede that I didn’t think about DRIVER_OK.  Personally, I would 
>>> do all
>>> final configuration that would happen upon a DRIVER_OK once the 
>>> first vring
>>> is started (i.e. receives a kick).  That has the added benefit of being
>>> asynchronous because it doesn’t block any vhost-user messages (which 
>>> are
>>> synchronous, and thus block downtime).
>>>
>>> Hanna
>>
>> For better or worse kick is per ring. It's out of spec to start rings
>> that were not kicked but I guess you could do configuration ...
>> Seems somewhat asymmetrical though.
>>
>> Let's wait until next week, hopefully Yajun Wu will answer.
> The main motivation of adding VHOST_USER_SET_STATUS is to let backend 
> DPDK know
> when DRIVER_OK bit is valid. It's an indication of all VQ 
> configuration has sent,
> otherwise DPDK has to rely on first queue pair is ready, then 
> receiving/applying
> VQ configuration one by one.
>
> During live migration, configuring VQ one by one is very time consuming.

One question I have here is why it wasn’t then introduced in the live 
migration code, but in the general VM stop/cont code instead. It does 
seem time-consuming to do this every time the VM is paused and resumed.

> For VIRTIO
> net vDPA, HW needs to know how many VQs are enabled to set 
> RSS(Receive-Side Scaling).
>
> If you don’t want SET_STATUS message, backend can remove protocol 
> feature bit
> VHOST_USER_PROTOCOL_F_STATUS.

The problem isn’t back-ends that don’t want the message, the problem is 
that qemu uses the message wrongly, which prevents well-behaving 
back-ends from implementing the message.

> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device 
> close/reset.

So the right thing to do for back-ends is to announce STATUS support and 
then not implement it correctly?

GET_VRING_BASE should not reset the close or reset the device, by the 
way.  It should stop that one vring, not more.  We have a RESET_DEVICE 
command for resetting.

> I'm not involved in discussion about adding SET_STATUS in Vhost 
> protocol. This feature
> is essential for vDPA(same as vhost-vdpa implements 
> VHOST_VDPA_SET_STATUS).

So from what I gather from your response is that there is only a single 
use for SET_STATUS, which is the DRIVER_OK bit.  If so, documenting that 
all other bits are to be ignored by both back-end and front-end would be 
fine by me.

I’m not fully serious about that suggestion, but I hear the strong 
implication that nothing but DRIVER_OK was of any concern, and this is 
really important to note when we talk about the status of the STATUS 
feature in vhost today.  It seems to me now that it was not intended to 
be the virtio-level status byte, but just a DRIVER_OK signalling path 
from front-end to back-end.  That makes it a vhost-level protocol 
feature to me.

Hanna

>
> Thanks,
> Yajun
>>
>>>>> Now, we could hand full control of the status byte to the guest, 
>>>>> and that
>>>>> would make me content.  But I feel like that doesn’t really work, 
>>>>> because
>>>>> qemu needs to intercept the status byte anyway (it needs to know 
>>>>> when there
>>>>> is a reset, probably wants to know when the device is configured, 
>>>>> etc.), so
>>>>> I don’t think having the status byte in vhost-user really gains us 
>>>>> much when
>>>>> qemu could translate status byte changes to/from other vhost-user 
>>>>> commands.
>>>>>
>>>>> Hanna
>>>> well it intercepts it but I think it could pass it on unchanged.
>>>>
>>>>
>>>>>> I guess symmetry was the
>>>>>> point. So I don't see why SET_STATUS 0 has to be ignored.
>>>>>>
>>>>>>
>>>>>> SET_STATUS was introduced by:
>>>>>>
>>>>>> commit 923b8921d210763359e96246a58658ac0db6c645
>>>>>> Author: Yajun Wu <yajunw@nvidia.com>
>>>>>> Date:   Mon Oct 17 14:44:52 2022 +0800
>>>>>>
>>>>>>        vhost-user: Support vhost_dev_start
>>>>>>
>>>>>> CC the author.
>>>>>>
>


