Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431E786F57
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 14:45:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ9hC-0006Aq-ET; Thu, 24 Aug 2023 08:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ9h8-00066E-Gn
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:44:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ9h5-0003nZ-Kc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:44:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so3024420f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692881050; x=1693485850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZABzKcgIyiiTBAbagah8P6w9MrqGPaKlWQZ/GD3zX7I=;
 b=nOfWTGdeZmS8aTCKP40/qiA7ktOwSHgudcMds4nZkaByTctoDC/DNjaMcPGrIgtUJc
 TwbXfkqdaPtIZvS0x1VRZP6qw4LEVLWjtNG0Kq15MCm9Jda7gAJf/90dihefmfICFltm
 uGNPl2gxczpeY61SKWwIpVyceiEZGx+IrcTAO14bf2jWgoOv1kj3yiIG6IPzEDqhgb5o
 d/CzjST1bfVIKJwCkW+8+mwXvI1N46a5SUi4VKGsEL5ceA/KQimMqbxv0mNPJboKU2sA
 HM4fQ4W/NKK4clRA/z+pJ5u0AJrc/L7MYfMqQQE0DrXx2QERPo7zFEP0F584LOn9lxZj
 9pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692881050; x=1693485850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZABzKcgIyiiTBAbagah8P6w9MrqGPaKlWQZ/GD3zX7I=;
 b=AGInx4u9e2/+FqmWlRlFDH45GLlzTLEWY5ZpDny56UcAq9X6ZV+O6IJHwZNygEhVDB
 U1Aa3HPSL39qjpB1QMf49kirmR3QRbP+pmNikkl+VzX0NVtHPgAblCwGqvDHSWsDAnlM
 r7lS6t/zcmYCkFVaQdWJt/Ud9f3jIncLK1KWMLvlAyR1a3HoxxkZcu3Xq7vYgwrCee33
 ZKD2m7o3BGLi34ymIRKE45r5J0Z1GqZU0SJYpsxSFNZvlGDtg/M84pgTce+r7UTkFkAV
 RK5pOZdaKipA7C9ZFjXHAJCZqt+XEVeU3eng3MnwjuhIwlVJA8Z2t6U0eaxmTz0PzP6U
 VlBw==
X-Gm-Message-State: AOJu0Yy7cgRSwRYWfImfE/Xvgwv/m+eewM1nn8SoeAp8U9u74ejH9kwT
 pIrHLWznRWnhfvKIr3Xk+X/lGg==
X-Google-Smtp-Source: AGHT+IEM0NfDosO39i3ykOaSbtynNVUc3JdTDh+pl75v0hIlMRwsMDs/ryu6lw3DwjCCOyv/m89FsA==
X-Received: by 2002:adf:fd4e:0:b0:313:ef08:c83b with SMTP id
 h14-20020adffd4e000000b00313ef08c83bmr10610886wrs.56.1692881049891; 
 Thu, 24 Aug 2023 05:44:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 y17-20020adfe6d1000000b003176eab8868sm22124972wrm.82.2023.08.24.05.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 05:44:09 -0700 (PDT)
Message-ID: <556b1036-fa1c-f207-6ce6-a9cf22805e6c@linaro.org>
Date: Thu, 24 Aug 2023 14:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PULL 1/2] hw/nvme: fix null pointer access in directive receive
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <j.devantier@samsung.com>
References: <20230809133909.45818-4-its@irrelevant.dk>
 <20230809133909.45818-5-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230809133909.45818-5-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 9/8/23 15:39, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> nvme_directive_receive() does not check if an endurance group has been
> configured (set) prior to testing if flexible data placement is enabled
> or not.
> 
> Fix this.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1815
> Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
> Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index d217ae91b506..e5b5c7034d2b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6900,7 +6900,7 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
>       case NVME_DIRECTIVE_IDENTIFY:
>           switch (doper) {
>           case NVME_DIRECTIVE_RETURN_PARAMS:
> -            if (ns->endgrp->fdp.enabled) {
> +            if (ns->endgrp && ns->endgrp->fdp.enabled) {

This patch fixes CVE-2023-40360 ("QEMU: NVMe: NULL pointer
dereference in nvme_directive_receive"). Were you aware of
the security implications?

Too bad we hadn't committed "Fixes: CVE-2023-40360" as that
would have helped downstream distributions cherry-picking
security fixes ASAP, since our stable is not that frequent.
At least the commit has the 'qemu-stable@nongnu.org' tag.

>                   id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
>                   id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
>                   id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;


