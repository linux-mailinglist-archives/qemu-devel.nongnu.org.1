Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB4713600
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 20:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2yGs-0002w3-68; Sat, 27 May 2023 14:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yGq-0002vp-4W; Sat, 27 May 2023 14:04:04 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yGo-0005gH-Gl; Sat, 27 May 2023 14:04:03 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-555536b85a0so970337eaf.2; 
 Sat, 27 May 2023 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685210641; x=1687802641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEq+fHjKFXQ+2QFXmbbcj20vDaALPHbxPYITxP72p+I=;
 b=sQ8hIrhA975JqeijOd2j1MNtpQvKadmrVwvOR1rtdBupTFcxnZRbZRz7TCV+pbA6MT
 YUbuD9AWcZHr/nYH6W+1xdC0wT9nchB7iqcEq5aw3o9rWBhx9JCqAm5FbMgdsCIxhZSx
 yctg3gdnlXQ9uK6YkC9M86WFw18c0NAf4SzuK7kCe/eccyxJ8NjAiANzT6tD4PGtQHUW
 71Gm8g+uYpgab2rLGf0G2u4ESYifdi39QO/Tk/OuwUtmya6ROqz4B6CS03G1dQpPT2/F
 n8iAJttydJFuPdTU/gQx4c0VWBKVakKN6VoXnexssQcrR7Se8FfMxRU4wFbkxRCTHNwF
 fICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685210641; x=1687802641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rEq+fHjKFXQ+2QFXmbbcj20vDaALPHbxPYITxP72p+I=;
 b=fFpaw3DSFsvK7iXR6v5CbO6wryPWADFI+Pcee+OdGLoeuRuYZyslzmdfSg7Ly55eZy
 /TKhEzJsqtzQ07hT+zGFUb1oaoi5d+4+cRFuBoJw98OMv6xTICfxjBSR1SJKqm/dzB4a
 FzwCT2wIKU8PBaVZ2xFAJfrBAKKGSbW70dbtRoMiE82hv697/zJsz2XcmMadIqYPrt7x
 7PBHTGciGb1ncJ0YecfpltHiTQZo/46QRk+ombWqobmS1HGLxAal7dExrUe8zzg/03hI
 nHAm/zxtrRawy9haQIzegymibsRDtyrly2vDgoIuGXzuogjaRWuvvibKunWuImbKN0/o
 Uwfw==
X-Gm-Message-State: AC+VfDyiIrNvKUJqgfp798ZvkzepmNPzu79sLBtYNor34YNtBjbQjB0b
 M6WwBFyJ5NF8lP0PJ6TC2+BMBYy4KNY=
X-Google-Smtp-Source: ACHHUZ6KpWWt8CGijgp20Dneli44Ms75Wvqic8oLJ0B75LLxPkv4Mi2PvU4MrdV8yZFmZfjS1u6Acw==
X-Received: by 2002:a05:6871:6b85:b0:19e:fdb6:c46d with SMTP id
 zh5-20020a0568716b8500b0019efdb6c46dmr2425142oab.19.1685210640740; 
 Sat, 27 May 2023 11:04:00 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 ec11-20020a0568708c0b00b001964cb38d37sm2978489oab.11.2023.05.27.11.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 May 2023 11:04:00 -0700 (PDT)
Message-ID: <212ab1d7-c902-9675-9267-aae6d549556c@gmail.com>
Date: Sat, 27 May 2023 15:03:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Use SMT4 small core chip type in POWER9/10
 PVRs
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
References: <20230515160131.394562-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230515160131.394562-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 5/15/23 13:01, Nicholas Piggin wrote:
> QEMU's PVR value for POWER9 DD2.0 has chip type 1, which is the SMT4
> "small core" type that OpenPOWER processors use. QEMU's PVR for all
> other POWER9/10 have chip type 0, which "enterprise" systems use.
> 
> The difference does not really matter to QEMU (because it does not care
> about SMT mode in the target), but for consistency all PVRs should use
> the same chip type. We'll go with the SMT4 OpenPOWER type.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


And queued. Thanks,


Daniel

> This is a replacement for
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2022-03/msg00227.html
> 
> But the chip type is changed to 1 instead of 0, because that's the
> more familiar SM4 / small core CPU.
> 
> Thanks,
> Nick
> 
>   target/ppc/cpu-models.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 1326493a9a..a77e036b3a 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -348,11 +348,11 @@ enum {
>       CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
>       CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
> -    CPU_POWERPC_POWER9_DD1         = 0x004E0100,
> +    CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
>       CPU_POWERPC_POWER10_BASE       = 0x00800000,
> -    CPU_POWERPC_POWER10_DD1        = 0x00800100,
> -    CPU_POWERPC_POWER10_DD20       = 0x00800200,
> +    CPU_POWERPC_POWER10_DD1        = 0x00801100,
> +    CPU_POWERPC_POWER10_DD20       = 0x00801200,
>       CPU_POWERPC_970_v22            = 0x00390202,
>       CPU_POWERPC_970FX_v10          = 0x00391100,
>       CPU_POWERPC_970FX_v20          = 0x003C0200,

