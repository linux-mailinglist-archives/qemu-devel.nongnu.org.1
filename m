Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9257B47D0
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 16:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmx8p-0004B4-C3; Sun, 01 Oct 2023 10:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmx8n-0004Aw-LC
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 10:09:49 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmx8i-0003nI-OO
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 10:09:49 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1dcf357deedso6753670fac.0
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696169383; x=1696774183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pAEZ5w2ItAyyL23yYyZ4IO4EgMXEqHlwu3tLq2zEkkg=;
 b=sLuGq8BA8fpP2r5xX3iuP0/E6ksVd3TubULciAKrpZ0JEoCvqLcDcizKybstkEFABu
 6od5HrPXs/SrK1YqB6U4dbKfRIy4pU9LcfgKUhQvUCsk5BHLaELp5jhoa1H2AEZsQ1ub
 SIGHmqYT/ilBucQssx+kUmv1Q2zCFahvYQUWCxrOuOjM1+jgieto24s5SU2SL/zgKxel
 gPdrRPH5XLKJYz1PRKeORKmfeR+LljV0A5tyeI8GGP2yg6BjPhQBw33LmMg2a6GohiIN
 i2PeN1tg1ugEagLh/ar6jh8n+Vylsbkas+3KJyNpirGSANdLdjtr91i2z8XSW0/20075
 N64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696169383; x=1696774183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pAEZ5w2ItAyyL23yYyZ4IO4EgMXEqHlwu3tLq2zEkkg=;
 b=gPHtpH12+8hW0UCfq5p18Ac0p0ZaEeexhrf8t5aKEIV0WcspgIzpJpBOkZUPzGYy+S
 zLbkMwl+RKwDc/iv/+YbuYx0iOO+teKBwGZrhfF8IVDtRi/hVNyXh1HtGnEWA7pZwMTE
 C9PQ+XhrwttXqcBTjFl28f+XBAcSIvHyQnWvi/dEUvlAgXUx4y1YnWZ1fBkFXDyTtnzg
 scxmcfVDCY2LJgC5A32Fh3o8qLGKiFb5McCS0VPsjons8khX1iTFTn9lAyvZA8Zzboe6
 bOaUtWNKpQVnoNuTaBVY+XutSVi/taPFaY34BOKtFx8zi9DfksvpHbmSX0LsJYSe3SG4
 8XlA==
X-Gm-Message-State: AOJu0YznJpFU5hs+cHOKW0qppBYAxtJ6PFnHo4myl/lyp8ctUVsLrdb8
 tnvLUFcM0WNsrPGMWT6qfRrBvQ==
X-Google-Smtp-Source: AGHT+IG5iYLX9Ct2ZLVkfDUX1VLS7Rw+k0I7GIQdXq04Qg1qjegAfJlNybyoKxwgk/IjOo6MhqKP0A==
X-Received: by 2002:a05:6871:794:b0:1d6:5658:7989 with SMTP id
 o20-20020a056871079400b001d656587989mr11507104oap.19.1696169383214; 
 Sun, 01 Oct 2023 07:09:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t21-20020a63b255000000b00578e9751b88sm17706795pgo.1.2023.10.01.07.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 07:09:42 -0700 (PDT)
Message-ID: <42ffa53a-be0f-f05c-0f67-83dca46927e9@linaro.org>
Date: Sun, 1 Oct 2023 07:09:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] linux-user/elfload: Enable LSX/LASX in HWCAP for LoongArch
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name, Laurent Vivier <laurent@vivier.eu>
References: <20231001085315.1692667-1-c@jia.je>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231001085315.1692667-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/23 01:53, Jiajie Chen wrote:
> Since support for LSX and LASX is landed in QEMU recently, we can update
> HWCAPS accordingly.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   linux-user/elfload.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

