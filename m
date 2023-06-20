Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF84736737
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXOr-0003p9-NF; Tue, 20 Jun 2023 05:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOo-0003nm-NG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOn-0000Zq-3n
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-988a2715b8cso379273266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252300; x=1689844300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eUz3DlKwLnu/e8cj9r+UiutdLzhG34IzY6xkzHPNaaU=;
 b=dIuz6LtsUEtrIN9cE6Ug2p4uks44PiJ9Sa7MleeQSq401kni6opc5p5eB80J+I66Ee
 A8kmtY7PIh5ReX48qKUWqV/ggbXuNgJrD7p4vKo6Z9vf7CcD/VK5ZBNcUW/74vc6Vnox
 zpNlyg6YiEZNvyefrtmXpZHlcBsVIYPNTr5a+tWk2WcFRB6MdWloLG5DJ+SmDScZ8u68
 5Ar/dZLhUkmuwHGQYxmfK138rQTio/zalqc5ZXfs/e7BS0axUGzr0K0zhVzXaVrzOse5
 zvVf+oY3tjA7YRho86AAbiiMtZYLtY4FcrBweXxrfzQXiQ8C6wenCgr1kVN5gxA4kOyI
 3fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252300; x=1689844300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUz3DlKwLnu/e8cj9r+UiutdLzhG34IzY6xkzHPNaaU=;
 b=UPCYRdFor2TvGZOZhfH9+pTOE4rE+sfSJAjmjuCe6sdbhtAyM9zr7QmJYc2F+A8CbW
 Ff24eez6tz3uttJ79fwSrO6evLWhweVP1yBe1JcEGGpBhDmavUu0tS7Pg/9mhkLhYeew
 fDKgN+LPnHY+eGn/kV8sPNbknjtGp3IFPfbBxUm5IyZYqiBI3ZLPU5XgWT6vQkxRh1L7
 hBzbutpaQQGq25mh8/S0LYR60sJxW7gPL2cpT3PLYOBXY8r+JoKa1bOgh+p1SkcY/L23
 U94kr3WnbjJsbl3exc3ssAaxq0CsEXdvVdPwFd7joJOFxzQt67AlczBph0+5voDc/VDu
 fLVw==
X-Gm-Message-State: AC+VfDykK5RuBjXB+t2SCQG75eN8cfyHIOL3VBRRYIHXLn/WIb9b2Jc3
 O1sZfp3fQj5OlEd+T0b/bpuI3w==
X-Google-Smtp-Source: ACHHUZ5zUNRqEgMw2Zh+RFtIsy3l/UqkAkkTsIySenprF2ClWar/YRZUbs8hKzcIZu5+4+IXKrUVxw==
X-Received: by 2002:a17:907:7d86:b0:984:25ab:bb2e with SMTP id
 oz6-20020a1709077d8600b0098425abbb2emr9863478ejc.3.1687252299897; 
 Tue, 20 Jun 2023 02:11:39 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170906374a00b00988fe829d66sm1045585ejc.35.2023.06.20.02.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:39 -0700 (PDT)
Message-ID: <56ebe37e-d252-53d2-86a7-8e129b34fda5@linaro.org>
Date: Tue, 20 Jun 2023 11:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/9] ppc/pegasos2: Report an error when run with KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-6-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-6-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> The 'pegasos2' machine never supported KVM. This piece of code was
> inherited from another model.
> 
> Cc: BALATON Zoltan<balaton@eik.bme.hu>
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   hw/ppc/pegasos2.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

