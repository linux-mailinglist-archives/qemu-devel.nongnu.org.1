Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC37847A6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUIR-0003D2-0u; Tue, 22 Aug 2023 12:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUIP-0003Cp-Ez
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:31:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUIN-00041l-8b
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:31:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso2201684f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692721913; x=1693326713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3wbawRQ3OaSsz6WrInodZ42QFgCgOUhUCYeU5IWIRx4=;
 b=SroFX7xcGRJLOQDlWwcFjWiA5PxxZRKrZAjwRpYVRSRhQoI4V48Lb7Yb4HLaUBKrd/
 1yqEPhraOyHZxxDcArjH5iNi7a4DXkD0WDwzYc0rqSjISr8emdylp3Nak1BLSfFsziN+
 5k3coMcucnOGHU7Jx3vr0sXTdHuYb1ra9xuo6omI4ZX4vpqJMQQK8SSXpVjSaDvIyGEW
 LuzGL4KwdtHEdNZ+AFU9yvqkFcl/hYvKzn4HDB9U3FGYiltnzVRc/tnTZGtCrfo1pwUR
 nAM170+W9zE8UjF31+JHHvyuv7f7Z1Uo8YG4GnlR8Kcz6rIPu9z0cWCusteF35VOlhHX
 qToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721913; x=1693326713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3wbawRQ3OaSsz6WrInodZ42QFgCgOUhUCYeU5IWIRx4=;
 b=DY+H2Zw998W0BQBAETwSnruciIP+BJKn8l+X/UWGYx/InwtrGhdwcsszN7LTardpxt
 6qkBeTN0OXxZ0fhbknaZbFxUVspRzHFQisHL9m1oICSelO2yb9hwFVWTXsLcija4BiVU
 ziVI2jEimTiF6UOeAaEWVwylyF5/32HSGIuJ0afauzZPNCn38v38lxdUNPqcKlT0vBT+
 rQUYQqlYBmSm68e7OLQh3eqM5hXNSjaR49wfYuqwAoLIhRbV2mEvM1SK1U4E2xIC3XvH
 LJRPkKxDyb0X8QEhtItGL4Ef0rA0NaFowPK2LpnuLX+LStYPi34kyUZOkag8IBG0RnxH
 FP3g==
X-Gm-Message-State: AOJu0YxxKvjICYd3fVZNQnOCCD7Xcrx7U+W83oYv/vdFezWxyS2HkCSa
 HTjiGdika+1supuJxekG4xQqXXFN6Y+pFdgdmGwGWQ==
X-Google-Smtp-Source: AGHT+IHwqh7mqHl0HHSZExmIvbINghiFBjHu5ck+HRlsB34kLW0xwxUZYi8H5WxKhRc1xHJR9dteZg==
X-Received: by 2002:adf:f80b:0:b0:317:df82:2868 with SMTP id
 s11-20020adff80b000000b00317df822868mr7704144wrp.26.1692721913571; 
 Tue, 22 Aug 2023 09:31:53 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm16304630wrh.44.2023.08.22.09.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:31:53 -0700 (PDT)
Message-ID: <2a954d90-1489-3c35-0105-0135f42ebf9e@linaro.org>
Date: Tue, 22 Aug 2023 18:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822155004.1158931-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 17:50, Alex Bennée wrote:
> I've already wasted enough of my time debugging aliased variables in
> deeply nested loops. While not scattering variable declarations around
> is a good aim I think we can make an exception for stuff used inside a
> loop.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/style.rst | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 3cfcdeb9cd..2f68b50079 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -204,7 +204,14 @@ Declarations
>   
>   Mixed declarations (interleaving statements and declarations within
>   blocks) are generally not allowed; declarations should be at the beginning
> -of blocks.
> +of blocks. To avoid accidental re-use it is permissible to declare
> +loop variables inside for loops:
> +
> +.. code-block:: c
> +
> +    for (int i = 0; i < ARRAY_SIZE(thing); i++) {

ARRAY_SIZE() -> sizeof() -> size_t -> unsigned.

Is it a good example to use 'int' here?

Otherwise, glad to declare variables in loops!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        /* do something loopy */
> +    }
>   
>   Every now and then, an exception is made for declarations inside a
>   #ifdef or #ifndef block: if the code looks nicer, such declarations can


