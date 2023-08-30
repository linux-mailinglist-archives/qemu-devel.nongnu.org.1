Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531578E36A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUnn-00067i-3B; Wed, 30 Aug 2023 19:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUnf-00067G-6L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:40:39 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUnc-0002rE-V0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:40:38 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bc9254a1baso260974a34.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438835; x=1694043635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTwoMkZU/Rpkiv3YiLMKuBe++xd5wxYcBnl3nmQQkU0=;
 b=EkI+cEuxM/cojZwhufUwFBR8Ldo7GxliSyYQxoL0vnfPcAbEzQlD4P/0GrebCKvqKK
 We3qq8md8Siy9RGy1pUux4WbC6S24NIfaR0AuH1sd+tuUIyDFHBSswh80Tucs1Gmz3oG
 le8kLuF6STNDcC8j9K2KTEbSYFM5wvXjeHia1o/vAfD+T/UWWfeeoOebj3z2aUIO5PNj
 eLvPyTPp9Fyv0W0erq2tSghw0GB/GG9GUHpQeDjobTOKUYKMvGwjA5PMS8kXQDtihRVF
 6CWDGToqDlHSaMKqFzojbTUsNbVF4O9EoPzE/x9LNquukKaW0d+eixKCUy2UJkXjEqq3
 5U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438835; x=1694043635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTwoMkZU/Rpkiv3YiLMKuBe++xd5wxYcBnl3nmQQkU0=;
 b=Lu92Dz7yRqTon9aAa7yP4MEpxOYaH/6vsbmE5ww+Ne6ZVtTMZwAv9AHH0/WTY4aN1v
 0QxOdf6J3Ildyn9EstoNcU+H6ydafogWQ32veU7OIVL9HhlJymgMxcw9O+y1P/IdXueY
 iPSLcuLpxRk9dZH2T8p9UbJvsKa7C+Cb43iSlE1lmyHl7/o5g9Q9K9gu9DacJqGEYTlo
 twy1V6RgR59U+W3FTVIeUSpEGJMQDPX2uZE6xLJATm7zPC9TGod8VUezmYHtDjQo6hcf
 QYAAqpSilbvSiPtMo9Vn1Z7MHi1O6muXMPwXi4C32GQcFIhltFetruKO/GAUGXeoQhJ4
 Vnsg==
X-Gm-Message-State: AOJu0Yz4pFITS6ouDgosm2Ll+OtwDNF8r6pjhRPNVulCVI1bcf2i070F
 lm94JN5QEzQYXmQtfzeLID3DcfyouN3G2zlfFMU=
X-Google-Smtp-Source: AGHT+IFUX2MzRWHGqJIjsmicBHI9LQ04o2TDOJvxEEq1IJFrJI14oeoONeu+zc2TPksO231xHQTKiw==
X-Received: by 2002:a05:6871:71f:b0:1bf:62d:6ea3 with SMTP id
 f31-20020a056871071f00b001bf062d6ea3mr4873308oap.20.1693438835366; 
 Wed, 30 Aug 2023 16:40:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a17090a020f00b0026b3a86b0d5sm154483pjc.33.2023.08.30.16.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:40:34 -0700 (PDT)
Message-ID: <9524a11a-757c-d6bb-cb73-f1e96c0cc7ac@linaro.org>
Date: Wed, 30 Aug 2023 16:40:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 39/48] target/loongarch: Implement LASX fpu fcvt
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-40-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-40-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
> - XVFCVT{L/H}.{S.H/D.S};
> - XVFCVT.{H.S/S.D};
> - XVFRINT[{RNE/RZ/RP/RM}].{S/D};
> - XVFTINT[{RNE/RZ/RP/RM}].{W.S/L.D};
> - XVFTINT[RZ].{WU.S/LU.D};
> - XVFTINT[{RNE/RZ/RP/RM}].W.D;
> - XVFTINT[{RNE/RZ/RP/RM}]{L/H}.L.S;
> - XVFFINT.{S.W/D.L}[U];
> - X[CVFFINT.S.L, VFFINT{L/H}.D.W.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  58 ++++
>   target/loongarch/disas.c                     |  56 ++++
>   target/loongarch/vec_helper.c                | 263 ++++++++++++-------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  56 ++++
>   4 files changed, 335 insertions(+), 98 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

