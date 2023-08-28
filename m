Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AB078BB1F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakxc-0003hu-Lk; Mon, 28 Aug 2023 18:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakxa-0003hg-Td
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:43:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakxX-0001Dw-Fd
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:43:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso3082987f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693262625; x=1693867425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZRzXnLTRqN+NAoFSdgE2RqfPIcu18B7VBfCAs46eww=;
 b=vKaHEoB/I/WDoQEz5zNNnkbrl804LBwDXx4lF9APsqwUXCowOf3zuslob0G7emNhQS
 c7FvZHjKxWiSeyajHZUsh9PAebi7BwYRduFgmrLwNTYcQi79sDHDkvlVHNpJPCLmRJ/a
 jbxo0K9c5u5i4vw9PDwEmMk2p5ttHexo5bI+WPfI/H/IScp0p91faVAhRZINzsjMqTjJ
 Or1xKgUeRFlSQo/kUvxfJnYIthx1ctlqdsbuGibqfvjg9f4j53UCxFD1eNkMOHpkKJUb
 kHifz5LC2vVdF1wU2HjM+0ed5lEilDsG8gPcngcaE6A7G74E3AuyEorhshgZPam+26vb
 GNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262625; x=1693867425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZRzXnLTRqN+NAoFSdgE2RqfPIcu18B7VBfCAs46eww=;
 b=L0xO/t3zz/Joo5N1BoEZJgUaaJ0CQil3FfsPLl4OoL2xwhXAUoH7Q+WabeGY6NXW+c
 eg7NfWVQyNp3xWapnCT1+DRaNVMzhD17qexbpoRLJ4SY0zv/37K3lXjLZJ6N8whBAkI7
 TAAjF1MRDa8H/QmUk0kYd5UPl5RNyVYmwu1B9MYH6Zz8N+GM+j+JT+yb8uQJ3csYBe3I
 XXhOMLm1gAssdvy90bFgjuQIjba5jcPtycDfEuP6ymUkCj8oL3TMnx3CBUoePAsf7Nra
 jmRGv5UU+yMuRanLwSsLhA9C2q5cEqKruuUV8yUbe5CzRssyu2R0u2nEd1s1AlEP/tbN
 NCMg==
X-Gm-Message-State: AOJu0Yzxu0O7ihQqlF+mcSDbTFlLFJJuccgdeDgLZ7tV4IJaboG3Jxzr
 FVmkEJcvv5gctGKX99qnx83Ozw==
X-Google-Smtp-Source: AGHT+IEcB9ejLEN+i2kjgdIcf4x84n+ATGTzcwGQJD7X+LB/AsKZ0ASEFUjsmSgESasn5iXXImVX9Q==
X-Received: by 2002:a5d:62cf:0:b0:319:79a9:4d9e with SMTP id
 o15-20020a5d62cf000000b0031979a94d9emr19473948wrv.44.1693262625241; 
 Mon, 28 Aug 2023 15:43:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d6107000000b0031c4d4be245sm11720033wrt.93.2023.08.28.15.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 15:43:44 -0700 (PDT)
Message-ID: <2d3fe007-c8d3-b6dd-a4a7-7f85daaa259b@linaro.org>
Date: Tue, 29 Aug 2023 00:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 15/16] memory,vhost: Allow for marking memory device
 memory regions unmergeable
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230825132149.366064-1-david@redhat.com>
 <20230825132149.366064-16-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230825132149.366064-16-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 25/8/23 15:21, David Hildenbrand wrote:
> Let's allow for marking memory regions unmergeable, to teach
> flatview code and vhost to not merge adjacent aliases to the same memory
> region into a larger memory section; instead, we want separate aliases to
> stay separate such that we can atomically map/unmap aliases without
> affecting other aliases.
> 
> This is desired for virtio-mem mapping device memory located on a RAM
> memory region via multiple aliases into a memory region container,
> resulting in separate memslots that can get (un)mapped atomically.
> 
> As an example with virtio-mem, the layout would look something like this:
>    [...]
>    0000000240000000-00000020bfffffff (prio 0, i/o): device-memory
>      0000000240000000-000000043fffffff (prio 0, i/o): virtio-mem
>        0000000240000000-000000027fffffff (prio 0, ram): alias memslot-0 @mem2 0000000000000000-000000003fffffff
>        0000000280000000-00000002bfffffff (prio 0, ram): alias memslot-1 @mem2 0000000040000000-000000007fffffff
>        00000002c0000000-00000002ffffffff (prio 0, ram): alias memslot-2 @mem2 0000000080000000-00000000bfffffff
>    [...]
> 
> Without unmergable memory regions, all three memslots would get merged into
> a single memory section. For example, when mapping another alias (e.g.,
> virtio-mem-memslot-3) or when unmapping any of the mapped aliases,
> memory listeners will first get notified about the removal of the big
> memory section to then get notified about re-adding of the new
> (differently merged) memory section(s).
> 
> In an ideal world, memory listeners would be able to deal with that
> atomically, like KVM nowadays does. However, (a) supporting this for other
> memory listeners (vhost-user, vfio) is fairly hard: temporary removal
> can result in all kinds of issues on concurrent access to guest memory;
> and (b) this handling is undesired, because temporarily removing+readding
> can consume quite some time on bigger memslots and is not efficient
> (e.g., vfio unpinning and repinning pages ...).
> 
> Let's allow for marking a memory region unmergeable, such that we
> can atomically (un)map aliases to the same memory region, similar to
> (un)mapping individual DIMMs.
> 
> Similarly, teach vhost code to not redo what flatview core stopped doing:
> don't merge such sections. Merging in vhost code is really only relevant
> for handling random holes in boot memory where; without this merging,
> the vhost-user backend wouldn't be able to mmap() some boot memory
> backed on hugetlb.
> 
> We'll use this for virtio-mem next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/vhost.c     |  4 ++--
>   include/exec/memory.h | 22 ++++++++++++++++++++++
>   softmmu/memory.c      | 31 +++++++++++++++++++++++++------
>   3 files changed, 49 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



