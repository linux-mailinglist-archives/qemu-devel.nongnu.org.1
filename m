Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5F75E386
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbjP-00006h-Ui; Sun, 23 Jul 2023 12:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbjO-00006R-Fo
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:14:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbjM-0006ZX-Ud
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:14:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso33112745e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690128887; x=1690733687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5/6sqRcuAKAaO8NdMsPk/yLj8skEuSJ5IOLQB9tAXqU=;
 b=MRffcJt9anj0c6I92Cvn+iQA+b4Ypq8LVBglFR/3FNoraYSkOjVdMfEkC0tR8nRXn0
 00xCL38Nrie7OTTgWM03vxBYaqCSzwd+cKsrrIpYAvXCEs8woZdxByE25m7lO6P5cHWu
 jD3kumljy/d+VwvKv3c6k4IvZLPX01bCTHn3VQGjumBATM1NPBIpZYTyAwPzD9/T93TO
 tQd48Vc/mQJtvmUCEw3jmsTVZ5wPtHnzMwmIVbmZpi+xpNuwz2ODfMGyX1E46FNPNxt2
 Zs3wNlt44HV0ucJM/JlY52ni+rKCfJuMXpunTarTJM1PUkUnBuDKwkfpiyZQ1ISDKAUx
 Qy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690128887; x=1690733687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5/6sqRcuAKAaO8NdMsPk/yLj8skEuSJ5IOLQB9tAXqU=;
 b=OwbInEGy8ualjUJoLvEaUBGMaLTsnvSb0dgjQWXTDE0UGpjvbIIx5b2rzoB8vmHHXm
 9o5DdGmT/MaxCvyOOVSGvtiJK1SrLzUcJql3s5q39EWNP8IavBZC0QWGGrM2EUZfeU1M
 U+vbYX6WYzXhGq8M48Bc/9ohwEYfLcFbrxo3SM076WdtkeS8kFMSfAIaw4KsL8xQ1gT+
 CgWkOXZIsJnkSZ8DNFhTVyrwqMxgcVmPuXLsY0+3e7ELxTxIRleoNqH6SpDlmo0fDIXR
 2oXzXP2V7MwKqmdEnLmSInP1q77UPc673p4N4ERqD4cZckpCkSQhLZPCpJzxBpBZwdbE
 cukw==
X-Gm-Message-State: ABy/qLaoRk1/Mbjgs4ieIA0X1TnrO5JbuI9vy2Fovj/stD7lLwtbQ3+q
 gA8PO8r/vNaA3dePPrGGPG7mqQ==
X-Google-Smtp-Source: APBJJlHjjHlTk0P50kQxF7h71EQVVwbQVqzmzS+H4EcmVpSMb7RM1aAmDV7ALW+8nSgqkwGnYSnl0A==
X-Received: by 2002:a05:600c:b58:b0:3fb:b1fd:4183 with SMTP id
 k24-20020a05600c0b5800b003fbb1fd4183mr5747250wmr.12.1690128887201; 
 Sun, 23 Jul 2023 09:14:47 -0700 (PDT)
Received: from [172.20.10.57]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a5d6382000000b00314427091a2sm9963034wru.98.2023.07.23.09.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:14:46 -0700 (PDT)
Message-ID: <ae9fc1bc-3ca6-b8dd-2ae0-319cb00611e8@linaro.org>
Date: Sun, 23 Jul 2023 17:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/14] target/s390x: Make CKSM raise an exception if R2
 is odd
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> R2 designates an even-odd register pair; the instruction should raise
> a specification exception when R2 is not even.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 6661b27efa4..2f61e879878 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -1991,11 +1991,18 @@ static DisasJumpType op_cxlgb(DisasContext *s, DisasOps *o)
>   static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
>   {
>       int r2 = get_field(s, r2);
> -    TCGv_i128 pair = tcg_temp_new_i128();
> -    TCGv_i64 len = tcg_temp_new_i64();
> +    TCGv_i128 pair;
> +    TCGv_i64 len;
> +
> +    if (r2 & 1) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }

Ideally, SPEC_r2_even would be set, handling this earlier.
Perhaps adding an "in2_ra2_E" might be helpful?


r~

