Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F46D720DAA
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5IAX-0005pa-5d; Fri, 02 Jun 2023 23:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IAU-0005p8-EN
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:43:06 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IAS-0001F5-Rh
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:43:06 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6af6fe73f11so2633968a34.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685763783; x=1688355783;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cO3+65pCnteyTg/TqBvJkuTh2HYlOFH1JtHN3WWoZ4=;
 b=zjfWqRqEKdeo4a1eo1szmAXfThnPl4415vZYPQGDQsglpHOoH2RqnzxMvIHXYgZYls
 OSIC4yCGJa3o5nYALeTfE1mFTe8LKYboO+ZsD7Qwv/F07F1isAtBX6FFR/lz9bOX5X5r
 SBb+7mcKCoA13Si8lw95JS5P3VCqnt7Icy3dLyrOIC3dXZzKAhnm/wQzBuUWHnMxYEEM
 NmKbhh1xRcZKLWEWU1XvvD+93Uh+xO0okS9gw46T8KEfEibhdwhwfLu9WH9fUGs5jAeA
 U4+m8tulLU8NQWqAFEg4pVRnhvIrt9qGnDWxigpt+FDKeo/wl3ez9gMcUxp/NnPCsUgq
 XSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685763783; x=1688355783;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0cO3+65pCnteyTg/TqBvJkuTh2HYlOFH1JtHN3WWoZ4=;
 b=Jninxd17lci68OJa4FuS2piCHW4Ntl/VPiFCmRvee65Zn22cXjoQBrWywf3BsRMYVV
 v7+gyvJlfb9Conk8GO7Oxq4jyfnUE4u2vRIuDKL9AMdHElcaXMpCd9bUcf6Iq4pO1D/o
 EqK2NZskc9+F4q8RHzXDPwX9xPLIEOHJ31knVc3cXKHwem0kkV+dd+thJNg4OIqW6Lim
 pt29gTOYH9c/8xZo5XekYCGGbSLWuFIqPv3v0nqVBOCz2ig9ZW31O9n9TmG+n9NnoANS
 JBROCJWlRy89AmhSFcqIEEzjJ3u6t76/R9APP0F60M2jTDwabWXAcVxJYjQwXlDASr3o
 isSQ==
X-Gm-Message-State: AC+VfDyJCYucNhtmIU1YiceKQWaiR0kv2cTQDS3DPANZaj5oxBNmPaml
 OWneSY0Avnq2l1e8bDFlUVIlMg==
X-Google-Smtp-Source: ACHHUZ6CoUMdbKdPRZY2mRA2edtgq/xVMfvARcqAAZwgTL95HyBqLb9z4tq13GAk+q1i/+wehO7ZOw==
X-Received: by 2002:a05:6358:919c:b0:123:5851:f09f with SMTP id
 j28-20020a056358919c00b001235851f09fmr14394396rwa.23.1685763783327; 
 Fri, 02 Jun 2023 20:43:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a17090a674d00b0024dee5cbe29sm1909216pjm.27.2023.06.02.20.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:43:02 -0700 (PDT)
Message-ID: <fc27a270-6ff1-db8a-5438-d3e21d2707a6@linaro.org>
Date: Fri, 2 Jun 2023 20:43:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] target/i386/helper: Minor #ifdef'ry simplifications
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230602224628.59546-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602224628.59546-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 15:46, Philippe Mathieu-Daudé wrote:
> Not very interesting code shuffle, but this was in
> the way of another big cleanup. So sending apart.
> 
> BTW this file isn't covered in MAINTAINERS:
> 
>    $ ./scripts/get_maintainer.pl -f target/i386/helper.c
>    get_maintainer.pl: No maintainers found
> 
> Philippe Mathieu-Daudé (2):
>    target/i386/helper: Remove do_cpu_sipi() stub for user-mode emulation
>    target/i386/helper: Shuffle do_cpu_init()
> 
>   target/i386/cpu.h    |  3 ++-
>   target/i386/helper.c | 15 ++++-----------
>   2 files changed, 6 insertions(+), 12 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

