Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942873673B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXOi-0003SU-Sr; Tue, 20 Jun 2023 05:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOh-0003OK-0q
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:35 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOf-0000Yl-Ga
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:34 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-988e6fc41ccso177510666b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252292; x=1689844292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gaw1EU8tbIRwnItfSINavW5clPLjF3Y6+j+Zka34hNs=;
 b=JNLm50ErzMTZnkv44nVrjJg+/oVOoIXIb7IKG+0tyxwA7UhL3d8HjBJ6eocPR4c0Ti
 PrihgHvY/GOq0DdB0a4g+duRbLB8OWMDx4Ac8GQWFYU1BoUBBcyTGhhMvv9tr1QzJ49r
 sG+H5KKBn6Sf+cJy/hi8WRJ1vB/7MvTJOP2EtFRlCqxZ3meJsHZydH8UBQCtgECx8gEr
 LJ6Ohalo2QV1Uuj/4ItiisrhzvOgEyphip0i7ryNJKopCNMI4kfD3bTFx84clIEnxUe4
 HLHRphrWTmtizkHtB7le/soOHpKp+CZaP85eGqd7+5tvTbvUgA21XgKTPszxk4hxZzK5
 3dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252292; x=1689844292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gaw1EU8tbIRwnItfSINavW5clPLjF3Y6+j+Zka34hNs=;
 b=eanfJntIlSUo/oJONgOI1lDFe3hSeJALhXVDsk2WjmNqNHqb8cz/XPOirmHNvJ+MP0
 7Dd14qAM4FgXNefiuA/lhVYvvgijzZzw8bhupKA73idq61t/i9Xho/akSy+ymunXMNtd
 aXODa2Ja9U+kbXo58yDOKHekPS4hSplsX6fqQ54Y3nf7utliM/66BKPAFcz9HS3bzQzv
 +XsIKI5txhA09be3u9HLTDuxUyEoTnXrVNmD49HTwixMoCF6DgxpxO+7YZmxBL8I6goU
 OfpOoecG8zTn/pMU+PuiJ4euuixthh+xorJslII5+kJrYGNLuzA2acirdmFJOJqO/cV6
 BQ1w==
X-Gm-Message-State: AC+VfDwAwiUTaiNLqy6ZFVj5af4gQpvSslFpHkIm1rcvtvFHDwUUiHKt
 d/2f+g+VpYN6Oew9Gvm36Onmn/U/NlP0qHFVRPUHlC2X
X-Google-Smtp-Source: ACHHUZ6ITBf7Uk3DagAGNKsqdfRilduORuWFaZQCbvmvBQzIo40i3Uml2FzYUMhUQOV3iz3TqlEnoQ==
X-Received: by 2002:a17:907:7294:b0:988:c97b:8974 with SMTP id
 dt20-20020a170907729400b00988c97b8974mr2957752ejc.1.1687252291852; 
 Tue, 20 Jun 2023 02:11:31 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a1709064ccd00b00982a077599fsm1004254ejt.110.2023.06.20.02.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:31 -0700 (PDT)
Message-ID: <0f6a1ed7-9f0c-7153-1016-62b1336d2685@linaro.org>
Date: Tue, 20 Jun 2023 11:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/9] ppc/prep: Report an error when run with KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-5-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-5-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> The 'prep' machine never supported KVM. This piece of code was
> probably inherited from another model.
> 
> Cc: Hervé Poussineau<hpoussin@reactos.org>
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   hw/ppc/prep.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

