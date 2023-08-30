Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A1478E22C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:15:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTSe-0006mS-6S; Wed, 30 Aug 2023 18:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTSc-0006mJ-MW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:14:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTSa-0002uM-2c
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:14:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso1119835ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693433686; x=1694038486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hh8bhZASm1fnrN/u99t5IxHTJhH+uiUyan8+5BhhGyA=;
 b=KZDKlxY6uKbFKtFrS2IEK6do+tnBq76Y+RFciTIxnZmdrOPJv0wMKtCIk1PXWPqEQm
 F8SV1pXUCsDk4sO45mAI7+GtxdQCQnq/NHYY3E2UqW3jIzhBFww1tFhjenMOaxuuVRas
 j8E50267JPqf3T6J+zuKqWwH+GmAILDd1aRDoYKUnX0c2+OCgiDPF2P41WMsl7cYiUBo
 gxmdOFiTS3xvFDrOIi1v8YTT/+Bu4P92WuSJWcb3xoSUy5/jAR9zZaFubhZeOBy3w8YP
 E8j+X64GW1kkMeA7JIzDRafiHeVUswYlq6jFrn3jqE89lDIEEr3EKJ5sX/hUC3Sws1tk
 pzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693433686; x=1694038486;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hh8bhZASm1fnrN/u99t5IxHTJhH+uiUyan8+5BhhGyA=;
 b=VSJUMZ5Mtp5DGIsaGVWa9Epu1xzb285xXw8ptNM7fZ0P5Lhh1KOF8Or5XJdcCwkFJq
 zE5vHseHpHtpadw0m3Ox3m1lO2uvGxmCNycT8qeJe9NGlOchIaGkS81TMEkodtGAzS18
 6OOr5bgxfkG/mUTpgufcAtp+vkstcLjQL15YhloL93XPL77T+0ZjGpFm4F93y+hPHkju
 Z5klsotaLsD5uHfKAC+lTiYmzGM7o9iZgMjt6ixalUKYHobMGK6Yl08GtRpAPwvMpDUL
 sFgg6zwFqUOK+2TJ37cNEHTNU+PAmWDYyMvfqy+HSqir2x+20yrJk3omHMquj6QVv0r1
 yzcw==
X-Gm-Message-State: AOJu0YyAlNYBA8AO4UGp7TGkVX2DkZqPof6sztOWp5vNg6wHZblEaia4
 IyD3c5XpqoV2iGqBDMB7eO6u1Hb7WnWo61YpyQI=
X-Google-Smtp-Source: AGHT+IGczQemSq/BWHKRcPf1T+j2wIDpI3mb1xmQRThxaJtd4+ncV7/aaJvFDSDMKBY8XAjnDtDqjQ==
X-Received: by 2002:a17:902:8f8e:b0:1bc:3504:de35 with SMTP id
 z14-20020a1709028f8e00b001bc3504de35mr3412532plo.62.1693433686601; 
 Wed, 30 Aug 2023 15:14:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001bdc2fdcf7esm11600511pli.129.2023.08.30.15.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:14:46 -0700 (PDT)
Message-ID: <a16e5b3d-743f-fe43-dcad-e1ece1f6c458@linaro.org>
Date: Wed, 30 Aug 2023 15:14:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 19/48] target/loongarch; Implement xvdiv/xvmod
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-20-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-20-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> - XVDIV.{B/H/W/D}[U];
> - XVMOD.{B/H/W/D}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |  7 +++++++
>   target/loongarch/insns.decode                | 17 +++++++++++++++++
>   target/loongarch/disas.c                     | 17 +++++++++++++++++
>   target/loongarch/vec_helper.c                | 10 ++--------
>   target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++++++++
>   5 files changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
> index 06c8d7e314..ee50d53f4e 100644
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -65,4 +65,11 @@
>   #define DO_MADD(a, b, c)  (a + b * c)
>   #define DO_MSUB(a, b, c)  (a - b * c)
>   
> +#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
> +#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
> +#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
> +        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
> +#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
> +        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
> +
>   #endif /* LOONGARCH_VEC_H */


Aside from this movement,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

