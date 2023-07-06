Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AC7497C5
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKlj-0005Qs-R1; Thu, 06 Jul 2023 04:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHKlh-0005L7-3x
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:55:17 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHKlf-0003mO-7u
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:55:16 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51dec0b6fecso651325a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688633714; x=1691225714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2MX8Qya89grbHJBV5GtzFiJrwHPygKrxoVfh20qfAXs=;
 b=Ji4VBs8hb4m0mw6iwsLutsF/Y+wfahhSjtwr7rDCvDjMyOj6rp3zH6OLUf34NxyTy+
 8MmxpidnU3GZexNLgiopBCXhLK+1mFPAw5rSf4UlCeRA0BEwZpiW+0S+QZ0E2g68F4Ky
 NT95g0qVRXrB/srUciFPTuYu6hsaMunFvALz2COCLuiOBUJ5CFG8Q28BLjIu0v3EtgI9
 UyKCWrOr32dci8pGxJ+sfxkb5Eiund3fGfEUcNCvxRfT0X0wDmYis5nC4zdLO4uOs9tn
 Ge2Ngd4ZMktIsI/kqfomQnbePVOc0XJNRRxo9hnH5wjTsZXhsn/wlxB03fRWs9mQd8l6
 zaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688633714; x=1691225714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2MX8Qya89grbHJBV5GtzFiJrwHPygKrxoVfh20qfAXs=;
 b=OnGWcjSOO13LJ0PV3pie1sWQXAxoaJvqRV5cMPRfMdOZcALV+x/BLc3hs6+U28Q7Se
 09F+6hX6MAVtArH/DgQy7HAPkKKC9yTexOYMXsHfNfUqGYQwGwfbq2GsOygxLmVqP5Vm
 BALCw+mxekc3SyexbfQSlGUI+yLOXzSwH1fOJrO/1PY61wKju6Bw9Sjat62SFtYr/DUX
 7oqdtnJO8+p4QOf3hctzkVsVN+v4TO0UHO9zi+ulfyTHnLOu778I9FeiJMtVh/YqoY00
 +sAdzpg3GwRifVg1micfiW7OTWZJwt8eBao9eHjNgFHOgbqjWQVzChGCmt5ctw7mMARf
 Oydw==
X-Gm-Message-State: ABy/qLaNJJviMgFwHWywPRi8euPapwxPOonhwOqMmUnFbVI3UFllP4aE
 kiI/RDLNyMzwdPmD+28sz2Ew1g==
X-Google-Smtp-Source: APBJJlFOH48/4ZtWMY5CiVAzEHjbk/lsb5VWEdW6k7+CnQ2tRTrfHFKRSm5H8ybNYQxCTRMSK2PcAA==
X-Received: by 2002:a17:906:72de:b0:992:ab92:8d6d with SMTP id
 m30-20020a17090672de00b00992ab928d6dmr890653ejl.74.1688633713843; 
 Thu, 06 Jul 2023 01:55:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 jt5-20020a170906dfc500b0098822e05539sm524573ejc.191.2023.07.06.01.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:55:13 -0700 (PDT)
Message-ID: <639f7aa6-37c6-7680-dfd6-3c2d7cc35329@linaro.org>
Date: Thu, 6 Jul 2023 10:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Log all unimp warnings with similar message
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230706024528.40065-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706024528.40065-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 6/7/23 04:45, Joel Stanley wrote:
> Add the function name so there's an indication as to where the message
> is coming from. Change all prints to use the offset instead of the
> address.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Happy to use the address instead of the offset (or print both), but I
> like the idea of being consistent.
> ---
>   hw/ppc/pnv_core.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


