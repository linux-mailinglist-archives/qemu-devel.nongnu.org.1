Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13B72E1AF
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:31:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90bU-0006Xj-CA; Tue, 13 Jun 2023 05:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90bO-0006XV-Gj
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:46:14 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90bD-0006t1-F9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:46:13 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5187aea68d6so8423a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649559; x=1689241559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YZRWsuqIDLG8YMDaGNQ84deINGg3AWJhx3IXmFBx8Xg=;
 b=zlZfA2StjtY4jaTwYGUtG1w25jwCegih/lItEi+KOqLmtJvABeuYvfmfhuutTHYP9b
 mueYzmxBI4oYLc9748e0WjsS5F21AAebO9IFd3po+bSNjeuZ8pv4R8xA2OVGalCzBsAp
 IKvdYOv3q6renIPLucE6I6KtsYax/6jjW+imKfAMrkVX9jDPJFlMAlqKLdf5CDdq2KYx
 5KlbOI6F+RA1wYybcgczZ0s0GKtc00cB4cOnt14Cji3IeaqAHXC4AMFL2WvPAvaAB7mq
 UKhEggCglA5VOKKsSsVJLqrdguBV29HBrO+ZnbttnJKgsANkDQtxOlq5rHzUBEjkrV9B
 ffvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649559; x=1689241559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZRWsuqIDLG8YMDaGNQ84deINGg3AWJhx3IXmFBx8Xg=;
 b=ew1RVMHogyAalVcMUwdWgA7Krk4cyt9TngOFurekYt+KPNqs5w8dQC3fF0/nrMANS2
 1K9gioqoBquwMyefGy4FwW0EmtJI8PnoLqXacGeauCapo2GFky4ExYYO5AyPcKilu202
 OZnnp1I4PlayXQLyltMpJUaFsjcjvNIYQAj4Wz9vIh09zAfRT7rA+ZGYDqkk/219JNRg
 SCeVcXEhAJUhq93CtInPYrDo9NDSvbpN/TWRcjTvxoaNGYoJ8osdPZ6A/YUAYpvXwSWV
 WnkemJVt1p3q5MnN0Npf5fUpHOBkcVHq1i33rSp3Mjx4TVPu8rTljrlStHciv9D1yDBK
 +dsw==
X-Gm-Message-State: AC+VfDxnhNkRy9IYRaGnrYsTWhXD6F18ywlTL2fl2bz2Ta6wOOlCmN0P
 5IJ2D1Q+Py3Cc/Hly2uDJ7tNAw==
X-Google-Smtp-Source: ACHHUZ44u9Wh6l+7Vgoh/fExHfSrEp5sVrJfxBbACi/36h+kLKYi9Oslffc1a06X8sULqtRYP61oFA==
X-Received: by 2002:a17:906:dc93:b0:978:acec:36b2 with SMTP id
 cs19-20020a170906dc9300b00978acec36b2mr12823469ejc.41.1686649559007; 
 Tue, 13 Jun 2023 02:45:59 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a170906358700b00969cbd5718asm6325646ejb.48.2023.06.13.02.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:45:58 -0700 (PDT)
Message-ID: <146d1bf0-5b05-7fe2-5379-1031353c8eaf@linaro.org>
Date: Tue, 13 Jun 2023 11:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Avihai Horon <avihaih@nvidia.com>
References: <20230530180556.24441-1-joao.m.martins@oracle.com>
 <a043b593-c576-5dd2-8ac7-63ecad5533af@linaro.org>
 <79b5565b-1d44-f6e5-6c55-66ff403353b6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <79b5565b-1d44-f6e5-6c55-66ff403353b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/6/23 11:37, Cédric Le Goater wrote:
> On 6/13/23 11:34, Philippe Mathieu-Daudé wrote:
>> On 30/5/23 20:05, Joao Martins wrote:
>>
>>> Joao Martins (2):
>>>    exec/ram_addr: return number of dirty pages in
>>>      cpu_physical_memory_set_dirty_lebitmap()
>>>    hw/vfio: Add number of dirty pages to vfio_get_dirty_bitmap 
>>> tracepoint
>>
>> Queued, thanks.
>>
> 
> I had taken it into my vfio-next branch. As you wish.

Oh I just sent my PR :/ I can drop them if the PR fails.
I didn't understood Alex ack'ing the series meant you'd
take the series (I try to look for exec/memory patches).

