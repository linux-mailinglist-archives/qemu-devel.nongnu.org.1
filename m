Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA7E8221D0
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 20:13:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKkBY-0008CL-3p; Tue, 02 Jan 2024 14:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKkBW-0008Bt-4j
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:12:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKkBU-0002QQ-Lx
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:12:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso27571845e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704222735; x=1704827535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/1Cc+MQMSq9U5gFf9WsOF+WBjndRWPg/m+IpcEV0ek=;
 b=XU/TwPoo0lKdYlSrT0vfd3cZ0Y4Fh6KcZrLIALr3TJf+UqytfLAeK9lEr7PVsvhR6q
 aM+p5Ay3lLz3AzXZkqVhbj26TEh7P0sJs7pj4dSVzyaYjNugTFDGn4+NsJOu6gU2ZINx
 7Y5nNqkg/Of+sbB7R6A+vaqZlbGkxzksdTBeOKT4qLXIQSY3NCohDhjI1hiYKMT574gd
 XKf268UaDngk/rBWUjqXguyWGl7QDl5fnhcVlC6uc4jiG06BiaublqfGhXxwd2C3m2GA
 KMlyYl+ObFdxJbBgdWIyHi9bzm6LTnAVYjsRyHVl2dT0GqDzxfS2Y3gUJN5JWdUYwJkX
 yv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704222735; x=1704827535;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/1Cc+MQMSq9U5gFf9WsOF+WBjndRWPg/m+IpcEV0ek=;
 b=fnAnrA8FSoiV+KgzfjxO0EGUXILz9YQ/TtbBVVLZFP58PFbjPJKbQJ3PBJdM4vbg8I
 jI13TeXSw7vXeABJ4BdGTXNx5gmQ+PF2be+qnBiULC1T2sV9SBfwbzCVBO/jCpmCe+LA
 UpClC1RwOoYNSOSa2szQM1u2IjopJAnCFvA59iPnmWqe729fm2Ft5z7F6zZgWR7WA7xc
 rC9RqZgTuLGARJEI0Oq1J3u/pa5NRosIa/uswqDjYyhNJGHqdpNUpaDGFxzC/Yo2rVHq
 vx884mVpZL62A/1s8KRvbrL2PqmwsL4s/hUXd2/kdXONY7UWSfq1vZhC8zzKeZbVkUon
 imZw==
X-Gm-Message-State: AOJu0Yzx2fYD5ZX41DmCgedJfF3G8VDR4AXi8Vl8jimFKlWrWfEGfVzl
 rm+3W/pUOfusLfHYY9kDL8dl3dmU5W+QxQ==
X-Google-Smtp-Source: AGHT+IEIfqKCcgcFB7P+srnvZP5HutaRuAP/vfDBX2kpPzQDpKUcirsyFmCggP+VYmyi2HACMxFTqg==
X-Received: by 2002:a05:600c:4e45:b0:40d:8b38:57d0 with SMTP id
 e5-20020a05600c4e4500b0040d8b3857d0mr1183259wmq.144.1704222734894; 
 Tue, 02 Jan 2024 11:12:14 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c138f00b0040d7b340e07sm16167378wmf.45.2024.01.02.11.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 11:12:14 -0800 (PST)
Message-ID: <864fe591-935e-4197-91df-51be68360ae2@linaro.org>
Date: Tue, 2 Jan 2024 20:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/33] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/1/24 02:57, Richard Henderson wrote:
> The size of the allocation need not match the alignment.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/tpm/tpm_ppi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index 7f74e26ec6..91eeafd53a 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -47,8 +47,7 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
>   void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
>                     hwaddr addr, Object *obj)
>   {
> -    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
> -                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> +    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(), TPM_PPI_ADDR_SIZE);
>       memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
>                                         TPM_PPI_ADDR_SIZE, tpmppi->buf);
>       vmstate_register_ram(&tpmppi->ram, DEVICE(obj));

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


