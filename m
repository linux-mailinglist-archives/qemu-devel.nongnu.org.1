Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE1879F8D0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcqq-00082e-5A; Wed, 13 Sep 2023 23:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcqo-00082K-0W
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:17:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcqm-0000J4-85
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:17:05 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c35ee3b0d2so3584305ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694661422; x=1695266222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mt0VwCPBSm/MnC5/2WCLIhtpuysfPOVVgcKtn8AQ9co=;
 b=NTSDj/9NHkmSy0WfVYby4UyfYSrpv/jMPJ/yFUdoetplQcFG45/U7KYb9RdutrLyPM
 iCgPxfZxQKQnw6gtstxNcrXbR6mjQZaRDIElA13pEdsDcKIA1o5Un0C0armlOo2Kggat
 wPMP3IjCbqB0C+qWXmtW4IQ/n9kmb9dmGuCgR0ItHQz7b7ywsaJ9F938mXoKjdFf1Xpl
 x36Qrs36kT7FHxj5+/ikED8x6Tafi25xbvG6JKPqVVYZH6WR5eEmgmgwAv42TN8cMTaA
 qbUDVaEbIPWRynVVFpBzZiv6LwTOBxUm/wfZ0Vyou9x7NyEZ22UCiMCqiOxpiplcm/gg
 UNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694661422; x=1695266222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mt0VwCPBSm/MnC5/2WCLIhtpuysfPOVVgcKtn8AQ9co=;
 b=ilHZEZK/6NqNwQS/3Pl5K9xISuDlgwLD19i6IggYs+MVmHR5zgmjIGJqKnZO5yuDxl
 Qw9t/BKXt0qF+R/+P7Nnf6Y5/1gzmO8vJ2OfIw9zkDvXRnKr2Oce0g8cVb87wfVjtyuq
 fE4zC50WvTZUVwPFpvoE5d4JGPQVK+Ijtil85RmCAAkfy27xRRK6tervVerRB7DWzgvg
 r9wFup78NF20bww17DjJLfNIEA0PUhtDXu9U+osfiXbpDrB0ER2X0CkSJ8C5Ha7ErPNc
 iJ4zNDqwj8TjcsCY54IZNtqPQe6keyxx8EUX4gIdAPPhuZWxX9T6BpFunKWzVmN5r9WX
 Te/A==
X-Gm-Message-State: AOJu0YwuLTt408g2p+TAe9UqQnoOhiN6cKr6aNOo6F8KElvfosba8cCR
 OwEpvh8PmDn1YpbrvuMuegq8WA==
X-Google-Smtp-Source: AGHT+IGVqFnnMEqu7uFIUhFhDs1PxCOhIrPFSknHtWDm7BvC1/UmasCd57iqsiLvSXXM2pNHVDX5Rw==
X-Received: by 2002:a17:902:8210:b0:1b8:6cae:4400 with SMTP id
 x16-20020a170902821000b001b86cae4400mr4077606pln.37.1694661422020; 
 Wed, 13 Sep 2023 20:17:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a1709027d8400b001c0a4146961sm354425plm.19.2023.09.13.20.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 20:17:01 -0700 (PDT)
Message-ID: <1e287c3c-0507-a176-5eb2-7ab43ae6b563@linaro.org>
Date: Wed, 13 Sep 2023 20:16:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 52/57] target/loongarch: Implement xvreplve xvinsve0
 xvpickve
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230914022645.1151356-1-gaosong@loongson.cn>
 <20230914022645.1151356-53-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914022645.1151356-53-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 9/13/23 19:26, Song Gao wrote:
> +static bool gen_xvrepl128(DisasContext *ctx, arg_vv_i *a, MemOp mop)
>   {
> -    int ofs;
> -    TCGv_i64 desthigh, destlow, high, low;
> +    int index = LSX_LEN / (8 * (1 << mop));
>   
> -    if (!avail_LSX(ctx)) {
> -        return false;
> -    }
> -
> -    if (!check_vec(ctx, 16)) {
> +    if (!check_vec(ctx, 32)) {
>           return true;
>       }
>   
> -    desthigh = tcg_temp_new_i64();
> -    destlow = tcg_temp_new_i64();
> -    high = tcg_temp_new_i64();
> -    low = tcg_temp_new_i64();
> +    tcg_gen_gvec_dup_mem(mop, vec_reg_offset(a->vd, 0, mop),
> +                         vec_reg_offset(a->vj, a->imm, mop), 16, 16);
> +    tcg_gen_gvec_dup_mem(mop, vec_reg_offset(a->vd, index, mop),
> +                         vec_reg_offset(a->vj, a->imm + index , mop), 16, 16);

I think this isn't right, because vec_reg_offset(a->vd, 0, mop) is not the beginning of 
the vector for a big-endian host -- remember the xor in vec_reg_offset.

Better as

     for (i = 0; i < 32; i += 16) {
         tcg_gen_gvec_dup_mem(mop, vec_full_offset(a->vd) + i,
                              vec_reg_offset(a->vj, a->imm, mop) + i, 16, 16);
     }


Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

