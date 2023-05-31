Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A5717664
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EmE-0003Q6-IT; Wed, 31 May 2023 01:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Em3-0003PE-A7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:53:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Em1-0002qK-Hn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:53:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so1354286f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685512407; x=1688104407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0NYvbESkfPbVA7Uj/A3Mc+DWgHjZSxUtYHePhJjb2I=;
 b=ymgJMEXTuJIFyf6H8FB2ND4ULma67CwEbWwzrfW4p8uvNWQ5/7EHsRlLVAFKA9G7Vz
 rMDLlMeTlQyDD7Ne3dcO/A2PPmguaVr0ZPfecWk967k6CBRTopgPX9pZhXQbWwxl67gE
 4Z07OvVVREVSApnqgIDu1GeCdoCo4pRQF72M+qTBCL2SYcV4aS/qanB1dsYHSdvmWaRo
 5aswYAOYw/vHoAoAwGVCfFPXwEnc7fR++9vbwBdnKZ0nNxEmKcghyMvbnBht1WNFSjoq
 nQRX6oXlrFvRupsVUwj/lOqaBPAHuGpq86Nvqzc71Ra21kM2kJCWxWYeFtH6dWyTp3DA
 4LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685512407; x=1688104407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0NYvbESkfPbVA7Uj/A3Mc+DWgHjZSxUtYHePhJjb2I=;
 b=LPR2UJP9IANmoizqYpu7DgA+telhHldkUKWgTdJPer3U38Pl9oO13SVzEqB1gb9V9x
 bHD0wWD4dgWuq1DEvRLkK1BDmhaVF5SECZrN2MpBvpp1BzYh5S27UO3fT8CNOt7ET8Ui
 5EUQGl87K4XTJSK2BoTUO/cm7Lh/vJ2jY37tYj4+T6lLDra4vZGgf9cks6M7gWn1L2Ma
 z3nalmHrgryz2ETxPMSN6UMrzDT65lehXf+TbgVD31QdtLTHM+ovH3QPbOX/JCnIXMmQ
 U9SHvXWue5wZgOf0AFrXpQOILiEKxu4pSVVWFviSbJWHAlBQkKodDyUmFYJEi4fp0fg7
 x8vA==
X-Gm-Message-State: AC+VfDwrWm0Jmx2ZWxyIpGRs3yBPPkSSclFO2O7pmlflCV/2XgExqlTg
 X0A2a69jf/VnSfsF+uOkB2nJvg==
X-Google-Smtp-Source: ACHHUZ5ocjIlnmRjbuCQPj8ziVwvQVfbU+9RCM2M2hgCqy03Kql8SQauCarDkLGIrf7+Z9FiHGXRBw==
X-Received: by 2002:adf:f20c:0:b0:309:36e9:5834 with SMTP id
 p12-20020adff20c000000b0030936e95834mr3031661wro.61.1685512406922; 
 Tue, 30 May 2023 22:53:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a5d4fd1000000b003095bd71159sm5506544wrw.7.2023.05.30.22.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:53:26 -0700 (PDT)
Message-ID: <d49f59ba-ee8e-70de-4a94-5ecb7ca9dcac@linaro.org>
Date: Wed, 31 May 2023 07:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/avocado/virtio-gpu: Cancel test if drm rendering is
 not available
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230530180330.48722-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530180330.48722-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 20:03, Thomas Huth wrote:
> The test_vhost_user_vga_virgl test currently fails on some CI
> machines with:
> 
>   qemu-system-x86_64: egl: no drm render node available
>   qemu-system-x86_64: egl: render node init failed
> 
> The other test in this file already checks whether there is
> an error while starting QEMU - we should do the same for the
> test_vhost_user_vga_virgl test, too.

Reported-by: Richard Henderson <richard.henderson@linaro.org>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/virtio-gpu.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/virtio-gpu.py b/tests/avocado/virtio-gpu.py
> index e3b58fe799..89bfecc715 100644
> --- a/tests/avocado/virtio-gpu.py
> +++ b/tests/avocado/virtio-gpu.py
> @@ -143,7 +143,11 @@ def test_vhost_user_vga_virgl(self):
>               "-append",
>               self.KERNEL_COMMAND_LINE,
>           )
> -        self.vm.launch()
> +        try:
> +            self.vm.launch()
> +        except:
> +            # TODO: probably fails because we are missing the VirGL features
> +            self.cancel("VirGL not enabled?")
>           self.wait_for_console_pattern("as init process")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


