Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70017734D0B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9to-00067w-G6; Mon, 19 Jun 2023 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9tj-00065X-Gt
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:06:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9tg-0001Fp-J9
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:06:02 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-987c932883bso324384166b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687161959; x=1689753959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0l5GOaHWYG0L0zKQlFk/9TlrxBHtaYkVp2Z4p8EEnY=;
 b=D2D2iNFhbRpX0HCq0mM24zFaSrXA5S4oTEbSnp3xl9XIFMEIMZrARRa/0WtoS69MMh
 1wCfOucya6V4etrMO3VlUlxlxm5Jdt+6QyFezeprGFibc3yewc6KQ19L7QNSj+eR1Vnl
 garbCXPb4vLQ1TxsL/bk+tkIm2aGcTe8PQw79GdckIT1XMq9gl7r6GuE8KEveZUxN2Jr
 6qwY5Au0hjpaiRe0mc2svwzZjlj0req7r+uyR+pBu9ZYVWZVefARZyJAh2mgqIgZ+VNw
 Hnq7Kfh1DeMfZ7HGRA4cOqFMCTU1lrXjxuSvz0r4SLQtyxYEFQVd+RlexIBcddoS4mVa
 j6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687161959; x=1689753959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0l5GOaHWYG0L0zKQlFk/9TlrxBHtaYkVp2Z4p8EEnY=;
 b=FKK5fhEJBtRp13KweBsbvpNlYry/PHrsVOlNrY14MzEWmosY/AWU1PaCMRK+5u8F36
 LpWGTjI+AxGjlVSvXDpTRUL1Dw+7izx5fNsLwrESnvpBro1Hm5yxBQNz0Gbs0754850R
 by9quL1ysiMnHCp26AKCATiWRI5Y2flTsbt0qGXgyIs7nalXcsJ/0/SizgNEvA+IGQdi
 X40zzhIVfl0jMcXywy5LQISBxWulHNAKC+/KsF+n4C8cSRyQ6YyuXW4SJtV1URLDS6Hq
 L0zeM9xDPvEB0qhkPbQCfdiSYlx3KwKVsxPwOcGj5B63MjUz4r32cC1vbAPHQycQuD3o
 bcZA==
X-Gm-Message-State: AC+VfDzxrx14CSsjJDeQSES/bEmHyj/1OyrduZYpvsZaFpiX9gsZSdeK
 xHuIyx/kOIVue8LB0eNCONQLYg==
X-Google-Smtp-Source: ACHHUZ49YEn+5itFRHuTll43hZznxgato+HMnQvuoh8l0WLgNI4U3K8ec4WhybOgDvxxrSKxEeu9Rw==
X-Received: by 2002:a17:907:1c95:b0:987:15ee:4399 with SMTP id
 nb21-20020a1709071c9500b0098715ee4399mr6970592ejc.29.1687161958726; 
 Mon, 19 Jun 2023 01:05:58 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 a12-20020a170906670c00b00988b2050f47sm964912ejp.20.2023.06.19.01.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 01:05:58 -0700 (PDT)
Message-ID: <73329920-8d4c-dd55-2a09-1167b37a1903@linaro.org>
Date: Mon, 19 Jun 2023 10:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] hw/dma/etraxfs: Include missing 'exec/memory.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230619074153.44268-1-philmd@linaro.org>
 <20230619074153.44268-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619074153.44268-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 6/19/23 09:41, Philippe Mathieu-Daudé wrote:
> The 'fs_dma_ctrl' structure has a MemoryRegion 'mmio' field
> which is initialized in etraxfs_dmac_init() calling
> memory_region_init_io() and memory_region_add_subregion().
> 
> These functions are declared in "exec/memory.h", along with
> the MemoryRegion structure. Include the missing header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/dma/etraxfs_dma.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

