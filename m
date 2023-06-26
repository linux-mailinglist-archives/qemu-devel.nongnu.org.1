Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B763773D8BF
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgvA-0008Sj-LP; Mon, 26 Jun 2023 03:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qDgug-0008QE-J8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qDgub-0001tq-0q
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687765522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9f5v7MfXUgmJJxiLeQFkqHqneWRAAj0HrQQkEsmFD4=;
 b=XFaPMVasAQkxIDdjXYQeb4cYiwh6l2VveI/JtFs9N8VSiFlk91D+qlRjO6DOI0j0SxXW9p
 15jmBigaLiPtAKi2/3unIyt3gG14e900Fogvw/zvGmchdAzUoR95UwZYTc03/4fEtVS/Fj
 D6ZlECmG1qncxQR1Bl6cj0bI6boKOjs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-BgPwWpBqNnCM7HFuZM2ghA-1; Mon, 26 Jun 2023 03:45:20 -0400
X-MC-Unique: BgPwWpBqNnCM7HFuZM2ghA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb76659d44so411159e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687765519; x=1690357519;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9f5v7MfXUgmJJxiLeQFkqHqneWRAAj0HrQQkEsmFD4=;
 b=SGlwY+vExZYUZ+rH0L5A7m6ncw7RbRFYG/RGkqMsWJhhH1pcL+F65kSSaA6tBlpQH8
 Ow0WuLfLOYYt7uJXfKcdwvX2fCCCGmQa1XugIxZSU2xirJkZeTw15W5+HZ76DhE/+JyW
 IW7BMq/Y3CRy62zLsrkL9sXxNFtviMJUj3xamTd20F2J1wa/1F3RnVccUvPzz3lHr99k
 ZYWJkbELuDxZoUL/ugdwvr7/pMzDnYOaoxMBLZxvxnKibwbuvbaHvm87O0InTmJayZ6/
 PLZQJfDe9XC5aUNF684pgt3UhHalBe38NPTR7r/EEyOkhhNgBod7E4vvMBWV3/65rYgd
 hKWw==
X-Gm-Message-State: AC+VfDy8/Yl40avEqz0fv74qGMmvlmoFdt4OtlWM7DftQajYPaElU/bh
 gNQ4w+Qr9x5oV6Kkgfo4MNfLxW8HMxOG45bS+vqA8u+BdoJKs09E1jQJuS6FTw8cgg0uIoEga/7
 d8dq5Wc50BVI0uxk=
X-Received: by 2002:ac2:4bcf:0:b0:4f9:644c:1ec5 with SMTP id
 o15-20020ac24bcf000000b004f9644c1ec5mr7173986lfq.36.1687765519215; 
 Mon, 26 Jun 2023 00:45:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QXiiLfCk16Utn3COsWOD2U3LgOzlvD068xFlujMX7Hjcj7M1HwZ0LlsOZhHfoipcPkSdiAg==
X-Received: by 2002:ac2:4bcf:0:b0:4f9:644c:1ec5 with SMTP id
 o15-20020ac24bcf000000b004f9644c1ec5mr7173972lfq.36.1687765518876; 
 Mon, 26 Jun 2023 00:45:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498?
 (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de.
 [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adfe303000000b0030fd03e3d25sm6524572wrj.75.2023.06.26.00.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:45:18 -0700 (PDT)
Message-ID: <6a701609-e041-787d-d9c9-3d85ef2a8bb3@redhat.com>
Date: Mon, 26 Jun 2023 09:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] virtio-mem: Simplify bitmap handling and
 virtio_mem_set_block_state()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>
References: <20230523183036.517957-1-david@redhat.com>
 <39b97e00-fb3c-29b2-aa1f-1de4c8094899@redhat.com>
 <20230625170601-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230625170601-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25.06.23 23:06, Michael S. Tsirkin wrote:
> On Fri, Jun 23, 2023 at 02:51:11PM +0200, David Hildenbrand wrote:
>> On 23.05.23 20:30, David Hildenbrand wrote:
>>> Let's separate plug and unplug handling to prepare for future changes
>>> and make the code a bit easier to read -- working on block states
>>> (plugged/unplugged) instead of on a bitmap.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Gavin Shan <gshan@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>
>> I queued this to
>>
>> https://github.com/davidhildenbrand/qemu.git mem-next
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
> 
> oh I queued this too.
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Good, I'll wait for your next pull request. If it's included there, 
perfect :)

-- 
Cheers,

David / dhildenb


