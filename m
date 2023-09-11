Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5F79AF4B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqb5-0000XW-L7; Mon, 11 Sep 2023 19:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqb3-0000Wy-0m
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:45:37 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqb0-0007LH-Ct
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:45:36 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57656330b80so3242371eaf.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694475933; x=1695080733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iMUl0Avtf0q7lsPv68fPK6k+ZAbmBSs3G+eXttL0TSQ=;
 b=j2TQogC4KX68bilHu2LC9TKBrKpDkab0BYr+QpcH4MKwFR7d/WChHm9xyXDTj6FqCS
 P7jPN4c+d6WRnIh3SXkJl3LsVFCvGAVfJdQnhcqJw0et+tjAmHA4P8HGX3exatq65Ghw
 KiX/MuGyBstXavFyGJabjg3y1G/PZdpPuxHvySZkIaGexKBSWW2ai94yVi9sEH4giibq
 bWgkEJSf9FVS65J/V6L4QnjpIUd1omCNTnEiHldCboW2VmjDB7/PKl6KjX/XK1YSAa/d
 JtK1NVev90dxPTL8qk9A0cnbL3eyb6Sf/Yi8faALLpEzMFy9rPqCIaByj5aNfCkFxFcT
 tXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694475933; x=1695080733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMUl0Avtf0q7lsPv68fPK6k+ZAbmBSs3G+eXttL0TSQ=;
 b=kBr6f8k1NUvcGVmV/iM8P3CnvyizP88TJn2TTly/IwsJgGXkC+Up+1dT1LCs+UTi6q
 u/Qg269FH59b/KBE8txJJW7UnvXz8yxnjQPIj2Y/63+UI20zEpkS/vDo1nyUq4Yn/Jvk
 F2X64G33lVtAG2z8IdBrwxo0FkAgVHiq4/ndCxN/SgRM0Z9Q0Ke4R9zJcu5gsSMA8SnP
 VbBzhofTUhYJNds6TV++eeJqBusM5OBjP9V5pI7IfIgQXC8PVRVz5ahjt++GzWuOZg0W
 h94sv0euCPTpezHkXLL1QCkIAt6jspEozV8Rl6OnNxYiTpm7gTQWaU4P6+gLQzp/0tHC
 YiOQ==
X-Gm-Message-State: AOJu0Yw1pHhkJPU0wLNoOpHCTHc/VuHFC2k6/Gl2UnROkvZa4vwXcVK1
 V4yvi4xhfO7H5njlejMYRjqhH2NzWtN6XuHeOzA=
X-Google-Smtp-Source: AGHT+IFD5BVnXWaCLPi1JMKoyL3NLLGAjACavNbgx3Jq1Q6CUUimVtSH87axGHCzKcUWMwLX4epUOw==
X-Received: by 2002:a05:6358:261c:b0:130:5951:b268 with SMTP id
 l28-20020a056358261c00b001305951b268mr11813763rwc.31.1694475932657; 
 Mon, 11 Sep 2023 16:45:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a28-20020a637f1c000000b00565cc03f150sm6082474pgd.45.2023.09.11.16.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:45:32 -0700 (PDT)
Message-ID: <240cefae-4203-a405-3e02-5d4b64225e47@linaro.org>
Date: Mon, 11 Sep 2023 16:45:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 54/57] target/loongarch: Implement xvshuf
 xvperm{i} xvshuf4i
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-55-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-55-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 9/7/23 01:31, Song Gao wrote:
>   void HELPER(vshuf_b)(void *vd, void *vj, void *vk, void *va, uint32_t desc)
>   {
>       int i, m;
> -    VReg temp;
> +    VReg temp = {};
>       VReg *Vd = (VReg *)vd;
>       VReg *Vj = (VReg *)vj;
>       VReg *Vk = (VReg *)vk;
>       VReg *Va = (VReg *)va;
> +    int oprsz = simd_oprsz(desc);
>   
> -    m = LSX_LEN/8;
> -    for (i = 0; i < m ; i++) {
> +    m = LSX_LEN / 8;
> +    for (i = 0; i < m; i++) {
>           uint64_t k = (uint8_t)Va->B(i) % (2 * m);
>           temp.B(i) = k < m ? Vk->B(k) : Vj->B(k - m);
>       }
> +    if (oprsz == 32) {
> +        for(i = m; i < 2 * m; i++) {
> +            uint64_t j = (uint8_t)Va->B(i) % (2 * m);
> +            temp.B(i) = j < m ? Vk->B(j + m) : Vj->B(j);
> +        }
> +    }

Loop, not a compare against oprsz.  Several instances.

> +void HELPER(vpermi_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
>  {
>      VReg temp;
>      VReg *Vd = (VReg *)vd;
>      VReg *Vj = (VReg *)vj;
>  
> +    temp.Q(0) = (imm & 0x3) > 1 ? Vd->Q((imm & 0x3) - 2) : Vj->Q(imm & 0x3);
> +    temp.Q(1) = ((imm >> 4) & 0x3) > 1 ? Vd->Q(((imm >> 4) & 0x3) - 2) :
> +                                         Vj->Q((imm >> 4) & 0x3);


     for (i = 0; i < 2; i++, imm >>= 4) {
        temp.Q(i) = (imm & 2 ? Vd : Vj)->Q(imm & 1);
     }


r~

