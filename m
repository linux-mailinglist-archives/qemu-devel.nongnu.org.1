Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C22087A2406
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhC6S-0005Nv-Hz; Fri, 15 Sep 2023 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhC6I-0005Hw-QZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:55:26 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhC6G-00079X-Sl
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:55:26 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so2844391a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796923; x=1695401723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0ufrpg8mAs38ReSqS2EFGPYJBUHuNakkkgpSxwIp0s=;
 b=nIvHZP04cWJWo2ZShBkI7BVcCzie4I+IUPuqLCpYDJ9wBpcYNjAMxMYKDnPEy6WHsh
 7y4aYyfFjH916FDKI446xM+g/VR/kVstey1zXgvdahQFIoS/NLKVLCXLP79sb0yc5OMs
 fMX4QuP2tkzGJQY0pWWG3pjndSrIiDGOzFc3B3rHZFbLUlXbIZK1hHwvlo2rxyX9M2e0
 GlDkUnpErwwmAkT+WBYdt4+hNHZ66PP+4u8VpWBeqLNlOfzMWnf4AU+mPl0CoFsuDEYz
 7QiieYSK2KIiEcSpnRKdalbnPd7/Blv4Rej0tbLZV9RoAH0nsJwDSMqcosRnizsxdbgo
 inRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796923; x=1695401723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0ufrpg8mAs38ReSqS2EFGPYJBUHuNakkkgpSxwIp0s=;
 b=a0SyKYI+5y5jkGMIuTYRRRcdejZykFRIRC7QCHIpELhRY1azn8EBl3iq2pzv7NwGqA
 hnPQ47QMcBgevygl0mbbmAfZ9iSN4XQSwqLHD6Z1Cm4DKGojm303dkEo7TZv9CyfMAW9
 upWjYg5WIxL4/lTYw/YWH5ltgmCw3ywzK0aNOcJBleDCpNhA6XZsX8jbzX1LV1rn13hv
 oUwrixIt6xosTcQi/Cpjrpv2/IlnYS3ATi9SjX0deb6pjI5xAmgBc278ryUIqB15HM8X
 BugrUHE0wDmA8rFvm1XuRTf9MhWuHlJQS39mrtzU2040/lfbuOFKkAePrNW1BltoT/Xg
 Ixhw==
X-Gm-Message-State: AOJu0YzPRhICn6E6YHmBA4N5Temp9WRGi6Ld1H4SJifmOb/jULbJz29q
 LQUhVsQoVmIHmAXGlPpuUdlr9w==
X-Google-Smtp-Source: AGHT+IFIdP8e19jP6d+Xtr4XdMV5RtPQX/z+Gx27xtfyKHUHAMoN7uap0l1CSRBTynpQ7En9Xffa9w==
X-Received: by 2002:aa7:c649:0:b0:523:3f45:5678 with SMTP id
 z9-20020aa7c649000000b005233f455678mr2125275edr.31.1694796922707; 
 Fri, 15 Sep 2023 09:55:22 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 i23-20020aa7dd17000000b0052544bca116sm2498518edv.13.2023.09.15.09.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:55:22 -0700 (PDT)
Message-ID: <bc786411-2802-4e77-54de-a406f2b0c909@linaro.org>
Date: Fri, 15 Sep 2023 18:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] accel/tcg: Alternate fix for #1866
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230915163254.123338-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915163254.123338-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 18:32, Richard Henderson wrote:
> Supercedes: 20230914174436.1597356-1-richard.henderson@linaro.org
> ("[PATCH 0/6] accel/tcg: Always require can_do_io (#1866)")

Patches 1-4 (5?) are cleanups although, isn't it?

> An alternate fix for #1866 without touching can_do_io, and is
> perhaps a bit cleaner and clearer.
> 
> Instead, the current cpu checks whether an address space update
> is required on each entry to the slow path.  This certainly
> catches all i/o.  It easily works for the sequential case of
> two i/o, the first of which changes the address space and the
> second of which requires the new address space.
> 
> I've done a tiny bit of performance testing between the two
> solutions and it seems to be a wash.  So now it's simply a
> matter of cleanliness.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>    softmmu: Use cpu->created in tcg_commit
>    softmmu: Introduce AddressSpaceDispatch generation numbers
>    softmmu: Introduce cpu_address_space_sync
> 
>   include/exec/memory.h |  6 ++++++
>   accel/tcg/cputlb.c    |  2 ++
>   softmmu/physmem.c     | 46 ++++++++++++++++++++++++++++++++++++-------
>   3 files changed, 47 insertions(+), 7 deletions(-)
> 


