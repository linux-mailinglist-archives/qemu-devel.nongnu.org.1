Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA33F7BD687
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmKf-0001uq-0H; Mon, 09 Oct 2023 05:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qpmKb-0001dB-3T
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qpmKZ-0007xh-DD
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696842818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABO1ssmOf/yxp2UqU5hYWT8EihQdB3rO6TA7kl/rMis=;
 b=GTAgtL7KIjnoi4DZApUK/U4hzX7VsJnk7TLz1yyI2WkRJHgqsajqAyaJl9Smriu6ONEb1s
 O/UhPp02xNS/bQf4cmHQ8lcoHWUHJmbyVUMzgYjbwXvaNqlqRDow3J4aemo++2WzFZ4F+4
 nbEIMj2A/CXZYmdmbKkG5xWtDV6/GVk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-rnmrDuvqPFa_UlXr6sbjFQ-1; Mon, 09 Oct 2023 05:13:37 -0400
X-MC-Unique: rnmrDuvqPFa_UlXr6sbjFQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so309909566b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696842815; x=1697447615;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABO1ssmOf/yxp2UqU5hYWT8EihQdB3rO6TA7kl/rMis=;
 b=CEM3J3lBGh51J8RZHXRBq3ldRx5k94VY4uOaQucpaSpHo52c908C2gyaNp5D7bhMUP
 euqKuFdwzGSbFMhlZ8BrykE/rOxuVxUdTIj1lGni95Tr8yqe0LwqFJOleLwrP3vPahAw
 okpg6mfDyn+G7wfTFpJVhJJFJC0JtQAsni0YhTwDAmJZOFf4BAgtSM41i+ogDUAvxUNo
 gn8WVhMXYlPujHvIWS+IlSgzuspp6bd92V/3XGqFiJ1Vsw++a5C2jUhHAejvk9bhiTSJ
 ej4rY6bKqJ9OYR9CilCbCtHREd1q21p6Ppi8f6c5p9aN8SgrqSk4P0e2N0lOyb9sEPvt
 Q62A==
X-Gm-Message-State: AOJu0YzzYwj7j7vxow3AIE1TBU+IS2kBhQTRTkzSaNfpjvqptO6UItgP
 mKwo8OyQIe0qgInThUur+xeTasXqGNWibVyo4B08Aq8SZwBSZo1jDRTwXvkLgzwDsatMRIW3yG1
 oBKFsMJ7G60UYBtJRbg6DYws=
X-Received: by 2002:a17:906:30d6:b0:9ad:a4bd:dc67 with SMTP id
 b22-20020a17090630d600b009ada4bddc67mr10912598ejb.50.1696842815741; 
 Mon, 09 Oct 2023 02:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQWIllm1FsHRmJ7hvKTtgZwxQRNcY24qwB9Bq944KT4i/yQ1IpdO1mAwEExLj/wzNUO3qEeA==
X-Received: by 2002:a17:906:30d6:b0:9ad:a4bd:dc67 with SMTP id
 b22-20020a17090630d600b009ada4bddc67mr10912577ejb.50.1696842815353; 
 Mon, 09 Oct 2023 02:13:35 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a170906a28b00b009737b8d47b6sm6465450ejz.203.2023.10.09.02.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:13:34 -0700 (PDT)
Message-ID: <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
Date: Mon, 9 Oct 2023 11:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Yajun Wu <yajunw@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, parav@nvidia.com,
 maxime.coquelin@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
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
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
In-Reply-To: <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
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

On 09.10.23 11:07, Hanna Czenczek wrote:
> On 09.10.23 10:21, Hanna Czenczek wrote:
>> On 07.10.23 04:22, Yajun Wu wrote:
>
> [...]
>
>>> The main motivation of adding VHOST_USER_SET_STATUS is to let 
>>> backend DPDK know
>>> when DRIVER_OK bit is valid. It's an indication of all VQ 
>>> configuration has sent,
>>> otherwise DPDK has to rely on first queue pair is ready, then 
>>> receiving/applying
>>> VQ configuration one by one.
>>>
>>> During live migration, configuring VQ one by one is very time 
>>> consuming.
>>
>> One question I have here is why it wasn’t then introduced in the live 
>> migration code, but in the general VM stop/cont code instead. It does 
>> seem time-consuming to do this every time the VM is paused and resumed.
>>
>>> For VIRTIO
>>> net vDPA, HW needs to know how many VQs are enabled to set 
>>> RSS(Receive-Side Scaling).
>>>
>>> If you don’t want SET_STATUS message, backend can remove protocol 
>>> feature bit
>>> VHOST_USER_PROTOCOL_F_STATUS.
>>
>> The problem isn’t back-ends that don’t want the message, the problem 
>> is that qemu uses the message wrongly, which prevents well-behaving 
>> back-ends from implementing the message.
>>
>>> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device 
>>> close/reset.
>>
>> So the right thing to do for back-ends is to announce STATUS support 
>> and then not implement it correctly?
>>
>> GET_VRING_BASE should not reset the close or reset the device, by the 
>> way.  It should stop that one vring, not more.  We have a 
>> RESET_DEVICE command for resetting.
>>
>>> I'm not involved in discussion about adding SET_STATUS in Vhost 
>>> protocol. This feature
>>> is essential for vDPA(same as vhost-vdpa implements 
>>> VHOST_VDPA_SET_STATUS).
>>
>> So from what I gather from your response is that there is only a 
>> single use for SET_STATUS, which is the DRIVER_OK bit.  If so, 
>> documenting that all other bits are to be ignored by both back-end 
>> and front-end would be fine by me.
>>
>> I’m not fully serious about that suggestion, but I hear the strong 
>> implication that nothing but DRIVER_OK was of any concern, and this 
>> is really important to note when we talk about the status of the 
>> STATUS feature in vhost today.  It seems to me now that it was not 
>> intended to be the virtio-level status byte, but just a DRIVER_OK 
>> signalling path from front-end to back-end.  That makes it a 
>> vhost-level protocol feature to me.
>
> On second thought, it just is a pure vhost-level protocol feature, and 
> has nothing to do with the virtio status byte as-is.  The only stated 
> purpose is for the front-end to send DRIVER_OK after migration, but 
> migration is transparent to the guest, so the guest would never change 
> the status byte during migration.  Therefore, if this feature is 
> essential, we will never be able to have a status byte that is 
> transparently shared between guest and back-end device, i.e. the 
> virtio status byte.

On third thought, scratch that.  The guest wouldn’t set it, but 
naturally, after migration, the front-end will need to restore the 
status byte from the source, so the front-end will always need to set 
it, even if it were otherwise used controlled only by the guest and the 
back-end device.  So technically, this doesn’t prevent such a use case.  
(In practice, it isn’t controlled by the guest right now, but that could 
be fixed.)

> Cc-ing Alex on this mail, because to me, this seems like an important 
> detail when he plans on using the byte in the future. If we need a 
> virtio status byte, I can’t see how we could use the existing F_STATUS 
> for it.
>
> Hanna


