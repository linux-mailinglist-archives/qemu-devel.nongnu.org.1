Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA987E387D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2n-0002CG-L3; Tue, 07 Nov 2023 05:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J28-0001OO-EE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:15 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J25-0002O0-It
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:08 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso9397725a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351803; x=1699956603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dc3a0ysY6P4SIvvDatF+i7AJx3PzPsT9pYZUa0VjZjs=;
 b=SuOdl0n9qKBSaEuygkRPaBLSoNW/5hmXTmoyd/Tyd3l4moIyHqVH/0IeNpxKluQKSw
 s3vwjwrBaP+r3zDSe1aWBMDq+53fuS7aAirizPlORmsiobFJxNDwP3JuXpcXUC1k3LNU
 Kiz9HtCtxXM/qPTWsnGnXJsq3w89j7aJwDYbjrHn4JZy2PlifUzs/7AIgjF/SxY+cZ2p
 Fn3KO7NMZ3XL+NYAQoi+IhPj7VZZVd8Re9U3BG3rrSbgNgtD5u28nh+m7AmAC83g8m/R
 2on1oU6PPR5xGGNn9cUnotBefViq0WwMoh1jI0YKRoCbRkQc6KN53k914bIUjngigd/V
 KJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351803; x=1699956603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc3a0ysY6P4SIvvDatF+i7AJx3PzPsT9pYZUa0VjZjs=;
 b=EHVbI3x7riApfEz+q/PFdoHVpo/gcVw2k8jeNMVpQujWv+mSDa8hX0Fn4lPWDaNtww
 KMjx+abIFX2MpmGw9Bm3+OY8gpZlWFPCl6cmKh+dSV29zFJ+EmtcE9doP5JL57spsL6r
 1j+rz3J/p02ZSHKUrgwClr7p26xhkfJqXrsAxpaJecVhKItcG/arTVIxhzfLcDTEA7b7
 HT1m//YzdxaWk1hVmu1wWwHkITJ72X7QsdIXdre2uo5jxNkgpNUnVWUoEhKPGs4394Gt
 kZkBlAXvZyQT/5HEReGjeIJeMo7buqknnsG5RHWu73F8lU//eqLC5h93bzXgdlVmsqaj
 w6EQ==
X-Gm-Message-State: AOJu0Ywznk0j0dYh/g+/TVabCczCdJLhj7jvLT7oIgfIv+NmaeBtm0HY
 qKS2a2/6EIciZiVqJ0aR//yOPg==
X-Google-Smtp-Source: AGHT+IHWFwPm5zci4Vt3ElSD/515CKKEAgv9mjIbubVUA3BzLQskyeS+wc/MoBSl9/6CJVOXhIIWdg==
X-Received: by 2002:a05:6402:cb6:b0:53f:d261:7945 with SMTP id
 cn22-20020a0564020cb600b0053fd2617945mr24000139edb.21.1699351803329; 
 Tue, 07 Nov 2023 02:10:03 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 k28-20020a508adc000000b0053de19620b9sm5450734edk.2.2023.11.07.02.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:10:02 -0800 (PST)
Message-ID: <959a8a53-29be-4d88-9ce8-8e512c1ccf4c@linaro.org>
Date: Tue, 7 Nov 2023 11:10:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] plugins: disable lockstep plugin on windows
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
 <20231106185112.2755262-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106185112.2755262-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 6/11/23 19:51, Alex Bennée wrote:
> From: Greg Manning <gmanning@rapitasystems.com>
> 
> The lockstep plugin uses unix sockets and would require a different
> communication mechanism to work on Windows.
> 
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231102172053.17692-4-gmanning@rapitasystems.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-29-alex.bennee@linaro.org>
> ---
>   contrib/plugins/Makefile | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


