Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E10736F0B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcdt-0007SN-LM; Tue, 20 Jun 2023 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBcdr-0007Rv-3I
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:47:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBcdp-0000MJ-Iq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:47:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso589018366b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687272451; x=1689864451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Js052Fw3gqeRmxwqLZmPRf6l53QXe8esLD+k1uAI8yE=;
 b=WHvvhYPb4ALwoeeq1afnihZP/B9y6h+InKOV4bSKoK7wwlGkUC8+xSG3u2lIDSwYAn
 U2g3wgxUnYhVLJFrlEjeC5sF0zck6sP1/vMoG5t6qMHOOEhh3FmobicIuQpxk45ObaKL
 oP9hfjTjQ4a6ocrYvdEIqzs3b7sTBbP8nYcfnKRIsjKdzz25dflOjdb3XZQhwfgXakNc
 SvBn5ym3LmRB4CYWqQnGl9iS7tj5ez6b+deTPBk9mGLNyLw62qIWIzGiwbV3uuBzLOLU
 EP0Xa9Ps1wWo60eH80XJ/DFkhx2Bf607NvPaJx3RObvZWux7H3Aa2SKuYOR+dXdZOm10
 lGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687272451; x=1689864451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Js052Fw3gqeRmxwqLZmPRf6l53QXe8esLD+k1uAI8yE=;
 b=iDYV0looCKrf9g7LGIZvrUCvCsBEa2bB0GtkQh976jkq2IY5qO8xX0UKe09XYQcSRR
 TGvhycEaks5UkfektPB1FaYdNipjG0SwOOksQy446Nt4t0T35462IEJWAbsCayNxg4NK
 khubeGDrNzPtB4w2+yKx3OYIjnG6dK1nYHsh7ZKRUqwL5DPG6BZBUkXCDtxI4NEywRzM
 Ww4Ytz6lRkwAcJP+DA91zsyAm84wkvQFTQPyGrMy8CBX2uqc8G5Dzg1d82DkmUWv6bnh
 V/mui6ULw3Pcp4ygbZ0++bwtsyfB/30flpIBXfjhwiSwHgNP9qeBBoLPRi/hNvxyT4dO
 m09A==
X-Gm-Message-State: AC+VfDzsxW8Mj2ZiH2vVftxY9oGaAzW/501hu/Bhx6gAUc9Z7b7XCljS
 XwJk7aaQFT7O6USlHGb2SDtRag==
X-Google-Smtp-Source: ACHHUZ5n599PBQhDc6ApA/XsAsb/cjnZ7FGa9x+8pNNFFyChqoLkDnrulntm01Pj/mvjmcSTruLfSg==
X-Received: by 2002:a17:907:9624:b0:987:9852:603a with SMTP id
 gb36-20020a170907962400b009879852603amr10244926ejc.26.1687272451408; 
 Tue, 20 Jun 2023 07:47:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709061f0500b00973ca837a68sm1534687ejj.217.2023.06.20.07.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 07:47:31 -0700 (PDT)
Message-ID: <7b778d89-edbb-3de2-ca1e-43b326f4406c@linaro.org>
Date: Tue, 20 Jun 2023 16:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/5] target/microblaze: Define TCG_GUEST_DEFAULT_MO
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
 <20230619142333.429028-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619142333.429028-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 19/6/23 16:23, Richard Henderson wrote:
> The microblaze architecture does not reorder instructions.
> While there is an MBAR wait-for-data-access instruction,
> this concerns synchronizing with DMA.
> 
> This should have been defined when enabling MTTCG.
> 
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Fixes: d449561b130 ("configure: microblaze: Enable mttcg")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



