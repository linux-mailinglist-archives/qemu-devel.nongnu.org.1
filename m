Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9AE7E3887
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3J-00057N-7x; Tue, 07 Nov 2023 05:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J3F-0004nH-Sg
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:17 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0J3D-0002Vu-SH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:17 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso9186003a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351874; x=1699956674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ib8kBRPeV5EfosSTrkg+X2z6Y5tUzvz041Z1N7hG7z0=;
 b=AKfrrV1lBbuj9B/0JDjCK2khzghXvBs62l8A/PnFddVZfJGHLZ3AQs62z767smZ2JR
 76DTKdQvLCqECLCfM1NG2s3luc7tZ2wupmkHYcLZ+mRLKrzGgY6yuaB6eEzWQlU4uN88
 aUjYUV0nrSr3dM5vTRzB6nMHwyUvmBTwfmGpnKY7DxagCw9kVpV3njqJn+ZgklQuY3Zc
 OoarLWhjQmuU7HllnQxw67Ry8pTDicwjrwoqQmrVfkRGyNsS1cw9OHU7mK3POKoqgUs7
 7b5FYUlHHNeR+N967tMMorVdT8bwYBP2aqgSsInPaYcoSf0BvQeY51fkM+JwYrMJxvJQ
 wj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351874; x=1699956674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ib8kBRPeV5EfosSTrkg+X2z6Y5tUzvz041Z1N7hG7z0=;
 b=jO80VivFjVNx1DS1WbHWS9V2aDFiXQYBZbj6vR6szGZokTY4Jf/XwdscmEtJ/SXjsb
 zzANxTCiM1f5ejbPGtpwd+navYapx2sSf6QP1v99DjI7AYtS5LWOPVIc8m5nMKIqUIym
 CP7WNkVTaktHrjW9sks1UaWhmtOSWS7KBqkQTyi4SvEP1qP08D3kxrFl+/p1PZqW+aBh
 RLSWVhT5mCuGxdCSbzMSSVutI51i5tBybSrypc//VGThvyqs1PQ+6ex7qAiEFFLM++Od
 jbo3DCtzBOt77F/ByG2iqDhNSWloUxclM4KjqFdoyxR3oFJMICRM60SlPkIRHLgzmwpl
 i25w==
X-Gm-Message-State: AOJu0YzdwTF2wRh5c66Y4Ljl9H72PKLMT/BSX5vtMql5sK+w9xKF0YQa
 9hBWxl1RU7d2N7J9vg/PFi3SsA==
X-Google-Smtp-Source: AGHT+IGJAyiF30wW/loslMC5FhfX2qPQMxwQJurW3n9tsuJRnBHl4lbw7c0LmzcT9jQkYJ5z26fU1g==
X-Received: by 2002:a50:d511:0:b0:543:f08:fdc with SMTP id
 u17-20020a50d511000000b005430f080fdcmr22627590edi.9.1699351874203; 
 Tue, 07 Nov 2023 02:11:14 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 k28-20020a508adc000000b0053de19620b9sm5450734edk.2.2023.11.07.02.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:11:13 -0800 (PST)
Message-ID: <3de367cf-9b32-4bab-bb03-af974c6d894c@linaro.org>
Date: Tue, 7 Nov 2023 11:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] plugins: allow plugins to be enabled on windows
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>
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
 <20231106185112.2755262-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106185112.2755262-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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
> From: Greg Manning <gmanning@rapitasystems.com>
> 
> allow plugins to be enabled in the configure script on windows. Also,
> add the qemu_plugin_api.lib to the installer.
> 
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231102172053.17692-5-gmanning@rapitasystems.com>
> [AJB: add check for dlltool to configure]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-30-alex.bennee@linaro.org>
> ---
>   configure   | 4 ++--
>   meson.build | 5 +++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index e50ec99fe2..abcb199aa8 100755
> --- a/configure
> +++ b/configure
> @@ -1011,9 +1011,9 @@ if test "$targetos" = "bogus"; then
>   fi
>   
>   # test for any invalid configuration combinations
> -if test "$targetos" = "windows"; then
> +if test "$targetos" = "windows" && ! has "$dlltool"; then
>     if test "$plugins" = "yes"; then
> -    error_exit "TCG plugins not currently supported on Windows platforms"
> +    error_exit "TCG plugins requires dlltool to build on Windows platforms"
>     fi
>     plugins="no"
>   fi
> diff --git a/meson.build b/meson.build
> index dcef8b1e79..b855224acc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3904,6 +3904,11 @@ endforeach
>   
>   if get_option('plugins')
>     install_headers('include/qemu/qemu-plugin.h')
> +  if targetos == 'windows'
> +    # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
> +    # so that plugin authors can compile against it.
> +    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
> +  endif
>   endif
>   
>   subdir('qga')

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


