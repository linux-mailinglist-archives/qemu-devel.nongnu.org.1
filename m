Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142770C0C8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:17:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q16KL-0001Oi-A6; Mon, 22 May 2023 10:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q16K8-0001NJ-W6
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:15:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q16K6-00022b-82
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:15:44 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so2549797b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684764936; x=1687356936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PBvw5qTXxwxfmFrGlIdM875GAPjwaEWrubZgMy5Cn28=;
 b=jl9qrUSgXSTyjmVrTG/DUdSziDoPnxtEJWpwITH0E0D8R3WVw+7Hp+psXcQqTEIHRo
 N+YRt5sw8qGkDDI7T/61b33v645XsEigl50RoYlxKIzf4gj8XeFgUzMZYiupB63QOL7t
 IeUAILF3ZvDSywC/7CwBVCpQzJjkzKyOGHAV3//7WS9O9cizuuFJH6SFg1F5TfgqCx+x
 u78yY+8BYd5kiaB+ZFxUdVtVSwO1m6ToNKCZxnDQVbfmLHVYPkTcfgRx3dryX4FsmG7w
 rG5exTpHzqSk0//5zW7vdehl+B1iVDE71onInYvrQmz+nqX8cKK/+wT+vRQ96BTEIfN+
 DFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684764936; x=1687356936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PBvw5qTXxwxfmFrGlIdM875GAPjwaEWrubZgMy5Cn28=;
 b=Un3wZLIzWHk/sTpe1+h+F2kspnfma8eOWimSYWt7iGR363iKEg5Dc0CnQfWU0CCq1I
 thjH3t6soVvsOrriai8pGZGZhUtg1rGaRKJ5i6x8ZDaK15hft+3yyZqIpqbiqoMcV64t
 OvRw7kBVPQ8ZXed3dtIiXsdio+6AsKMTATke0FtMkzPPLZ/XbIG6S3CRT4PxgNM45shd
 rN4/PqAksTkHwiz60GIswlGmSJ/0liwqRgR4htMP5Tyk9Di85hpj8HXvW1qOYpeAwqQK
 Oi/2IaWEOBWMVbDwOaTqlIHYfVyFTnpWLGTynYskZpTpiEvBTvxWXIQsgJJttJldX2+I
 dvNA==
X-Gm-Message-State: AC+VfDwL48cFzQufMxE2kWJJcL44uVrl5m8M7hjLujLdx/k3gWPJXXv5
 6/oNGFID4B0gBTzJXtAZjfZH8w==
X-Google-Smtp-Source: ACHHUZ6TybJ+lRj955/SBklZfOxT3r5+OOJaySscrOWCfJuPJMptpy3GDFCs5Lu1+QIK9izug8Su/w==
X-Received: by 2002:a05:6a00:10d1:b0:63b:5501:6795 with SMTP id
 d17-20020a056a0010d100b0063b55016795mr14426338pfu.24.1684764936203; 
 Mon, 22 May 2023 07:15:36 -0700 (PDT)
Received: from [10.0.14.188] (static-66-243-253-154.ellensburg.fairpoint.net.
 [66.243.253.154]) by smtp.gmail.com with ESMTPSA id
 g11-20020a62e30b000000b006259e883ee9sm4192545pfh.189.2023.05.22.07.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 07:15:35 -0700 (PDT)
Message-ID: <b82beafa-c9fe-2c89-2d97-f6c64f01706a@linaro.org>
Date: Mon, 22 May 2023 07:15:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/27] target/s390x: Use tcg_gen_qemu_{ld,st}_i128 for
 LPQ, STPQ
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-16-richard.henderson@linaro.org>
 <698d17f4-8018-41dd-4551-749d715bf71e@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <698d17f4-8018-41dd-4551-749d715bf71e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/22/23 01:35, David Hildenbrand wrote:
>> @@ -4533,14 +4522,11 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
>>   static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
>>   {
>> -    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
>> -        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
>> -    } else if (HAVE_ATOMIC128) {
>> -        gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
>> -    } else {
>> -        gen_helper_exit_atomic(cpu_env);
>> -        return DISAS_NORETURN;
>> -    }
>> +    TCGv_i128 t16 = tcg_temp_new_i128();
>> +
>> +    tcg_gen_concat_i64_i128(t16, o->out2, o->out);
>> +    tcg_gen_qemu_st_i128(t16, o->in2, get_mem_index(s),
>> +                         MO_TE | MO_128 | MO_ALIGN);
> 
> I briefly glimpsed at tcg_gen_qemu_ld_i128_int (and use_two_i64_for_i128()), does this 
> really provide the atomic guarantees we need in all cases?

Yes.  The CF_PARALLEL check is the same as the one removed above.


r~

