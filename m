Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063A7DB22E
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:08:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIck-0000Eh-Qm; Sun, 29 Oct 2023 23:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qxIci-0000E8-Ig
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qxIch-0004Qb-5u
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698635245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=509gLieTfbl3y77HBjXtSwMmopBamvith14CazYhtHA=;
 b=MEYlqok+6UIq1Jc6yVYus+K14fGUkLsvF4oY+RrbecnKc5gZ7fveWSrx5rXkVEWe/PP+//
 olAH2PvZ12Uu3QBQqNA2SnOFgX+LMFrvhSSZlFACblCAmpprf//J7Uc+ejs5c08e2zxJAe
 HaBWVCNgV3wnOwpD2wfHJgD7d9DjkeI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-2mEzcNqPNgKDYycEYffOyQ-1; Sun, 29 Oct 2023 23:07:01 -0400
X-MC-Unique: 2mEzcNqPNgKDYycEYffOyQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1ef4f8d26d2so5040100fac.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698635220; x=1699240020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=509gLieTfbl3y77HBjXtSwMmopBamvith14CazYhtHA=;
 b=Shft277YZw9jHhSHofwD6uA7xmRmS++Cqj0ZhIGCJwiSVBbJ0vMkPDkVYqkHmPUYkc
 Z5rLRWI3tWzazM8lcKkW8jlt/LYy15Fal3iOAPfa9Y8m6sb5M7IgrRvQNlkgXxsGb5gs
 o+JXep/xPSpro9jwla6OrsbXhwfQWkCrV2dBah1b9BrgkbvkYsApPmSdfMiEOv5j1+5X
 ZKCnjzLRjFmWLEU/lxc8hD6h69+YFR+uXLdZ0p8O1ofb7Rl4B2sPPVPaapEnM5spcy6/
 e72+seRZUXq+EuhOWj80Iw9lfQ+r5DZFrueI3NvGBsOmBnEYBOgtyu7ItlLGe0OsUSra
 1SHA==
X-Gm-Message-State: AOJu0YzQu6s64/rpsEUYQ/YNtLthzPTuYHLUUBxk76vBZ6tesR8WUxmP
 SSrtXEEw+dB10DbawCaDoNiLS6cIj7X1o7zMjlqbMJR06nnMq0yx4U3mrQejJdGynWup1C4m6Fe
 EXhDteLdf2hbwA44=
X-Received: by 2002:a05:6870:6b0c:b0:1e9:cde8:6db0 with SMTP id
 mt12-20020a0568706b0c00b001e9cde86db0mr13503126oab.50.1698635220628; 
 Sun, 29 Oct 2023 20:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYs5BnrdkMUjiKdAr0HkAVDHL5cqer6DPUgYP9XK90v6uh+Yn5117SDEGi2newbxmfYOS5xA==
X-Received: by 2002:a05:6870:6b0c:b0:1e9:cde8:6db0 with SMTP id
 mt12-20020a0568706b0c00b001e9cde86db0mr13503123oab.50.1698635220310; 
 Sun, 29 Oct 2023 20:07:00 -0700 (PDT)
Received: from [10.72.113.184] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a639855000000b005b46e691108sm3806506pgo.68.2023.10.29.20.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:06:59 -0700 (PDT)
Message-ID: <9204e711-0eb9-01da-54dd-c67ae9e05c3b@redhat.com>
Date: Mon, 30 Oct 2023 11:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 04/21] net: Remove receive_raw()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-5-akihiko.odaki@daynix.com>
 <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
 <ef82309f-ca89-4850-acf6-94ffa7726c2f@daynix.com>
Content-Language: en-US
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <ef82309f-ca89-4850-acf6-94ffa7726c2f@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
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


在 2023/10/27 15:52, Akihiko Odaki 写道:
> On 2023/10/27 15:49, Jason Wang wrote:
>> On Tue, Oct 17, 2023 at 12:09 PM Akihiko Odaki 
>> <akihiko.odaki@daynix.com> wrote:
>>>
>>> While netmap implements virtio-net header, it does not implement
>>> receive_raw().
>>
>> The only user for raw is the announcing. Netmap probably doesn't it 
>> at all.
>
> In my understanding, the announcing *sends* a raw packet.


It's send via NIC and receive by its peer which is the TAP

qemu_send_packet_raw() -> nc -> nc->peer -> peer->receive_raw()?

Anything I miss?

Thanks


> Both of tap and netmap *receive* packets with virtio-net headers.
>
> Regards,
> Akihiko Odaki
>


