Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C008A7AB914
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjknJ-0004YQ-N1; Fri, 22 Sep 2023 14:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjknF-0004YC-K3
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:22:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjknE-0000tb-0U
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:22:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32008b5e2d2so2000001f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695406938; x=1696011738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TzcTfdX9aeSr7V6aiUD55g2o2awpIPFdj+aa3CZBmT4=;
 b=c4xPqcFzGNhkqBx2pruCzd/yuc9ltEFoned+MEL1I+ZjGH1t/3Szbvicu79yiKKw07
 m6Vs2qoMxgfDMgZOZ5MJdFKOXCit31S7IM2dYlFyLf79dJWDLyZnJpNTSIUtXNWX1F19
 6ZptMnChPcKNa11T2DpcZ0H4C3eTCyAH7zxgLZFazHJHgon/ELkihswrQEK/eAr0zhVz
 /UBvexkSzX7ODqeQ7ux2UeQpa3krvyTMHF4NDR7bWULuOmTVQiDwa3i9JRHg2pcOWrv8
 iX6IrEC9TstNJ+Rs25ODlGichurlbfUjN6PxqqG0WsVyPKGX8uHUcVnv8C1mkrxevyYK
 6vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406938; x=1696011738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TzcTfdX9aeSr7V6aiUD55g2o2awpIPFdj+aa3CZBmT4=;
 b=CQb+PaRoP0w0EIV5fIgE1pVehbHxyh64Dqk0By84ruaNqEYcdGa/rCni5kAa8b/gBz
 sYogz+lgF4PHzeVvgHdD7nAOcGgaMql7z7GBlSJiqI4z6U5x/5NfbwOnLIjF3Sjf+lzo
 HjDPkiv0NOJMo9Ghsvc44YNbe2+292jfmOapC29UKtD5HMqNUo8EnaLvc3THVkJVWdHM
 dNOaH/MLvK1pZ7NBwQdK/XZyhJeX20HLdez1ash+GUdj2pUOKZSvF7lWzz59MlhexwSl
 /haz3A442WaST0jfl2gWVRzctNl8pfBwj7qxaFS1Lx4Mg2u/83MwND6ZDxbCveiru3tL
 zLkg==
X-Gm-Message-State: AOJu0Yy8Uv4kCTqWIda+AhjYq+ppB07uQ/MXIYH5tAdYFRGjy/01jEZa
 DmhGJXcAapYKmZJNRT7qD0iIqtsMuAlFMXKt4eb/tZV1
X-Google-Smtp-Source: AGHT+IFrIztj7LJDvC+P6KycV8uo7xGcGFF5+IpFmloXKDOG4Rv+KLQtrMHItLXuiiwnbHlKRX28uw==
X-Received: by 2002:a5d:4852:0:b0:31f:f710:a943 with SMTP id
 n18-20020a5d4852000000b0031ff710a943mr2435415wrs.15.1695406938459; 
 Fri, 22 Sep 2023 11:22:18 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 b12-20020a5d634c000000b0031ad2f9269dsm5043110wrw.40.2023.09.22.11.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:22:18 -0700 (PDT)
Message-ID: <b96eed12-c2a7-9d56-19db-6118730ac26b@linaro.org>
Date: Fri, 22 Sep 2023 20:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] aspeed/i2c: Clean up local variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922155924.1172019-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 22/9/23 17:59, Cédric Le Goater wrote:
> Remove superfluous local 'data' variable and use the one define at the
> top of the routine. This fixes :
> 
>    ../hw/i2c/aspeed_i2c.c: In function ‘aspeed_i2c_bus_recv’:
>    ../hw/i2c/aspeed_i2c.c:315:17: warning: declaration of ‘data’ shadows a previous local [-Wshadow=compatible-local]
>      315 |         uint8_t data;
>          |                 ^~~~
>    ../hw/i2c/aspeed_i2c.c:288:13: note: shadowed declaration is here
>      288 |     uint8_t data;
>          |             ^~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/i2c/aspeed_i2c.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


