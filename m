Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E3781A32
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 16:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXN85-0007eE-B3; Sat, 19 Aug 2023 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN82-0007dr-QB
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:40:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN80-0004gB-NY
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:40:38 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a2d0bde54so164433b3a.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692456035; x=1693060835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmEKHy10y/WQgG+v7eF09nb43gNm4c0hAugQpMfuhEw=;
 b=f4esFBZ3uPAmEyeyvFfOADQxc9ANHSPBYclbYQJdZEFosT1wMSa7meOuRlqUqOD08M
 T+Ojpw5RoWyTjiO0DWwZ2xOgPGh8kZ8TH72W22itjhYdm5+Ek2oLDO5eYO/4BFkfJxj+
 tDkWlGtpa66cujJVByPJ64e3DX1do9TWu5Lbzd6qgtuUuCvKU2P1W4yDzbJaalMR5Bb0
 usuiM8Z2me+nVFDi6M4oy2FMog/9+rGa92TRlc0NOe1GqCQrI02E6mfCkdQ58F9E3HC+
 FUs+hz5p/56BbemjNQE8s/wZTsk0VZtLStda6pQgAZks8ATTly7yZWYuqA9VJ4iMuliH
 Nu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692456035; x=1693060835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmEKHy10y/WQgG+v7eF09nb43gNm4c0hAugQpMfuhEw=;
 b=D4oUMQ6vKKl8E+FGJF3CVBLFL+yhHsa9LBR5LDXbs7fwoXgpsSFI//ZQJs77ZoMyXi
 ttbhGv4vxoB1zYAdf/d0IyJ3zejIDhKjlsXJ0fAGdX5Xm8ddGoFwzixJWSTm12+AfUs1
 qhAPBScPFwtbIOkRMVCk0Uof7CYLqvNDYO2rIl9xf0UmQGg50MQVqK6K/kg+bL695rPw
 FFBor30PTblcHV6v3S3eTOeRy8LCGmnSFkRXyTC8uT1CsHC14Nn0qAZj0LRVGwcGI/tB
 gMd3CBhSbGBAP+4e5y9IU970eX5vkf5Fcg8n1UAPO2AlxMMbf917x2IvOMWq309pe215
 0ECQ==
X-Gm-Message-State: AOJu0YzYQ1oLw6FwHC4WsmaGA5Re4aMiw2xmEDAQDVoPgI4CJyqee0Pp
 Oh/tdWcnP81aUMSRWNCoN5TEXw==
X-Google-Smtp-Source: AGHT+IGhpa6zDx/c4++yTBMJoEcDwCHAFeaE5gLbyIwQ9LvNfuHQasw7YqVnm0b6gDrIVVoCPCLIDA==
X-Received: by 2002:a05:6a20:429f:b0:137:2d73:707f with SMTP id
 o31-20020a056a20429f00b001372d73707fmr2221703pzj.5.1692456035273; 
 Sat, 19 Aug 2023 07:40:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:d058:ace4:c86a:5384?
 ([2602:47:d483:7301:d058:ace4:c86a:5384])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a17090301cf00b001b8a2edab6asm3725970plh.244.2023.08.19.07.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 07:40:34 -0700 (PDT)
Message-ID: <1d9b0c8b-1ccf-1ca6-ca60-45786cd339b3@linaro.org>
Date: Sat, 19 Aug 2023 07:40:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/22] Introduce freebsd/os-misc.h to the source tree
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-5-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-5-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> To preserve the copyright notice and help with the 'Author' info for
> subsequent changes to the file.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-misc.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 bsd-user/freebsd/os-misc.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

