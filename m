Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27674720A1C
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5AzR-0005Ww-DV; Fri, 02 Jun 2023 16:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5AzP-0005Wl-LF
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:03:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5AzO-0001rF-1g
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:03:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso19086415e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685736188; x=1688328188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KUrXZ3aEp9W5527YntEK244U69CfUa0h4/w6C4jEne8=;
 b=e3QVY4myjVKyzlxyM3MVsnrQALcOBasMAaYscCzcyrItdLGOh3s2XozrejqFEwnnk1
 0qP0rjvycapXvcAnDYg46QflZf3DbI8huO9i4ZKC4Cq1gR41fiIgr09XkLimUP6HYtUj
 AxZuvGqepS0oTRYOjW3Hole5Qou8eOd3KLR2Qckdw9YrAcV+3E+OiiYs30wQF+UHbrQl
 VaK0eovp49+6vv3HKJ2BLat1vodd3x+G2miU97FsHG7PvlcUKipD7u3nyOMour+jDvPa
 fwE/68fHRQ67qBsb/52Ppsxx0EIdjZqb1W0gJ/VAb6k0vLj7CumiOFBiFPL9L7Cgk712
 Xe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685736188; x=1688328188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KUrXZ3aEp9W5527YntEK244U69CfUa0h4/w6C4jEne8=;
 b=Zl7uDH4cqoE9u5CBo3PxtkVJw2R9kH/PyNv5NPeRCtV8nXA7TBKNKrLXd5ys/cajUY
 4ah35dsb35S2XX+ZjAg98QPi0EFqbMkRvqm8Q9Irtnrovs3NFq0/V19c+cfYZSWvz6Nb
 lt+o3nt75HdkgArnKkPD9sJ21fm7sdFlk5ORouiprLtgVZxN+q63s2BlpUCnbze6stKq
 OqqAhyU4+F5QovslexyqLTzrd8T77TTSX7OYhMHL8tmL7wVKcN5Rwb6QjAvsDG7sU43M
 4BQmdAx+5gPoNc/QR7ujj7AbDRPUl1Z1SXwvRKkgCFTMg8AOGsdoRU/+mc4u5HnxhlF0
 i4qw==
X-Gm-Message-State: AC+VfDwVYJqsNLC4s57+2x9dtWryG9Fto3o0XP0a1yF4PxMutQePM7Ub
 kIqipXqssMPu+A4E78fRNY4m3A==
X-Google-Smtp-Source: ACHHUZ6ZGjnMZdTqYN7DPPK13zrkmyyugQutKd/HwxEWnOZy5iFI53GKEwgFSQRzKyiS1FLRYrUmOA==
X-Received: by 2002:a05:600c:210:b0:3f4:2158:28a0 with SMTP id
 16-20020a05600c021000b003f4215828a0mr2887158wmi.12.1685736188312; 
 Fri, 02 Jun 2023 13:03:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b003f72a7918e7sm696355wmr.45.2023.06.02.13.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:03:07 -0700 (PDT)
Message-ID: <d92bc6de-17db-96a9-096d-68b396e11128@linaro.org>
Date: Fri, 2 Jun 2023 22:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] meson.build: Group the network backend entries in a
 separate summary section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20230602171832.533739-1-thuth@redhat.com>
 <20230602171832.533739-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602171832.533739-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
> Let's make it easier for the users to spot network-related entries
> in the summary of the meson output.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 4a20a2e712..c64ad3c365 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4267,13 +4267,19 @@ summary_info += {'curses support':    curses}
>   summary_info += {'brlapi support':    brlapi}
>   summary(summary_info, bool_yn: true, section: 'User interface')
>   
> -# Libraries
> +# Network backends
>   summary_info = {}
>   if targetos == 'darwin'
>     summary_info += {'vmnet.framework support': vmnet}
>   endif
> -summary_info = {}

Ah, this should be squashed in the previous patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   summary_info += {'slirp support':     slirp}
> +summary_info += {'vde support':       vde}
> +summary_info += {'netmap support':    have_netmap}
> +summary_info += {'l2tpv3 support':    have_l2tpv3}
> +summary(summary_info, bool_yn: true, section: 'Network backends')
> +
> +# Libraries
> +summary_info = {}
>   summary_info += {'libtasn1':          tasn1}
>   summary_info += {'PAM':               pam}
>   summary_info += {'iconv support':     iconv}
> @@ -4295,9 +4301,6 @@ if targetos == 'linux'
>   endif
>   summary_info += {'Pipewire support':   pipewire}
>   summary_info += {'JACK support':      jack}
> -summary_info += {'vde support':       vde}
> -summary_info += {'netmap support':    have_netmap}
> -summary_info += {'l2tpv3 support':    have_l2tpv3}
>   summary_info += {'Linux AIO support': libaio}
>   summary_info += {'Linux io_uring support': linux_io_uring}
>   summary_info += {'ATTR/XATTR support': libattr}


