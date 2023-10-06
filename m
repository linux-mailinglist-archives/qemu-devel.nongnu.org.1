Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440A7BB410
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogwa-0005yK-8p; Fri, 06 Oct 2023 05:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qogwI-0005pF-CY
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qogwC-0003Fx-MB
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696583760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqWOxkOyfIqACV11mMXKmh3AJy3JhEl9ZRaUid4FjkU=;
 b=HL8JfQJkBaBGlzqdhMnuvAl03s6hAAFOPlQPQiUrZGcAnOkAHlJvAcDTjAiiHd7sTca+Ii
 jtlna5hPc5ROvikEaH2rRfO+qA88XLaNybcGWJU7saOB5GLt/R4vw/2eAA5MCdxo53r0Vt
 W4CAE1L3lN6LtpkadnvAb5W2VpCFgdI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Y4_I2hj2M82br_glF6c-yg-1; Fri, 06 Oct 2023 05:15:58 -0400
X-MC-Unique: Y4_I2hj2M82br_glF6c-yg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53635d2442dso1599152a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696583757; x=1697188557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqWOxkOyfIqACV11mMXKmh3AJy3JhEl9ZRaUid4FjkU=;
 b=wMke8zjoYBX/QqyiWCARat0MyrNpTIOBTAahpNIcO3OoKsv0EdTjd3VJFn6O/0GLyw
 dH8e4y8/xb0vsrvW1zlwdZJKpYXqH8SfhbrSh/7dkb0hCJFwmxv/BvSxw0iu9VfWrWFO
 2egeIcq7jD8agH5PCNc66q+W0G/Q+n4beLwOJ8Z3HH/ZAgQJTTL/+xKEqkkiNJuj5iNB
 Ivx534H8gy66q7JLJyyWbczLpCc8c4NsN7IDZalyUROARN+Hz6wnK4bWdCckKUykz96z
 IyPbeuKwgvvRlu2QoX1s0ZHy21jVaCIoMW2u5TTu6OYrel8AkrFlXxPqXN9u/sLUF+2P
 IJiA==
X-Gm-Message-State: AOJu0Yx+ZLCK04JHRZI13GRxrKS8qWhyI+b+G4bEW6h8mDKEAfkBwCT4
 M7EjQdrtrgCDf8zMe3E2bapAEpqiSCUIMKc+oUpCTFpnna4cqfkaDMcVKu+uxOlkCaPhoMF7jeU
 1oysb4j3qZbdSghc=
X-Received: by 2002:a17:906:8a71:b0:9ae:3d75:4c83 with SMTP id
 hy17-20020a1709068a7100b009ae3d754c83mr5938408ejc.0.1696583757627; 
 Fri, 06 Oct 2023 02:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfJLi6tSSvsCp6ovvR9RhyGFkPGNVyjRg8BNg250Pi08HUfAEVvceRE6kdP5nPfyS20VpOcg==
X-Received: by 2002:a17:906:8a71:b0:9ae:3d75:4c83 with SMTP id
 hy17-20020a1709068a7100b009ae3d754c83mr5938390ejc.0.1696583757218; 
 Fri, 06 Oct 2023 02:15:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a056402515300b0053495596f42sm2299769edd.30.2023.10.06.02.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:15:56 -0700 (PDT)
Message-ID: <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
Date: Fri, 6 Oct 2023 11:15:55 +0200
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
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231006043518-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 06.10.23 10:45, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>>>> There is no clearly defined purpose for the virtio status byte in
>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
>>>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
>>>>> protocol extension, it is possible for SET_FEATURES to return errors
>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>>>>>
>>>>> As for implementations, SET_STATUS is not widely implemented.  dpdk does
>>>>> implement it, but only uses it to signal feature negotiation failure.
>>>>> While it does log reset requests (SET_STATUS 0) as such, it effectively
>>>>> ignores them, in contrast to RESET_OWNER (which is deprecated, and today
>>>>> means the same thing as RESET_DEVICE).
>>>>>
>>>>> While qemu superficially has support for [GS]ET_STATUS, it does not
>>>>> forward the guest-set status byte, but instead just makes it up
>>>>> internally, and actually completely ignores what the back-end returns,
>>>>> only using it as the template for a subsequent SET_STATUS to add single
>>>>> bits to it.  Notably, after setting FEATURES_OK, it never reads it back
>>>>> to see whether the flag is still set, which is the only way in which
>>>>> dpdk uses the status byte.
>>>>>
>>>>> As-is, no front-end or back-end can rely on the other side handling this
>>>>> field in a useful manner, and it also provides no practical use over
>>>>> other mechanisms the vhost-user protocol has, which are more clearly
>>>>> defined.  Deprecate it.
>>>>>
>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>> ---
>>>>>    docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
>>>>>    1 file changed, 21 insertions(+), 7 deletions(-)
>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
>>> The fact current backends never check errors does not mean they never
>>> will. So no, not applying this.
>> Can this not be done with REPLY_ACK?  I.e., with the following message
>> order:
>>
>> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is
>> present
>> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
>> 4. SET_FEATURES with need_reply
>>
>> If not, the problem is that qemu has sent SET_STATUS 0 for a while when the
>> vCPUs are stopped, which generally seems to request a device reset.  If we
>> don’t state at least that SET_STATUS 0 is to be ignored, back-ends that will
>> implement SET_STATUS later may break with at least these qemu versions.  But
>> documenting that a particular use of the status byte is to be ignored would
>> be really strange.
>>
>> Hanna
> Hmm I guess. Though just following virtio spec seems cleaner to me...
> vhost-user reconfigures the state fully on start.

Not the internal device state, though.  virtiofsd has internal state, 
and other devices like vhost-gpu back-ends would probably, too.

Stefan has recently sent a series 
(https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.html) 
to put the reset (RESET_DEVICE) into virtio_reset() (when we really need 
a reset).

I really don’t like our current approach with the status byte. Following 
the virtio specification to me would mean that the guest directly 
controls this byte, which it does not.  qemu makes up values as it deems 
appropriate, and this includes sending a SET_STATUS 0 when the guest is 
just paused, i.e. when the guest really doesn’t want a device reset.

That means that qemu does not treat this as a virtio device field 
(because that would mean exposing it to the guest driver), but instead 
treats it as part of the vhost(-user) protocol.  It doesn’t feel right 
to me that we use a virtio-defined feature for communication on the 
vhost level, i.e. between front-end and back-end, and not between guest 
driver and device.  I think all vhost-level protocol features should be 
fully defined in the vhost-user specification, which REPLY_ACK is.

Now, we could hand full control of the status byte to the guest, and 
that would make me content.  But I feel like that doesn’t really work, 
because qemu needs to intercept the status byte anyway (it needs to know 
when there is a reset, probably wants to know when the device is 
configured, etc.), so I don’t think having the status byte in vhost-user 
really gains us much when qemu could translate status byte changes 
to/from other vhost-user commands.

Hanna

> I guess symmetry was the
> point. So I don't see why SET_STATUS 0 has to be ignored.
>
>
> SET_STATUS was introduced by:
>
> commit 923b8921d210763359e96246a58658ac0db6c645
> Author: Yajun Wu <yajunw@nvidia.com>
> Date:   Mon Oct 17 14:44:52 2022 +0800
>
>      vhost-user: Support vhost_dev_start
>
> CC the author.
>


