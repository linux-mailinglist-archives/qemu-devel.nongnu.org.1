Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D876D951
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJDN-000450-01; Wed, 02 Aug 2023 17:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJDL-0003ys-Ho
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:17:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJDJ-0003Fs-Ah
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:17:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso3171915e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691011019; x=1691615819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=12a28ZHmv41bGaZB1BneLFcANagUNJJm30Ta3EkFFIo=;
 b=zplWm0rfYOegCcm7yT7cGUnKw5NRcdZ/22eEWpnqwAWEkW7XvtLmaju2f9kM+YoGTz
 ue8atAH8JphGEI+MJ77v3+gKGdXWGLCD3pryVnUT4CKctBHR32tU/U3CT0q3BB5RfmfC
 Z7jVJQ2DXlXXWoT1ICH49gloIn0wOboWHGTHb3D3fMKfOW0RtbbXS5cAbeBy0g7Po18m
 wdETkFGM7GaHTz0vq0yoCL0oy1F+hptj24AgU+GBJT/KIy8KFpn8tqb9pWFWDgswG74v
 CPgCr+eL+5Mr7Nle7r+klgQPi7Ylr//rC10ANAvqGXmnaHO7nrt6w/HJ4LjWv4NTc9Ot
 7Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691011019; x=1691615819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=12a28ZHmv41bGaZB1BneLFcANagUNJJm30Ta3EkFFIo=;
 b=kAJKIdWGPvBNqr++OzumrS7wiLt7H4Zyjf0lVa5N8KuY/SpVMbyGRKLWQ2T+JBvrmj
 SnSrsV1OePlutHIKgJqFfcnjifB5zFLw7w21FfVhbd2ig4GJ27EudLBCdi752sicI7dA
 thY7tSsbzfPknN4Yb1+6HPv/BpWen3XWHkk8A0fCf4erDEIfQqAV7dxkyqdCP+AFt4NR
 rDR90veEXJzSjtID36+g0I3xI4LcY/mtmOmst5M29V/VxqaWi22NY6ckdfd9+zVu+A9f
 beS8iMfdnHER+lY8VWL7nmWZrel9v0ms8hW0N1Ytf4hG8fX0t3aXvITt+0f2xoigVSPk
 1WRw==
X-Gm-Message-State: ABy/qLY95gYSaPC/BxgpMHMppQUk6GFGmYqVNTUkNtvaOUYsKEAQ5uw6
 5ns0PX/Jt8UwKh3Vp62/cyZdSQ==
X-Google-Smtp-Source: APBJJlE2N8JPMKOP49LpktRCTyqm84mgmkBmGYbWuY5o6ZYefvauaNgGPcX0UaGuuCyt3UyTn7LnAw==
X-Received: by 2002:a5d:595a:0:b0:317:6459:e3ae with SMTP id
 e26-20020a5d595a000000b003176459e3aemr5574901wri.68.1691011019680; 
 Wed, 02 Aug 2023 14:16:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a5d55d1000000b003143be36d99sm19975190wrw.58.2023.08.02.14.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:16:59 -0700 (PDT)
Message-ID: <909d2e3d-37f0-adf1-c82c-e786cde88f82@linaro.org>
Date: Wed, 2 Aug 2023 23:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] hw/i386/x86-iommu: Fix endianness issue in
 x86_iommu_irq_to_msi_message()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230802135723.178083-1-thuth@redhat.com>
 <20230802135723.178083-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802135723.178083-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 2/8/23 15:57, Thomas Huth wrote:
> The values in "msg" are assembled in host endian byte order (the other
> field are also not swapped), so we must not swap the __addr_head here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/x86-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



