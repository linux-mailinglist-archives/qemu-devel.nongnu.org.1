Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620D7BA597
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoR3Q-00076w-LJ; Thu, 05 Oct 2023 12:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoR3O-00076b-Ow
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:18:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoR3N-0004v4-5G
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:18:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so1188257f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696522698; x=1697127498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IPs8CmVIqqhjxhkLT1ZeWllfz+bS0XwCVUChuLjQcOQ=;
 b=aRMTvkSzljpwgmn+a3gq0XXDymohTSPDlGwfOxegUuImVX3TrAkZrLc+e4G3bW+yIy
 6rcczPeaKA44FfBkmT4upKoqKETM6Uy1Dc8ceaDxuscK4uTxqLlVr8nz6+Cl4aE6G3cl
 CagERjiTQq3JqW5znYl0e94aztpkRLb+seZ1SvlgP+6v+6OL84/7ja1okiJqfDWRErpG
 YCMBrjJeUTRS+T7Z1Xi+GDjx0xZ6FhSm+lkhK0OaAlvgnMdmSeuu18XxqSvSMIUmRQnJ
 q+m/6sWbmvRRYsEYbrcDriSZakrM3VzH1LvFg4LgABsfw4oGTaUN9jY/2wGI6IA05Z5C
 jZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696522698; x=1697127498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IPs8CmVIqqhjxhkLT1ZeWllfz+bS0XwCVUChuLjQcOQ=;
 b=vD01bHV5CJOz/mstGiCJ2SciiFBfEkRQGFKMfWSqtkkk3+IW8C+3U+E3VGwDUo61UW
 LTIOrnS1N8SsGvoEtU6n5+xk8BBA3lew0fqenR1GZ4htsaq5WFZgSHbati+e8fGgIe+h
 CTkLDkq37Qvl/71Zkm+2LrYM0N1g0L84tUxPUZ9HXFINpGTd2s918nhLEqnaNGsuRdAi
 ahu5mHzu+mfbAv0R339YvN2ZwXwNqrYpo7SoLI8Vip05RenhDw/RzHrshFCCm+m0LJFl
 KptkDeJOHBdzDuseB7zeHCqiWwms1XgFR7X155mj1yES4R+FWHzBy6wDmlTWoAnCwhFW
 3uxA==
X-Gm-Message-State: AOJu0YwPl6UHbOAiOrWAIZiu5u6Eo+kBE0+poj9isliSU+eIqo/NdrfX
 JMFdHmcUNWNMbF/9qzt6vJzFgA==
X-Google-Smtp-Source: AGHT+IHvbB5TC8cohpmZsuXMDQVGX1Qio02oQx6yTvwr4Zddzj3kywcXRijTafdTsG0Bc0lAZiuZAA==
X-Received: by 2002:adf:e70f:0:b0:320:6f4:a200 with SMTP id
 c15-20020adfe70f000000b0032006f4a200mr5138641wrm.10.1696522698470; 
 Thu, 05 Oct 2023 09:18:18 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 p15-20020adff20f000000b0032318649b21sm2121448wro.31.2023.10.05.09.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:18:18 -0700 (PDT)
Message-ID: <8904d73d-3d14-e9c1-dda9-e0a2d5f5dab1@linaro.org>
Date: Thu, 5 Oct 2023 18:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 15/19] linux-user/loongarch64: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu, Song Gao <gaosong@loongson.cn>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 30/9/23 04:15, Richard Henderson wrote:
> Requires a relatively recent binutils version in order to avoid
> spurious R_LARCH_NONE relocations.  The presence of these relocs
> are diagnosed by our gen-vdso tool.
> 
> Tested-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/loongarch64/vdso-asmoffset.h |   8 ++
>   linux-user/elfload.c                    |   2 +
>   linux-user/loongarch64/signal.c         |  17 +++-
>   linux-user/loongarch64/Makefile.vdso    |  11 ++
>   linux-user/loongarch64/meson.build      |   4 +
>   linux-user/loongarch64/vdso.S           | 130 ++++++++++++++++++++++++
>   linux-user/loongarch64/vdso.ld          |  73 +++++++++++++
>   linux-user/loongarch64/vdso.so          | Bin 0 -> 3560 bytes
>   linux-user/meson.build                  |   1 +
>   9 files changed, 245 insertions(+), 1 deletion(-)
>   create mode 100644 linux-user/loongarch64/vdso-asmoffset.h
>   create mode 100644 linux-user/loongarch64/Makefile.vdso
>   create mode 100644 linux-user/loongarch64/meson.build
>   create mode 100644 linux-user/loongarch64/vdso.S
>   create mode 100644 linux-user/loongarch64/vdso.ld
>   create mode 100755 linux-user/loongarch64/vdso.so

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

