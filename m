Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF88B7E5CCD
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 18:59:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0moX-0001QE-Cv; Wed, 08 Nov 2023 12:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0moR-0001PG-Ot
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:57:59 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0moQ-0004sk-5e
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:57:59 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9d242846194so664666b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699466276; x=1700071076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3Q4tfAf+IGdI9PIg2FtubMMyLq/QbHSC2HlBHS/hQM=;
 b=bJbwv0cdi/TrZ7CrTF9XZkLlDU+dxP/mQB4tdSXGbovOER84k1eeLicb5Gfk7mcD3f
 zWRhGowl0xCMbIbLDVACkE8aH4LZa/+9+MGw62WbrIZRgQWfV99yLBq9mmZc5SHUVLeP
 Jkho4VoNjGOXhPVTyYtQs8B9dvvoRCf/zH3p0HVuALuAxAi5mNQaSEvzSBPoSV2h/vrc
 Wzrl+AJeM9IY6/La71LOg4g6uOvWoSyW1SXpxz29UBY9QiH/nTJOr0CKn49Oj9cR2v/W
 zThywyDNGF9p/zAx5r7nvus/wq5m93HwL/0wRO8BW0kUxXSfG0xjBGfWqbPtAcjRxrqe
 ZiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699466276; x=1700071076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3Q4tfAf+IGdI9PIg2FtubMMyLq/QbHSC2HlBHS/hQM=;
 b=VglwNrhxTeNSaqRohgpMNIC23k+cHok6zHrg2uBvNfGKReJHD5Aa5PjHZMvaWyy+1b
 c3nFEuGGsKUeIvmsrLDwzHcIV0gqt9SjuWalxLm+CODbnIFGhzjLxMHhb2VCUiMixjou
 I8Q2hF0dpJrA57+inADXMthaPiB7QC+Ra70wz3j17DnLop8oaVrs0j4u6jn/vV3f8ZkE
 ETguK1rwi6GMZXfSCaQmAD4RO38YfmYqfXKf4YkN9VjTjGYJ5vKxnTXyFvE0IjVUuqxZ
 2wgLB0Jb9BvI/wWJoyR8j5WapAlFrlUFdL1y5Vg3U0tvpQDvb+dbZqzaIBdp2oh4Bjso
 ttCg==
X-Gm-Message-State: AOJu0Yw5GPjvCOpCF7ONalXMs42DlARVwSKqbyfOVb1qsHKBHiYoj70z
 2/t7ipY4+ObRp0cY+UlFFbnOBw==
X-Google-Smtp-Source: AGHT+IEJdprsPNEReN33TjW7+WbAEC5F5l9x3Tq0FE5PdvgDtlZBiQ8d+6huMWrnrU/5RAa44qiZDg==
X-Received: by 2002:a17:907:7295:b0:9dd:6d39:42b9 with SMTP id
 dt21-20020a170907729500b009dd6d3942b9mr2060206ejc.55.1699466275693; 
 Wed, 08 Nov 2023 09:57:55 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 lv19-20020a170906bc9300b009a9fbeb15f5sm1372376ejb.46.2023.11.08.09.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 09:57:55 -0800 (PST)
Message-ID: <573b7776-a01d-4837-a17c-059ed8159b57@linaro.org>
Date: Wed, 8 Nov 2023 18:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] python: add binary
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, jsnow@redhat.com,
 crosa@redhat.com, bleal@redhat.com, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, thuth@redhat.com, darren.kenny@oracle.com,
 Qiuhao.Li@outlook.com, lvivier@redhat.com
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-4-davydov-max@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108153827.39692-4-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Hi Maksim,

On 8/11/23 16:38, Maksim Davydov wrote:
> Add a supportive property to access the path to the qemu binary
> 
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>   python/qemu/machine/machine.py | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> index 31cb9d617d..78436403b2 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -328,6 +328,11 @@ def args(self) -> List[str]:
>           """Returns the list of arguments given to the QEMU binary."""
>           return self._args
>   
> +    @property
> +    def binary(self) -> str:
> +        """Returns path to the qemu binary"""

s/qemu/QEMU/ (like 2 lines earlier).

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        return self._binary
> +
>       def _pre_launch(self) -> None:
>           if self._qmp_set:
>               if self._monitor_address is None:


