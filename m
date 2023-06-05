Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F27227BF
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6AWE-0001Wh-RX; Mon, 05 Jun 2023 09:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6AW7-0001UZ-DD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:45:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6AW4-0001SP-Pn
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:45:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f61b45ee0dso2481811e87.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685972698; x=1688564698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+0vkFzNLmtFU/cMVgeyPzdtmnfbSDXXjw85rDM/XYo=;
 b=nn1wutnFUPouShYv88AB00o3vOvQTZAi3F6Ot7eQafil0cjYX7s6kUF/L3dc7gMVH7
 InvwYtAoMWJ5dvm7O8Z5veqw9GhNEtmiK5b9hFgT5Nz2UgpaevLH4YQR6NbqUj1c2THc
 aiorc7bFDPJc/HgfGslfl+RMHHmwAdcH7XRHBAy2YIhM1/Jx5WDYHGZ3RsUkgQrRiA2s
 2oFzo1hJ/pUA9/7I/Ad2iMPAhhRIXPuPR/ciyUyK8LVjvYzmY1JfYRC9yMcbwMXZIXKf
 DMNbMV7Rppe1Vsg8NVJPiV+Hdjl8/EmZ5yc+sC+vyr9xGQYiMtATRliJ7FzSEl/9SVZi
 nZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972698; x=1688564698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+0vkFzNLmtFU/cMVgeyPzdtmnfbSDXXjw85rDM/XYo=;
 b=Z8e/HpgocmkqUCsjj8yDBCwG9W1jNbvJIlUIZxNiqF+JsBtuplu1vXA2D7hiwWwPQf
 p7V+knLQca7zw/vnq9ZUr/qMq2h3bKugNmTl0GANPakJNnsaMrYuAdKRYIJeN0eiQFqY
 mJYJNMEa98oojle7oD/oslP/B6ScX3kxZ+pzSXhwmR5EHJfKywtC82Lv8EYW7FvpYAEH
 M7V6MwYhWPFUrXPyFE0ValNcfGFgvsK/Y7nQDGrVXEYSt8/XgxPOOeyasx3jXpmDH5W4
 m6Xtb6GbaJ/nIuYaOGFrykB+GTvTdUFvj7gINTZ0MezbIoDydC6hJpmWLSPxxyb5S4xC
 vy1w==
X-Gm-Message-State: AC+VfDwQ9JuIFUzGx4fpa4TM7O2Xirlxsfkmj0D3aOVIcOrj0WGjvF3I
 HCItIWoQ9TP5O+pL2XqTfnPLEcnSRujkmaWePXU=
X-Google-Smtp-Source: ACHHUZ5e7Hwi4pCczx/d7sg3LiVL62B0KijpMX4ncymkpeUxkVy9+vBj/6ET60qfMtNBdvFFH1kJ8w==
X-Received: by 2002:ac2:4945:0:b0:4f0:441:71a4 with SMTP id
 o5-20020ac24945000000b004f0044171a4mr5215915lfi.35.1685972697846; 
 Mon, 05 Jun 2023 06:44:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a7bcc99000000b003f4289b18a7sm10900137wma.5.2023.06.05.06.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:44:57 -0700 (PDT)
Message-ID: <39574948-bbc1-165e-5f49-20f8a560e732@linaro.org>
Date: Mon, 5 Jun 2023 15:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2] hw/scsi/megasas: Silent GCC duplicated-cond warning
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20230328210126.16282-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230328210126.16282-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

ping?

On 28/3/23 23:01, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> GCC9 is confused when building with CFLAG -O3:
> 
>    hw/scsi/megasas.c: In function ‘megasas_scsi_realize’:
>    hw/scsi/megasas.c:2387:26: error: duplicated ‘if’ condition [-Werror=duplicated-cond]
>     2387 |     } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>    hw/scsi/megasas.c:2385:19: note: previously used here
>     2385 |     if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>    cc1: all warnings being treated as errors
> 
> When this device was introduced in commit e8f943c3bcc, the author
> cared about modularity, using a definition for the firmware limit.
> 
> However if the firmware limit isn't changed (MEGASAS_MAX_SGE = 128),
> the code ends doing the same check twice.
> 
> Per the maintainer [*]:
> 
>> The original code assumed that one could change MFI_PASS_FRAME_SIZE,
>> but it turned out not to be possible as it's being hardcoded in the
>> drivers themselves (even though the interface provides mechanisms to
>> query it). So we can remove the duplicate lines.
> 
> Add the 'MEGASAS_MIN_SGE' definition for the '64' magic value,
> slightly rewrite the condition check to simplify a bit the logic
> and remove the unnecessary / duplicated check.
> 
> [*] https://lore.kernel.org/qemu-devel/e0029fc5-882f-1d63-15e3-1c3dbe9b6a2c@suse.de/
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v1: https://lore.kernel.org/qemu-devel/20191217173425.5082-6-philmd@redhat.com/
> ---
>   hw/scsi/megasas.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 9cbbb16121..32c70c9e99 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -42,6 +42,7 @@
>   #define MEGASAS_MAX_FRAMES 2048         /* Firmware limit at 65535 */
>   #define MEGASAS_DEFAULT_FRAMES 1000     /* Windows requires this */
>   #define MEGASAS_GEN2_DEFAULT_FRAMES 1008     /* Windows requires this */
> +#define MEGASAS_MIN_SGE 64
>   #define MEGASAS_MAX_SGE 128             /* Firmware limit */
>   #define MEGASAS_DEFAULT_SGE 80
>   #define MEGASAS_MAX_SECTORS 0xFFFF      /* No real limit */
> @@ -2356,6 +2357,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>       MegasasState *s = MEGASAS(dev);
>       MegasasBaseClass *b = MEGASAS_GET_CLASS(s);
>       uint8_t *pci_conf;
> +    uint32_t sge;
>       int i, bar_type;
>       Error *err = NULL;
>       int ret;
> @@ -2424,13 +2426,15 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>       if (!s->hba_serial) {
>           s->hba_serial = g_strdup(MEGASAS_HBA_SERIAL);
>       }
> -    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
> -        s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
> -    } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
> -        s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
> -    } else {
> -        s->fw_sge = 64 - MFI_PASS_FRAME_SIZE;
> +
> +    sge = s->fw_sge + MFI_PASS_FRAME_SIZE;
> +    if (sge < MEGASAS_MIN_SGE) {
> +        sge = MEGASAS_MIN_SGE;
> +    } else if (sge >= MEGASAS_MAX_SGE) {
> +        sge = MEGASAS_MAX_SGE;
>       }
> +    s->fw_sge = sge - MFI_PASS_FRAME_SIZE;
> +
>       if (s->fw_cmds > MEGASAS_MAX_FRAMES) {
>           s->fw_cmds = MEGASAS_MAX_FRAMES;
>       }


