Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972AC79E045
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:55:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJlF-0002RY-4m; Wed, 13 Sep 2023 02:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJlC-0002R7-Gm
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:54:02 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJlA-0000zF-3e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:54:02 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bf5bf33bcdso103364821fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694588038; x=1695192838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=211zCmIv+vPEaED+Sp4DjaXx7DIucvF6focw/AbqiiQ=;
 b=QpegN7kwP43LjYvFzQdwz9hMPEGhLIojKqIJY9DiIJBSORR3IYE/y2pe1xqO2vpyUX
 u5b+ZwjyiQXlgzQsUr1RyMOqfv4q2KCn0gnoSezFGqRiJel5etE1V3hOJp5fNgJYRHU3
 I7H9KOuA58sS4kl8cU2rL0Ja4dWtKDHUtgsS8X+C06DD9cveoQq0PolnZIo+kc3M5wSb
 fK6aPkG8PDzD9Z2RFDOE/te3tIiHP/5/vmpGJDSW7tGxpTkKJ8y7EnOKVbc0WDmS8pFg
 sS6EkAc19zBYF0oDE5axAZfZotNt2MtEdsPu/qWivzpRP5uOQBz30gKoc0bydk39ikTS
 MIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694588038; x=1695192838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=211zCmIv+vPEaED+Sp4DjaXx7DIucvF6focw/AbqiiQ=;
 b=cnimKWkebcmWDRhmTu0nhL9r1wcwIPsjEx2A2d3Vu18eEBadQUiy1GLDwxNwEgrPQM
 PYHQuoONtPfdRVlXPCMzpEydL/eg22gKgC4JBL8UjW6x26I+Ok9B6IjEtqgIwMREOugJ
 5tHFqvbfTwHqPbRnrD7HTiAYKE3Jy34x2l0ZOMDzeaIh9Ykki602AhKg8oZ9s70QiQnK
 Cy0R/qgYuBL9qkdaT/OK3DRwRU57lFYOEWSQz0L8ncsD4iDPzpjgogWf98udNM0xVnwk
 Oiwf4mF49l2Qb3gnhfxyPV5//Y0bkD5MZjVPcToj0wbwJyzCQpBgt/23CHduUq/46Hg9
 C9sA==
X-Gm-Message-State: AOJu0YxZl4UfcAHQHCw4e34PXX5TdyWM1/wU/HShog2VZ4nnKTD7SFg8
 vlVjgDTN9yxbIx8O7BtSW6OtSA==
X-Google-Smtp-Source: AGHT+IGmXzrN8RrPxven59mFGJOecTiXK/ZGzWoT1Ckaqo3J3rB7nwndwTMyl6V015x3eVQaTTa/4w==
X-Received: by 2002:a2e:a28d:0:b0:2b7:33b9:8809 with SMTP id
 k13-20020a2ea28d000000b002b733b98809mr1235791lja.16.1694588038119; 
 Tue, 12 Sep 2023 23:53:58 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 l21-20020a170906939500b00985ed2f1584sm7845653ejx.187.2023.09.12.23.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:53:57 -0700 (PDT)
Message-ID: <b4ad0199-2df5-05ee-dde4-eb85ffb0a2b0@linaro.org>
Date: Wed, 13 Sep 2023 08:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM
 decoder block size everywhere
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: linuxarm@huawei.com
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
 <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 11/9/23 13:43, Jonathan Cameron wrote:
> In order to avoid having the size of the per HDM decoder register block
> repeated in lots of places, create the register definitions for HDM
> decoder 1 and use the offset between the first registers in HDM decoder 0 and
> HDM decoder 1 to establish the offset.
> 
> Calculate in each function as this is more obvious and leads to shorter
> line lengths than a single #define which would need a long name
> to be specific enough.
> 
> Note that the code currently only supports one decoder, so the bugs this
> fixes don't actually affect anything. Previously the offset didn't
> take into account that the write_msk etc are 4 byte fields.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v3:
> New patch to separate this out from the addition of HDM decoders.
> ---
>   include/hw/cxl/cxl_component.h |  2 ++
>   hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
>   hw/cxl/cxl-host.c              |  4 +++-
>   hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
>   4 files changed, 31 insertions(+), 18 deletions(-)


> @@ -761,26 +763,30 @@ static void ct3_exit(PCIDevice *pci_dev)
>   /* TODO: Support multiple HDM decoders and DPA skip */
>   static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>   {
> +    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
>       uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
>       uint64_t decoder_base, decoder_size, hpa_offset;
>       uint32_t hdm0_ctrl;
>       int ig, iw;
> +    int i = 0;
>   
> -    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
> -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> +    decoder_base =
> +        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
> +                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);

Alternatively easier to review as (matter of taste ?):

decoder_base = deposit64(cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * 
hdm_inc], 32, 32,
                          cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * 
hdm_inc]);

Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


