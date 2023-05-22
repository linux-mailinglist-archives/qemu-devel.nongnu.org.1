Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC870BFEB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15nY-0006ba-DN; Mon, 22 May 2023 09:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q15nW-0006bN-Jh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:42:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q15nR-0004Wq-DO
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:42:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f42c865535so61865905e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684762916; x=1687354916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54D1bbj/xFjc7rwByQhrtuC83B2Ki1WixTDw3OT/3Yc=;
 b=f7Bn1C42A+AMGuh/qIdBiu1nL3OqWeJr7d5uryJks3GLKNdUkMLTf8bI1O4RIbNG+e
 2hiRi3w06suaNO6dpbNclt2SIzhx7pTmnA3xT2pdYBnA3I0nGilRtkIMy9r85GPf4I/p
 cDnchLs/+9iWbnrQ+BsWOWAiQL2ZCIKit6gKB2064VoIrfrdLswpjprYZPkB24G8cNTy
 aIxLzAABwxqNuewsLgkUpDOgoUsoUsLZM0kLcFiUnQ3o6y3QnuIX92vplopjgYI2N3nZ
 WVF3481RZiD5Kw+W1/yn+hsDXp9Swi22IrDK1qwNT8773/kRB90RVX7ACIXkurGigpg9
 gjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684762916; x=1687354916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54D1bbj/xFjc7rwByQhrtuC83B2Ki1WixTDw3OT/3Yc=;
 b=KK/WZQ7p0y9MB8MKvz+FRvpi1Q6EcCmEGHgIahqLXMOVoXTYGdZa45umUtw9AeapeN
 bQpWT4NkiR5ddFpkW8rQz/EdzahrNIW2gIVGx1VOD1cOmJ2ofLRPDtA86NQDUc/5i+hi
 NDD2ubZhLhtbks/pPyff3Fm+XLzaS4BCQk5NDqyJUxpxIkW+SC/0Gt9g/yDmn92KeCR2
 KUyhs0TObKLzvPmjXNWpeMerhfeT3AssjuszvByCTISAHyhqnxwz4NHWV0kKHNyyiBhS
 kx4U11kgNiY8g1Q+QOWlhXM8rGKYvTiRPZH+efPRp5DUEZHfBpqzGhg/b6lV1uqOetKr
 BBKA==
X-Gm-Message-State: AC+VfDxA5eoRrbaHe6lFZ70guiPno1K+HDzJRHujx42DaZ5zI5MB3aWD
 j7U6ul+VM8TMGAjgk7bB1SQKYw==
X-Google-Smtp-Source: ACHHUZ5PZ86h7co4DBNtvYe36OFVSYGIVieUQUf712qUrjbY+m/b2P/kvZT2MiK2mZgSr6Oh0WHqXA==
X-Received: by 2002:a1c:f311:0:b0:3f4:d18f:b2fb with SMTP id
 q17-20020a1cf311000000b003f4d18fb2fbmr7770928wmq.8.1684762915822; 
 Mon, 22 May 2023 06:41:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a7bcb99000000b003f195d540d9sm11706329wmi.14.2023.05.22.06.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:41:55 -0700 (PDT)
Message-ID: <7fb1818b-7ed9-975a-3fa0-ebda7553aa73@linaro.org>
Date: Mon, 22 May 2023 15:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>,
 "Kambalin, Sergey" <sergey.kambalin@auriga.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>
 <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
 <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>
 <CAFEAcA8bLr+_raHie4JxoEJAQ7cuj5nJKTYt5+7r6T0w8FFNsg@mail.gmail.com>
 <ea63d09bb2d249b282a429ff9d373e4d@auriga.com>
 <CAFEAcA8HMgJ5_WwC6Mc5E61_KN4kqvpW6AE_EyDf-JcrFVQJMg@mail.gmail.com>
 <672004b332154e15b14e4e96d20a23de@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <672004b332154e15b14e4e96d20a23de@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 22/5/23 14:41, Kambalin, Sergey wrote:

>> Could you please tell me what size is appropriate for a single patch?
> 
> The most important things for patch splitting are:
>   * everything still has to compile cleanly
>   * the contents of a single patch should be a coherent single
>     thing that it makes sense to review in one part
> 
> If there's something in there that only touches 20 lines of
> code but is a coherent single change, it's fine to have that in
> its own patch -- small patches are easy to review.
> 
> At the upper end, I tend to think a patch is a bit big
> at around 200 lines, but for the specific case of "here
> is a new device" bigger than that is OK, because it's
> just adding new files rather than merging changes into
> existing ones.
> 
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html 
> <https://www.qemu.org/docs/master/devel/submitting-a-patch.html>
> has some other advice on patch submission, if you haven't
> read that yet.

FWIW example of series adding the Pi Zero:

https://lore.kernel.org/qemu-devel/20201024170127.3592182-1-f4bug@amsat.org/


