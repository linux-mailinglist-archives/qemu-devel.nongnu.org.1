Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A170B7213F2
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 03:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5cXC-0006L9-Lb; Sat, 03 Jun 2023 21:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5cXA-0006KF-HZ
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 21:27:52 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5cX8-0000Ns-Gj
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 21:27:52 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b15f091949so329981a34.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685842069; x=1688434069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8/PVqrzt+xSg8MZGMP0A6uTQ13mbx7w79tDibjgQls=;
 b=h6KCOAo41JH1LkgvEgKP9syVSqorASUD/OqB7Ge9PpTh9YGfc58RG5vtmSLCTc4/eU
 UuDWfde6y1h1v9RzmzGsQfH97tT2faFabofoSVxGHIKPraZmn9HEhpjDTeKpnFAVBR1G
 il/hq/CCXv6eLqng2oLTQ6NqNZi/hW5nHaSclUPTA6sbLB4iF22MFHgg0Y3gptB7s9PQ
 v+O2D6b3Tn+GiDdNeDoW7qk4shAnxpg0DfsD97cBffTYzFOhDdsjqzbuazIFJdxa2ms2
 xeL6M+dZTdigPDNOQIvYgkWr+3bV8vPkOcVAG47BvHwCzQlDWua7l6RyxKdokIUwOQAL
 l3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685842069; x=1688434069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8/PVqrzt+xSg8MZGMP0A6uTQ13mbx7w79tDibjgQls=;
 b=GDNXjn904n1s3k/ecq1GAWsgGArkZd4kqHibvEexwJ369B8pCln3vSFgyCsFfL9EmH
 BmOhcgzpb4Ye9wmifiFDz+J4CFLQJg/PvDNMNMCpNQiq2+3SyZJd6RYxp4Yj8dvfgsdO
 MMjcG+21z9g9qQLVGr35DS29U9KIySvvcI/tJwMXw8Y8gaKVrLhNAtqStwbxqWs3oP1W
 3bpONlGR8iiVNQI1yCUlXrNIe9Mm3khCJaBpQx7C3tcqDmKdb5X4jsSrbhMbvceFtrvW
 vt8JsBjtQAhMiIcA+F/X0oVXLIzh3imUZsJ8cVk383XVutVt4MXbtK11yK/SXLLUKrIq
 xfRA==
X-Gm-Message-State: AC+VfDyPfGGq2b13aKBIKfH2X+15aOLGbddoEhzxlgcAJ4ib2eFW+o0t
 t6tnDEbwjk51sBtZqaAb+LiXNg==
X-Google-Smtp-Source: ACHHUZ4/lYA58tou+H3s9O1CZUC8bYp+1ggRmxH6gnypOfn3csth5XVQhKz/xdPpOzdqaQ0+Fdr56Q==
X-Received: by 2002:a9d:7497:0:b0:6af:a39d:b5ea with SMTP id
 t23-20020a9d7497000000b006afa39db5eamr6703870otk.32.1685842068800; 
 Sat, 03 Jun 2023 18:27:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 v19-20020aa78093000000b0064928cb5f03sm2960798pff.69.2023.06.03.18.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 18:27:48 -0700 (PDT)
Message-ID: <4bb70c74-e002-a3d7-b2b0-edd57e9238b2@linaro.org>
Date: Sat, 3 Jun 2023 18:27:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 19/20] target/arm: Convert load/store single structure to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> +# Load/store single structure
> +
> +%ldst_single_selem 13:1 21:1 !function=plus_1
> +# The index is made up from bits Q, S and the size; we may then need to scale
> +# it down by the size.
> +%ldst_single_index q:1 s:1 sz:2
> +%ldst_single_index_scaled q:1 s:1 sz:2 scale:3 !function=uimm_scaled_down
> +%ldst_single_repl_scale 10:2
> +
> +# We don't care about S in the trans functions (the decode folds it into
> +# the calculation of index), but we have to list it here so that we can
> +# handle the S-must-be-0 pattern lines. Similarly we don't care about sz
> +# once it has been used to calculate index.
> +&ldst_single    rm rn rt sz p q s selem index scale repl
> +
> +@ldst_single        . q:1 ...... p:1 . . rm:5 ... . .. rn:5 rt:5 \
> +                    &ldst_single index=%ldst_single_index_scaled \
> +                    selem=%ldst_single_selem repl=0
> +@ldst_single_repl   . q:1 ...... p:1 . . rm:5 ... . sz:2 rn:5 rt:5 \
> +                    &ldst_single index=%ldst_single_index \
> +                    scale=%ldst_single_repl_scale selem=%ldst_single_selem repl=1
> +
> +
> +ST_single       0 . 001101 . 0 . ..... 00 . s:1 sz:2 ..... ..... @ldst_single scale=0
> +ST_single       0 . 001101 . 0 . ..... 01 . s:1 00 ..... ..... @ldst_single scale=1 sz=0
> +ST_single       0 . 001101 . 0 . ..... 01 . s:1 10 ..... ..... @ldst_single scale=1 sz=2
> +ST_single       0 . 001101 . 0 . ..... 10 . s:1 00 ..... ..... @ldst_single scale=2 sz=0
> +ST_single       0 . 001101 . 0 . ..... 10 . 0 01 ..... ..... @ldst_single scale=3 sz=1 s=0

Wow, that's hard to follow.  How about

%ldst_single_selem    13:1 21:1 !function=plus_1
%ldst_single_index_b  30:1 10:3
%ldst_single_index_h  30:1 11:2
%ldst_single_index_s  30:1 12:1

@ldst_single_b     .. ...... p:1 . . rm:5 ...... rn:5 rt:5 \
                    &ldst_single scale=0 selem=%ldst_single_selem \
                    index=%ldst_single_index_b
@ldst_single_h     .. ...... p:1 . . rm:5 ...... rn:5 rt:5 \
                    &ldst_single scale=1 selem=%ldst_single_selem \
                    index=%ldst_single_index_h
@ldst_single_s     .. ...... p:1 .. rm:5 ...... rn:5 rt:5 \
                    &ldst_single scale=2 selem=%ldst_single_selem \
                    index=%ldst_single_index_s
@ldst_single_d     . index:1 ...... p:1 .. rm:5 ...... rn:5 rt:5 \
                    &ldst_single scale=3 selem=%ldst_single_selem

ST_single          0 . 001101 . 0 . ..... 00 . ... ..... .....  @ldst_single_b
ST_single          0 . 001101 . 0 . ..... 01 . ..0 ..... .....  @ldst_single_h
ST_single          0 . 001101 . 0 . ..... 10 . .00 ..... .....  @ldst_single_s
ST_single          0 . 001101 . 0 . ..... 10 . 001 ..... .....  @ldst_single_d

LD_single          0 . 001101 . 1 . ..... 00 . ... ..... .....  @ldst_single_b
LD_single          0 . 001101 . 1 . ..... 01 . ..0 ..... .....  @ldst_single_h
LD_single          0 . 001101 . 1 . ..... 10 . .00 ..... .....  @ldst_single_s
LD_single          0 . 001101 . 1 . ..... 10 . 001 ..... .....  @ldst_single_d

# Different unnamed argument set -- there is no index for repl.
LD_single_repl     0 . 001101 p:1 1 . rm:5 11 00 scale:2 rn:5 rt:5 \
                    selem=%ldst_single_selem

This is similar to how I handle similar situations in SVE, e.g. PSEL.


r~

