Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A7720A19
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5AyE-0004lI-JD; Fri, 02 Jun 2023 16:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5AyB-0004jx-GW
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:01:55 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Ay9-0001bq-H2
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:01:55 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f3edc05aa5so3318946e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685736111; x=1688328111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eixWxAIWACcBaU14lsZt5WZ6M+7glRk47HuuKf81bQo=;
 b=WgbM4d8MOPdA67BSl8zvZqzxDVCP+khBeWZDX4wfgNVc/QZ+CeHt61vLu3u6dw9SLx
 rMw7Y8+jJPW0vl5V683mpaTb540krru8r9JihB0IDi2Bz25wxT7fCt+QpL3GsQIPYQgJ
 8WUj18gUPXKf3ZMZ1lR43WfS/b+yMc2hoE93qci8jd/SGjlagNeD2uik7Zej9fkvohqW
 ncDdB1lhFof9QWClUjZFxwiMkrnXKqEb5hSZRy+oNCsXw4A0Q3jlWaiej97i6BltjHSs
 mSjOXcbyTzfxV8a9XJZ3Vz3SuWwfRLaL0cfMZpxAcf5Z1fLRQ6n4Z0ghqEg+nLugQZDD
 82Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685736111; x=1688328111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eixWxAIWACcBaU14lsZt5WZ6M+7glRk47HuuKf81bQo=;
 b=XKh3NUS1yFHZKY1cAogDeqRkx+NzpIoLIUBHDX/HF6R4VzwWwsdYSwInk0nVtVQTm5
 +O7qdI7tWKGP+QHeXyCdvrNbTEyaXF6vHO/CAvTWa2q0jE9N6rFMUbNOUr4FJ781Daak
 fpix+lwKxPboP91+jHM5nj4LU33zKmV72P8YAaDY9ArxW/yfTIKTFukEyQdduUxHOUYj
 N2GT3+1t6eGbXyH2YnxG5ufd8ILs1AGbuXumKoaMCJIDvul4UEITy09zL4bZ/8aEZS2F
 tkX+2U3atU5/msNqLOvrrSBt2JOH2YXlxcWXsfooegJR8echZpGe5bAKTa6TUy4p5c/a
 2O8A==
X-Gm-Message-State: AC+VfDx8XshCQP9p8Kb9v5jAmHsnrM7K3jCl1O3Z/iIcuLS4ZFuGg7+C
 F0wz2sQR/oMhB3hxaWZFAalWMA==
X-Google-Smtp-Source: ACHHUZ5RvXG8vxSoJZIcouRZb/3CmzW2B41ZHKosDXP8U3JX4zHXpFFJKtvEKdrauf5ap/h9RYshmw==
X-Received: by 2002:ac2:4c31:0:b0:4f6:10e9:c507 with SMTP id
 u17-20020ac24c31000000b004f610e9c507mr1622142lfq.23.1685736111660; 
 Fri, 02 Jun 2023 13:01:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c211000b003f4fe09aa43sm6466707wml.8.2023.06.02.13.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:01:51 -0700 (PDT)
Message-ID: <942bfe20-7d15-e015-93ec-28c6cd6967cb@linaro.org>
Date: Fri, 2 Jun 2023 22:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] meson.build: Group the UI entries in a separate
 summary section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20230602171832.533739-1-thuth@redhat.com>
 <20230602171832.533739-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602171832.533739-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 2/6/23 19:18, Thomas Huth wrote:
> Let's make it easier for the users to spot UI-related entries in
> the summary of the meson output.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 35 +++++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index a61d3e9b06..4a20a2e712 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4243,32 +4243,44 @@ summary_info += {'rng-none':          get_option('rng_none')}
>   summary_info += {'Linux keyring':     have_keyring}
>   summary(summary_info, bool_yn: true, section: 'Crypto')
>   
> -# Libraries
> +# UI
>   summary_info = {}
>   if targetos == 'darwin'
>     summary_info += {'Cocoa support':           cocoa}
> -  summary_info += {'vmnet.framework support': vmnet}
>   endif
>   summary_info += {'SDL support':       sdl}
>   summary_info += {'SDL image support': sdl_image}
>   summary_info += {'GTK support':       gtk}
>   summary_info += {'pixman':            pixman}
>   summary_info += {'VTE support':       vte}
> +summary_info += {'PNG support':       png}
> +summary_info += {'VNC support':       vnc}
> +if vnc.found()
> +  summary_info += {'VNC SASL support':  sasl}
> +  summary_info += {'VNC JPEG support':  jpeg}
> +endif
> +summary_info += {'spice protocol support': spice_protocol}
> +if spice_protocol.found()
> +  summary_info += {'  spice server support': spice}
> +endif
> +summary_info += {'curses support':    curses}
> +summary_info += {'brlapi support':    brlapi}
> +summary(summary_info, bool_yn: true, section: 'User interface')
> +
> +# Libraries
> +summary_info = {}
> +if targetos == 'darwin'
> +  summary_info += {'vmnet.framework support': vmnet}
> +endif
> +summary_info = {}

Conditional to dropping the previous line:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   summary_info += {'slirp support':     slirp}
>   summary_info += {'libtasn1':          tasn1}
>   summary_info += {'PAM':               pam}
>   summary_info += {'iconv support':     iconv}
> -summary_info += {'curses support':    curses}
>   summary_info += {'virgl support':     virgl}
>   summary_info += {'blkio support':     blkio}
>   summary_info += {'curl support':      curl}
>   summary_info += {'Multipath support': mpathpersist}
> -summary_info += {'PNG support':       png}
> -summary_info += {'VNC support':       vnc}
> -if vnc.found()
> -  summary_info += {'VNC SASL support':  sasl}
> -  summary_info += {'VNC JPEG support':  jpeg}
> -endif
>   if targetos not in ['darwin', 'haiku', 'windows']
>     summary_info += {'OSS support':     oss}
>     summary_info += {'sndio support':   sndio}
> @@ -4283,7 +4295,6 @@ if targetos == 'linux'
>   endif
>   summary_info += {'Pipewire support':   pipewire}
>   summary_info += {'JACK support':      jack}
> -summary_info += {'brlapi support':    brlapi}
>   summary_info += {'vde support':       vde}
>   summary_info += {'netmap support':    have_netmap}
>   summary_info += {'l2tpv3 support':    have_l2tpv3}
> @@ -4295,10 +4306,6 @@ summary_info += {'PVRDMA support':    have_pvrdma}
>   summary_info += {'fdt support':       fdt_opt == 'disabled' ? false : fdt_opt}
>   summary_info += {'libcap-ng support': libcap_ng}
>   summary_info += {'bpf support':       libbpf}
> -summary_info += {'spice protocol support': spice_protocol}
> -if spice_protocol.found()
> -  summary_info += {'  spice server support': spice}
> -endif
>   summary_info += {'rbd support':       rbd}
>   summary_info += {'smartcard support': cacard}
>   summary_info += {'U2F support':       u2f}


