Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EE76C83B
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR72A-0001Lm-CQ; Wed, 02 Aug 2023 04:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR727-0000zy-2L
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:16:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qR725-0006XK-1H
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:16:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbd03cb7c1so41769225ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690964195; x=1691568995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Jr7yZBKyIpdAKujHGVloZ3C6r8NRdtLFLWY29dPTWQ=;
 b=F1mcnGQCQa5yVFXex9t8ilgzXzh4XpsTHjgL34ExlWLLixRFnIeWIm8i7QwxUNFJq5
 a40e7xe4aXT9SV8vcadxCqwhY6D5Nggkx492pTjvNPb+VMMft77ZlXr4xX/hGNDC9eBm
 /d3Qr5A1uTbJ2STOy6T/KfzUVR8oAJTlb6egjVp9qbLKlUb3svqlaAQl0cEk51K+VoFG
 V819xSt7+qtNdKcujLgPGFOS5oTnxPN9gRGuDQ+5FULf6A8JTlZ2YmyveGY7rM3MrPN9
 B2AmvA4FvmjkhyigY2qb/I5RMLqfrl00hCWYrgaCWfP5CvlPmcWceKm6GJyAVNKI/Tt+
 sJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690964195; x=1691568995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Jr7yZBKyIpdAKujHGVloZ3C6r8NRdtLFLWY29dPTWQ=;
 b=ZFSl7HH25mFdiFTm2Uej7GD7A97ksRaDvD3uoKw4lY6U5w6VT5n00jYMUZKKtP4DEW
 dFC3KvTTcaabzzawwG0MzJ6r2lS4I2q00Sb9EGd2ijwKhDEiEJvzjM2oKFjFiO2r6nnf
 HPTzjGdYcLQ7cNgQdtJiKQ5TVCmFCFk8MITVAbu0qiGUsJq3wN6II8aXLQYivhkJPLmp
 54nRBZ32ljNLE3LdLe3PdlkZV3ZhtOBTdqtkJrBU+gMMKPEq3JaEwBJSbgr7kD3Qd9Ni
 iu/4B/ZHtp1PZM+XW/jCz9ucfUUL4HY4W2u1weQUQIKhMh52e+fs+2X7c8gZrvm1uosT
 S49w==
X-Gm-Message-State: ABy/qLbAGbaattx1KyQI+4ZRh15Jv2swfyTyew+N6SwpdJnbeaPzad59
 s5oUbrZulTnGKKqhk88PzAg=
X-Google-Smtp-Source: APBJJlFUwyLTkQBkIvEYQBU8lKESREAT7FqJRiCsfKuMvET6dQqftQwk+iumReLW2XPzxCjFYfozWA==
X-Received: by 2002:a17:90a:6848:b0:268:96e:31e1 with SMTP id
 e8-20020a17090a684800b00268096e31e1mr10829521pjm.49.1690964195033; 
 Wed, 02 Aug 2023 01:16:35 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iw3-20020a170903044300b001b9dadf8bd2sm11776722plb.190.2023.08.02.01.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 01:16:34 -0700 (PDT)
Message-ID: <d205f5a6-c7ec-c8a2-74f6-901dac1774e4@gmail.com>
Date: Wed, 2 Aug 2023 17:16:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] contrib/plugins: add meson build file
Content-Language: en-US
To: Anton Kochkov <anton.kochkov@proton.me>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230628162451.147419-1-anton.kochkov@proton.me>
 <20230628162451.147419-2-anton.kochkov@proton.me>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230628162451.147419-2-anton.kochkov@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Thanks for letting me know this on GitLab.

On 2023/06/29 1:26, Anton Kochkov wrote:
> Add crossplatform Meson file to build TCG plugins since
> the Makefile makes wrong assumptions about it being used only
> on Linux. Tested on Linux and macOS.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1710
> Signed-off-by: Anton Kochkov <anton.kochkov@proton.me>
> ---
>   contrib/plugins/meson.build       | 31 +++++++++++++++++++++++++++++++
>   contrib/plugins/meson_options.txt |  1 +
>   2 files changed, 32 insertions(+)
>   create mode 100644 contrib/plugins/meson.build
>   create mode 100644 contrib/plugins/meson_options.txt
> 
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> new file mode 100644
> index 0000000000..72c4167461
> --- /dev/null
> +++ b/contrib/plugins/meson.build
> @@ -0,0 +1,31 @@
> +project('qemu-plugins', 'c', meson_version: '>=0.50.0')
> +
> +qemu_src = get_option('qemu_path')
> +if qemu_src == ''
> +  qemu_src = '../..'
> +endif

The default value should be provided in meson_options.txt.

> +
> +qemu_include = qemu_src + '/include/qemu'

I think the following is more idiomatic:
qemu_include = qemu_src / 'include/qemu'

Regards,
Akihiko Odaki

> +incdir = include_directories(qemu_include)
> +
> +plugins = [
> +  'execlog',
> +  'hotblocks',
> +  'hotpages',
> +  'howvec',
> +  'lockstep',
> +  'hwprofile',
> +  'cache',
> +  'drcov',
> +]
> +
> +th = dependency('threads', required: true)
> +glib = dependency('glib-2.0', required: true)
> +
> +foreach p: plugins
> +  library(p, p + '.c',
> +    include_directories: incdir,
> +    dependencies: [th, glib],
> +    override_options: ['b_lundef=false']
> +  )
> +endforeach
> diff --git a/contrib/plugins/meson_options.txt b/contrib/plugins/meson_options.txt
> new file mode 100644
> index 0000000000..2d76cda496
> --- /dev/null
> +++ b/contrib/plugins/meson_options.txt
> @@ -0,0 +1 @@
> +option('qemu_path', type : 'string', value : '', description : 'Full path to the QEMU sources to build plugins for')
> --
> 2.41.0
> 
> 
> 

