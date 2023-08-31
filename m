Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0CB78E99F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 11:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbe9T-0002t5-Tk; Thu, 31 Aug 2023 05:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbe9R-0002su-RM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:39:45 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbe9P-000750-FW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:39:45 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so717554a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693474782; x=1694079582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7JdPg93Ei8hblCCjbAx2Au7bfzurcULcL9LDqSm08Ls=;
 b=h8dloLrWU+DjiBwgjit1jPdTBUynG8rEU1R151ib1o0bNh6xVMwNiNDnHAa7+pVXDR
 qF9QvIJJNxPROX7uKmopuTVAmNiSwoyGMK1E4eaqX8MKlyH5quj9+/5qv1jkkv4PPLvl
 0SIsYlZhAYR8Furqzz5zgjRN0JnMThbq8ReV5sVdJV59vyi9Gd50snJkBVoAZD66IISr
 Q8caTj5mZrauLNKLlCr0KPwcoDsE+QLblpkZ/8qATr1+zfhMfuR5nbAmPhk5w/gSaMNp
 eCqiWzP5x08xZaKD5I6Qis+XqeBLsAFVSjuMYkg7ut9rSHbu4q8EbWBI+aux0D8mNMgL
 4AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693474782; x=1694079582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JdPg93Ei8hblCCjbAx2Au7bfzurcULcL9LDqSm08Ls=;
 b=hKQVw3plENDXhGkw5Dl+4vWuRZxSfA7NpVwoUqmip7znvfdRhEPexCXmp235z1TYgp
 jyS5Fq25MjK+6T/n+5hpXbeVo5/xNg3dw4f4hqDTZBwvUYQFK2scyCsaH7IdAC9eUFIL
 EaOM+MgFUOUAzqA3YGreGQITlB9HK/WteeRo9Gi/vRUasuZTA4ZRwuOe8StgumxOaIbD
 wRlHZb3KsFLCoVOYC2gbyUw8YEWeKsbzxr9Kk2PUuRiZuzaPTf6sesP1sXHQhk3neRRm
 OCscTnF42mBH5Ac/bEp6rT3aBUavyHUMjxP6Mhv2EKZfk0fgTqJAVb2RRU4RK7yQ32EW
 /Ntw==
X-Gm-Message-State: AOJu0YxegVDl0UNSOAR9RCNVzZi5riq+EzcM1lloL6SxTLvxE38rDcb1
 GKJbflGKEsm5HBQ8kCH0FwNYlQ==
X-Google-Smtp-Source: AGHT+IFKFcGA55zoP29NL8tSR2n9BKd9iAV/sJ4cWrvrJR59iHHmgQtwvMfn6apItLJAT6m18Ev6sw==
X-Received: by 2002:aa7:d80f:0:b0:52b:ce21:ad12 with SMTP id
 v15-20020aa7d80f000000b0052bce21ad12mr3293192edq.4.1693474781845; 
 Thu, 31 Aug 2023 02:39:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a056402164200b00521953ce6e0sm573340edx.93.2023.08.31.02.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 02:39:41 -0700 (PDT)
Message-ID: <a3ffe20a-db49-5c16-caed-a858ea5dff09@linaro.org>
Date: Thu, 31 Aug 2023 11:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [QEMU PATCH v4 06/13] virtio-gpu: Configure context init for
 virglrenderer
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-7-ray.huang@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230831093252.2461282-7-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 31/8/23 11:32, Huang Rui wrote:
> Configure context init feature flag for virglrenderer.
> 
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> New patch, result of splitting
> [RFC QEMU PATCH 04/18] virtio-gpu: CONTEXT_INIT feature
> 
>   meson.build | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..ff20d3c249 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1068,6 +1068,10 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>                                          prefix: '#include <virglrenderer.h>',
>                                          dependencies: virgl))
>     endif
> +  config_host_data.set('HAVE_VIRGL_CONTEXT_INIT',
> +                       cc.has_function('virgl_renderer_context_create_with_flags',
> +                                       prefix: '#include <virglrenderer.h>',
> +                                       dependencies: virgl))

Shouldn't this be inverted with previous patch?


