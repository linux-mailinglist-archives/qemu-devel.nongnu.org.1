Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E829479A6BB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdDW-0004FB-TE; Mon, 11 Sep 2023 05:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfdDU-0004F3-RC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:28:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfdDS-0001Lg-4Q
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:28:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so436457966b.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694424499; x=1695029299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AYjaTGDVOvYCTadL5dsWx09HwjynT5qt+XzoeASInJk=;
 b=mrevSF6DG6AJfwmYKU8QBLWfa9Ejb0XOUpf1CxSDAyR21S/dc39VWnAcDOJZVj3qAT
 f5xydwLeorlE4Z5ppaB/fXAawl7TQE/4t+YKk6KL8HyQ4W6e16Zr3YpmOl9oDUf1sECJ
 azkPNNJVrPBF6SiufgUcqUNPRKSe+QKVLGHPX2AqbG/JM1p3Kgd4u8pAqsylbTgCJWtf
 z2kNhPlDFCOt5x9wVGdCw/V0WOemzWI+MA8UuQDLJBfD+YK3whSyuAtuFU9keSL0fyxH
 bYZosZ7Nu0tSrW/lhhAizb/iYj6Kyuu0TolnIR0AdZko/uiQI3KywlA18KcJ/jfBuhav
 yhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694424499; x=1695029299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AYjaTGDVOvYCTadL5dsWx09HwjynT5qt+XzoeASInJk=;
 b=xB7N/IT+7aPzuh6cCAJ8diXYB1VMJRkHvVc23x1ZhM0lH81e9hCbp4Zwz8aDN+x4SD
 Ok6uR4uvrcy4dYIXPCXfFZI2/lm9h4UALyJrPbZxsyu/m3XoL0sw75ulR6VU2UGBkEXE
 9Paim+5easYeeHgYNmeM3Q10XVLxSk8+/e4DIBAFSKVzbwskqigw99UZ+daWzoQ9IZZS
 lRDRDc/0P6pNgsBHRx1rRz6s8wEOSa0sXMnWVeq8NABlfSh+G3mOr4CrANDdcfsQ1EUR
 Xp6E0hg9Yp2J6TYBHikj6FTYzP53exY0OJOJ5osw77W2vMKJ1hgz376rYYjcmZF6LATY
 TU7w==
X-Gm-Message-State: AOJu0YzQsEjdxZ1r12UZwOzr8yzEDEvmop2cuYWLQW9D8HvrHejfPNIr
 /7zuvAA5+JZ/TMy9v+6OMq2BXxH9m47QJcqNfLQ=
X-Google-Smtp-Source: AGHT+IGHxqo4NVlzPbb0GcxYC2OJ5jI6dyWq2pTpDhA3T5CXDnjIg42qcl2oK7GPv89LxpRDDxcEUw==
X-Received: by 2002:a17:906:2189:b0:9a5:b875:eba with SMTP id
 9-20020a170906218900b009a5b8750ebamr7397015eju.24.1694424498930; 
 Mon, 11 Sep 2023 02:28:18 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 oy25-20020a170907105900b0099d0c0bb92bsm5032426ejb.80.2023.09.11.02.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 02:28:18 -0700 (PDT)
Message-ID: <c4fd505e-de5b-ea33-4959-38a735cf173d@linaro.org>
Date: Mon, 11 Sep 2023 11:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] meson: Fix targetos match for illumos and Solaris.
To: Jonathan Perkin <jonathan@perkin.org.uk>, qemu-devel@nongnu.org
References: <ZPtdxtum9UVPy58J@perkin.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZPtdxtum9UVPy58J@perkin.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 8/9/23 19:45, Jonathan Perkin wrote:
> qemu 8.1.0 breaks on illumos platforms due to _XOPEN_SOURCE and others 
> no longer being set correctly, leading to breakage such as:
> 
>    
> https://us-central.manta.mnx.io/pkgsrc/public/reports/trunk/tools/20230908.1404/qemu-8.1.0/build.log

Paolo if you don't mind please replace this link
(which is likely going to disappear) by:

In file included from include/qemu/osdep.h:151,
                  from ../qom/container.c:13:
include/sysemu/os-posix.h: In function 'qemu_flockfile':
include/sysemu/os-posix.h:88:5: warning: implicit declaration of 
function 'flockfile' [-Wimplicit-function-declaration]
    88 |     flockfile(f);
       |     ^~~~~~~~~
include/sysemu/os-posix.h:88:5: warning: nested extern declaration of 
'flockfile' [-Wnested-externs]

../util/compatfd.c: In function 'sigwait_compat':
../util/compatfd.c:36:15: error: too many arguments to function 'sigwait'
    36 |         err = sigwait(&info->mask, &sig);
       |               ^~~~~~~
In file included from include/qemu/osdep.h:117,
                  from ../util/compatfd.c:16:
/usr/include/signal.h:165:12: note: declared here
   165 | extern int sigwait(sigset_t *);
       |            ^~~~~~~

> 
> This is a result of meson conversion which incorrectly matches against 
> 'solaris' instead of 'sunos' for uname.
> 
> First time submitting a patch here, hope I did it correctly.  Thanks.
> 
> Signed-off-by: Jonathan Perkin <jonathan@perkin.org.uk>
> ---
>   meson.build     | 4 ++--
>   net/meson.build | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0e31bdfabf..5150a74831 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -226,7 +226,7 @@ if targetos == 'darwin'
>     if compiler.get_id() == 'gcc'
>       qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
>     endif
> -elif targetos == 'solaris'
> +elif targetos == 'sunos'

Commit a988b4c561 from Oct 2022... I'm surprised nobody tried
to build QEMU on illumos for almost 1 year...

>     # needed for CMSG_ macros in sys/socket.h
>     qemu_common_flags += '-D_XOPEN_SOURCE=600'
>     # needed for TIOCWIN* defines in termios.h
> @@ -2048,7 +2048,7 @@ have_slirp_smbd = get_option('slirp_smbd') \
>   if have_slirp_smbd
>     smbd_path = get_option('smbd')
>     if smbd_path == ''
> -    smbd_path = (targetos == 'solaris' ? '/usr/sfw/sbin/smbd' : 
> '/usr/sbin/smbd')
> +    smbd_path = (targetos == 'sunos' ? '/usr/sfw/sbin/smbd' : 
> '/usr/sbin/smbd')
>     endif
>     config_host_data.set_quoted('CONFIG_SMBD_COMMAND', smbd_path)
>   endif
> diff --git a/net/meson.build b/net/meson.build
> index d2d70634e5..51caa42c9d 100644
> --- a/net/meson.build
> +++ b/net/meson.build
> @@ -47,7 +47,7 @@ elif targetos == 'linux'
>     system_ss.add(files('tap.c', 'tap-linux.c'))
>   elif targetos in bsd_oses
>     system_ss.add(files('tap.c', 'tap-bsd.c'))
> -elif targetos == 'solaris'
> +elif targetos == 'sunos'
>     system_ss.add(files('tap.c', 'tap-solaris.c'))
>   else
>     system_ss.add(files('tap.c', 'tap-stub.c'))


