Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E37362AE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 06:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBT73-0004lz-Cg; Tue, 20 Jun 2023 00:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBT6l-0004jr-V3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 00:36:53 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBT6e-0003zn-Nk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 00:36:42 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51a4044b7a1so5217523a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 21:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687235798; x=1689827798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GymiMp2FbK6bfKAur+gZrdL0hAysnLJjkwE1TW0Ggbw=;
 b=xxb7JHEYBUtvSNRqic5c9bOML+n+p5m1AFwPB/aLMV2ocSbkegSkdkZQ0UsHLaKnF/
 XtC60FcKDwDIZjUhOq9e34I19Yf2ndGNR0tpw2Fe2ZKE5opASvcaJ1hNmjGd+o7WKMqu
 qPVyiitgX5s7CYZhqPDGyUNomgQRZwH8cvGBILCTatV+veMZwbgdmTSO5zMKWn4Z3T8i
 iUhTiyK0oROf0DiXMnrQycqN1frD1ljmj4cyl8+5+FNNvZhaVBM7TqeLSkyUNf6xH/+w
 b8PnkKNlhURs3wnfCDsgMKo0D7nxKQTpKjumrFcr/EaWsa1x7p98s1qBcs0SWFoAvmUm
 gLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687235798; x=1689827798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GymiMp2FbK6bfKAur+gZrdL0hAysnLJjkwE1TW0Ggbw=;
 b=OdfpUF9sF746eQTFWmP35EqrlQqu5lkfCdyZjTafSVUDOHHK8jDa9w+HoNxowldRMX
 lpyuqfctKo1gulUbnRwJJBtBdx39aGMO5ynSVdLXLsuRzYndWBbEvr79L6bYPSBCeyyt
 cJT8luCWkfL9J1I4c5UxpSWv3l+RigzLrD6o83z6sJpE3+YQOyyulh4MCmFMRpNugGkd
 O0+HXasiQ1f0A0W4k5RGTfKTmP9xX+yegvi1ypDI+txvTZ1aCgzLK2LQW+UQ2goQCUHY
 ZcU/wpBECBfEWjZI9/3an8IPEb+BXWlxEnVmpx/MeQG1AJ8L3C5k49auoJB0Qn3mbZHW
 2QIA==
X-Gm-Message-State: AC+VfDzIw2Bad6dYlJwS7RfqkLIGa2jTNrkTQ39wDsDiawvQ0K1F8pnq
 U0LFdliXI9YXu0WAS5vLUrDp6g==
X-Google-Smtp-Source: ACHHUZ6dEKkalovIvCWnShF+m1bowfjNeU2F0mXSoVsjscxZinjcU8D3q4GG+nXw1BZGU+pCXLXdNw==
X-Received: by 2002:a17:907:2da4:b0:988:806c:62da with SMTP id
 gt36-20020a1709072da400b00988806c62damr5342536ejc.58.1687235798114; 
 Mon, 19 Jun 2023 21:36:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a170906381100b00982bb85e8e4sm626714ejc.18.2023.06.19.21.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 21:36:37 -0700 (PDT)
Message-ID: <77136248-92e5-ab53-a1b4-ebce8497b9dc@linaro.org>
Date: Tue, 20 Jun 2023 06:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] include/migration: mark vmstate_register() as a
 legacy function
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619171437.357374-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 19/6/23 19:14, Alex Bennée wrote:
> Mention that QOM-ified devices already have support for registering
> the description.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/migration/vmstate.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



