Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E278E32D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUWK-00028w-EJ; Wed, 30 Aug 2023 19:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUWG-00028X-9r
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:22:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUWD-0007um-0s
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:22:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d6so1729265ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693437753; x=1694042553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rX0FTWvXPhISO1xzn4LWpmKksNMl34Rg5EGz6ApTZiI=;
 b=i9zDl1LwX13aAwGgvfRuhvaQr5fBxUHKBfqP2qRoEAK1dC/BmrdUGFosMfYfZzCcSK
 0iLoK1KDrOPRawKLEEprMlRqQp37jtumeJhTF5bLgBIa9pmZwEc6vuTbFQsClL3X8dDc
 N2KR6qeHv1kEX//D4qP9WLTgwPt40NXlyZEZuFgkffuj0xnx3vzvygJtQb7PKxoT5XJi
 Ruwlp8xYVbQs6ZVZxDwlmB0uABD8NVO7U2DwINHvwSFkyCm7F5sGIoopsmotHdZPFZKT
 22DrjGmO8GDDzIdtgjb/meHxummpniykDOCrJpUajepAh1OFvSYhIvPIZF7b7X2Zv4j0
 K1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437753; x=1694042553;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rX0FTWvXPhISO1xzn4LWpmKksNMl34Rg5EGz6ApTZiI=;
 b=Ay5jDHTpFfIFK4suKGPqzJrfuaZP+N8RfUTjuxDobUQqsimJJz4HX/Ee+xGNTp4LLf
 aHJsO+GRJPgTJ9SXx9IMnl4bOjdNxtwiyb13Xje/YsAjXE5+pgNEIjsYaTRbCLVTLb6I
 n97mmvPKE5tzRdLc7ieoD2KCzvkCdqNKEROCK/KZMBGPW2t/Ven/H3zpNbABr5jnhGrb
 k3CKRkGBHuYQVv0h/Yu3vIqjp3e3a8fJZiLOk+S/SVPuoBJOFAE8Yog3I7lZrMWXfbc0
 C0a7Jwg+COQCilU4tUa7ZE9nQx4rbse9KJdkW5xy6Tm8+DiXUkNOLyx7TQ7kxhZBoXdl
 CHeQ==
X-Gm-Message-State: AOJu0YwNDbHRL+yjJMbrjgbreJ10ek10lnT2nlwCZTnqx+1ENSI/aCRr
 1GvNg4oXaIcxB1j8kQI8Pcz2Mlf6wudSdJMk9ws=
X-Google-Smtp-Source: AGHT+IHkDEofRzx/LO+S6wSdfQnR7rthkiEYbzD769p4jmXJRCDOLJpeKdZodzaY4YcCcOnAhdOIbg==
X-Received: by 2002:a17:902:b58c:b0:1b8:8223:8bdd with SMTP id
 a12-20020a170902b58c00b001b882238bddmr3184177pls.59.1693437752887; 
 Wed, 30 Aug 2023 16:22:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001bdc5023783sm39170plc.179.2023.08.30.16.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:22:32 -0700 (PDT)
Message-ID: <8c857e08-16bd-160b-69da-afffcab8a31c@linaro.org>
Date: Wed, 30 Aug 2023 16:22:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 32/48] target/loongarch: Implement xvssrln xvssran
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-33-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-33-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
>   void HELPER(vssrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
>   {
> -    Int128 shft_res1, shft_res2, mask;
> +    int i, j;
> +    Int128 shft_res[4], mask;
>       VReg *Vd = (VReg *)vd;
>       VReg *Vj = (VReg *)vj;
> +    int oprsz = simd_oprsz(desc);
>   
> -    if (imm == 0) {
> -        shft_res1 = Vj->Q(0);
> -        shft_res2 = Vd->Q(0);
> -    } else {
> -        shft_res1 = int128_urshift(Vj->Q(0), imm);
> -        shft_res2 = int128_urshift(Vd->Q(0), imm);
> -    }
>       mask = int128_sub(int128_lshift(int128_one(), 63), int128_one());
>   
> -    if (int128_ult(mask, shft_res1)) {
> -        Vd->D(0) = int128_getlo(mask);
> -    }else {
> -        Vd->D(0) = int128_getlo(shft_res1);
> -    }
> -
> -    if (int128_ult(mask, shft_res2)) {
> -        Vd->D(1) = int128_getlo(mask);
> -    }else {
> -        Vd->D(1) = int128_getlo(shft_res2);
> +    for (i = 0; i < oprsz / 16; i++) {
> +        if (imm == 0) {
> +            shft_res[2 * i] = Vj->Q(i);
> +            shft_res[2 * i + 1] = Vd->Q(i);
> +        } else {
> +            shft_res[2 * i] = int128_urshift(Vj->Q(i), imm);
> +            shft_res[2 * i + 1] = int128_urshift(Vd->Q(i), imm);
> +        }
> +        for (j = 2 * i; j <= 2 * i + 1; j++) {
> +            if (int128_ult(mask, shft_res[j])) {
> +                Vd->D(j) = int128_getlo(mask);
> +            }else {
> +                Vd->D(j) = int128_getlo(shft_res[j]);
> +            }
> +        }
>       }
>   }

This does not require an array of shift_res.
In fact, I encourage you to split out a helper.


r~

