Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5C7E592E
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:35:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jcl-0003hF-5T; Wed, 08 Nov 2023 09:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jci-0003h2-Sf
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:33:40 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jch-0006Vs-8Y
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:33:40 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso86259301fa.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699454017; x=1700058817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUi9y5bLAzCx+3JdbgnGbPL8ag7jLzWYgknDzZmr/oo=;
 b=lEVmVXdOpKzjVf3Xvlyl+cjVNFsTbIU75eAzohcBaYa6lIk9xCzq2sVRX8CiykZe5c
 VLfc+gLZ1yAfRuY0KHVQFZWVEx3mZEBekQJU7nSNF/qnxaIhvXN0xRrvHNiDrtTHDlgd
 qj6pudfqHoQkWj258C6G0qCiGMK02j/AcbFoT1jlBaWEIdmvWnj4a/MpeQS3QzYH+gRf
 OUeKldxCgQnfOAGjbzX3HNZ+OAbU2jDeT07gDQ6t5Sdgxt6L1A0TDA5Z4dRQ8vFs1WWz
 0hQFRyRlZAS82kpMmtbdbjL1pZhHCJ5vQV3jJ9bOQRYuosSAnztIpxAhfshxCKkqx3Yq
 +bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699454017; x=1700058817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUi9y5bLAzCx+3JdbgnGbPL8ag7jLzWYgknDzZmr/oo=;
 b=ICMlN/K5oe5OlANb9ALHNENase9l442phE7G0QI3/4O8h3tYZZ1x0SJuxUqBXkLctL
 5+KFxGq8P7CgrzugBjuAm3oXoeZh6W+HwjHKvxdAeU4Tp+LHq4EjpiFMJP/okIwLudRj
 Ws4d3uMZOY/d0mT35J2QX/RcmS54Uau+sJUlHjePZJEBM0yoxAmyDf6igw6Q/uUYfk4g
 YWrBVukWcVxn4X2a4TuJ5RRLEAqPCN1itmVRhjNcz7v3JSvaZxwkQemv7BmOKsvEsIk9
 c+QD/RbGFNzaptJuSo/+TmA90RIgEq+OJKixtpu1tr6wmk8cp/X0QNJHXsHZSlu/QSoN
 47nA==
X-Gm-Message-State: AOJu0YygTcGpit7dDTtpmk1VHHgm7uwI8wacwtMEXIUQBDALl6+FfNqy
 4IUkn1bJxPP02t8m5iyOFPQrQw==
X-Google-Smtp-Source: AGHT+IEX/mR237Q+TgK1r55YZqc/3D+KAS5nW8O91vHidvDLocVM2yonH6l0arUSjrdVC0YMEIV2mA==
X-Received: by 2002:a2e:80da:0:b0:2bd:d34:e1ef with SMTP id
 r26-20020a2e80da000000b002bd0d34e1efmr1747948ljg.3.1699454017109; 
 Wed, 08 Nov 2023 06:33:37 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a5d5189000000b0032da75af3easm5074912wrv.80.2023.11.08.06.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 06:33:36 -0800 (PST)
Message-ID: <fbc70e51-5a09-497e-a22f-48416eb688d1@linaro.org>
Date: Wed, 8 Nov 2023 15:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] mcdstub: tcp packet processing added
Content-Language: en-US
To: Nicolas Eder <nicolas.eder@lauterbach.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Boenig <christian.boenig@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-6-nicolas.eder@lauterbach.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107130323.4126-6-nicolas.eder@lauterbach.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Nicolas,

On 7/11/23 14:03, Nicolas Eder wrote:
> ---
>   include/mcdstub/mcdstub.h | 144 ++++++++++++++++++++
>   mcdstub/mcdstub.c         | 277 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 421 insertions(+)
> 
> diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
> index 36058157ae..1461d0e1cb 100644
> --- a/include/mcdstub/mcdstub.h
> +++ b/include/mcdstub/mcdstub.h
> @@ -25,6 +25,21 @@ typedef struct MCDProcess {
>       char target_xml[1024];
>   } MCDProcess;
>   
> +typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
> +typedef struct MCDCmdParseEntry {
> +    MCDCmdHandler handler;
> +    const char *cmd;
> +    char schema[CMD_SCHEMA_LENGTH];
> +} MCDCmdParseEntry;
> +
> +typedef union MCDCmdVariant {
> +    const char *data;
> +    uint32_t data_uint32_t;
> +    uint64_t data_uint64_t;
> +    uint32_t query_handle;
> +    uint32_t cpu_id;
> +} MCDCmdVariant;

[...]

Can we add an URL to the spec in this file header?

It should be relatively easy to add a qtest for MCB, with raw
packets to:
- read memory
- write memory
- read register
- write register
- register breakpoint
- run vcpu
- stop vcpu

Maybe we can write a tiny code that loop incrementing a static
variable, run for few ms and check the variable got incremented?
That would exercise most of these commands.

Regards,

Phil.

