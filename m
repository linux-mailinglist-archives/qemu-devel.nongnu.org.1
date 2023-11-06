Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD267E2E0C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 21:19:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r063N-0007E9-Tr; Mon, 06 Nov 2023 15:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1r063M-0007DZ-2J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 15:18:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1r063J-0003DS-Sw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 15:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699301909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H8dhqD0fI5442CJOnqmmDHi+YK8Xea/crdEhD76Fznc=;
 b=C1nNgahpJ3KDmy996Xk5/oojQ5+YtQZkcu7C2aJc/QO3va/1bgxqJyON+rkY7hnRwF6Fs5
 Rpj5xWBSOFniNk335qxuYMEDTK9jw0VSr1+zTTDnRPTMNdyt50+GBcVIMsrL6zDqKu/4Ao
 KINeYj6h3+TMBhAdrBe1UZLnEWri3WE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-1ew4z2KPNTGyrK93sD4OQQ-1; Mon, 06 Nov 2023 15:18:26 -0500
X-MC-Unique: 1ew4z2KPNTGyrK93sD4OQQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c506abc320so42397071fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 12:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699301905; x=1699906705;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8dhqD0fI5442CJOnqmmDHi+YK8Xea/crdEhD76Fznc=;
 b=tZqt5DRK8bOEVIKZJgPi4DT/y9T+76y4H+FeAXJQJ/QNWdFxTVqVVFtw/vYZXHjkCZ
 7IKs3HOgKfxfC1PXrHq1uX8PLlrgfQSo/AzLpulJG4Ne5BBFe17NL4SJy/LQLEhbnZe/
 6mrBak5BMZ+t8zvvtp7UyLdFH1mvGzr3X62hkbRIwJNURftV+hMdhMjlW27IadMXvdTn
 6ehHXpEuRHJuw0+Uvxu2G7DiOQvZFutOBdeCo05JEw2gcoOeyFWjwqHV8WBn/ay83Y3m
 o/UL1OJUBjpDMivIZWICP/shhrwNe05OXAQfZYSuAxpSOsDcJQYcFn+B8XFFrL21pUKR
 Z/lg==
X-Gm-Message-State: AOJu0Yym7GK2n1MBkl3B1uh/o1lZNeAxESmTGM4y6xBb9nsK99A6RMKI
 F8yWsvuTyi9iUzFZFRvNakI2fcyz2eLzyO1Ykhsk+0QCPoBLPPx7D1T4+aw+tH2CHwbLsnG7voe
 g98c3wMlAV1wkrRw=
X-Received: by 2002:a2e:8558:0:b0:2c5:2423:e225 with SMTP id
 u24-20020a2e8558000000b002c52423e225mr21422000ljj.6.1699301905277; 
 Mon, 06 Nov 2023 12:18:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUMXFlUEcVLCCwDDfcfI/05CPz+1d2oF8bn/gOt26D3cnHyjgpVBx5Yjqbn5yEnsZCHBCS8Q==
X-Received: by 2002:a2e:8558:0:b0:2c5:2423:e225 with SMTP id
 u24-20020a2e8558000000b002c52423e225mr21421988ljj.6.1699301904800; 
 Mon, 06 Nov 2023 12:18:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:8300:17ef:a8f2:1ed1:81e6?
 (p200300cbc723830017efa8f21ed181e6.dip0.t-ipconnect.de.
 [2003:cb:c723:8300:17ef:a8f2:1ed1:81e6])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c358600b004053a6b8c41sm13100903wmq.12.2023.11.06.12.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 12:18:24 -0800 (PST)
Message-ID: <8644ddc8-f7d7-45f5-acab-b4758611d443@redhat.com>
Date: Mon, 6 Nov 2023 21:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/s390x: Fix LAALG not updating cc_src
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-stable@nongnu.org
References: <20231106093605.1349201-1-iii@linux.ibm.com>
 <20231106093605.1349201-4-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231106093605.1349201-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06.11.23 10:31, Ilya Leoshkevich wrote:
> LAALG uses op_laa() and wout_addu64(). The latter expects cc_src to be
> set, but the former does not do it. This can lead to assertion failures
> if something sets cc_src to neither 0 nor 1 before.
> 
> Fix by introducing op_laa_addu64(), which sets cc_src, and using it for
> LAALG.
> 
> Fixes: 4dba4d6fef61 ("target/s390x: Use atomic operations for LOAD AND OP")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc |  2 +-
>   target/s390x/tcg/translate.c     | 19 +++++++++++++++++--
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index 0bfd88d3c3a..2f07f39d9cb 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -442,7 +442,7 @@
>       D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_TEUQ)
>   /* LOAD AND ADD LOGICAL */
>       D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_TEUL)
> -    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa, addu64, MO_TEUQ)
> +    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa_addu64, addu64, MO_TEUQ)
>   /* LOAD AND AND */
>       D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_TESL)
>       D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_TEUQ)
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index a0d6a2a35dd..62ab2be8b12 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -2677,17 +2677,32 @@ static DisasJumpType op_kxb(DisasContext *s, DisasOps *o)
>       return DISAS_NEXT;
>   }
>   
> -static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
> +static DisasJumpType help_laa(DisasContext *s, DisasOps *o, bool addu64)
>   {
>       /* The real output is indeed the original value in memory;
>          recompute the addition for the computation of CC.  */
>       tcg_gen_atomic_fetch_add_i64(o->in2, o->in2, o->in1, get_mem_index(s),
>                                    s->insn->data | MO_ALIGN);
>       /* However, we need to recompute the addition for setting CC.  */
> -    tcg_gen_add_i64(o->out, o->in1, o->in2);
> +    if (addu64) {
> +        tcg_gen_movi_i64(cc_src, 0);
> +        tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
> +    } else {
> +        tcg_gen_add_i64(o->out, o->in1, o->in2);
> +    }
>       return DISAS_NEXT;
>   }
>   
> +static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
> +{
> +    return help_laa(s, o, false);
> +}
> +
> +static DisasJumpType op_laa_addu64(DisasContext *s, DisasOps *o)
> +{
> +    return help_laa(s, o, true);
> +}
> +
>   static DisasJumpType op_lan(DisasContext *s, DisasOps *o)
>   {
>       /* The real output is indeed the original value in memory;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


