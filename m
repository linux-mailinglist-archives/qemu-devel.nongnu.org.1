Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021A7E79A4
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:05:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1LYg-0002Y9-O6; Fri, 10 Nov 2023 02:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1LYf-0002Xz-79
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:04:01 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1LYd-0001eh-Ix
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:04:00 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so2762225a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 23:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699599838; x=1700204638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l3rUg7roLk6k2RfgB8iBCaW3n9h+FcwIvamkKS3y6Fs=;
 b=kl+Htmy6pGmliLdOz8DWXmDVo1avsQwvHjw9DYfsX6FSPOcPbC6HHD5/xwLo0XeWvy
 qk8RXU4aL0RL12n1DVNqy45zgbro36fPSrn6xdoMM5EKXY0E4GYHMz8fBidJfPCcetI7
 By2MVyqGiXQwKoHZPUwc+1W9FmRS4ODXUsA8aDZowNsl1j14xU/AvXo35X82BJubanf7
 CPThBrQCYgvQPyqMUGE2GpNdUkkFbaTj95Y2pXBUZx1qT+PYZUs0rlxp57pXUuyE0Bsu
 4Icx9Xtbqhx790OXIcRAMXyKaXbNOQKkM36W0iyauFaO9MUQzT7l0bC/fxxpl0bSxBgE
 T4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699599838; x=1700204638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3rUg7roLk6k2RfgB8iBCaW3n9h+FcwIvamkKS3y6Fs=;
 b=BiAuXBfxAMXUOoMh2VWwAaqOW3Ucg6UNVA/QJeV8EycgMSqmfBJC5MDDjOkrhyGPQq
 iXHIx5tJxOiei4aeVEogemSQUDZq/UKDIVQAiwyqPrFYjFcgn44O9FfHqJRpf4Ly9EK3
 u5lVEyXB+lYHlvwHpyHXsQ7ikYX7QKob+mnuN040t7mLNaT7t/jBvJISuDPxl90f9CuD
 vqKjGR2wcDCkqJreEvnmOrZhWcvDxCaTL/WdSWV5FT5ug4IWlYwYTBKYowlOHfJtBy1C
 okG2U3iPDtgJzhd17AYACO2E2XGNtRicLBxNxfEX/V6cG2FQ0FQOUI4xxFhQ6jR5YeAK
 GngQ==
X-Gm-Message-State: AOJu0YySrf2FLzxsMlIk3fDnThHqatiNHSKlnvo3eEWU2igqCayh+ZvZ
 mCXuN3ylCVVxm6js7Jrf2UQUtg==
X-Google-Smtp-Source: AGHT+IEP5ekL0z+0R8y4rsGvA29JkBpQwS/mb2MZXlZvWvZVqjc65t2oWiytR2TxSav6hpkqyfkg2g==
X-Received: by 2002:a17:906:c115:b0:9c2:2d0a:320c with SMTP id
 do21-20020a170906c11500b009c22d0a320cmr6123542ejc.46.1699599837914; 
 Thu, 09 Nov 2023 23:03:57 -0800 (PST)
Received: from [192.168.69.115] ([176.187.194.109])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a1709061ed100b0098884f86e41sm3484298ejj.123.2023.11.09.23.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 23:03:57 -0800 (PST)
Message-ID: <e52a7cea-5f89-40f0-8bba-e244c3642a0a@linaro.org>
Date: Fri, 10 Nov 2023 08:03:54 +0100
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
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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
> +        return self._binary
> +
>       def _pre_launch(self) -> None:
>           if self._qmp_set:
>               if self._monitor_address is None:

Better patch subject could be:
"python/qemu/machine: Add method to retrieve QEMUMachine::binary field"

