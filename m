Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38194736743
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:12:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXPI-0004vP-EN; Tue, 20 Jun 2023 05:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXPG-0004mv-HB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:12:10 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXPE-0000eH-Rx
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:12:10 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51a324beca6so6009794a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252327; x=1689844327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hXWkUbCN8mCx3bzv7BwWRwJ3Kc3wo97oFFfvsnwxyvY=;
 b=h2aKcWKaHnQQCGATJZuukNYQV/+8Hwme7WR8aC7PSVHa12TxIeo4o274LyDMs1yyoW
 2UemGQUYFoGO/2Nw+1/lZlIE83hxPx0trXsvNHxxnYuxiwn1tmqBFJJS2/tWIDJ0CzJn
 H0ARRBP6YOKHIcc2VSkI7vxoKx8asoT+jynz2PXbXMhRy31Ff2uac1q2MpHgFf6s/GRa
 4iB4ZNGx35GRNy9DmKkH7lygqaWCVoIzDCnuOMiC7J9IVX1L4rb8+N3qr6bv6Rps/xaB
 CbgsFOLsXHG1Ld/a8xbINBIj5+NwcULFBBc4iUnHDGCSn6S3UF2mQw1XRDA4X/xkMcYL
 7gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252327; x=1689844327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hXWkUbCN8mCx3bzv7BwWRwJ3Kc3wo97oFFfvsnwxyvY=;
 b=absERRiyhL27RmYllekxUPtLVk8Ws3904queXhcNlLldjQkRRe5Dgv2mDRR25XJPhx
 ZbDdWddP0v586npO1B8G5de6MDFM5dTZj8X+gW1tyNS2tiPWa6cWvyhkzKFaugXB0JxG
 9c8uR8drNZwOje5gq9fwa6AAZRCYq2kVTCNAiippbT8yEFkUQ/GztjFxTnbJ3jknmO3n
 XFSn7z8rMknMacxoYWebyoBVhv4kQDelbZvrdFIhid69xtR3NtZt7zZEZqnNgk2l3GkP
 xkxK/HaacNZw5CKhLr7Eu2R1T5MiWezkVZkGpmK1nbNf9vRT8fpd2nFzDZvfXow57BQg
 RKkA==
X-Gm-Message-State: AC+VfDyN0GYqetZCKvHZGo0cRJAPv3almpKqcjblq8uFkJaWiftAFOJD
 5sydXz1kw9yKM39XAYhZjwg7Vg==
X-Google-Smtp-Source: ACHHUZ5CE+JkfNuThiWpy2Kem7RMKchuAfP+1QyoqLpW+JagZJWYsX0+NFdWmc03hkAlIwWV/Q6v4A==
X-Received: by 2002:a05:6402:759:b0:51a:7bcd:a82d with SMTP id
 p25-20020a056402075900b0051a7bcda82dmr2812949edy.23.1687252327487; 
 Tue, 20 Jun 2023 02:12:07 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 h3-20020aa7c603000000b005149b6ec1bdsm831776edq.29.2023.06.20.02.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:12:07 -0700 (PDT)
Message-ID: <b5a9c470-d499-fdaa-3699-b1d66e9262ff@linaro.org>
Date: Tue, 20 Jun 2023 11:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 8/9] ppc/pnv: Rephrase error when run with KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-9-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-9-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
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
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   hw/ppc/pnv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

