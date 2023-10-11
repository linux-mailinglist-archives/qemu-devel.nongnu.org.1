Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A20877C4AE8
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:45:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSwn-0001mJ-NQ; Wed, 11 Oct 2023 02:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqSwl-0001lx-LI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:43:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqSwj-00017R-Nq
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:43:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-694ed847889so4960519b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697006632; x=1697611432;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Jn+NKwWTZXJVmfPy1k1GUZNHp2gO9ceFQHoImbV4xo=;
 b=tfQzUmt4/k+a/qwBDj35UH0ve/ErMT17yFr0KvjaeQCPgDmBhrJksSvKtoJ+VwEUFI
 QlOex1zZQRm2MAMsGLSzkinWrSa6mcw8UnxnnCMWaiIriqKqiUKIZVKAjlV8UwSVcP7b
 ZWbzkLqFNOa0t71Nkdpaf9R36V6O9zj3shlqOkxaaIiFs0KQwclvMoVQ3q3PFroU3/9o
 n5kYNgosFDCcJoyt1GX4RKt10Q8XZa7l4TLleRC625LnPBm3dR3sgd004pW+EGEtBkt1
 nsQX/ZRNpfDmLYBy/TNY8udHNPx61XlkUyl89EWbPnVzdU0E39G+eYkLH03naQ4w+j4J
 lX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697006632; x=1697611432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Jn+NKwWTZXJVmfPy1k1GUZNHp2gO9ceFQHoImbV4xo=;
 b=tT7T7ObdPia/fjuf32kVDXo8o7uRNg60LhyESrwPKQ1z0Kl5TBRkRLzAQCI8FQuuXG
 Cg6EgX6vCcJc+ioBt8HARJq6kpmm7CJjoOo5bdZVURAczcTp8oc059CJ6zc0w/wvveys
 yGlh2QdQg0Xzirn/gxNdBrCozJOd1ucwpM7CACn41TgsU3TnZkk3Ex+kKoyLM67YLmuK
 uwTKB9pBHhOHT/vD/o7AN/5SxoWBOsdDDQmd6LDtAKE/4+2JrtgYPZ3Ijm+viDisxWAQ
 EB/68pErV7hQD7pZtzWiJJNnEVPWV9+zMY0iEUmm/1LMpqGkVan+FqjOSRmAP89a/Gd0
 hQ8A==
X-Gm-Message-State: AOJu0YxmsFP/8dm9djFFfOLNAYLZV/0DF+jZnK0dL5pOiMnbLK/Ram7g
 9AGOR6nygetwIZ7HjYa4+CA7Tw==
X-Google-Smtp-Source: AGHT+IG7/ZoXxWxwkju4w2nk4ZKEgp/nyPKgcvZfAFBmIPWKkKQLUTsjQncVbzxEGDULd3pkv8ePTg==
X-Received: by 2002:a05:6a20:160c:b0:163:b85e:6348 with SMTP id
 l12-20020a056a20160c00b00163b85e6348mr20790882pzj.39.1697006632055; 
 Tue, 10 Oct 2023 23:43:52 -0700 (PDT)
Received: from [157.82.206.10] ([157.82.206.10])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a170902820600b001c99b3a1e45sm5823212pln.84.2023.10.10.23.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 23:43:51 -0700 (PDT)
Message-ID: <e0f860d5-a6e9-43e6-b8f1-0395bac0c90f@daynix.com>
Date: Wed, 11 Oct 2023 15:43:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] tap: Fix virtio-net header buffer size
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
 <20231010025924.14593-2-akihiko.odaki@daynix.com>
 <b80debfa-b789-400b-bc0c-a0ccc77a3530@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b80debfa-b789-400b-bc0c-a0ccc77a3530@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2023/10/10 16:56, Michael Tokarev wrote:
> 10.10.2023 05:59, Akihiko Odaki wrote:
>> The largest possible virtio-net header is struct virtio_net_hdr_v1_hash.
>>
>> Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   net/tap.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index c6639d9f20..ea46feeaa8 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, 
>> const struct iovec *iov,
>>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>       const struct iovec *iovp = iov;
>>       struct iovec iov_copy[iovcnt + 1];
>> -    struct virtio_net_hdr_mrg_rxbuf hdr = { };
>> +    struct virtio_net_hdr_v1_hash hdr = { };
> 
> BTW, can we get rid of (implicit) memzero() here and in
> similar places, initializing only the actually used fields?
> Not that his particular structure is very large (and this
> change makes it 8 bytes larger), but still..

These variables are rarely used so I think it's fine. In particular, 
these variables are used only when QEMU sends an ARP packet while 
virtio-net is enabled.

Regards,
Akihiko Odaki

