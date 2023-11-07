Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2117E3873
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:09:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J1X-0000sm-Dk; Tue, 07 Nov 2023 05:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J1Q-0000pl-HJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:24 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J1O-00026H-0w
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:24 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso6712242a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351761; x=1699956561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1/9USN/jBOffMp2yloOb5x9kWe3LnPxTW7blqDcHgQ=;
 b=UibiEMV9QYa9jtiJIrsTX+Gvk4bRz3ccxc6gjJy968xIIkh2a1kPEEy9UY22V8qMkF
 IkVW34HzZNP8jgyPj30N0iiuJaasg3Lx060A16w5KY81rAiYNm/kiozMyFsMidk93cqi
 pfy/XHCY7z28l/C96fqcLTYx315NhLEorpTflT94upKzokJybW5sg+/o0LkmoUXfhq1j
 6ZB2G2LzmlS7M/p+rqyF1yTYbc7UhP/+KdQY47LCnpKADlVaW3DDWkMiygN4FXAJskYG
 zacz2rpwuf+HI/bSZG7j69ubBzBd7Zi9XM3hGV7Y+WrZmvq5WFlv98JBWIUNnjnedFeR
 0sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351761; x=1699956561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1/9USN/jBOffMp2yloOb5x9kWe3LnPxTW7blqDcHgQ=;
 b=SKE1p9OnGAu4ZG37P6tNpJzxOb+/e7G65rost0zj0MZR3t/AzupfyzW4H8dKGacGH9
 HfIYccwChZXrVxhpjXpa7fa/9b/fEMyK+8ifNGqxBAquFcwwW/AthQ55EskIk5XXzYMw
 4zIS6gDHnzWBJIqk5Bo0cw6/2SOVxObC+skRHdBDnw8IC1NtpQKFQDm4YgMxzFht1NLn
 KPjZ1FjkcHAKLM6cI5zT6FlrBospCAfxfKXg1rGJpY5VpovgRsSuUxfeWjXFHqDRY0hH
 3uHh/qPCf7rp49u8yHw2Zhorp+xg4mZ5iJhw7PjsXjFrXVVJ/l2zXbBtGknZ9tkZhOeh
 lkJA==
X-Gm-Message-State: AOJu0Yyj7qPbwuZWdHDHzXlyCk6zQJEH8XSN3WU1+SfslLRYiye6WGSf
 Zl/Y463ze0cEVrGtUJVMGYDVMA==
X-Google-Smtp-Source: AGHT+IHsREcktv5dvqQ2cBAqy8QrIyKH8UP64Cl7+lTHN+KBuQS53H2dfJXqxgYiOpp+imodOZzX1Q==
X-Received: by 2002:a05:6402:1b0e:b0:53f:e49e:4be with SMTP id
 by14-20020a0564021b0e00b0053fe49e04bemr20396618edb.42.1699351760854; 
 Tue, 07 Nov 2023 02:09:20 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 k28-20020a508adc000000b0053de19620b9sm5450734edk.2.2023.11.07.02.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:09:20 -0800 (PST)
Message-ID: <04ea9a57-90f2-4da2-aa83-96691ba8fffb@linaro.org>
Date: Tue, 7 Nov 2023 11:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/22] configure: tell meson and contrib_plugins about
 DLLTOOL
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Richard Henderson
 <richard.henderson@linaro.org>, Greg Manning <gmanning@rapitasystems.com>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106185112.2755262-13-alex.bennee@linaro.org>
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

On 6/11/23 19:51, Alex Bennée wrote:
> To cleanly handle cross-building we need to export the details of
> dlltool into meson's list of cross binaries and into the
> contrib/plugins/ make configuration.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Greg Manning <gmanning@rapitasystems.com>
> ---
>   configure | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


