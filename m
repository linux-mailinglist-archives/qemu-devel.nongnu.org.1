Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C954756723
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 17:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPlL-0000NQ-3M; Mon, 17 Jul 2023 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLPlI-0000Mj-59
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:03:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLPlD-0005Xp-9q
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:03:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso42052985e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689606217; x=1692198217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OdyJdU1A050O0D+ULAwGSIK/rq+WDNYHj7qnr0GVztw=;
 b=zHyNV16wZRdRP2rmygS7sodYfX56j9AwV7PnonQL9sHGC8Xpgh6xKnnsbG0f7ae2Dw
 hJ+d5QADkHPwXnqRc62a8CFLrTJeadaDuboAgS5mB9iRnzRw5uFQWh23dnJKVHipwaRi
 PHlRyKMcSIjRiTnOe4iyxjpAHFe6ZgEU7Hv+0+SAHFNjRqd44yRogp3BS7nn778g0h2q
 iIhxWaqFT6ULzbF43XLE6eC+23g2IyEh35bH4bNPaA22vM4b2l9+THwmQ4Hoj7f8XDYB
 LG+oAoJuKlcLls1LiKlHzcS/q3DKwNWjW3RZV7F0A2Jdn2Tv1Gla7WLhG0cbGf9VtBAr
 nhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689606217; x=1692198217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OdyJdU1A050O0D+ULAwGSIK/rq+WDNYHj7qnr0GVztw=;
 b=fs8hUETkBsmHkTbnYU4jAFk0iMihSgB7hC69ax3m1bovLTk4CyJtADLEviabeAgrqi
 4ORzTqXVunzwzGv2KQytLURzXPB2NP+nUwMUc0bGKTDVqSJleAmYgwbeDl7OOUc0dhLj
 NI08ywWLvGIxNRxosWcXGt65NhF7+p8czxqq2BCis4fQVFUob/YS7tDPv4+WF+lrsRDu
 yUcmUP8g3EVs/SqqsBN27dCvQcD+k50z4gZJRWbD6Y01yeINSyedwmjdkYXgMpcg0f1i
 xo0wmHhtEQSKqIoPvpA0plI9kbd1bN2yodUu69Lafc9zAmStmmMrrqoOSRZqvci4+U50
 a4nA==
X-Gm-Message-State: ABy/qLYIT51ONauTUwzTB9xNdHpLyUaPEO2dlkOfJUBQN56vDPHHUUQf
 ewVNTKpa6ACHRbM9HLxCpl625A==
X-Google-Smtp-Source: APBJJlHJaJH76Oj/PUxXU8E/q7vqx6infdKDfZ63//y6q5zQQipbRsFbW6Q2elD6g2uJWa6DNCZ9zA==
X-Received: by 2002:a1c:730c:0:b0:3f7:f884:7be3 with SMTP id
 d12-20020a1c730c000000b003f7f8847be3mr9983194wmb.4.1689606216886; 
 Mon, 17 Jul 2023 08:03:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a1ced06000000b003fbacc853ccsm11283wmh.18.2023.07.17.08.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 08:03:36 -0700 (PDT)
Message-ID: <619ce0d3-2e2f-83ad-f1c3-666c3d0ac262@linaro.org>
Date: Mon, 17 Jul 2023 17:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] hw/arm/smmu: Handle big-endian hosts correctly
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>
References: <20230717132641.764660-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717132641.764660-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 17/7/23 15:26, Peter Maydell wrote:
> The implementation of the SMMUv3 has multiple places where it reads a
> data structure from the guest and directly operates on it without
> doing a guest-to-host endianness conversion.  Since all SMMU data
> structures are little-endian, this means that the SMMU doesn't work
> on a big-endian host.  In particular, this causes the Avocado test
>    machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
> to fail on an s390x host.
> 
> Add appropriate byte-swapping on reads and writes of guest in-memory
> data structures so that the device works correctly on big-endian
> hosts.
> 
> As part of this we constrain queue_read() to operate only on Cmd
> structs and queue_write() on Evt structs, because in practice these
> are the only data structures the two functions are used with, and we
> need to know what the data structure is to be able to byte-swap its
> parts correctly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/arm/smmu-common.c |  3 +--
>   hw/arm/smmuv3.c      | 39 +++++++++++++++++++++++++++++++--------
>   2 files changed, 32 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


