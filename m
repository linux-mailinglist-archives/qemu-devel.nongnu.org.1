Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4873D999
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhXo-0005IY-9q; Mon, 26 Jun 2023 04:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhXZ-00057d-7u
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:25:45 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhXI-0003LP-4l
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:25:27 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fb41682472so1312500e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687767921; x=1690359921;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WrYY0wwF3zjRBlyzjIEsKjkrdd6x1Cerv5bibsj9z+M=;
 b=V3GynXOdYm9rvfiFGF3UfTM2NBIdy6DhEwGIu4nrgkChtB71OPVKvtO7gd9HDT2Cjq
 6gPwUdIRyBnvkn4MscShmggrSOHKxlXnKN1+xQKEBZvCfmI3mTcP42o2Nr0AinNepFKM
 o1OLrHwm+hYS6oMO5s3/K78zASorM0lhzNM8pBqxxGgQ9fsSSQHcbWwDnCtn6nCyLVAS
 gQxXpcXIPQRTGkb6JvVkf9tChroULCt4d+PFoaskm0PSeknRGsrcJbRmuYGxNXmgM7wI
 ZMExJtgRwyPvrK5eiKpPCew7faFNlrDUZC9l+yKuH/ez0bBzbYWNNXoQ9EkpiQxt+zhv
 NbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687767921; x=1690359921;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrYY0wwF3zjRBlyzjIEsKjkrdd6x1Cerv5bibsj9z+M=;
 b=hSSlehSNOyR6Dp0CR1nx9+pa+fqPcx/723oAiflpLlZMMFxVpCfqWqlj7wc4yG2H6B
 n43n2acfG8My6Vd+veIP+Lr0+ArEudyTpubU3zAx7OOTyxarJYZjev+9YdmXDFXqyEaC
 TYcu+r8tyPXdDWux7JwgkmJvPg0XcB1TYBUdKuyJICkk6t4BvbsSgF2gudijXR2Cdb5V
 7XFzj/HOuE1L3DYas6qzFkv2qAhkTu0RiiYlncmTBHLxkHYvtQcdHIHf3PyktjkdeOih
 U5ITp9nbBevLRFgiQouMARU5FIEneTgFpqARSEtm8wzLckw3H1vFLoyAuWOl3KmUud/k
 9X2Q==
X-Gm-Message-State: AC+VfDxqWJ/Bv6B/olrTUbG4HwNsfobZB1idZvtCdVOqjP6d0bLgLAz/
 hDiyD7VMHFiVNQeuNaJMTJ3syA==
X-Google-Smtp-Source: ACHHUZ78egT8lrkJIzef519UcXiBm073WEaPo+HO2m9NgwWjP3XVWEd5DaKeOwD29wqMMfELmt0aQQ==
X-Received: by 2002:a05:6512:118d:b0:4f9:596d:c803 with SMTP id
 g13-20020a056512118d00b004f9596dc803mr13499472lfr.53.1687767921326; 
 Mon, 26 Jun 2023 01:25:21 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c210800b003f9b4330880sm6920487wml.29.2023.06.26.01.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:25:20 -0700 (PDT)
Message-ID: <f38f6d05-9fc7-b470-ee83-d7c87e88ce6b@linaro.org>
Date: Mon, 26 Jun 2023 10:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 20/26] plugins: update lockstep to use g_memdup2
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> The old g_memdup is deprecated, use the replacement.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/lockstep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

