Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E29744C63
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFq7C-0006DZ-6B; Sun, 02 Jul 2023 01:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq79-0006DL-9q
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:59:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq77-0001pH-Qg
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:59:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso28424985e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277552; x=1690869552;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Zcn2sPf92aZ5ta3EKbYl31TdeoWcWKFwlfTOFzjlCk=;
 b=OH+zpABA1qbeSqSEXC2eUEbuYhizPAY8CIdBOCeT8MT3cX+GYjVfGwFw5bXvaenjed
 TECQa8dlBBDuiBwYcUcodiZvH52o+g1nRd/s7aQHAi0RGdS0yfpiGHTJLw8rSbMTZalb
 0r1DHgqXorfgk7CYNLkafzv6IV7KHOcowcoWQQ9HAmdUIGVdPa9xrmHOMbKDlNA9TyLi
 oNTIIR3TTiuE2uBsDHVqW30VNmcSrDhcMvuvr2Di8fpMfOHVWM5UTMBM/E/rPRRGJ+Nc
 L/uDqA7Q0tKrW4lmJ9y20vN7dORD7DHxrLuCvHlmk3buXlgft+UCDA3Dj1CC0ra1xO1h
 Z3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277552; x=1690869552;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Zcn2sPf92aZ5ta3EKbYl31TdeoWcWKFwlfTOFzjlCk=;
 b=hUD2ChkPT7MVGXHwa8I51z3aS+/phJ/HCyL1xyEZWVpKSb/nTrSe7OSWT77xa1RXHH
 Zcj+7QMpsUDineYBDmA3XHbTBYZlN0Kmafpv15f4tZdoZOWRsp07gtEFxO4EPlabcW5H
 FnbaaemTmBy9Wg5Dij1i7nRlpKsJof7pC1mJLiCMMz11jua6MiQd8FKCMdQzF69oxlkB
 yzKQtyLMNKCFqw3sts74VVzb/FnoZI6ivPYR9f/2HDpa84nQgNpgsuZ3iGzOhi5LOMR0
 wpBeauXqDWXffnwaNtmy83+eu13sHB1kWpdwOLwLF6myq0gnP9KRtGE8m2F0rC+91r9J
 rzkA==
X-Gm-Message-State: AC+VfDx5LzmzZes/1hJO+rxknEoaewwHngjdTHghLLLGy1k6vmateyYG
 c6fX6wCFWj8K4dU4Sbb94vS7Rk6UdBpZgCQ1dYOuUg==
X-Google-Smtp-Source: ACHHUZ4MDWmidSTnNS4Un0fLRlCU/fF1hRyFdxekcb74cEPyCqIOd/HdwfvpZa+3V1JZeR0VADPJ9w==
X-Received: by 2002:a05:600c:8606:b0:3fa:125c:8d65 with SMTP id
 ha6-20020a05600c860600b003fa125c8d65mr11011123wmb.3.1688277552054; 
 Sat, 01 Jul 2023 22:59:12 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 c13-20020a7bc00d000000b003f735ba7736sm23743916wmb.46.2023.07.01.22.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 22:59:11 -0700 (PDT)
Message-ID: <4ef7e66d-d473-5aae-6a72-2c013c047e06@linaro.org>
Date: Sun, 2 Jul 2023 07:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/46] target/loongarch: Implement xvaddi/xvsubi
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-7-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/30/23 09:58, Song Gao wrote:
> @@ -1315,3 +1315,17 @@ xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
>   xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
>   xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
>   xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
> +
> +xvaddi_bu        0111 01101000 10100 ..... ..... .....    @vv_ui5
> +xvaddi_hu        0111 01101000 10101 ..... ..... .....    @vv_ui5
> +xvaddi_wu        0111 01101000 10110 ..... ..... .....    @vv_ui5
> +xvaddi_du        0111 01101000 10111 ..... ..... .....    @vv_ui5
> +xvsubi_bu        0111 01101000 11000 ..... ..... .....    @vv_ui5
> +xvsubi_hu        0111 01101000 11001 ..... ..... .....    @vv_ui5
> +xvsubi_wu        0111 01101000 11010 ..... ..... .....    @vv_ui5
> +xvsubi_du        0111 01101000 11011 ..... ..... .....    @vv_ui5
> +
> +xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
> +xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
> +xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
> +xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr

Rebase error?  It looks like you've duplicated the xvreplgr2vr patterns.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

