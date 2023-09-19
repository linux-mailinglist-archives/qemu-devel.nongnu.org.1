Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA97A635E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qia5L-0004hx-R7; Tue, 19 Sep 2023 08:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qia53-0004hE-9D
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qia4z-0002XR-V6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695127414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nplo/SNuxQRMVbQR0FxcvrCm8s9Feea5WdrvYeva3TI=;
 b=DcsAIG6fSURhJZSEcUgxRDiYflLp+Cnl5/kH1UXdW3fUONyDkEESd1IaBOp02iY+TkjKRi
 INWd+AZgUfKSsSO0TEURMejIjZQaxiBRRKoIujDFZ3eA/4+Zt6+jTJ/p3KYMN149FYKb9Z
 KvucXKX7dBRqvHOapx/e7Z/8yS4guPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-IbqiAR38NZyoPt01W1Komg-1; Tue, 19 Sep 2023 08:43:33 -0400
X-MC-Unique: IbqiAR38NZyoPt01W1Komg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401bdff6bc5so43109945e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695127412; x=1695732212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nplo/SNuxQRMVbQR0FxcvrCm8s9Feea5WdrvYeva3TI=;
 b=DeSHGX94qdsbJmKruUSzVnwzm5DPREq6f+DzEkw40Lge3Oe8n4a8LdFylTzaBa7Ck2
 PktOF2EX81GolrfVKdGoi0VrfwMAoFptFhJiOwFDTRScQO89rAp8BDG2YteDxjFDr/62
 VnMjuAKiZunwc9U0dzvLuDOXxSMKK/cFIzD3rGTsiatis5xi7FHoIONFyMjG3iJu/tbW
 LjMNyBZxvgUrnkSzPr3AFSAEO5mziRRYff81Gy5OxWrFWqZyaW1SH7FiZYFQt8Nr+jVD
 L7WsxnG3X2fV9SBJohpC+CAMfZ/Jbk5m2rbXJRM4I1vyUP2FGfz4gxbgfpeEWrnIfdwP
 Q7Jw==
X-Gm-Message-State: AOJu0Yw0x309Pc6kvugG6klQn/nvgGeZRkA3IPwh/etMxT691+mzNpW+
 N6qgwiWTfsOud0cu7IuvGdiH+D4fkS+ahy9HRjB3UzlgZPC89TMeYjx7BOpMVf6z/WeZcrfB3Pw
 mJ5J2XjvHotm38FU=
X-Received: by 2002:a5d:6d42:0:b0:317:3f70:9dc4 with SMTP id
 k2-20020a5d6d42000000b003173f709dc4mr9346839wri.31.1695127412187; 
 Tue, 19 Sep 2023 05:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOFFnGHUjKnfIi3II4M6pDjUecuVUDrX3TnDcEcSLqW1iKytvrasbnh0xko6dnjmQrqRoYtQ==
X-Received: by 2002:a5d:6d42:0:b0:317:3f70:9dc4 with SMTP id
 k2-20020a5d6d42000000b003173f709dc4mr9346830wri.31.1695127411834; 
 Tue, 19 Sep 2023 05:43:31 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a7bce85000000b004013797efb6sm17937513wmj.9.2023.09.19.05.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 05:43:31 -0700 (PDT)
Message-ID: <96acc3b1-3cea-3b7e-ff2c-2662bc9dbee6@redhat.com>
Date: Tue, 19 Sep 2023 14:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/18] build-sys: add a "pixman" feature
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-2-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230918135206.2739222-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/18/23 15:51, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For now, pixman is mandatory, but we set config_host.h and Kconfig.
> Once compilation is fixed, "pixman" will become actually optional.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build                   | 10 ++++++++--
>   include/ui/qemu-pixman.h      |  2 ++
>   Kconfig.host                  |  3 +++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   5 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 5150a74831..e870b039cc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -828,10 +828,14 @@ if 'ust' in get_option('trace_backends')
>                        method: 'pkg-config')
>   endif
>   pixman = not_found
> -if have_system or have_tools
> -  pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
> +if not get_option('pixman').auto() or have_system or have_tools
> +  pixman = dependency('pixman-1', required: get_option('pixman'), version:'>=0.21.8',
>                         method: 'pkg-config')

I wonder if we should _anyway_ default to "enabled" if system emulators are
enabled, even after the series.  That would be

if not get_option('pixman').auto() or have_system or have_tools
   pixman = dependency('pixman-1',
       required: have_system or have_tools ? true : get_option('pixman'),
       version:'>=0.21.8',
       method: 'pkg-config')
endif

(There is also .enable_auto_if() but that requires Meson 1.1).

>   endif
> +if not pixman.found()
> +  error('FIXME: pixman is currently required')
> +endif

This would be subsumed by the above "required" argument.

Even if we don't want to require pixman if system emulators are enabled,
this should be "if not pixman.found() and (have_system or have_tools)"
otherwise compilation with --disable-system would require pixman until
the end of this series.

No need for a v3 to fix the above.

Paolo

> +
>   zlib = dependency('zlib', required: true)
>   
>   libaio = not_found
> @@ -2124,6 +2128,7 @@ config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>   if seccomp.found()
>     config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
>   endif
> +config_host_data.set('CONFIG_PIXMAN', pixman.found())
>   config_host_data.set('CONFIG_SNAPPY', snappy.found())
>   config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
>   if get_option('tcg').allowed()
> @@ -2843,6 +2848,7 @@ have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
>   host_kconfig = \
>     (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
>     (have_tpm ? ['CONFIG_TPM=y'] : []) + \
> +  (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
>     (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
>     (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
>     (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index 51f8709327..b3379f6625 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -6,11 +6,13 @@
>   #ifndef QEMU_PIXMAN_H
>   #define QEMU_PIXMAN_H
>   
> +#ifdef CONFIG_PIXMAN
>   /* pixman-0.16.0 headers have a redundant declaration */
>   #pragma GCC diagnostic push
>   #pragma GCC diagnostic ignored "-Wredundant-decls"
>   #include <pixman.h>
>   #pragma GCC diagnostic pop
> +#endif
>   
>   /*
>    * pixman image formats are defined to be native endian,
> diff --git a/Kconfig.host b/Kconfig.host
> index d763d89269..b6ac2b9316 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -11,6 +11,9 @@ config OPENGL
>   config X11
>       bool
>   
> +config PIXMAN
> +    bool
> +
>   config SPICE
>       bool
>   
> diff --git a/meson_options.txt b/meson_options.txt
> index f82d88b7c6..1aaec02d68 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -218,6 +218,8 @@ option('l2tpv3', type : 'feature', value : 'auto',
>          description: 'l2tpv3 network backend support')
>   option('netmap', type : 'feature', value : 'auto',
>          description: 'netmap network backend support')
> +option('pixman', type : 'feature', value : 'auto',
> +       description: 'pixman support')
>   option('slirp', type: 'feature', value: 'auto',
>          description: 'libslirp user mode network backend support')
>   option('vde', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index e1d178370c..d016caf819 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -147,6 +147,7 @@ meson_options_help() {
>     printf "%s\n" '  pa              PulseAudio sound support'
>     printf "%s\n" '  parallels       parallels image format support'
>     printf "%s\n" '  pipewire        PipeWire sound support'
> +  printf "%s\n" '  pixman          pixman support'
>     printf "%s\n" '  png             PNG support with libpng'
>     printf "%s\n" '  pvrdma          Enable PVRDMA support'
>     printf "%s\n" '  qcow1           qcow1 image format support'
> @@ -398,6 +399,8 @@ _meson_option_parse() {
>       --disable-parallels) printf "%s" -Dparallels=disabled ;;
>       --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
>       --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
> +    --enable-pixman) printf "%s" -Dpixman=enabled ;;
> +    --disable-pixman) printf "%s" -Dpixman=disabled ;;
>       --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
>       --enable-plugins) printf "%s" -Dplugins=true ;;
>       --disable-plugins) printf "%s" -Dplugins=false ;;


