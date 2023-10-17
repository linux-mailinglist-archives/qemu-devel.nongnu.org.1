Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2C7CBCD2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qserx-0007hA-Ev; Tue, 17 Oct 2023 03:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsert-0007gv-HO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsers-0006Rj-0X
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697529115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1O+Edd1A/UmdQ2F6m8Wn9qIH7jSo0rMxrhvk9TSZ+kw=;
 b=OnoTzdtiMym7vppCr4ox/hEl5IQSOfqjEZB3TXn0PtLzNpE+Ozv9VgfPCun2dqc2iTmH0p
 IQBae8wq1cDvW+DN6ArdCkdd4ua5oPEIu59W+i5bQNQE8XYP8sTe9xzHBXeVqn+uKFNO7z
 J8rpYQERcuG3Pbqhhl82ucbsqi5MVs8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-IRS2jh7vOw61j2zI_3b2cQ-1; Tue, 17 Oct 2023 03:51:43 -0400
X-MC-Unique: IRS2jh7vOw61j2zI_3b2cQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-323334992fbso3408778f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697529102; x=1698133902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1O+Edd1A/UmdQ2F6m8Wn9qIH7jSo0rMxrhvk9TSZ+kw=;
 b=GWuc5CXLsW+Goi/drGSIza/jtuuOjvNuMbY7nerySz0pNlUpvXS8pgY1zGHaFboSmx
 MG3rGOFHTa8OtPyW9x9gF2xGHn7CmeiJLHwL9/83amJkBnizMQFfeI864177L16A+KRY
 zenndF41fKZ3oUlrdo37D55yNgOxPsLzE3JLhfh3e9bgZ7BbeV/Ad4VSy6IoMSW620OW
 A1JSZNogZ6zzI+23nJ5ZRmwnTrJTypNxEXJ19tYmTBxbnUJrLFh3aZ4z8QPq5X7YAYh9
 il34qltlu3EXxFGXH2K4XPifPHg0WP+bvW7R65gq/37lnjegq7nmPNvQW3872GCN7BgQ
 L5dQ==
X-Gm-Message-State: AOJu0YzD1RYo3XLD1p4CJ6es3JhuM28qz4q826zSYDn1mzVYGYCkWPV5
 AEBSHq2whi6wTw7tLie/rMpe3RS7hvINcGfSy7LpygnKydLIxrf1S2PAl9OZHq7+1s/e03CAwVE
 MOCkcP8ca+KVz6wA=
X-Received: by 2002:a5d:56d1:0:b0:32d:9a69:ab61 with SMTP id
 m17-20020a5d56d1000000b0032d9a69ab61mr946005wrw.65.1697529102106; 
 Tue, 17 Oct 2023 00:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3UJsX9NzfqMaaMcmVYi8A4dDjChohn2ki8zzmOBClDs8TrHoYarZOL0wzOeg4/4kXlNNA8g==
X-Received: by 2002:a5d:56d1:0:b0:32d:9a69:ab61 with SMTP id
 m17-20020a5d56d1000000b0032d9a69ab61mr945990wrw.65.1697529101713; 
 Tue, 17 Oct 2023 00:51:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 q23-20020adfb197000000b0032d8ce46caasm1050205wra.93.2023.10.17.00.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 00:51:41 -0700 (PDT)
Message-ID: <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
Date: Tue, 17 Oct 2023 09:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Viresh Kumar <viresh.kumar@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org> <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
 <87lec2dc7r.fsf@linaro.org> <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 17.10.23 07:36, Viresh Kumar wrote:
> On 16-10-23, 12:40, Alex Bennée wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>
>>> On 16-10-23, 11:45, Manos Pitsidianakis wrote:
>>>> On Mon, 16 Oct 2023 11:32, Hanna Czenczek <hreitz@redhat.com> wrote:
>>>>> diff --git a/include/hw/virtio/vhost-user.h
>>>>> b/include/hw/virtio/vhost-user.h
>>>>> index 9f9ddf878d..1d4121431b 100644
>>>>> --- a/include/hw/virtio/vhost-user.h
>>>>> +++ b/include/hw/virtio/vhost-user.h
>>>>> @@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
>>>>>      VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>>>>>      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>>>>>      VHOST_USER_PROTOCOL_F_STATUS = 16,
>>>>> -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>>>>> +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>>>>> +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>>>>>      VHOST_USER_PROTOCOL_F_MAX
>>>>> };
>>>> May I ask, why not define VHOST_USER_PROTOCOL_F_XEN_MMAP as well instead of
>>>> a comment mention?
>>> Perhaps because we will never use it from Qemu code ?
>> Vikram's work on enabling xenpvh support will mean enabling grant
>> support and while I suspect most VirtIO backends will be within QEMU
>> itself if it ever want to off-load something to a vhost-user backend it
>> will need to ensure this flag is set.
> Hanna,
>
> It would be good to define it then in the current commit itself.

Not that I’m really opposed to that, but I don’t see the problem with 
just doing that in the same work that makes qemu actually use this flag, 
exactly because it’s just a -1/+1 change.

I can send a v2, but should I do the same for libvhost-user and define 
the flag there?  Do I have to add a patch to do the same for F_STATUS, 
which so far only got a placeholder comment?

Hanna


