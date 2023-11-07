Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA67E380D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:45:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Id3-0000aO-T9; Tue, 07 Nov 2023 04:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0Id2-0000a6-0S
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0Icz-0005iv-Vc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699350248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUWbuaCqFxy1qo9QYm6b7x55Eg5dZhglr722fG27ZPM=;
 b=izUEXLBm5BxycWWfv+Df74G08zElBuTVrE/J+vAy/uba1U9HG02eJ7XHEJrhluvtGi+X4C
 mn3lFv1xDaQPpJEiExykQKDDjYJXzuLNrfS4HanAElZeU5zeSmUPoi8cU/v48YIrNqUyxe
 HKwlAoHKPoYBb+Yp2Qvvepsd0WKlNN0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-zBp-aDh6NwS0yakBTNGd7A-1; Tue, 07 Nov 2023 04:44:07 -0500
X-MC-Unique: zBp-aDh6NwS0yakBTNGd7A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c6eaf3838fso47046071fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699350245; x=1699955045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUWbuaCqFxy1qo9QYm6b7x55Eg5dZhglr722fG27ZPM=;
 b=Z70U1NQWUriTx7iBtH23k+gKSrJQ8HyF0f/Vf6LPvj4b1BvYFAmCJekG2DhlaZ4pti
 swbdp61RrkqDSOyNA/LX7BPAS2tMALwfBHzNmdHLwwE6Y7cuVllwlklKFCz1dFh4+7WU
 PhQrnBYyhG19vLg1NZHbJDoybl52Ryx2hd/0oeeK3ZwITUSZDls8qRvl7ljJpJm+y0/X
 oaKU9KRqQIPatxNTVVaMS/N2QRHGv65krKaKahRbJK/EXotv8QWQp7uBqO2Hnp8iDLgP
 k404T4GKN/fOSHvaH8F+tQuJIFaqlFd9Ip60wwIPpHFhWgxzSDAAJ20t7O9nLpakCnxh
 ZSbQ==
X-Gm-Message-State: AOJu0Yxj4+T+oDOsOkovQKSinbH+sVV2Ut9bd8yr/q5YSBGbAmun6JKM
 Ai3Ke2cD+UT0qCAe69fU+mFTCPFHJFl0YjDkbciYXf2a4oDxNGwL9kybXzuuZ3GDOdE1w31ifRW
 8ZtwrcRSJpOvU7yE=
X-Received: by 2002:a2e:918d:0:b0:2c5:ffa:375d with SMTP id
 f13-20020a2e918d000000b002c50ffa375dmr23962540ljg.11.1699350245601; 
 Tue, 07 Nov 2023 01:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbd/89x3eVIzDHlcPeOblOuhLhUPh/Le+EeX7pIxfdWs0OavfyVjQQQIJgiBUGOT3A9rQ7WQ==
X-Received: by 2002:a2e:918d:0:b0:2c5:ffa:375d with SMTP id
 f13-20020a2e918d000000b002c50ffa375dmr23962523ljg.11.1699350245169; 
 Tue, 07 Nov 2023 01:44:05 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 l26-20020a05600c1d1a00b003fef5e76f2csm12486652wms.0.2023.11.07.01.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:44:04 -0800 (PST)
Message-ID: <ea92d71f-35a3-4a5f-bece-01436a33e1e8@redhat.com>
Date: Tue, 7 Nov 2023 10:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] plugins: make test/example plugins work on windows
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Greg Manning <gmanning@rapitasystems.com>
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
 Richard Henderson <richard.henderson@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-15-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231106185112.2755262-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

One important remark below that Greg can answer; the others are nits.

On 11/6/23 19:51, Alex Bennée wrote:
> diff --git a/contrib/plugins/win32_linker.c b/contrib/plugins/win32_linker.c
> new file mode 100644
> index 0000000000..50797d616e
> --- /dev/null
> +++ b/contrib/plugins/win32_linker.c
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (C) 2023, Greg Manning <gmanning@rapitasystems.com>
> + *
> + * This hook, __pfnDliFailureHook2, is documented in the microsoft documentation here:
> + * https://learn.microsoft.com/en-us/cpp/build/reference/error-handling-and-notification
> + * It gets called when a delay-loaded DLL encounters various errors.
> + * We handle the specific case of a DLL looking for a "qemu.exe",
> + * and give it the running executable (regardless of what it is named).
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include <Windows.h>

Just a nit, but we generally use lowercase "windows.h".

> +#include <delayimp.h>
> +
> +FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli);
> +
> +
> +PfnDliHook __pfnDliFailureHook2 = dll_failure_hook;
> +
> +FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli) {
> +    if (dliNotify == dliFailLoadLib) {

I think this could also use the notification hook and 
dliNotePreLoadLibrary.  That's a little more tidy but it's okay either way.

A bit more important: would it make sense to include the hook *in the 
QEMU executable itself*, rather than in the DLL?  If it works, it would 
be much preferrable.  You still would have to add the .lib file to the 
compilation, but win32_linker.c could simply be placed in os-win32.c 
with fewer changes to meson.build and the makefiles.

> +    if targetos == 'windows'
> +      t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
> +                        include_directories: '../../include/qemu',
> +                        objects: [win32_qemu_plugin_api_lib],
> +                        dependencies: glib)
> +
> +    else
> +      t += shared_module(i, files(i + '.c'),
> +                        include_directories: '../../include/qemu',
> +                        dependencies: glib)
> +    endif

If the win32_linker.c file can be removed (by moving the hook into the 
emulator), I'd rather have this where win32_qemu_plugin_api_lib is created:

if targetos == 'windows'
   ...
else
   win32_qemu_plugin_api_lib = []
endif

and then here you can just use "objects: [win32_qemu_plugin_api_lib]" 
unconditionally, saving an "if" and some duplication.

Paolo

>     endforeach
>   endif
>   if t.length() > 0


