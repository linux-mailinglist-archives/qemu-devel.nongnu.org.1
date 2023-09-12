Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381A79D620
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:21:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg68D-0002nG-Ng; Tue, 12 Sep 2023 12:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg68C-0002mt-0d
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:20:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg686-0003dI-FI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:20:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso4898560b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694535645; x=1695140445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ausoj2mjmEyJFXuYmIC1Cq+n4M7yTOf98uQU4qPXRIA=;
 b=rNFFi7ATOSEzkOjkMCI3KZIApzJ7imeKsuSG8B59lxHLtFdN1tx6ttWWT/arAVZ7YR
 ECYgbgPpCccTZD4QbzoXcaFR9QDM5GkO3hsdf5XsUNCYP8mzGDWthWWE8av5J3SinhNy
 u0yeJ8b9IKAUprOp3+z41cllrH5axn8bPQV4TzLeU5je+0WInhY8fLwwukw4GyW9MN5Z
 NBBn1JeNtEJh22T2umDw2FAJq+HrKJKcSliPntBkwpy19SaAB15RT5V4EEMukAbl62+O
 841p/6t2XT8BnOBirJKuVhbE59rrlJtAkYmbZFYvTPG6QXzybythOB9PwaZv1UX5lZi8
 93WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694535645; x=1695140445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ausoj2mjmEyJFXuYmIC1Cq+n4M7yTOf98uQU4qPXRIA=;
 b=h30gE6waSX4aH14agjSPc3binF/J3jDgMCXJpSa2azUNBj2s2MawGM0qt1SshlC8Um
 QUmmovhI9WCfMXOuP/7A5Kb5b5oGYfnvAd2F6zeix143OzDACH8a0R/btqEDdJceWuYR
 DJ4Ihc2YVVCYCijMCEikoAIdZOCFKIOILTnkISF0WEiesD16hHRAkvOfdYxtDp3UiG2K
 MDKTZ7quiKiQn8f5Kx6dYYWPEQF8+LJMFMZPH6s0CFY4RgBIgyPgxtom7atAgJJ4xXao
 klKUwzCDFZTyesFH3XIJghfQ/0VTIXhhmxu0VixDuEKVOjmVlBIABE+E39cBeVvQI/5L
 00yA==
X-Gm-Message-State: AOJu0YwPxhpGeRBRUyAyqxkYZ4HB12hUzl68MGv+hKcl5IvY1I2OlcKg
 90eBmmw3zezAAUq9dhCwnIodvvBFAdM3HO9lSB0=
X-Google-Smtp-Source: AGHT+IFsMUoJPqFoB+MSYRK0T99oUhKlXcY5qlLiFYnPZcliU69vZfyPGSOmJt0VLwHpaFI7/rKSmw==
X-Received: by 2002:a05:6a20:6a03:b0:153:3d8f:cb24 with SMTP id
 p3-20020a056a206a0300b001533d8fcb24mr14012362pzk.37.1694535644769; 
 Tue, 12 Sep 2023 09:20:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 s10-20020aa7828a000000b0068a0922b1f0sm7517883pfm.137.2023.09.12.09.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 09:20:44 -0700 (PDT)
Message-ID: <e3405db6-8670-a764-e584-feb2dca9437c@linaro.org>
Date: Tue, 12 Sep 2023 09:20:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 51/57] target/loongarch: Implement xvinsgr2vr
 xvpickve2gr
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-52-gaosong@loongson.cn>
 <2b3210ad-a8ca-5efd-d6a2-7639e6e5ad7a@linaro.org>
 <1eabb2c6-510e-76c9-62b2-7bac8213f693@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1eabb2c6-510e-76c9-62b2-7bac8213f693@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/12/23 02:09, gaosong wrote:
> static bool gen_g2v_vl(DisasContext *ctx, arg_vr_i *a, uint32_t oprsz, MemOp mop,
>                         void (*func)(TCGv, TCGv_ptr, tcg_target_long))
> {
>      TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
> 
>      if (!check_vec(ctx, oprsz)) {
>          return true;
>      }
> 
>      func(src, cpu_env, vec_reg_offset(a->vd, a->imm, mop));
> 
>      return true;
> }
> 
> static bool gen_g2v(DisasContext *ctx, arg_vr_i *a, MemOp mop,
>                      void (*func)(TCGv, TCGv_ptr, tcg_target_long))
> {
>      return gen_g2v_vl(ctx, a, 16, mop, func);
> }
> 
> static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
>                      void (*func)(TCGv, TCGv_ptr, tcg_target_long))
> {
>      return gen_g2v_vl(ctx, a, 32, mop, func);
> }
> 
> TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
> TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
> TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
> TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
> TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)

Looks perfect, thanks.


r~

