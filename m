Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D29E72C2D2
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fmE-0004GO-86; Mon, 12 Jun 2023 07:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8fm6-00046P-So
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8fm3-0006Yt-EN
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:53 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30fbf6603d2so1021006f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569510; x=1689161510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xnz5GxnQehEX8IMPfxH8j1jlI1cczDW0P4EZmSJZ8Vk=;
 b=vYo2EwGJhIjx8CC/LIQ236p2N2ZzuaONcwQ7k2VPicB4VQpT39k6fX82eQA3eU2Qdy
 4WxZDieDcjrIi1fXWGxjaG82Tgzt4LKvIKs5M1McVMhJS7RyMuiQ/oGeYo90b84uLnEh
 Kt5Zjs7WywUb3soIaUNpbmCoTByhq4E8uC9CkehmwjxZ8YJXj8spub8iFMRTFA8W1AZP
 YsumBH2hpJZAnyk51eaahi57T1kdB47jnN7sj0J1HVXMA/0S5/QkbbgyWra/7U0zwTaG
 A7c+uc7C1FYa4FU2hbLErAP0d2/alQ+4p+JXuPSexTlKOOkzieE0YzeTbmsgSUBWhZH7
 44zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569510; x=1689161510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xnz5GxnQehEX8IMPfxH8j1jlI1cczDW0P4EZmSJZ8Vk=;
 b=fApXW6NWYI9taLarLl4DFwSSBfBohtfeYIVlAvKhW9imwCGT+zz844SwH/PWaHPWBA
 6IR3/5LnP6sPlLSQg3g3d9+GwdFpn0grSfK2ARh3Xfss+reLN5MvJOijRgu1pWOSHWdS
 tPYPikz7bC/UkUgeDgaLKXK/iydg3IjIk51vNuFulsusEVUP8E8Gr5MgPkgnafS1K3UR
 gzDqZuCWMTB7tGfBEAdz6kZL6OstdIMwRc4GuxxSKDA/Xgcy+cOHK3tQosFB9lcRQTkv
 6VnHU14cwrcLfY/8wws8pVxS5gtjn00pXAxyV66ebsiKodQeyNUu55H/GvH787WQoMeT
 d9Lw==
X-Gm-Message-State: AC+VfDx+xwvITbNeHzxZBNGsWgwB9ucx9YTCOUC9ZJcZcr+M+4PRFvKO
 jwrkK9BNGJeUSs0F2E1xdhfGqNmjmzHT4DNe/qtKKg==
X-Google-Smtp-Source: ACHHUZ56SjehY20oIU1QkPYtOsdii2s8gtXvXgwUMVq3bnEORPbqOB4cEtVXd38o2YMtULoIoo/aTA==
X-Received: by 2002:a05:6000:51:b0:30a:d5e2:dc6f with SMTP id
 k17-20020a056000005100b0030ad5e2dc6fmr4244478wrx.21.1686569509969; 
 Mon, 12 Jun 2023 04:31:49 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 v5-20020a5d43c5000000b0030abe7c36b1sm12108755wrr.93.2023.06.12.04.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:49 -0700 (PDT)
Message-ID: <e6b98830-4e4e-d117-d6c3-7e0fe525362d@linaro.org>
Date: Mon, 12 Jun 2023 12:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 11/15] hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM
 property
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-12-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-12-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> Introduce the property in anticipation of QOM'ification; Q35 has the same
> property.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/i440fx.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)


> @@ -51,6 +50,7 @@ struct I440FXState {
>       /*< public >*/
>   
>       MemoryRegion *system_memory;
> +    MemoryRegion *address_space_io;

"io_mem" like the property? (this is not an AddressSpace)

>       MemoryRegion *pci_address_space;

(pre-existing misleading name)

>       MemoryRegion *ram_memory;
>       Range pci_hole;


