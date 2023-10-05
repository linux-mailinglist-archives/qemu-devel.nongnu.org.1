Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CD7BA614
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoR9K-0003bF-02; Thu, 05 Oct 2023 12:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoR9I-0003b1-Eo
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:24:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoR9G-00069K-JA
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:24:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so1101711f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696523064; x=1697127864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQnm9jAKlf+PYiNVQ+RewiotqGYe2YfFUfKdQfLvxrg=;
 b=rewXM50eBiOIwvIOQ5hJnuE2PJJcrKTnExok/O4FTnavLL5cuyUT4akFg/zNLNUo5w
 gWZTjN8sECVr6AC8wAf85Cmkudfz1WtbABRWjeZpttjbALcxjKEioYEXwqW18ux6f8Gx
 HZAouR6bbpRhfTDqSi8+Ye0D3PNZsljF5sLMLk11ZXsvG08GqZtk/iDvIBvt3QPpInl3
 bbkiVwz0kwZHHsMx5L+oRlE7ugztE92/HsuwiRu5TIK+ZANDBn28z2MHKUsT38WX9tvT
 7gPJ/p0ExQGpDEKsGCaZCn0fJLx7niqFsMZVou6gA4GnyNTqQga6LCNOQtyr2K5ScBvf
 Cm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696523064; x=1697127864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQnm9jAKlf+PYiNVQ+RewiotqGYe2YfFUfKdQfLvxrg=;
 b=TPgCpONlhpoVl6UVMzLa7M9ben0MsjURu/pgr06goBzBdHvukhrMZyYcByNcqa8ksI
 UT0+VDdfNQNhN6lQRXpemhVM6jysLrj6Qh55RGbxxKCmoltUUZjOGzKqAcNC+AgbWIKz
 bg+uwTIrAr9Tt7qGb3XCl3xd6OYBolQ56u33+Qa2wc8zKpdKTEc8TggD/bucFKWkMNxm
 33ig0dncBCD35Vjancug8USbsE2XvSFMap7IgPrdCIBy4QcGG6o5p5Alj//P2xywDUZg
 VfwHw21YbYuu6DzgWcQyG9qQ3Z43UVsOp2X/2Kdo7oUBVP3/bNHop6WFoBz50bAP2qzA
 +Dbg==
X-Gm-Message-State: AOJu0YxKxfDJqZ3c3AuZBFd+sfK0gKDg1Csia7whFxMrShael3R+0GXx
 3pieIYSWbxzNUpj8hpqpboFTismOFp9m2DaNMK0=
X-Google-Smtp-Source: AGHT+IE392RAWMQ0BimerSQiLimqOHoeoPc3Pqj265Q4o08qpBxtEQse/Li08vxOImfZ2Ds6mHSuLA==
X-Received: by 2002:a5d:49c2:0:b0:321:5f0e:26a4 with SMTP id
 t2-20020a5d49c2000000b003215f0e26a4mr5340653wrs.38.1696523064217; 
 Thu, 05 Oct 2023 09:24:24 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 u17-20020adfed51000000b003197efd1e7bsm2114000wro.114.2023.10.05.09.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:24:23 -0700 (PDT)
Message-ID: <e6f71197-56d5-9694-572e-cf3341e1153f@linaro.org>
Date: Thu, 5 Oct 2023 18:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 14/19] linux-user/riscv: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/riscv/vdso-asmoffset.h |   9 ++
>   linux-user/elfload.c              |   2 +
>   linux-user/riscv/signal.c         |   8 ++
>   linux-user/meson.build            |   1 +
>   linux-user/riscv/Makefile.vdso    |  15 +++
>   linux-user/riscv/meson.build      |   7 ++
>   linux-user/riscv/vdso-32.so       | Bin 0 -> 2888 bytes
>   linux-user/riscv/vdso-64.so       | Bin 0 -> 3840 bytes
>   linux-user/riscv/vdso.S           | 186 ++++++++++++++++++++++++++++++
>   linux-user/riscv/vdso.ld          |  74 ++++++++++++
>   10 files changed, 302 insertions(+)
>   create mode 100644 linux-user/riscv/vdso-asmoffset.h
>   create mode 100644 linux-user/riscv/Makefile.vdso
>   create mode 100644 linux-user/riscv/meson.build
>   create mode 100755 linux-user/riscv/vdso-32.so
>   create mode 100755 linux-user/riscv/vdso-64.so
>   create mode 100644 linux-user/riscv/vdso.S
>   create mode 100644 linux-user/riscv/vdso.ld

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/linux-user/meson.build b/linux-user/meson.build
> index dd24389052..3ff3bc5bbc 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -45,6 +45,7 @@ subdir('microblaze')
>   subdir('mips64')
>   subdir('mips')
>   subdir('ppc')
> +subdir('riscv')
>   subdir('s390x')
>   subdir('sh4')
>   subdir('sparc')

We should cover these directories in MAINTAINERS, likely in
the "$arch TCG CPUs" sections.

