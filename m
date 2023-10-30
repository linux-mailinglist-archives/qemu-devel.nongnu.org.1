Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719B7DB279
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:17:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJha-00012V-Br; Mon, 30 Oct 2023 00:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxJhU-00012F-S7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:16:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxJhT-0006nw-5m
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:16:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c77449a6daso34493745ad.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698639385; x=1699244185;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSwo3xUWVOMnUGi/WSyGqFMK1YEvx8fq30WrVLb1o/o=;
 b=lpC5ltgQcInnK0iMy7+xPD82HwNZcz5w5BqSkxbv+hewb0ac4j+lNBpJpRCnqlQ9Ie
 bGiVXwqvtL10qSuHqXnfz9z7y6ubbdZuq59YQrYBE19yWHvoqV7spL3lnEgbUZ4T//ny
 n5RoEaeOy9L4PqOJt4Ngc0/j/8w6bcfaf3ZLkH3pR+6t17OpKPtYIDsAvzsgGu071yXF
 EvLAvmxZV6ZA1yGez2Vsj4CXLqroZZ6uaoeLkNDfhRN0yrocJLs7YTYYDS9gD5gjWUka
 Y33AVV4YZtCpCGU8pacY0P6HF3dIMmqY5IqQJn8uUV0r50OxIw74D0Z7Jm+Kc/tWdAeW
 RVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698639385; x=1699244185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lSwo3xUWVOMnUGi/WSyGqFMK1YEvx8fq30WrVLb1o/o=;
 b=soZCSBXzEC8TVh0jKFO1zFzskPs4rawm6LavYpb8hxLkIjMzMWUSDADF6fOC/ky6W8
 r9kX2xChS1E6mN/MTYcoW2Wxwq9uQcEVGR0o0s6EO1AiWglh+TNEl+aQ6amruinn7aLW
 4uoxbkWd+tfW92eyPnQl7RTMGROIYla9NXpDTfAPD/HHvOAXD1XMvvRaCcnzsTR7XP9n
 P+LwarBKtdxQWJhYLxUeVZbxHByp3xCelD2fCnsLcd0Vq4Y0lqHe4/gv5UeJSjKm79dg
 FyYb7LXOGlM7vXBFWhImIeSK4+UMQ/oMN2pvh2yAZbqKplT9yEqk4hG8AoTcz74K8rA+
 XA1w==
X-Gm-Message-State: AOJu0YyIPWzSFo94zRVayB1jgH2o3R+kEba0gdwYipfqCs5Io0TyRQ3X
 +0LLCx00CNZqsfhYZ99l6kSjchVkh8Bq9Hy++GlqYw==
X-Google-Smtp-Source: AGHT+IE5wOVAJqj+m/KMX7A63VlAtKdXu7wWBQG6JrfkWuTxm/zK9Ajr38sCkSV3wAsDQROk8xofeA==
X-Received: by 2002:a17:903:1c7:b0:1c9:bf02:6638 with SMTP id
 e7-20020a17090301c700b001c9bf026638mr10060384plh.51.1698639385095; 
 Sun, 29 Oct 2023 21:16:25 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 ja17-20020a170902efd100b001c3f7fd1ef7sm3324031plb.12.2023.10.29.21.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 21:16:24 -0700 (PDT)
Message-ID: <b4c24738-e502-4e69-8d6d-1a3ef6a1614b@daynix.com>
Date: Mon, 30 Oct 2023 13:16:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] net: Remove receive_raw()
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-5-akihiko.odaki@daynix.com>
 <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
 <ef82309f-ca89-4850-acf6-94ffa7726c2f@daynix.com>
 <9204e711-0eb9-01da-54dd-c67ae9e05c3b@redhat.com>
 <13dc8043-cf30-4fe7-9e1d-1c69f4e26b1a@daynix.com>
 <CACGkMEsYTMuS+okKi7-e-F_JDqB2P3BEO6DLJSBc_eS1TaXe0A@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsYTMuS+okKi7-e-F_JDqB2P3BEO6DLJSBc_eS1TaXe0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2023/10/30 13:08, Jason Wang wrote:
> On Mon, Oct 30, 2023 at 12:03 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/30 12:06, Jason Wang wrote:
>>>
>>> 在 2023/10/27 15:52, Akihiko Odaki 写道:
>>>> On 2023/10/27 15:49, Jason Wang wrote:
>>>>> On Tue, Oct 17, 2023 at 12:09 PM Akihiko Odaki
>>>>> <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> While netmap implements virtio-net header, it does not implement
>>>>>> receive_raw().
>>>>>
>>>>> The only user for raw is the announcing. Netmap probably doesn't it
>>>>> at all.
>>>>
>>>> In my understanding, the announcing *sends* a raw packet.
>>>
>>>
>>> It's send via NIC and receive by its peer which is the TAP
>>>
>>> qemu_send_packet_raw() -> nc -> nc->peer -> peer->receive_raw()?
>>>
>>> Anything I miss?
>>
>> The problem is that the peer can be netmap and netmap also requires a
>> virtio-net header.
> 
> Right, but I don't know whether netmap can migrate.

Thinking of the condition that announcement can happen, I'm not aware 
anything that prevents migration with netamp. It also is apparently 
possible to make an announcement with HMP/QMP.
In any case, I think it's better to fix qemu_send_packet_raw() for 
netmap to prevent potential breakage especially if it costs nothing 
(actually it saves some code).

Regards,
Akihiko Odaki

