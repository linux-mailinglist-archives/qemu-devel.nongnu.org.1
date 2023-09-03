Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD6790A6E
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 03:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcbZs-0005B8-Tk; Sat, 02 Sep 2023 21:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcbZr-0005Ax-9C
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 21:06:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcbZp-00018W-4k
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 21:06:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so1661445ad.1
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693703215; x=1694308015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=99QoFQGddQ1LfBftUY7V5d8dtZGVfGbOPyPzo8tuG8Y=;
 b=GDTGbR9UIfHifq4UloD0OrZVQxuyNvWz0kwe7CfooC70w0zlvH+W9ZxtsqJCUmXcFj
 brQb03HsFBAHdSsab0qb9BxiRyMvCkGqRbFmxJsQL60jsBdxsg67TsxfbymA2CuvQxWU
 Cld0BFKE7ZlW9dvndoJOU+ov2JzRimZYDkF4xtHeeebF4zwX3eFhlBxrJaKL5KjB8vEI
 qoNlIhFz/f+T/xnp6sLDrvf3hRhjV8KNpTAdL/euWuh0dezNjHTVFy2lFD/EWbvdIdm9
 4pBPjBVlPWCMKwTkaZIW0laUJQAG+AgaXXQ4VKb2JFCBMhrZ+TfbFVvqhlsxi9C7MwQd
 CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693703215; x=1694308015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=99QoFQGddQ1LfBftUY7V5d8dtZGVfGbOPyPzo8tuG8Y=;
 b=WPnkKCLX0RqlYqRuCM5qWz5/bMXmYPGQqHBbm4AFnlZlcjtc4+egVspB4b4ond1hKW
 KUfLY3cZ7nzmgtDNCGcfen318bWRlhRRR5VO10xBRgWY5coX+strHnv0CpyBsf+COF9D
 bSh419nvYxSeg30L+YDvBAbSKZazZEjrW+yoyjHRpM8QCsMmFMfoKmrBM6s1eiD3ZO/e
 UwIBEWCAVumiphjlRCPcbkmMWBqkxnZ3yZu8RA33y3+hLAn7J2gSgqoyv+B5GSSIVN3m
 ZOkDLuk6tKUysWS6m3e8eoY2BZslY7JqX+MH3yLBjEMTs9NLeFSPIhGb3kHRb4WnX8ku
 mbAA==
X-Gm-Message-State: AOJu0YzvuMwxszLDEYnRz6Q36xaz7uxavrzVvEs0g0HQNUTOMx/8GN5Z
 3m3Xlahs+CFcsXJQC9jrJXU8kRh+tEXvcWwHZSE=
X-Google-Smtp-Source: AGHT+IFEBWewB9FXiLDh4qfqpvSmfuXfeWx8PRhvTgZejyuy52X/5reGo4EKOz3diFnl9IY7k3CrRg==
X-Received: by 2002:a17:902:ecc8:b0:1c0:cbaf:6954 with SMTP id
 a8-20020a170902ecc800b001c0cbaf6954mr8533669plh.25.1693703215391; 
 Sat, 02 Sep 2023 18:06:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902eb4400b001b801044466sm5128325pli.114.2023.09.02.18.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 18:06:54 -0700 (PDT)
Message-ID: <fdd190b9-2d56-a888-d6b4-da9534a38339@linaro.org>
Date: Sat, 2 Sep 2023 18:06:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/16] tcg/loongarch64: Implement 128-bit load & store
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230902050415.1832700-1-c@jia.je>
 <20230902050415.1832700-17-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230902050415.1832700-17-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 9/1/23 22:02, Jiajie Chen wrote:
> If LSX is available, use LSX instructions to implement 128-bit load &
> store.

Is this really guaranteed to be an atomic 128-bit operation?

Or, as for many vector processors, is this really two separate 64-bit memory operations 
under the hood?


> +static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi,
> +                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
> +{
> +    TCGLabelQemuLdst *ldst;
> +    HostAddress h;
> +
> +    ldst = prepare_host_addr(s, &h, addr_reg, oi, true);
> +    if (is_ld) {
> +        tcg_out_opc_vldx(s, TCG_VEC_TMP0, h.base, h.index);
> +        tcg_out_opc_vpickve2gr_d(s, data_lo, TCG_VEC_TMP0, 0);
> +        tcg_out_opc_vpickve2gr_d(s, data_hi, TCG_VEC_TMP0, 1);
> +    } else {
> +        tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_lo, 0);
> +        tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_hi, 1);
> +        tcg_out_opc_vstx(s, TCG_VEC_TMP0, h.base, h.index);
> +    }

You should use h.aa.atom < MO_128 to determine if 128-bit atomicity, and therefore the 
vector operation, is required.  I assume the gr<->vr moves have a cost and two integer 
operations are preferred when allowable.

Compare the other implementations of this function.


r~

