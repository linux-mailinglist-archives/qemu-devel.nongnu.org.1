Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0B78E36B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUoK-0006di-9f; Wed, 30 Aug 2023 19:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUoG-0006bP-7N
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:41:16 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUoC-0002yG-LL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:41:14 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a529e1974so159062b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438871; x=1694043671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tLBcjgRfm1tZGBuesX9X9XFZTqYWdDP/t6CSfpZg/cg=;
 b=wsOnKokvstqGfsKszs09EEAa0ikfCu1FMxg6sksvi8MG210wl4Xv8NMV60jtLLaX8b
 9x+pqLlB52fpNwnk5Pgjxf5nGCKFwg6bY8FvMJm+49M8FN81o44uDsSB6CF0aT6WO9Ps
 Wgzidh0pqkgTysQmi/fuIwoxPheQP0tMABX9Eq+D4M3xP1oQeuxpZ+6IRTGywfkJVm2A
 qivs9lakD/znHWHnTJC2y6JtKLxszQ5gV0rXyNG84VPDxIolXKQIxkmpwpbv7KZn0d6t
 9fjnzk0Wg8ZCGr/He5uEsQjLRVJymyLxj7PXi+0xtithlS1EZ2CAQeP3tPXHooSDIfK/
 qzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438871; x=1694043671;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tLBcjgRfm1tZGBuesX9X9XFZTqYWdDP/t6CSfpZg/cg=;
 b=Vxa4l2GQDnDSF3lgTuq0i0qi7RnkX8YBc6MlGrw7PFYaTwC+CnuFFaigvFcK4c+SvB
 6VxFBdsKks90Mmho74iW7Z21GbtpWvinuuyfd8kTBxYLJkqYo1g6hW8rnad+VLL9XxY8
 nge7cKzbpKn4NT2Hyw3M92U+fx9RHivMt6rrKlGz8HyrzwQEVRbW6RQAkxD4yo8sGLi8
 TtQWnUEiWNeaTcrd0b+Iw1EwZoOHW6Ndc7vrgLdqdQoSywu4gWR8QOx9s88fCfO+BVhi
 9UxxARC4psq7vUetoHDftFZ0T2Z6JtK5A7HjK+XHv+vH45TAUDg+t3DMdIVLtj4bi+7q
 YaVg==
X-Gm-Message-State: AOJu0YwCTZDlH/nkczfDREnm6lungw4hcIJ6awOi6APb3oW/XgYHo7uG
 JV7lAl7HT9xvHQinWJ2F7O6LsFIrb5L7p5RnH5s=
X-Google-Smtp-Source: AGHT+IG/TVAv5a3cVV2IzkyVUst4mkLJva+gATJvV/6WbPlDw2pjarqWxhP9SnCqvX4B+HwJuA6cHg==
X-Received: by 2002:a05:6a21:7802:b0:131:5f8b:9c7d with SMTP id
 be2-20020a056a21780200b001315f8b9c7dmr3209976pzc.22.1693438871205; 
 Wed, 30 Aug 2023 16:41:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a62fb10000000b0064398fe3451sm117023pfm.217.2023.08.30.16.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:41:09 -0700 (PDT)
Message-ID: <6941054e-a2d8-f600-f88c-f8b7c1ff1845@linaro.org>
Date: Wed, 30 Aug 2023 16:41:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 40/48] target/loongarch: Implement xvseq xvsle xvslt
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-41-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-41-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
> This patch includes:
> - XVSEQ[I].{B/H/W/D};
> - XVSLE[I].{B/H/W/D}[U];
> - XVSLT[I].{B/H/W/D/}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |   4 +
>   target/loongarch/insns.decode                |  43 +++
>   target/loongarch/disas.c                     |  43 +++
>   target/loongarch/vec_helper.c                |  27 +-
>   target/loongarch/insn_trans/trans_lasx.c.inc |  43 +++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 263 ++++++++++---------
>   6 files changed, 278 insertions(+), 145 deletions(-)
> 
> diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
> index aae70f9de9..bc74effb7c 100644
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -89,4 +89,8 @@
>   #define DO_BITSET(a, bit) (a | 1ull << bit)
>   #define DO_BITREV(a, bit) (a ^ (1ull << bit))
>   
> +#define VSEQ(a, b) (a == b ? -1 : 0)
> +#define VSLE(a, b) (a <= b ? -1 : 0)
> +#define VSLT(a, b) (a < b ? -1 : 0)
> +



Aside from this movement,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

