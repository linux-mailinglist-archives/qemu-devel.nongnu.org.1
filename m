Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CECE791332
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:20:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4oC-0007yp-8B; Mon, 04 Sep 2023 04:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4np-0007wr-1c
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:19:22 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4nl-0000WZ-Qm
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:19:19 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so167822466b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693815555; x=1694420355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0UexumYOWShk0V2gIT0GLNPhlxt4L6EPj0IqfdS0vk=;
 b=uH91MWQj1bK4jkFfjAylVLJU88ZL7skQAT2lMo6Vnlnu80Sgn4AWJYh3FyYQwqCCoU
 hyw8QWY3bRczrCj1uDLix03K3BAdBgpu5kHu3Ye2QJRgbtGykITOyY+SWPbVzlwSqXrB
 6dmZfZuaYv9rO1y2QxEN7yylmSaFEoPaY/bvh83RaCv1UAkCS5MyjK3CFUDouBFMfE8b
 zB1KpQp/RgcrOYXwjkCcFTq0uFR8QR1aOk0MLSZkPmaZL3cedBuAFRSteyd28GLpzx6y
 IvpJxtjgIZEVYkMqbuJ8CRCu62WQbavAGDQj+HfosoPviyQNahC4ZwnPLLy7pIN5Kxbr
 1GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815555; x=1694420355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0UexumYOWShk0V2gIT0GLNPhlxt4L6EPj0IqfdS0vk=;
 b=egok3J3lfj/aKeroQAfbe4zNgfWV9bnGydoaez5mWHGG5rCA1fLEE1nrpiVcmnpfXQ
 YnS8oM2XKYaOi42dGcWinrX/QR3priPBVGkkk22Z2vilvyZwF0GxZE0LYeKUEi+qj4Qw
 Pah+1P+1p3Uz7sM9iCplxUs+L/3lfJIz5HubbUMW6cPOdqSMR4erS2KSFS53WnimEuMI
 N8IL5qUZQlYwMiXTof9+atmJXiVIW4PaIlsPPZUsSOyG/9n6R3gMKEgIa6j6XwgYS03o
 lUQBQZ99xFGgMndBjDxHCXCkXT0YPzRs+A3xZnNM6wTwtJNi+KljzDwC9fIE5/veEN6f
 Uv6g==
X-Gm-Message-State: AOJu0YyH7wWmA+UlCNnnP8myYjvrUG0vU+cJpg/mP8bQCkL34CS8sgDN
 mM38wxjpHM/7+AbicHDhh+zLxQ==
X-Google-Smtp-Source: AGHT+IH9rGhCqhnsUpoZQ6/hb0WMVq1vuNRjUnaRKXgaVK4uVT9NWJBJerTDgUloVowi3uq/09eZWQ==
X-Received: by 2002:a17:906:209c:b0:9a6:1811:e4eb with SMTP id
 28-20020a170906209c00b009a61811e4ebmr6421940ejq.38.1693815554771; 
 Mon, 04 Sep 2023 01:19:14 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 rp24-20020a170906d97800b009a5c98fd82asm5734092ejb.81.2023.09.04.01.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:19:14 -0700 (PDT)
Message-ID: <dd39c9d7-f829-196b-1185-e6af96600fa3@linaro.org>
Date: Mon, 4 Sep 2023 10:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 08/13] range: Make range_compare() public
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-9-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904080451.424731-9-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/23 10:03, Eric Auger wrote:
> Let's expose range_compare() in the header so that it can be
> reused outside of util/range.c
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/qemu/range.h | 6 ++++++
>   util/range.c         | 6 +-----
>   2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


