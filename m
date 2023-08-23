Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6890B785B44
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpI1-00070H-KR; Wed, 23 Aug 2023 10:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHu-0006zh-Ov
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHr-0007fQ-DT
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:49 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so1174565966b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802604; x=1693407404;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Skxjv4S52TkZMfWTg8KjkXb8vUy9V7KmAADdam5qwCk=;
 b=Ogj+yjx+JqJugGRxDJY2vtSfAqOK9AfNyacI/WKPOZh9fAqzO4cKyuTjzIpBIQhYal
 qE9aFbtmErREgAXoDWyxRx1zo36oqTl9Vqq/PtI78doNiivf6tZsVfUr7689Qs4xaFOG
 dlSr9pardPG6+0TkFEJs87IgCkd6GjDF6TbpWv2DzQkOuxvJO2sLfl8AclyIs90+pCU8
 2SMzYYF7x7fQIBf5QZ1570Hvr3clPiF3KESR66eVcdxvogMn2reh+Qb7C2J0ZhW4jdtf
 m51aM5aHHRPrKP2udlkQIMFKyX8HN7CfEg5kCt3DWb7AkmVNVRI696Ca0Yh7f0w1wlMm
 6zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802604; x=1693407404;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Skxjv4S52TkZMfWTg8KjkXb8vUy9V7KmAADdam5qwCk=;
 b=UoIPEE2xZ67XLg6ZX6i0jGTOr4WXIHWnVcriZe4GxpbOF1n2iIueLkm5YTCwsCPXAf
 qoq175LYYrwEOPIi//cfkOWAokKbOO+slziqyCYE/7kn3ZNdGypxSc7vNW2yZx8zcQES
 Ycx7+hb3c8CbHJSuIQye3/u/EQNPtDyslf12yPMb0Iz513eOk4bbb1gYk/DEaViTpU1F
 jyhKMHQg6rrw/yVKciw+sDXr2w5cnZHGE0UNTaj/mNcMDLLJ77LpOvW/tC5WeALvrljL
 IaxVF2/AxXd48cT+RDIL4H4lZ2Vio7E/nNziGuEb4B89joqtzu/akQvfFVLOo/FLYlVX
 tzSA==
X-Gm-Message-State: AOJu0YwjvQpYTFfI0bOxJWVumyTvPkaqTDeCbby2S6qIaGFZu576IGag
 218iSlggxchhk3oU9GDzv6YLlqy/r05ZlnWgqcE1KQ==
X-Google-Smtp-Source: AGHT+IGxMVkdECOx+T6wJQEOYtujFzxN4l01IqP/vWtDUulx8H3L2phH5UvI4u/wW9xKDkX1nC/gRg==
X-Received: by 2002:a17:907:9717:b0:99d:ae3:80a3 with SMTP id
 jg23-20020a170907971700b0099d0ae380a3mr14620831ejc.0.1692802603970; 
 Wed, 23 Aug 2023 07:56:43 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 c17-20020a1709060fd100b0098ce63e36e9sm10047556ejk.16.2023.08.23.07.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 07:56:43 -0700 (PDT)
Message-ID: <494b3e93-5dd1-bf18-56d0-a247483f38b6@linaro.org>
Date: Wed, 23 Aug 2023 16:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] docs/devel/tcg-ops: fix missing newlines in "Host vector
 operations" section
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230823141740.35974-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823141740.35974-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 16:17, Mark Cave-Ayland wrote:
> This unintentionally causes the mov_vec, ld_vec and st_vec operations to appear
> on the same line.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   docs/devel/tcg-ops.rst | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


