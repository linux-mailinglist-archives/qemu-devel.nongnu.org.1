Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BF78E2DC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:53:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbU3I-0001i2-V7; Wed, 30 Aug 2023 18:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbU3G-0001hs-Id
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:52:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbU3E-0002Of-0q
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:52:42 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68becf931bfso152702b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693435958; x=1694040758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6J5sAiSe749LGjLvGBGd8mkTxMn0AVCqdJt/n5KkvVo=;
 b=z7fydSA/9w/djlDpyMG4gcPKCX9wGuAd+oznMmB1BugUKfNoJn/G2nhbytzlcinXST
 yCg22fZyJ1UfojmpooiWdCeV6+IZtiZI22XJVmjJ3FqZNQ92G0mcnWdH80EXvawzrc8c
 8+QXmODMzVBN1Eq82BD97CEiPo0LtofM2/spWmoPUTRK4SBexYIMp1As7ThEptUu8mRe
 g7amofc4hqkvxUgKgo9eXoej4ZMQn7reQzAPOvy98t7xlMVqV3JtvP9h60fsSDHAkl2s
 2OWUi4R7C/2oofHD4/khldwKpLSAsd66fi1Vt3jT3fZ5gid3BWZ9WVjq6b1mLDZK8dio
 Vnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693435958; x=1694040758;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6J5sAiSe749LGjLvGBGd8mkTxMn0AVCqdJt/n5KkvVo=;
 b=Nvs/K1nR7iS1wUec3N1mXUvLLBcxHVfbofUHMYTjCneIH2NlmlL1xhMR2Uex908mO9
 K6jptX/NIPqiVzsvyYFizNg4CA8vb7VLzdw2DLTCsCpDJWA9DTwEaQxf7Hi1BUc9pxaj
 dyyDgcMTgndg/YRnZzaub5WVImlzJqXvYfU+JGo2Y+2q98hzHKZxE466KtKj5ul41OmJ
 09RI5/Fb2Uyhi09QEUKUY0QcX19+7y9jI8/S6OB74ZyBWyU+i0QBZi78zc4ylH9DOVjf
 yYTOZP/x+5gVkka8ecll0B8Hpcf6KZZUAoGd9LU7w1XaZqwWfZ8gFrM2GhDimOm+VOqC
 ctvg==
X-Gm-Message-State: AOJu0YztY4PupHG5hhrm0Vxbg9u94CIFb0qTLyeKGeU7M0Qy+n4QETiD
 FuYUojoGYTVGNbNbJTfDBzdg97UjEFeckLxxtxY=
X-Google-Smtp-Source: AGHT+IHjsEjJ3URerwRXHBND5Kta+h4Cm6Vne3UYg+Rx01aRjKZBA+H734GkQgmj7f7JD1yQUwJfbA==
X-Received: by 2002:a05:6a00:b8f:b0:68b:dbbc:dcf4 with SMTP id
 g15-20020a056a000b8f00b0068bdbbcdcf4mr3968034pfj.4.1693435958447; 
 Wed, 30 Aug 2023 15:52:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g12-20020aa7874c000000b00687375d9135sm92213pfo.4.2023.08.30.15.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:52:38 -0700 (PDT)
Message-ID: <98f50d7d-8920-0de8-ea24-4c45eb708e2a@linaro.org>
Date: Wed, 30 Aug 2023 15:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 28/48] target/loongarch: Implement xvsllwil xvextl
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-29-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-29-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
> - XVSLLWIL.{H.B/W.H/D.W};
> - XVSLLWIL.{HU.BU/WU.HU/DU.WU};
> - XVEXTL.Q.D, VEXTL.QU.DU.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  9 ++++
>   target/loongarch/disas.c                     |  9 ++++
>   target/loongarch/vec_helper.c                | 44 ++++++++++++--------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  9 ++++
>   4 files changed, 54 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

