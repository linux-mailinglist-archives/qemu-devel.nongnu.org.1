Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD77DDE36
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:16:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7KK-0005jE-09; Wed, 01 Nov 2023 05:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qy7KF-0005iF-R3
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:15:49 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qy7KD-0001T8-Cy
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:15:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso6638200b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698830143; x=1699434943;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ewkk79e9jBkmPmkSl0nSjitRmJ7eef2gYjJt7qSIYgA=;
 b=uDrpaKPLk/C8F05EXXi0jvn5ZJ/pC0GzksrdUJINc51iBGzzJvL0DCflnXI1zAAVZ2
 PVCZu4MVbqU06Iv9uakhb3nqiUC+O0BsUC72gLKblughYe9kk6ZxRPv9V2KFt2UM6D5D
 U2pV77PQXNk6V93sX3jF2ZuBnCWEpqCFjKBzwQHgXyjOrTGAQsJcVjQRiZTdlURNmabv
 i5EhPTLe7Sm6tZg8ItpypTCHnxoe4WNz9/vPx3gbfZXITSDF63zJoah4SIp1WOIqzhQ1
 VsBREyh4tUsfrGZM2TIJl5cKOPn+GCN4nKQqzijuzeYI7WRMF+NMsycwW4LpGZnfZUE/
 BWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698830143; x=1699434943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ewkk79e9jBkmPmkSl0nSjitRmJ7eef2gYjJt7qSIYgA=;
 b=d64PlOWjtV+D1KPb4jMVelW3CRa6oXa8h4GkYXFcXqxGYsOkVZuLVRJS+M5g3jmjf6
 F6bcqpjdY3zFWaSimOmr1e1IYle37Xe6c+lAX4wN8mZjBqq1RzGBx+l5Yy/mIjzCeCKv
 tYsxNbyTw5urP9Cwfafrc/O7Sd7BYZHpy1MAS0DZXjbQaClPM8bYnHxqWNtDNaYx7LVf
 KIp1ee0GcEGsmJg/S4kmQDp3iqhZ1mnVh8biwiGJLnpum+rwEcUqfp5ve5i6DTCAzahr
 XWv90/8foAI0Pt77xer71nUwoMwDNCiqMCBdgPTp6Fr/+G5Tp+bv5LKeO+PXWH5VrC0g
 9svA==
X-Gm-Message-State: AOJu0YxbvWmFPK2k57GK+uz5jCTIYmYu7Co+i6+3YykMMyRxZPh7IrDM
 tsseVK0lZ04c8yNRe+1ACN+DkkrHmeHHFlMT/etiuQ==
X-Google-Smtp-Source: AGHT+IHicbbZDniqgzY7OwAgnuTw4BF87XYgoZPP50PBJNTkZzT1YQS0McZigyvJ2J9Oryw4d2VpVA==
X-Received: by 2002:a05:6a00:2d9d:b0:6b1:b5c4:a8b0 with SMTP id
 fb29-20020a056a002d9d00b006b1b5c4a8b0mr18739674pfb.23.1698830143671; 
 Wed, 01 Nov 2023 02:15:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z20-20020aa785d4000000b0068bc6a75848sm894191pfn.156.2023.11.01.02.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 02:15:43 -0700 (PDT)
Message-ID: <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
Date: Wed, 1 Nov 2023 18:15:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231101050838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/01 18:09, Michael S. Tsirkin wrote:
> On Wed, Nov 01, 2023 at 05:35:50PM +0900, Akihiko Odaki wrote:
>> On 2023/11/01 15:38, Michael S. Tsirkin wrote:
>>> On Wed, Nov 01, 2023 at 01:50:00PM +0900, Akihiko Odaki wrote:
>>>> We had another discussion regarding migration for patch "virtio-net: Do not
>>>> clear VIRTIO_NET_F_HASH_REPORT". It does change the runtime behavior so we
>>>> need to take migration into account. I still think the patch does not
>>>> require a compatibility flag since it only exposes a new feature and does
>>>> not prevent migrating from old QEMU that exposes less features. It instead
>>>> fixes the case where migrating between hosts with different tap feature
>>>> sets.
>>>
>>> When in doubt, add a compat flag.
>>
>> Personally I'm confident about the migration compatibility with patch
>> "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT". virtio-net already does
>> the same thing when the tap implementation on the destination implements
>> virtio-net header support while the counterpart of the source does not.
> 
> Trust me there's been so many times where we were very sure and
> problems come up later. Just don't enable new functionality for
> old machine types, problem solved. Why is this hard?

I see. I'll add a compatibility flag for VIRTIO_NET_F_HASH_REPORT 
exposure; it should be quite easy.

