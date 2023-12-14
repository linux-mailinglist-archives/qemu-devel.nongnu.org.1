Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE4813638
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 17:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDoZF-0008KJ-7A; Thu, 14 Dec 2023 11:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDoZ8-0008Jl-Ru
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 11:28:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDoZ6-0004p3-VH
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 11:28:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso86790655e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702571279; x=1703176079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=koRjVWkfmyBElvEJ1hU0wtx+8su1L2WZAzEP4KP5Epc=;
 b=CeuNP0i/gAVnQpABe/vG7mY8c4rHJFX1h8h7vqBffiBiVKyH+3MXDREIC04bNzAGCB
 nWtlgaXNjxkpduwK/vcuUorVtvWsCpSw2IAwJ5WkIccDXBast/kNcn5kXE3XWjMyWBnZ
 OT0iwwu9yE/nQh7pGVluVD7huJZrkw6qxOlIm6k3hH0aKUVhy1T6Jk47f+dC9W7h0D63
 S6jIN3AvDX0i1BoyoBRbYX3kmF8s3905asdZAr9rhtRkru7riuhoB4C3o6VXbzvevHdI
 zGck9pcCHVa7z1GYWH2wCzHQDfNhpfzPzU8yg2CMsrMj1A3LqwohbcfY08qTphaWV6PK
 fr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702571279; x=1703176079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=koRjVWkfmyBElvEJ1hU0wtx+8su1L2WZAzEP4KP5Epc=;
 b=DegjfNHCvnTQOTuqHoRWj/9qyzbQwe28i3HPI5PNYiOdF2CKhP4pngpC0W4VpJehsT
 hHT0axZpwGqVU3E+bzNw6rbHmRWXZJiIta1TCZVuZ2sgVIMBP2PNR5/h5Cxy065yeUM+
 9+BqSJXhwlgszs3/F3LEni/u11ht4SH2qoWyHyX4r2Br5stxqvEUIy0i2LZKG11APZv9
 Oi8sPoypbh/YhtPXrbYw4piQJr0QEoVCqDNHxHCsvlm5SlgPxpaUgE7MsZaQvLgoJhsU
 0561bXkx0LSbloYcfgwWhS7H0AWY6TLnqCQv4ZTL60xQSrXBvpEgynm+cQaabR68cAle
 7ZHg==
X-Gm-Message-State: AOJu0YzBZ/5anwkHsYG8jfkNlt+3jyOuhGAtdALdyNhHnD4Ch1VTSS3I
 BMglt+8xQEdDmCmqCuy+SdqNlg==
X-Google-Smtp-Source: AGHT+IHZB2fIC5lg6d4HaVGM+fwNZmLlQPrL/jZS4Y0sMJmnl/2ll8X196dF1U970aQ+XEg8LAVSeA==
X-Received: by 2002:a05:600c:c1b:b0:40c:2dd8:3a43 with SMTP id
 fm27-20020a05600c0c1b00b0040c2dd83a43mr4952772wmb.54.1702571278626; 
 Thu, 14 Dec 2023 08:27:58 -0800 (PST)
Received: from [192.168.2.234] (p50902f8f.dip0.t-ipconnect.de. [80.144.47.143])
 by smtp.gmail.com with ESMTPSA id
 k7-20020adfb347000000b003364b8f86dcsm955938wrd.75.2023.12.14.08.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 08:27:58 -0800 (PST)
Message-ID: <7bb74bc6-8806-4e54-9ccb-7f973e34558b@linaro.org>
Date: Thu, 14 Dec 2023 17:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/can/sja1000: fix bug for single acceptance filer
 and standard frame
Content-Language: en-US
To: Pavel Pisa <pisa@fel.cvut.cz>, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@redhat.com>,
 Grant Ramsay <gramsay@enphaseenergy.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jin-Yang <jinyang.sia@gmail.com>,
 qemu-stable@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>
References: <20231214104623.31147-1-pisa@fel.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231214104623.31147-1-pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 14/12/23 11:46, Pavel Pisa wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> A CAN sja1000 standard frame filter mask has been computed and applied
> incorrectly for standard frames when single Acceptance Filter Mode
> (MOD_AFM = 1) has been selected. The problem has not been found
> by Linux kernel testing because it uses dual filter mode (MOD_AFM = 0)
> and leaves falters fully open.
> 
> The problem has been noticed by Grant Ramsay when testing with Zephyr
> RTOS which uses single filter mode.
> 

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2028
Fixes: 733210e754 ("hw/net/can: SJA1000 chip register level emulation")

> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Reported-by: Grant Ramsay <gramsay@enphaseenergy.com>
> ---
>   hw/net/can/can_sja1000.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 73201f9139..575df7d2f8 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -108,7 +108,7 @@ void can_sja_single_filter(struct qemu_can_filter *filter,
>           }
>   
>           filter->can_mask = (uint32_t)amr[0] << 3;
> -        filter->can_mask |= (uint32_t)amr[1] << 5;
> +        filter->can_mask |= (uint32_t)amr[1] >> 5;
>           filter->can_mask = ~filter->can_mask & QEMU_CAN_SFF_MASK;
>           if (!(amr[1] & 0x10)) {
>               filter->can_mask |= QEMU_CAN_RTR_FLAG;


