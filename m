Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8098718357
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MCw-0003sW-0Q; Wed, 31 May 2023 09:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MCt-0003s1-Cd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:49:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MCr-0001Oi-WF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:49:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so5750383f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540980; x=1688132980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+5gtDnsFB7NOqVP3uWQ/ZOhQw8MUEOPL5moup0kzXq8=;
 b=b1ZVxneMBjMVct7lHxqF9S74QZ5UVIlIKkhUz82nVnp23oY80ytDCrLpy+Cg2f5Bd9
 oSbPwlnYlk+Ue5M+QR7tLjZUmFl/fz2/V9+bbVY4o/imedQR2wpsgCfYm7xNXVJaKn6L
 JzzBwllYk3WWWdLMClfXriyOuGSbu14Z52pX5/ecnLTVVUBewVERUsgCwFQjPByg3fYI
 Xg5XC11drflfWEbpdDbOKdyXmy5Qi42VtsBvJutaQjrX+OKQY9s2sk6NL0+kCfQ8tFZT
 SeVyQjX6ilAIBlgIQDsrtPkvCLrd868vBUuEf1ACi3agnzqfGJdpGXOz6wNQQwVV5fdS
 44dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540980; x=1688132980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5gtDnsFB7NOqVP3uWQ/ZOhQw8MUEOPL5moup0kzXq8=;
 b=bXzF+62uts8O+f7GRKtyHjJb65KFJj2MvzZ8eihQd0rJdos4R3fVnLuXuNl4Ow1Fvd
 u5Q31PW+ixdX8k+zFIRM+m9dMwCD9vK/BsKGty/oSX2NT+uTAJt5PB73R5jeeygJ/wJO
 Dub4GJYrixN0AZRWw5hIvwxOPn2RbqWwIEWFoyfBRSDYONqx3CnvQ05OjCkb9kxI7A1z
 3ij0ozcnRyZJYai+HCKd9t4IQvZOq/jiR83RfkMjarbO9IV/oY76gDUvLlr9LC365b8x
 iBkpUb+UlI8BCiw6/Rwq5dnBJukbXICBoIbP2i8yFTo9yeJFHBFHc3HuURxgnStzvhUH
 aXHg==
X-Gm-Message-State: AC+VfDxGkkOmP+nfBCcSsQKXjK+US+vXIKm2zFZPGu4aeeAZsa78Y8y/
 NvS74IBJ00YGquhLd9XPxlSeqQ==
X-Google-Smtp-Source: ACHHUZ4CrM+7b5UN8usNFbjvo0CHFH2ZznQX7/PxqaZPYVXuVOo7FcGQERrzVKkQuvP8gV59nRtiow==
X-Received: by 2002:a5d:510b:0:b0:30a:e589:689a with SMTP id
 s11-20020a5d510b000000b0030ae589689amr4247703wrt.18.1685540980573; 
 Wed, 31 May 2023 06:49:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003f6f6a6e769sm14555626wmc.17.2023.05.31.06.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:49:40 -0700 (PDT)
Message-ID: <e6af7ec6-3975-8c94-b506-0f7957f15a16@linaro.org>
Date: Wed, 31 May 2023 15:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/23] q800: move dp8393x device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-15-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the dp8393x device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> ---
>   hw/m68k/q800.c         | 6 ++++--
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


