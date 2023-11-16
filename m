Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23C7EE139
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cBs-0006yG-2A; Thu, 16 Nov 2023 08:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cBp-0006xE-6s
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:13:49 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cBm-00024C-JN
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:13:48 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso1208569a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700140425; x=1700745225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BjHr6lsSP8bNMGrU+6gn7WIpj6FMhww5OQNzSo2gfDk=;
 b=FRJLP6BPLA3H/WTROOTmLYKrnsfqQUmilJWUmVB3R83qz+uE3BtDzCPQh+XeozT9sI
 41DQ9wdMCM3CfM7XT+MgV8pHeaBDInXjzp4IYa/DawatYLf695X00gRzVdc5V2n5c0MR
 7eKuoJKXyHC97nb/BJWgtWJ/hPJFjOhydTSl4kLqsMFnFcHltNFUI4DkNN+raa78+NhT
 72XesGSfhBnM9Yw+Ds+O/twfAQ+JPECUl7WtuHyp8du+3PuaRqJ1N/cniEyzudGBY/zs
 1VX+6nsbi3Ih0FxfhBAEhBc6x0OO/JpSLcVL8aDdg/WPySUlXHHH72PU0pY8WB8qMeP+
 pmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140425; x=1700745225;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BjHr6lsSP8bNMGrU+6gn7WIpj6FMhww5OQNzSo2gfDk=;
 b=QlGt48CJRNxXfzuqtE05GGbgqFi0a8QLAD4qi7/hE3Uee/yhDZQjKuf71vKIDthm4s
 1iWiKhZHcxEFGbQOF/vzr9zK10pR2vBF8qkQIyZNsowi4AdxtULPXv3qvwZP6B08MjAr
 Y18OHNQYJyCtfNrpjK4gfEcQpqqHLGI02Jbi0KERDbtDZtuTrylinSn6+XeSk8QpmWYI
 m4GO9kBGKL+1oc//zZlHZ/2hXxaufiaqx2nUmloWgmDULlkwRokreV5c+8rQMFWd7vxk
 cVDsFCng2+2K493mMA6j1hZOrnyg4/ti9bg525Xj66/LqXFP0cpOVbJTSt5eOOuBtgz3
 Q+Ng==
X-Gm-Message-State: AOJu0Yx/t43NJfdRLjoHgfxebH+uFQJ2pGK4KTBB7XzaPHGe/c0oQLsx
 iXre7+wIyRkN/7ZxEEDE8t0oKA==
X-Google-Smtp-Source: AGHT+IEtAW9g/2HF0ODVNxihCI5zGLWUP9/+zpQrRuf7uTyP3Da6tTKaCZXmgeJlLvQE7kqjch+LXQ==
X-Received: by 2002:a17:907:9455:b0:9dd:79ce:fc72 with SMTP id
 dl21-20020a170907945500b009dd79cefc72mr14417608ejc.71.1700140425100; 
 Thu, 16 Nov 2023 05:13:45 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170906080a00b009a193a5acffsm8415558ejd.121.2023.11.16.05.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:13:44 -0800 (PST)
Message-ID: <1d8bd393-8edb-402c-b375-f4bc0f3e6edf@linaro.org>
Date: Thu, 16 Nov 2023 14:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ide/ioport: move ide_portio_list[] and
 ide_portio_list2[] definitions to IDE core
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, kwolf@redhat.com,
 jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, shentey@gmail.com
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <20231116103355.588580-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116103355.588580-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16/11/23 11:33, Mark Cave-Ayland wrote:
> These definitions are present in ioport.c which is currently only available when
> CONFIG_IDE_ISA is enabled. Move them to the IDE core so that they can be made
> available to PCI IDE controllers that support switching to legacy mode.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/core.c             | 12 ++++++++++++
>   hw/ide/ioport.c           | 12 ------------
>   include/hw/ide/internal.h |  3 +++
>   3 files changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


