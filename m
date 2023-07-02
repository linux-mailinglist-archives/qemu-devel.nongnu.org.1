Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF0744C67
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 08:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFq8X-0006xJ-3R; Sun, 02 Jul 2023 02:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq8V-0006x6-0l
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 02:00:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq8T-0002E5-FM
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 02:00:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2805826f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277636; x=1690869636;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkJFMstPob2NMUds67l9IydvxkoD46FkOiU78BnM1Ek=;
 b=czniHlB8eaJN/uXMG8HEDiLgjPTZQhxuEa3xurc1apODgjMRtq/pxd9bVsDfxpiBZH
 EYV9229oE6PtqKAJMMeYpNeymVY9dIeoeP1HqVnmbn6jKCFSLHXN/q9Td3geksx8Isux
 PF43UVNhrWqZXRnC9MUHAqdwBdTNd5IsEFnWUSpPr56ROSS0e5UZ6aIJ1JBGAC8buqql
 d6CvERo3J+kXtAXOsfF6zmdB4SkszSikvLstRN4ioc7htwQ9SFL/JcPJbfBcJq0sC4Gh
 J9MUPB6S0QxIaAZ/OuBOhlSbTRBHqroOFnmzEdLcBco7rODh5J5zUsiqBgYmvosnNbJT
 rXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277636; x=1690869636;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkJFMstPob2NMUds67l9IydvxkoD46FkOiU78BnM1Ek=;
 b=hzgxYMoql3g5zscPJR/b9jpYU6x7mkMOd4F098SGML2s9SelasB7WMQizG61fASr1V
 RSIsx0jBr8XjqDy4uNfKjUPMwTN2BKq8UCkWxZsAo3V7PfSZBazugj0Q9PkVR6+haa0M
 gROcvMH5sbw9taEHziboP3RSvzjTijYAAou7IeraDd62TISkMhI4mnJN2RjBEcpjmsCA
 m+v6Yo51VlGnP8HCOe+ecBn5Xo5hROF6EDeRoQCdny9KbOwelY6q823rROe5vwmHo1fV
 MudCIDs+slqnukM5dQts5vDaAv3gqZ0wXH7w9SW4m6ChTrME3URkhQjid2a5r0TSrrdR
 21Lw==
X-Gm-Message-State: AC+VfDzKyrcUuQpx0yVNL3MRxt5nZMJa4NNbJFaHYWEE9J646urzCbuo
 KA6U0dDXR2DgTynZT7oyL8cQTvBnt9ORdIWKnFnAKw==
X-Google-Smtp-Source: ACHHUZ5FT/gLuA8R8YLUcY/I1HQR0PnUwrvvh5gBka9Z7i7W/4lXp5+tWCeMP82YCov7gTfDlsxndQ==
X-Received: by 2002:a5d:4948:0:b0:314:ebc:1471 with SMTP id
 r8-20020a5d4948000000b003140ebc1471mr10688282wrs.27.1688277635672; 
 Sat, 01 Jul 2023 23:00:35 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1c7911000000b003fbb9339b29sm8598814wme.42.2023.07.01.23.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 23:00:35 -0700 (PDT)
Message-ID: <eab94c6e-82fb-2ecc-4878-f5952c58d823@linaro.org>
Date: Sun, 2 Jul 2023 08:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/46] target/loongarch: Implement xvneg
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-8-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
> +++ b/target/loongarch/insns.decode
> @@ -1311,11 +1311,6 @@ xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
>   xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
>   xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
>   
> -xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
> -xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
> -xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
> -xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
> -
>   xvaddi_bu        0111 01101000 10100 ..... ..... .....    @vv_ui5
>   xvaddi_hu        0111 01101000 10101 ..... ..... .....    @vv_ui5
>   xvaddi_wu        0111 01101000 10110 ..... ..... .....    @vv_ui5
> @@ -1325,6 +1320,11 @@ xvsubi_hu        0111 01101000 11001 ..... ..... .....    @vv_ui5
>   xvsubi_wu        0111 01101000 11010 ..... ..... .....    @vv_ui5
>   xvsubi_du        0111 01101000 11011 ..... ..... .....    @vv_ui5
>   
> +xvneg_b          0111 01101001 11000 01100 ..... .....    @vv
> +xvneg_h          0111 01101001 11000 01101 ..... .....    @vv
> +xvneg_w          0111 01101001 11000 01110 ..... .....    @vv
> +xvneg_d          0111 01101001 11000 01111 ..... .....    @vv
> +
>   xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
>   xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
>   xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr

Ah hah, the rebase error gets fixed in the next patch.
This should be squashed.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

