Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85A73D931
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhIE-0002CQ-BI; Mon, 26 Jun 2023 04:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhIB-0002Bn-O8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:09:47 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhI8-0008Fv-Ff
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:09:45 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f8777caaa1so3783527e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766982; x=1690358982;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APsqU8H8PIt/HIhpptqVOj95iZVi6DpIUGUqzXHcXcE=;
 b=BT9ZBiah2pYY0L+HZeRIB81PNYOSe6a8IcnKK2K8yoMuGtkVpVv41LgxNoP/bYb5Gp
 KFMZwxio/cXBJ3HWldjzKcibpToagD+Z2hayF9EjFoYBbhAMtkkvsCZOl5a21XoFJDd9
 WXSHwtqr7pyDs070+LgOk9QUGQ+2xo4M1kVcf6Sczlgw6q+GH1do1CsmMFM3BxVNPrye
 t2yiuKmELQJlG16lIz0UEFQieBX88n2gv8ZseYVydcz6Ni1FAZRShCKKGVF+9pMJU2+M
 U3o4Rq8WhHxANYEFWcqnN4Z0/cw8cblbecHDPES3951jYreIJNH54XjTGb/Ragg5eN9O
 widw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766982; x=1690358982;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APsqU8H8PIt/HIhpptqVOj95iZVi6DpIUGUqzXHcXcE=;
 b=EkFG6zVBEX2nxg+2pav+r2G067auNFv6fbOOMKf+6asf9gThAMpRxedV2CMNn535NA
 GYjmfuxKdjDJOheeDxrJb1i48ptuGEL7AWEUuUSt3veraVyEQbztFX9HeCb6jzu0TN5Q
 f/fh6WUst5IDdCGoAxg6q8PFj655O6gLz1WpFaLfq028CMz00G09csSN/uSXZy0TwtW1
 vbmsG+s91oAVNZi1dzBzY0h7VA5VjHaWLe8l3Q1SlGWw8D6DN/FcfaLVecjNiFdmcH+X
 nWob8qT9IUMw9Z/6oNed7QYOYAQ6rdF3ZibTnZlRzD+tR6zwYw3kBnGxVjVATO1rEaMJ
 3znw==
X-Gm-Message-State: AC+VfDyGp57e3b/obBUvyUKllUKhAso6+Ojg259rZdeUAVbNJw9HYgwk
 rTwA3T9hvzrr++6noGMC1anJDwXx2PuaGmr4XsDwXBqF
X-Google-Smtp-Source: ACHHUZ4PlCGNhb7d6Rj5ejl2C+9t0SBB+KO+/4KmLj+jrviGrgiTj8dkn0A/HN5SnHPCyPNSdmpZeg==
X-Received: by 2002:a05:6512:2343:b0:4fa:9817:c1da with SMTP id
 p3-20020a056512234300b004fa9817c1damr2002846lfu.21.1687766981847; 
 Mon, 26 Jun 2023 01:09:41 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a7bc8da000000b003f819dfa0ddsm6866823wml.28.2023.06.26.01.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:09:41 -0700 (PDT)
Message-ID: <edda3a6e-9862-0d9d-ba59-cb6e2cf8cdce@linaro.org>
Date: Mon, 26 Jun 2023 10:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 13/26] tests/lcitool: Bump fedora container versions
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> From: Erik Skultety <eskultet@redhat.com>
> 
> Fedora 37 -> 38
> 
> Signed-off-by: Erik Skultety <eskultet@redhat.com>
> Message-Id: <c9b00e573a7a80fc6ce5c68595382f5c916a9195.1685528076.git.eskultet@redhat.com>
> [AJB: Dropped alpine (in prev commit), reflow commit msg]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/fedora-win32-cross.docker | 4 ++--
>   tests/docker/dockerfiles/fedora-win64-cross.docker | 4 ++--
>   tests/docker/dockerfiles/fedora.docker             | 4 ++--
>   tests/lcitool/refresh                              | 6 +++---
>   4 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

