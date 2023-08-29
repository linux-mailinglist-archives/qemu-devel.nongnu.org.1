Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39D78D0A1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:30:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mt-0000hX-Bu; Tue, 29 Aug 2023 19:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5N7-0005Ew-Ab
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:31:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5N4-000508-AA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:31:33 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so1512485ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341088; x=1693945888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3aTEaFs7K9UOaQDulqexuk1KLWMtv6kkvzqJvJJKEEI=;
 b=dX+UIPKTDGnnDsI5vTsi76bcRFUw3OIhsZehiaEYpGXMtQKjluE4kU6tRv3BRnRnb9
 tTBYEKnaTaYuUR6mx0nyMqyW3JVcawO2AD9q7lzwTu3Cy/j02JKvOWRPnYUbp21JvYzT
 B/tgrGB3THd+DBKbwWtUBqopyrwIYRb9PSTbpAULCUm2y5kS/L89iBzKvrk8Zt59sDJ0
 9Q3/lgl4yYkgPXCJ5fJyq86OG3yFWnjnk5Q2VxgipOVfXaLEIz4NGcMgl8iZqN7Tmqcy
 ozpMMckQ7mAbdk3rTLLZWrKltgrCwYFzgF39Tjfa+Jv6P/OZENmdhT1FMjU7VEmsBKGy
 lD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341088; x=1693945888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3aTEaFs7K9UOaQDulqexuk1KLWMtv6kkvzqJvJJKEEI=;
 b=E0l0qv/2DrPMG+dLcg4gVbEKRXTBqM9KQuCC9f45wnLhk6yIMXdVo5uK5kXDe+IhDB
 DNWZXEDwfc+Z2697duasHlkXQJL6gVnzUu8/HqgwHAijVHFlt8GIK2FPpdGJw9KOCndP
 Hsu0wS4GqT7yBrc5fY2h49LSjLVSt9Uw4m4DrhTVelcH9tUaNmMLNFn55unwwV3b7fJZ
 /bC7obNBZSLlk+FvZGJfAExXIxPZEzloXRlWTyNR4djIgxHc+DE4p9+wLsmGPBJA1fst
 vLOQR9vuIZgjS/SdYaZ9PPnP2FdlsA/0OejZa679EsbOqs6CF5le6wIHQDcgHFr2/yvN
 RgXQ==
X-Gm-Message-State: AOJu0Yz8S/8oJqwvzz3hpBa0/GOTx7NOAr82Vf6X2zuZDEt1+ko2b9mJ
 K0HdCU7sB6F+bJPhOKlehStT+w==
X-Google-Smtp-Source: AGHT+IESTSSC5knEOYUWMxxjKhi7NYv23wcljS1+Ak4R0QZ+WrZzCWtC00xQDge5/SgUyWn89SsCdA==
X-Received: by 2002:a17:903:2346:b0:1b8:3936:7b64 with SMTP id
 c6-20020a170903234600b001b839367b64mr427134plh.1.1693341088649; 
 Tue, 29 Aug 2023 13:31:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902ea8500b001bda30ecaa6sm9798335plb.51.2023.08.29.13.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:31:27 -0700 (PDT)
Message-ID: <9f586d18-3118-8293-ee1d-60d7da758a02@linaro.org>
Date: Tue, 29 Aug 2023 13:31:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 26/32] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-27-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-27-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.h    | 49 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 10 +++++++
>   2 files changed, 59 insertions(+)
>   create mode 100644 bsd-user/freebsd/os-proc.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

