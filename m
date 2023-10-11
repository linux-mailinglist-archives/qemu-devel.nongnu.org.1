Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70337C5869
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbOY-0003bi-VU; Wed, 11 Oct 2023 11:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbOU-0003Yk-5T
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:45:06 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbOS-00031j-Ig
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:45:05 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bb6a2481fso3463974eaf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697039103; x=1697643903;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5CCaqDc4/3mUPxsQn0aA0Z52njJhzwqd0bUDp7BMqt8=;
 b=LYzj4HbTnXduFWJEcVSVDAnLr49BRXSpx/AypIiW0/fVWpiOAmZwcqlKXSrsA1aGdT
 lzRNAHoCb4ZV5HunauyBs6GiknUTZjLjj798/L493yuyRfgb+EL62lYoIoMZLbm5G+sZ
 dQCPfFmJSLPIh52U2L5uMoWmxbbgWhxLr4kcdKqOlddfEbNa+0/6C4/okw5nP2j10CVw
 wwFz4SDjxOzKJQ0w5bC+PSROBIxhnADv6dIlY/O88semyLALqKOLwyAPLgCY3pH56R+r
 l7tql4zF1eOCMNF27w19ElZaSoW1GPfDFpgyzh5/5WacJlIZFKcX3CCPBGwbLdxzQLCo
 B+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697039103; x=1697643903;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CCaqDc4/3mUPxsQn0aA0Z52njJhzwqd0bUDp7BMqt8=;
 b=FpH74Rzji5f2mguOWL3SxB2CthNnFLsXPSvg9m5FP0AtB4ucZd3aG+iB+SuvDJIOJJ
 ssSltnUiwKtJP+De6FGLzodLyOf2YMT2S/3qvyZ4o86cbmr5l8ypl43v1l5HhS5eC3Pb
 d5mO7Y4NnKU7+4ajv78+Zr/ZLZYL3nCeSx+cPjHR9emZsi/0mwEhlz2S9rv+H2F9mTaM
 cxnx/lX5FuQ5NJpQrkrTtZRJBIYXllXlQIsLAjD4NAtb4scFFqAgvBJa7EO/r4JeHGIl
 AMxk8K4DGlV6sAAkUVkwE8O8UbWTl1qgyeJgMw552fUTXkXWFo+Lug+FS7Y4jz5q0jZR
 CyaQ==
X-Gm-Message-State: AOJu0Yz3MtASykkp0BVyq+6ME9ETRLBKtmZzZqLUEnglMcWDmd1K+j4f
 iOYn543pLxUn8IInq+vA0+XPMA==
X-Google-Smtp-Source: AGHT+IE5S59r0VzKxadqyow8BWWpPR6J0w/2cT+GYTWdogk6EAMKN9Y4zvlMnaqAWc0FzDFuh4f2HA==
X-Received: by 2002:a05:6359:310d:b0:164:8252:2609 with SMTP id
 rh13-20020a056359310d00b0016482522609mr6460613rwb.20.1697039103175; 
 Wed, 11 Oct 2023 08:45:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x8-20020aa784c8000000b00690fdeb5c0dsm10168713pfn.2.2023.10.11.08.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:45:02 -0700 (PDT)
Message-ID: <6fce7508-9e9c-47da-85ab-51596f4f2522@daynix.com>
Date: Thu, 12 Oct 2023 00:44:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] tap: Fix virtio-net header buffer size
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
 <20231010025924.14593-2-akihiko.odaki@daynix.com>
 <b80debfa-b789-400b-bc0c-a0ccc77a3530@tls.msk.ru>
 <e0f860d5-a6e9-43e6-b8f1-0395bac0c90f@daynix.com>
In-Reply-To: <e0f860d5-a6e9-43e6-b8f1-0395bac0c90f@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/11 15:43, Akihiko Odaki wrote:
> On 2023/10/10 16:56, Michael Tokarev wrote:
>> 10.10.2023 05:59, Akihiko Odaki wrote:
>>> The largest possible virtio-net header is struct virtio_net_hdr_v1_hash.
>>>
>>> Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   net/tap.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/tap.c b/net/tap.c
>>> index c6639d9f20..ea46feeaa8 100644
>>> --- a/net/tap.c
>>> +++ b/net/tap.c
>>> @@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState 
>>> *nc, const struct iovec *iov,
>>>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>>       const struct iovec *iovp = iov;
>>>       struct iovec iov_copy[iovcnt + 1];
>>> -    struct virtio_net_hdr_mrg_rxbuf hdr = { };
>>> +    struct virtio_net_hdr_v1_hash hdr = { };
>>
>> BTW, can we get rid of (implicit) memzero() here and in
>> similar places, initializing only the actually used fields?
>> Not that his particular structure is very large (and this
>> change makes it 8 bytes larger), but still..
> 
> These variables are rarely used so I think it's fine. In particular, 
> these variables are used only when QEMU sends an ARP packet while 
> virtio-net is enabled.

My previous statement was not correct. These variables are used also 
when QEMU emulates a network interface that doesn't expose virtio-net 
headers.

I split the code path for these two cases in v3. The header size is 
shrunken now for the normal code path.

Regards,
Akihiko Odaki

