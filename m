Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9147E3870
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:09:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J0w-0008Bn-T4; Tue, 07 Nov 2023 05:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J0v-000887-01
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:08:53 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J0t-00024O-Eu
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:08:52 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so9134444a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351729; x=1699956529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PQ4+o/piKsP4ORGXI6NCo9rYNgG06wEm+IZM8VnuqEQ=;
 b=e1BfXvuKzCvcXGpEcuXNlHnuol42ZOigG05tD4HDJmJqHboEWb6fIjUQxsGpylHI3I
 V8TuemAA7fz4wXzLffCl/2EnXUJIsyC1MtOKQFAkblRhP4q6rbyLSA4bbKIU7oCdXtrh
 wGbXl7RLhTxtLNZuw4sZDOV25wNiLlg23RyxB3zyoyyO5O7mRNV4O422xykHk5Dp1pTO
 lyxc2yClgwyfitIEf/6hUpD2vDnUFKav6Ym7vDRI18j522SqH5DuFd334LIWsc9VQovb
 2Mku7D0GfYJ1qAexUk0SlYXuCZy7hmcmDu1eEl24PDtZCz8+vLF4lEobgil6XTFkiGGb
 bsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351729; x=1699956529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PQ4+o/piKsP4ORGXI6NCo9rYNgG06wEm+IZM8VnuqEQ=;
 b=mvDxRM5bCiKEXW+tlNH7VzaDsj1QYSaYv4gBfM/MlrTZCEadTboD2nAiGSlNegrhQk
 v46Gf7YJi5FrDnrzpeP35+yyR750iudrW6QugIccckl0z5+tMvd45t8+NXhWPoTlFNIu
 PkTCmdLHdVcG8pvQpx1O6JEkydUpbI0h+QEjwvcJXSFLKDNCbkqpWntQYXW6WhYEZRh3
 aHun2B3SSDgIx2HlfALj4/A991nH7dMgrBWqBEWbKjBNwmnnzCl460XYxx9eIUnurtRD
 UJ3DypR2084feNpBf4vnvAxt1RSr3BMIX1QF8ZRGD4qKjtjY6vAm5lvy9kA2oTRtGEPC
 eQNw==
X-Gm-Message-State: AOJu0YyRk0VIkEmAeX5HxjB2EZqCDZp1AmnGMoRFZlrbjw7Q5pjJRgUY
 1d6ZtOaagKVb3gQ5WdC08PrGqg==
X-Google-Smtp-Source: AGHT+IH4ZgHA4uTvskcqGv9JQ7OLDKf/rC6bwDf9MANmBxj2QVs0GS+vS5x17qm+RHLVw4Yjh2gSYA==
X-Received: by 2002:aa7:d5c3:0:b0:532:e71b:5ead with SMTP id
 d3-20020aa7d5c3000000b00532e71b5eadmr23307697eds.32.1699351729518; 
 Tue, 07 Nov 2023 02:08:49 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 k28-20020a508adc000000b0053de19620b9sm5450734edk.2.2023.11.07.02.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:08:49 -0800 (PST)
Message-ID: <3fc9185e-1780-4eff-a61a-1e334518e07b@linaro.org>
Date: Tue, 7 Nov 2023 11:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] plugins: add dllexport and dllimport to api funcs
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
 <20231106185112.2755262-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106185112.2755262-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
> In qemu-plugin.h, mark all API functions as __declspec(dllexport) when
> compiling the executables, and as __declspec(dllimport) when being used
> to compile plugins against.
> 
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231102172053.17692-2-gmanning@rapitasystems.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-27-alex.bennee@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 50 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 47 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


