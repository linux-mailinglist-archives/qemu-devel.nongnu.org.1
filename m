Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7C7BBC1B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qon3O-0000mN-EN; Fri, 06 Oct 2023 11:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qon3D-0000lz-4K
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qon38-0004uZ-Sh
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696607253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHDXD2ZruD93ieVNC/JsDnkX0F9Wo/v86bBKKvSlpzc=;
 b=MW21JzTFaygj3cv5dueNacAkr+Tmd/hBijiaXvBE+Ka2eOLPgCE1CqqhFuHAghMcZIYp0G
 sSi9E0wiDhMoVJn46yhK16gV/frudu5xAmicn0ZYdImFPjvL73PaZXROT8W0e41KmigJ4Y
 i/PjIJotdoLeWbABsl2z0hW0iGP8qoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-3Ga35XOwNvqOgH-SKHR7eQ-1; Fri, 06 Oct 2023 11:47:29 -0400
X-MC-Unique: 3Ga35XOwNvqOgH-SKHR7eQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-321f75cf2bdso1434666f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 08:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696607249; x=1697212049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dHDXD2ZruD93ieVNC/JsDnkX0F9Wo/v86bBKKvSlpzc=;
 b=cM1PytsNyEoJ3BeOV5RaaS/raQ5w5Dz22/L08rCnAGO4UrqAjROge0piKPkn8xcUGj
 AmfDiij+6dqDM0XQADU2NkNHmUiblLfOFrTP361m/po5faQjl4R8kKcWOL4RA2aq5J8U
 iVUeCUlUdc8dpaeUPxFKLG5siYMHfSe2u6AvxHB/2AsDDckgbQBdjkkmVDdPKtDTZx04
 jcNKJzIJXL55/tQvSWe0hQz6Ld7xpkS0kh6cmokOIQDfeop+1gxfzfjpyfVCTPKvaPZ5
 VuJjbfpezgkX0R95yXIJLJhdfMIxJ9tWXM/kiALpmHubUozN4oxeK4Pj2eLO4h2Vlqzv
 b1LA==
X-Gm-Message-State: AOJu0Yzx4on8xhNkbeWe4IO5mkqDsPmriGD0nC8dpa82gd5qoOAXb2/3
 H+EZ4udEBmFD9XxGqq5GIMIWZAYu8tCliLYIjL7cI4/INHkbFYr7yNXhYQp3fcic0k2xvpRZ51v
 Dqbi/evte/Ujw7Q0=
X-Received: by 2002:a05:6000:4d2:b0:322:dbe8:e18f with SMTP id
 h18-20020a05600004d200b00322dbe8e18fmr8801892wri.46.1696607248655; 
 Fri, 06 Oct 2023 08:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwZfgcLg5qqJWiIpdO/X8YDkNbq9VFClyxUrqLCGcBwAMmUiE225die2qhlUM8YTKJtanF7A==
X-Received: by 2002:a05:6000:4d2:b0:322:dbe8:e18f with SMTP id
 h18-20020a05600004d200b00322dbe8e18fmr8801871wri.46.1696607248312; 
 Fri, 06 Oct 2023 08:47:28 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a5d6dc9000000b00327b5ca093dsm1893096wrz.117.2023.10.06.08.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 08:47:27 -0700 (PDT)
Message-ID: <2ba3ef6b-4af1-9c65-f542-bfcc8412e99c@redhat.com>
Date: Fri, 6 Oct 2023 17:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Yajun Wu <yajunw@nvidia.com>,
 qemu-devel@nongnu.org
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <d9c2d2c4-5ab3-a3f3-8925-155e1c4ff73a@redhat.com> <87il7jg4oe.fsf@linaro.org>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87il7jg4oe.fsf@linaro.org>
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

On 06.10.23 17:17, Alex Bennée wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 06.10.23 12:34, Michael S. Tsirkin wrote:
>>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
> <snip>
>>>> What I’m saying is, 923b8921d21 introduced SET_STATUS calls that broke all
>>>> devices that would implement them as per virtio spec, and even today it’s
>>>> broken for stateful devices.  The mentioned performance issue is likely
>>>> real, but we can’t address it by making up SET_STATUS calls that are wrong.
>>>>
>>>> I concede that I didn’t think about DRIVER_OK.  Personally, I would do all
>>>> final configuration that would happen upon a DRIVER_OK once the first vring
>>>> is started (i.e. receives a kick).  That has the added benefit of being
>>>> asynchronous because it doesn’t block any vhost-user messages (which are
>>>> synchronous, and thus block downtime).
>>>>
>>>> Hanna
>>> For better or worse kick is per ring. It's out of spec to start rings
>>> that were not kicked but I guess you could do configuration ...
>>> Seems somewhat asymmetrical though.
>> I meant to take the first ring being started as the signal to do the
>> global configuration, i.e. not do this once per vring, but once
>> globally.
>>
>>> Let's wait until next week, hopefully Yajun Wu will answer.
>> I mean, personally I don’t really care about the whole SET_STATUS
>> thing.  It’s clear that it’s broken for stateful devices.  The fact
>> that it took until 6f8be29ec17d to fix it for just any device that
>> would implement it according to spec to me is a strong indication that
>> nobody does implement it according to spec, and is currently only used
>> to signal to some specific back-end that all rings have been set up
>> and should be configured in a single block.
> I'm certainly using [GS]ET_STATUS for the proposed F_TRANSPORT
> extensions where everything is off-loaded to the vhost-user backend.

How do these back-ends work with the fact that qemu uses SET_STATUS 
incorrectly when not offloading?  Do you plan on fixing that?

(I.e. that we send SET_STATUS 0 when the VM is paused, potentially 
resetting state that is not recoverable, and that we set DRIVER and 
DRIVER_OK simultaneously.)

Hanna


