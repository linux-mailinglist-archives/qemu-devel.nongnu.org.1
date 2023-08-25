Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB2788177
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:03:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRlw-0000qU-Sv; Fri, 25 Aug 2023 04:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRlu-0000qF-1K
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:02:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRlq-0002yO-U8
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:02:20 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so70975866b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692950536; x=1693555336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHb5v+DInJIOp14PgvsbEY7CeggfleyyQ38+S/GuOoA=;
 b=sxr3/AJ3VkgHHDCUfc1FwKqGTF3U+PFefq+RFl+6vdFULF0LqQINIO3M/Gjsh9+SpL
 ueC/nZZflOIwLMJLw3WO0X3+QCgmbA823kleXT3ME3SinDsdTq0rU2rXKIuOnxseBlGg
 PtCZjeJG5AI/PTCMQSwAZlEyIrvBuw3xqhN+B4KYrOtFUIMZEwNYhtDaS3HQb7Qx33ml
 j6Y3/5fyOFm1soiIvSk5BnH7JppToGCSfZjMa+QcsKncHGPUuNQoGqB1lgCp5j21gqLM
 xRloT+s5kUPqwcZSobGwIMXlS74EjWewGK7anlAQ1lk+VF7P24vCv2TDn/hrg7cqveUk
 id+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950536; x=1693555336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHb5v+DInJIOp14PgvsbEY7CeggfleyyQ38+S/GuOoA=;
 b=duBQSaPqmooo+hvkJw7ano2SB81v/Ai8siP5RoB5r8ioHc9xz9s5aXeq/4N0OgxyTi
 5qVAsP+kK2WI3LwfREqhFeG7SjPQvyVh83DgtmMX4/B4/f440/KvIve4GAJnNDGwLCXO
 M/iuPjMzfV4mUq7mstKQuvpRMi83sO2z/Td92FvkrHd1HcanRmWUsDElMXMQgEnsD1OU
 6Nq6hJClzfwKCiG+HToyu3dQp3CPMYsrCQZX5AhZTfnMFso/5EowxKA+wgckl+VfOElT
 CghyxIvkHwA3/7mFKdY7zVzZV27vQBQMcQemlprh7QoImhjJd9xRLp/2Taf2wzh/95Ao
 ktiA==
X-Gm-Message-State: AOJu0YzJ1LeQKsKnLVfJChJDaad3PLXQYAXkRe2HqAhtOpGrBZaQqZrj
 4jiv/hS6xXP5z9+b0ElTypPFZRVpP19KkqKtrAU=
X-Google-Smtp-Source: AGHT+IGjcB5gPTYa1R2H8kXdtx0MscP2xxpZvqZv2NvxCpseujYc4fCscV65vAVgPQG4Kz+KOEh9fg==
X-Received: by 2002:a17:906:5a55:b0:9a1:c00e:60cd with SMTP id
 my21-20020a1709065a5500b009a1c00e60cdmr7263877ejc.15.1692950536625; 
 Fri, 25 Aug 2023 01:02:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a17090626d600b009a1fd22257fsm664113ejc.207.2023.08.25.01.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:02:16 -0700 (PDT)
Message-ID: <e2bfcdb3-c057-7da5-8047-f6d7e1875c13@linaro.org>
Date: Fri, 25 Aug 2023 10:02:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.1] hw/usb/hcd-xhci-pci: Fail if user requested MSIX
 but it can't be used
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230719141733.35818-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230719141733.35818-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

Ping?

On 19/7/23 16:17, Philippe Mathieu-Daudé wrote:
> Do not silently ignore the user request of using MSIX.
> Remove the TODO. Coverity reported this as CID 1508725.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/usb/hcd-xhci-pci.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index 643d4643e4..416656b78c 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -155,11 +155,22 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>       }
>   
>       if (s->msix != ON_OFF_AUTO_OFF) {
> -        /* TODO check for errors, and should fail when msix=on */
> -        msix_init(dev, s->xhci.numintrs,
> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> -                  0x90, NULL);
> +        ret = msix_init(dev, s->xhci.numintrs,
> +                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
> +                        &s->xhci.mem, 0, OFF_MSIX_PBA,
> +                        0x90, &err);
> +        if (ret < 0) {
> +            if (s->msi == ON_OFF_AUTO_ON) {
> +                /* Can't satisfy user's explicit msi=on request, fail */
> +                error_append_hint(&err, "You might have to use msi=auto"
> +                                        " (default) or msi=off with this"
> +                                        " machine type.\n");
> +                error_propagate(errp, err);
> +                return;
> +            }
> +            /* report that msix is not supported, but do not error out */
> +            warn_report_err(err);
> +        }
>       }
>       s->xhci.as = pci_get_address_space(dev);
>   }


