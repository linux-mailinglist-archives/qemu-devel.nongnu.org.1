Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E3791342
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4r6-0001uv-9D; Mon, 04 Sep 2023 04:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4r4-0001uX-5T
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:22:42 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4r0-0001Sg-Eb
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:22:41 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a64619d8fbso153596566b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693815757; x=1694420557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23/xdPLVHPcpgk6xw7qFozBHQnTrr+y+sjvx7UE6Lxo=;
 b=xbhlUbo+YJzgm3jeb6UvoZiexnRkUP+1pVT47gm6mmm/AVTxZY1Ehrz8QIl+JNV/fY
 B/Ypzx7kphIKPsCYrGiYEVoVv46irbRsf71Jx1AsC90KKioguF/1A7I9xpFtZYlZNQhS
 6E6/1MffkYXxJmOop4a1wA3Ny9iPICL74h1HqJwq4UtnVNz7PusgROrIgFzI2LA4ZTUm
 uLCfFN3odVgKre5arVkWRjLLSbAwogvfYDxTUEEO0l9yiQ1RwmAAnRNzSo3tZGQKM7g7
 r6CQWNAHqJx6aryGTZZUMKfHeIfwF7HxhDYVmVmwoEbzdJrtKIsjSmQhQb8NfHTtU4GB
 AQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815757; x=1694420557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23/xdPLVHPcpgk6xw7qFozBHQnTrr+y+sjvx7UE6Lxo=;
 b=EeG5NPi/gId5huhXsfj12iKc5gYICVcj1B1ScHRwnVbmX9n+wlgHkPkmIRt3UsL3MU
 MgbtZ3vxlANvVdd55FppxpmCfwewjzmue5p3snJ4tJcqDLgy7sgA9473EMITa1teY3OO
 UQL+3IGbP39RxFvZv0Eob6/oG+Qga9zJIjlXFNVIBzExvVmzcoKcuX6awNayuCfnbgHb
 yBZmIr/qos1w1beZ0cHv10YdL7G/KKEfeRIiJlXyKeJB3A+Fst+INs1qiUf6rYx/AJ2e
 Cogb/dRvygrtOiy3yiGHFrD3oSarASOnbRtj1fkECrKcPwzi8pwyCRyWjGS5XEYiDRtK
 /5zg==
X-Gm-Message-State: AOJu0Yxk3iKOw7DTsh8SeFQrdTTpOkSaH5vtZTpZZgA+yjUDJ7EtwbtX
 6tHX5qULrHh4+V0tM05+wg94clDwjtvMddIgvg0=
X-Google-Smtp-Source: AGHT+IEaNKWjEsG/rRC2eNM/MSkLSoQYcJt8jpZvFvuHxV7S7ByNStqlO5NF9t2FC0lVjooqWWHp2w==
X-Received: by 2002:a17:907:762f:b0:99d:dc0b:a89a with SMTP id
 jy15-20020a170907762f00b0099ddc0ba89amr8021619ejc.63.1693815756774; 
 Mon, 04 Sep 2023 01:22:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170906410900b009926928d486sm5813920ejk.35.2023.09.04.01.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:22:36 -0700 (PDT)
Message-ID: <ddba4946-dd74-678f-f97a-84618db86ea2@linaro.org>
Date: Mon, 4 Sep 2023 10:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v9 11/20] avocado, risc-v: add tuxboot tests for 'max' CPU
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
 <20230901194627.1214811-12-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901194627.1214811-12-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/23 21:46, Daniel Henrique Barboza wrote:
> Add smoke tests to ensure that we'll not break the 'max' CPU type when
> adding new frozen/ratified RISC-V extensions.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   tests/avocado/tuxrun_baselines.py | 32 +++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


