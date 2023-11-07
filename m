Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F87E37EE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:33:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ISW-0006Sf-IL; Tue, 07 Nov 2023 04:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0IST-0006Nj-Lq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0ISC-0003lG-3r
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtTgagiP8lyMapKZMsh+KlYchDB5M1cWqwen5LGaOpk=;
 b=P6xOQk9gWijlusndOAVznd9YzBxqofTun6xVjdVYgh9Gei+kcGExWQFK0GeXkSDGm8V048
 71xzew9iVhNOoU8FT02P2KeqQUMiH/xXJURsu+iylRH7mEnsnHiJPhYHdfQtXuwhCTPWxY
 hOIPerWUS2h5MngzPXCLKAb2/btzjA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-13u81DacOi6QZB9YE17nnw-1; Tue, 07 Nov 2023 04:32:58 -0500
X-MC-Unique: 13u81DacOi6QZB9YE17nnw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40845fe2d1cso35952445e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699349577; x=1699954377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtTgagiP8lyMapKZMsh+KlYchDB5M1cWqwen5LGaOpk=;
 b=fDj8boTZuDJ+PGr1JXf4YcP7FkmNWS4vVF7Dap6ZErRP9z2qQKDI4+bfEeC0G0dDFM
 xtWx3bnxKymVLo1do8zBM4enNurQm8zT5xGIJMqYwo8yrD6iJ7ypQHsO4qhGIWKjmZb/
 Tw3/nh4yAObhCts9ofzAcJJIC+jqMkiifb/4gVT6SwiXX3/+Ev/WQrNiicfEX7m8HEbS
 h/6E+2tJAbxmcb32RtrXLinlDrVn3XnXQPgPTrrQWp4yJ9BMhLS140KN2r8nRFwCRntf
 80RRDPHQqz1e9lAZoVb8FxRmacohrOVbAdze/9AplQwdfJ2AZuzGeAusqZtLx7Obupkt
 JPrQ==
X-Gm-Message-State: AOJu0Yz6Zo4lpQZaquWjNJXNj9Hj/J/Ji0N9afioIE9asUgQHG0CDCBx
 4UqTqwhsb++i6fWAjCJdxvkThm/attXhR9G5KGtUcEmmkvbvsoZqDudnudrfizxltMeNZlMDXQw
 Fzeq57F2YyrKp0Yc=
X-Received: by 2002:a7b:c409:0:b0:408:3a67:f6f5 with SMTP id
 k9-20020a7bc409000000b004083a67f6f5mr1817445wmi.18.1699349576910; 
 Tue, 07 Nov 2023 01:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrnDuXPVjJDQ10qKyf/kpdBsUjIJLr1BUw7rE/gcsVE+vAuzW5e8pW/qbnaoOkN3AikWTI8Q==
X-Received: by 2002:a7b:c409:0:b0:408:3a67:f6f5 with SMTP id
 k9-20020a7bc409000000b004083a67f6f5mr1817421wmi.18.1699349576545; 
 Tue, 07 Nov 2023 01:32:56 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm15356005wmb.41.2023.11.07.01.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:32:55 -0800 (PST)
Message-ID: <a6074d8f-6472-48f8-b2e0-14410c314d5e@redhat.com>
Date: Tue, 7 Nov 2023 10:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/22] configure: tell meson and contrib_plugins about
 DLLTOOL
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-13-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231106185112.2755262-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/6/23 19:51, Alex Bennée wrote:
> To cleanly handle cross-building we need to export the details of
> dlltool into meson's list of cross binaries and into the
> contrib/plugins/ make configuration.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Greg Manning <gmanning@rapitasystems.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>   configure | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/configure b/configure
> index f1456f6123..cd6c521bd8 100755
> --- a/configure
> +++ b/configure
> @@ -309,6 +309,7 @@ fi
>   ar="${AR-${cross_prefix}ar}"
>   as="${AS-${cross_prefix}as}"
>   ccas="${CCAS-$cc}"
> +dlltool="${DLLTOOL-${cross_prefix}dlltool}"
>   objcopy="${OBJCOPY-${cross_prefix}objcopy}"
>   ld="${LD-${cross_prefix}ld}"
>   ranlib="${RANLIB-${cross_prefix}ranlib}"
> @@ -1659,6 +1660,9 @@ echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
>   echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
>   echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
>   echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
> +if test "$targetos" = windows; then
> +  echo "DLLTOOL=$dlltool" >> contrib/plugins/$config_host_mak
> +fi
>   if test "$targetos" = darwin; then
>     echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
>   fi
> @@ -1764,6 +1768,7 @@ if test "$skip_meson" = no; then
>     test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
>     test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
>     echo "ar = [$(meson_quote $ar)]" >> $cross
> +  echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
>     echo "nm = [$(meson_quote $nm)]" >> $cross
>     echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
>     echo "pkg-config = [$(meson_quote $pkg_config)]" >> $cross
> @@ -1869,6 +1874,7 @@ preserve_env CC
>   preserve_env CFLAGS
>   preserve_env CXX
>   preserve_env CXXFLAGS
> +preserve_env DLLTOOL
>   preserve_env LD
>   preserve_env LDFLAGS
>   preserve_env LD_LIBRARY_PATH


