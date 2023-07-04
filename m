Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960277473AA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGggx-0002iN-1B; Tue, 04 Jul 2023 10:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGggv-0002i7-1g
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:07:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGggt-0002Fl-I7
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:07:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so46894815e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688479657; x=1691071657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GJUlZxBRV+cA1G8ZOjeuGO39D5Z4XW8EbHGB5J7MMfc=;
 b=KofAj4YPcY/8C/tmjH/5EhZRXNRIyMld0GVixBN0nfdkj4mul8A3LmsDWLK6zvhkJ8
 vvwJHlXMYBSib20gCWodKnwFcxeQ7mIjYN7eILMoOkq7nhnNtpCCfTaCFGQSAHuSYAFO
 BZhRjgIqCP9WD4u4IdZ79tqdH08766surD+83/s6hMMVY5dv33pnOmSFoUvQS7asrULS
 TZeahSjzwlFhO9bbPvyhuIi5IIy3lLveIalbdGEDgCYniROuhQk8LGne3ExECBlEowm6
 cYkznukLyPwMJzcpf3Vkye8hGFVpqNhw8qfqMcVxMrBD8HbxzLOyuOHLRZVQAbKhkZPQ
 L9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688479657; x=1691071657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GJUlZxBRV+cA1G8ZOjeuGO39D5Z4XW8EbHGB5J7MMfc=;
 b=etrRC4UzmhkesdJkNyG9gUMGZksFlZbRhZaY5X1lixubkAaJG8mVksnNLV1iMxE8bk
 qnq4rFYLgHLtQ+euBfmK++ylVtbRYPZ1f4qMGjgRsuklkbQb12e8LePCUyjJ5zX9mMSM
 wWjOYkXglyg3eReRwO10z0KRRbcNHy0QAtCDZSh3M5aG49N7mB4yT3Aeh6OBTo+uDNFC
 68FqyI+BCD0cK9pA4lHVJbuqrenz91sEkkMzzS5cJFB13O51o7kxb8Girfx7c1undIqm
 7+qg4doemOKYxq0bwqrLIbYErrrXQiLMEwLwJCOtnwSiKtZgN5bKuO63VICQkwrY9LMk
 XQLA==
X-Gm-Message-State: AC+VfDyodCrwx10+klJjQ4Ph32q3zmT0Pvr5BcSCpROgU/hkXCGnbuNN
 L4vkMp9hP4Jl7k9FyvFXlO6QiQ==
X-Google-Smtp-Source: ACHHUZ6KAyRl8kr5FGEAhfYrSv00tr/dRpvtM9lWiGANDyTpW5ArssJL4nHfQQ/XFWnOmNQH029Few==
X-Received: by 2002:a05:600c:2201:b0:3fb:a6ee:4cd3 with SMTP id
 z1-20020a05600c220100b003fba6ee4cd3mr12333568wml.16.1688479657230; 
 Tue, 04 Jul 2023 07:07:37 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b0030e5bd253aasm28448291wrj.39.2023.07.04.07.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 07:07:36 -0700 (PDT)
Message-ID: <a359bb8c-9643-3dd6-66d4-ab32e2506d79@linaro.org>
Date: Tue, 4 Jul 2023 16:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
References: <20230704133927.24677-1-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230704133927.24677-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/7/23 15:39, Avihai Horon wrote:
> vfio_realize() has the following flow:
> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
> 2. msix_early_setup().
> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
> 
> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
> allocated.
> 
> In this case, vfio_bars_finalize() is called as part of the error flow
> to free the bars' resources. However, vfio_bars_finalize() calls
> object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
> thus we get a null pointer dereference.
> 
> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().
> 
> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
> 
>   Changes from v1:
>   * Assert VFIOBAR->size and set VFIOBAR->mr to NULL to make the code
>     more accurate. (Philippe)
>   * Small reword in the last paragraph of the commit message.
> 
>   hw/vfio/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


