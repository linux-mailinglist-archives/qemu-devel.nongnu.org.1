Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DF78D7F9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 20:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbPrC-0000Q4-3u; Wed, 30 Aug 2023 14:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPr8-0000Pn-F7
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:23:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPr5-0007KO-US
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:23:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso37065005ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693419830; x=1694024630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CaE+AF/iO9sIbjj6frl71U1zuDqmx5lioM/O8lH6Klo=;
 b=OCNRG40YBAO6x0v+Qfjegcq4zHWd+1+vmBEJCx5CBPONwOdTCE6RGK1i7EmBKoDzYv
 RsYBC1lSIraeoA2aLWRgxKS7NdBMj5PXT5SEqDjstku/C3NjErx9VzNBN8WBdmbTk9bn
 v8pB55OI4mWKzU5DeyUU45hxFSX8AIoVrAgQvXttjoQcS3sHJVj4KNl0ycv2TUMDu2RC
 WUq+39nRkvNO/3XY0yzbOZXX05uqI0cUFk95LbvhD84Ci/eFJVRGP/QfR7oJDbiWegQi
 UoeSYa5lRFpi/ty0HjfVZMWcGv8mVz/7KOa/X2qWnFC/zMYwTrKPcV3anbJwjn7Pm0PA
 SPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693419830; x=1694024630;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CaE+AF/iO9sIbjj6frl71U1zuDqmx5lioM/O8lH6Klo=;
 b=Gpn7YsVACQumhLgn6VG921RaaW3aHCynpLOtCAHSNZt9kOKq6NfPi3G4bgP3BNs3Yi
 1w4zbkA3nub4o6NQqWndmVKH3hlNRzgMo1UQ5lXMQ+vcXN7/AJEO3oZEKrrLwNsDnPdJ
 Y4ZtC4EjhJhBRmRgu2y0w3JVvwdwwzM6+QbIVntRRw6uA2SBy4OjWp+0u0Jz8zgsw10/
 7hh53kkRfqLZskz3LWduT8gIT6m3fjp4cvDuBaUbcobC0KD2XIUJChVxGxW8XNcGyZSV
 LhcMTAV3rdIar0P9Vak2bE1FMLVkctT/zOOC0ezmgP87GeWi36oxyCFipDniUHRt0ZCR
 fjGA==
X-Gm-Message-State: AOJu0Yzub/OQTj05nqUtxLmOEJ6qt01Q7phh4cNyAyMMeqBSeyxCQ32T
 vHRIb3AqK8NvrBo3cV3nsbWn8sx05mmKz2a67+g=
X-Google-Smtp-Source: AGHT+IHTUJDYiz5kigVtX3AJOqt0KmXMhu3omdRYNzrRwV6UDmjKpSC2BuhzRET8hjE9OxtAAbLu4w==
X-Received: by 2002:a17:90b:4a86:b0:26d:3458:7a61 with SMTP id
 lp6-20020a17090b4a8600b0026d34587a61mr2837841pjb.5.1693419830271; 
 Wed, 30 Aug 2023 11:23:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ce14-20020a17090aff0e00b0026b46ad94c9sm1536650pjb.24.2023.08.30.11.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 11:23:49 -0700 (PDT)
Message-ID: <c648ae08-eaf4-4f55-e8a3-e8400b19ed1c@linaro.org>
Date: Wed, 30 Aug 2023 11:23:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 17/48] target/loongarch: Implement
 xvmul/xvmuh/xvmulw{ev/od}
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-18-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-18-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
> - XVMUL.{B/H/W/D};
> - XVMUH.{B/H/W/D}[U];
> - XVMULW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
> - XVMULW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |  2 +
>   target/loongarch/insns.decode                | 38 +++++++++++++
>   target/loongarch/disas.c                     | 38 +++++++++++++
>   target/loongarch/vec_helper.c                | 57 ++++++++++---------
>   target/loongarch/insn_trans/trans_lasx.c.inc | 42 ++++++++++++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 60 ++++++++++----------
>   6 files changed, 180 insertions(+), 57 deletions(-)
> 
> diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
> index cd6f6a72fd..6fc84c8c5a 100644
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -60,4 +60,6 @@
>   #define DO_MIN(a, b)    (a < b ? a : b)
>   #define DO_MAX(a, b)    (a > b ? a : b)
>   
> +#define DO_MUL(a, b)    (a * b)
> +

No need to move this.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

