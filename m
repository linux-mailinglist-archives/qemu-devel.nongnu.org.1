Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C37257A7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oXK-0000tr-C9; Wed, 07 Jun 2023 04:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6oXI-0000tZ-VW
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:28:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6oXH-0002Ol-HK
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:28:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30e412a852dso2674925f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686126534; x=1688718534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ymjBykz6oPkeD2DnN/+SlsP633S5A1gJPG1IcrUGQU=;
 b=CMNu3B2irewPXFGkFCykjhzSkjfgLf5XHuLQqIM29C/N71De//ASQzev0vxJYlmBrR
 2oMlIt4YunpjzwX2OOkwOMcEswpcGOx0sTBluTb+13rXsfoxbOnx3NZ4U0Bkrlb51q0o
 MlT15Hgk8mxEKZWt2ilBVd2nZsCvhooi7ky7EEA9tuIMb5m2vzyEFj5eHZrHCeqOLTc/
 4shAkMjmbEgB0PZDDrQnodmVQL095BtKDfHeFYMlV3u1o8Th43EFkaz2pDsV49Qu6Ros
 zAy0ArKD6ryMYey7lGYVgVPo7krMcpooJOWHmsDelNepkKCC11AZw+OZ/771Is7uQncn
 X3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686126534; x=1688718534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ymjBykz6oPkeD2DnN/+SlsP633S5A1gJPG1IcrUGQU=;
 b=gLWgbxfzeIvSv6L38x2gyoiTNu06WM0/coITzSndvuqO75KmMWsGdoSt8dGjt9aA+u
 3B6ODt2wOpFfVkHiFBILie4bTyQn4y96PBjXiTnm0+chKvXNH8Bp6hQqw5I5/gqAEwa6
 TwDhUgOHGUzfqCxft47OnsEPA7lse4iRt7XHk4W/gpQvCgTfi3HsP/BvALYko5Ar0ePo
 uJ3aPH3uqrEpAe4UMLAKae2zO+WiMcMtTg6wJ4/cJcAWuFjASajm3I8WFkcdtgwSVq39
 USYpd5wlwpSqtp6H0mPQOOx14rMrvnFRPpqdq4YC4O/kte8j2QYeywdE70ujrmY3EyVo
 hntQ==
X-Gm-Message-State: AC+VfDwiU05jdzonRg/tZNrQAeZp5O2q401xzo5AIlqPblv4vFK6iD7D
 TlwCGDxdCNFE6OQJH4wOGO78yA==
X-Google-Smtp-Source: ACHHUZ6CHEcHbUZ+NzsIEW0rIKaUVAc7Mcai2MyGMRCcEXcEVTb8SvhDGAJQj8b4ohn7Nnwzybmgew==
X-Received: by 2002:adf:dd05:0:b0:30a:e378:76e with SMTP id
 a5-20020adfdd05000000b0030ae378076emr3358951wrm.64.1686126534031; 
 Wed, 07 Jun 2023 01:28:54 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 d6-20020a5d5386000000b00307c46f4f08sm14797784wrv.79.2023.06.07.01.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 01:28:53 -0700 (PDT)
Message-ID: <62e69c35-4869-8cc3-5983-9f83ff649da9@linaro.org>
Date: Wed, 7 Jun 2023 10:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 04/12] hw/ssi: Add an "addr" property to SSIPeripheral
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-5-clg@kaod.org>
 <CACPK8XencE5MMgYdQ5H6iV_rTHaynv-UJYHZy=y-DaCXYBWWXg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CACPK8XencE5MMgYdQ5H6iV_rTHaynv-UJYHZy=y-DaCXYBWWXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/6/23 10:06, Joel Stanley wrote:
> On Wed, 7 Jun 2023 at 04:40, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Boards will use this new property to identify the device CS line and
>> wire the SPI controllers accordingly.
> 
> "addr" and not "cs" or even "chip-select"?

"chip-select" is a good suggestion!

> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
>>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/ssi/ssi.h | 3 +++
>>   hw/ssi/ssi.c         | 7 +++++++
>>   2 files changed, 10 insertions(+)


