Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542D82A80B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpDD-0000g7-FH; Thu, 11 Jan 2024 02:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNpDB-0000fw-JR
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNpDA-0007Me-1D
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704957043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qbvOyn1TJHs4V8Z56wvvyaPMDJCTO9R1dJGDYBvTv2s=;
 b=Ym82wJ7TjTLLjUpNMPOU68mV+/+t0g3lIQ7KnzSS9WS4mzbrOc9dT5Rgpg64u/MK/3xZGQ
 /w2f9Z8cEywkaFDO9g0jbY4beFzZAN+0Z2j3/AZ4blg64wBb1WKSI3rHCF9Gx/WyKC2ysT
 JvYablXXbkIw5NgouloAIp0GMDrVa54=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Ypi28DVLN_G7a2UFyKexSg-1; Thu, 11 Jan 2024 02:10:41 -0500
X-MC-Unique: Ypi28DVLN_G7a2UFyKexSg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2cd64024de2so20982261fa.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704957040; x=1705561840;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbvOyn1TJHs4V8Z56wvvyaPMDJCTO9R1dJGDYBvTv2s=;
 b=MJ8Lmj3ESJt2fEp5wlyqqI64ozDAghx33UKeUxO+mr1Jw3p+TaXPdizeb1MUfrFCPE
 7IrW+Z7B7kyKbputFfZAtjpODdBVuy4aHcxAHvJOO67owYto0mRTCNeHhw0agXEvzzqK
 m5pdwxGV1Ftmr50rcISDKv1ssqCLAQ1nEhcv+HTlRj29D3NDfFDmipQ3T+83EuZ9MQzu
 ag0+TMVD5t52ROjcga57sQ0M84Q8vEx6gMQ1VBt/MXrJRBLO7ME7f8LnNLkicYpZkY2z
 vXUDV7AcSkhgAGJUNqfc5Vswj6rSi73xRAdDIGR4kIwtJZWATHwJle5JSdByrPP0PF3D
 Q9SA==
X-Gm-Message-State: AOJu0YwqfUDLCUsoVoV6mE5GxpxycSh6/iL3YqAaiBfZ77ecqtasQrpV
 PR8JTMcnOAzH83o3EpqcdSw89+qeRZxSFI3NpQZo9heimwOSwQAQ7MIJgn8ReP6r0jZd/gWoANb
 RXyDsZspflkW0xKoUKlSFo7w=
X-Received: by 2002:a2e:9851:0:b0:2cd:3300:bdeb with SMTP id
 e17-20020a2e9851000000b002cd3300bdebmr119667ljj.75.1704957040560; 
 Wed, 10 Jan 2024 23:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHvnDqSJU+B0oB6+Jc3V1iKcdMditi8rsV3HC0kN+P3Uxit03RQMDLD30v5u5TEl6WAi4S+w==
X-Received: by 2002:a2e:9851:0:b0:2cd:3300:bdeb with SMTP id
 e17-20020a2e9851000000b002cd3300bdebmr119658ljj.75.1704957040251; 
 Wed, 10 Jan 2024 23:10:40 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 w1-20020aa7da41000000b00557463cdc76sm267990eds.69.2024.01.10.23.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 23:10:39 -0800 (PST)
Message-ID: <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
Date: Thu, 11 Jan 2024 08:10:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Beraldo Leal <bleal@redhat.com>,
 WANG Xuerui <git@xen0n.name>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Xianglai Li <lixianglai@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240102172239.69452-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Used to test https://lore.kernel.org/qemu-devel/20231228084051.3235354-1-zhaotianrui@loongson.cn/

So why is it NOTFORMERGE ? Don't we want to test KVM-only builds for 
loongarch in the long run?

  Thomas


> ---
>   .../openeuler-22.03-loongarch64.yml           | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
> index 86d18f820e..60674b8d0f 100644
> --- a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
> @@ -19,3 +19,25 @@ openeuler-22.03-loongarch64-all:
>      || { cat config.log meson-logs/meson-log.txt; exit 1; }
>    - make --output-sync -j`nproc --ignore=40`
>    - make --output-sync -j`nproc --ignore=40` check
> +
> +openeuler-22.03-loongarch64-kvm:
> + extends: .custom_runner_template
> + needs: []
> + stage: build
> + tags:
> + - oe2203
> + - loongarch64
> + rules:
> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +   when: manual
> +   allow_failure: true
> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
> +   when: manual
> +   allow_failure: true
> + script:
> + - mkdir build
> + - cd build
> + - ../configure --enable-kvm --disable-tcg
> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> + - make --output-sync -j`nproc --ignore=40`
> + - make --output-sync -j`nproc --ignore=40` check


