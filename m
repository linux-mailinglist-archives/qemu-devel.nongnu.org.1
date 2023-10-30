Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539EE7DB23B
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:19:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxInt-0006J6-GT; Sun, 29 Oct 2023 23:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxIni-0006Ei-PV
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:18:52 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxIng-0006CI-6N
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:18:50 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso55270591fa.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698635926; x=1699240726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXdjaUTyztNJnuqJ51DB8PqlITILxnd7HmwWp4+4IL0=;
 b=WfaKEtHxjL76cpyfFBNVOk8VEBvWaoXF0guREoR/uoQ1uykIMGZvIzdYJPS3OZeyGN
 rn7p+U1UMxLe2cGFbUFBK/rB/BGaVtJQwSAZEz6vCTUKTzPN1CLPguWhWiZVlIhQ1BOf
 oZO+ExPLXC2e6Mv9uOWalVO2n5QNiHdSQarM7OfxiyNGBlOrR54si/MBrrIfpBThruji
 3Y5AOapMn4vvkClt7cyptnFr37W+AdNdgI5gqgtv/gmHcZ8jaUSjtIITg14KxhSTQRM9
 v1BWlcfGucjMki/i8r7U5JPEP4GbaHpntcr0jU3iUVdU3w9IxKH2GlPVCe6CLXiyPaHr
 ttdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698635926; x=1699240726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXdjaUTyztNJnuqJ51DB8PqlITILxnd7HmwWp4+4IL0=;
 b=QJwZYS3xpgOC5r319xzbJ/i2FiD/nlLh8LHzyqAYk8qwENKPyoYwL1iKBykGQP4p3o
 t0pQjzgkO08AGXhvXJV9sWUiEuNVkvTlny3DgXWJr8uODS8Xq2KDoPRcolut3+YsUtl3
 hKnvMQiJtjElDB/d41NXWeB6Yr1Ppj5P5NZTnbTRkAKAQZofsmNfJK6qxZ/Q5D1a8ELL
 /P3we26LRIvYF34/3/hF2zL2hmP850uJj3jfy8OX2DgXKifZwKj9o0Xrt07r68GeXDMJ
 MED6KJqzhEvSKJtQ3K6HkBYdBRLMbvHtpEhXabEDNKaoobEMY3HiROMFlBkAAlc8syF+
 hhBw==
X-Gm-Message-State: AOJu0YwFDwyVwjXMV00+LpImdgZcOjdJJDnq8oBV2rr+/6XUinHJXN+I
 P6MNtrLhOd6/wDcuCFZt8tUdesZpJ5yJQ5E35Fg=
X-Google-Smtp-Source: AGHT+IHUytrSL5DZ682plzKar3Cz4BiBFAvn9A5Mx4wsuFYCOEmdo+iWr1NPi6P//uO0GiIgVWOXUQ==
X-Received: by 2002:a2e:a9a7:0:b0:2bc:db70:b563 with SMTP id
 x39-20020a2ea9a7000000b002bcdb70b563mr7667009ljq.32.1698635926035; 
 Sun, 29 Oct 2023 20:18:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a05600c4f4100b004063d8b43e7sm11584532wmq.48.2023.10.29.20.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:18:45 -0700 (PDT)
Message-ID: <5f764920-b707-98ca-e58a-1c1726145685@linaro.org>
Date: Mon, 30 Oct 2023 04:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6] hw/misc/imx7_snvs: Trace MMIO access
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028122415.14869-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

On 28/10/23 14:24, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/misc/imx7_snvs.c  | 5 +++++
>   hw/misc/trace-events | 4 ++++
>   2 files changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


