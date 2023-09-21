Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C927A9232
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:40:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEH4-0005qL-HG; Thu, 21 Sep 2023 03:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjEH0-0005q6-KD
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:38:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjEGq-0006di-VQ
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:38:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52f9a45b4bdso642726a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695281923; x=1695886723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7RUltoTfDjrQftN2//7LR1fl2JSswr2zk7qtR0CySFE=;
 b=nM0vbhyIsCUai9ddb1YFvNrUmKX/kYJ0I9YzVgtj1stwYcGCW0WxzdgC7ElufIPD85
 mkVWq6g41aR91o1YOR32z5aNbaL5ZTcgMjGqr4k8edAhPhBO3Wa0uKH6wKGYfKaZwRE3
 tfMJSPXe2JUsm6cpSRM5NTta9F4hzyMWBhx76Y0BSk4XEOlrDQ4SFZkx+YJjpoxJ8lTK
 obl3Khhd98Irjv+d8n9AqXEhE7xGXSyiJxfdSoq+W1kddORBQAAhF5d7upKsl4W+btUb
 hrC+DzfvSdNUN8AtOam1Iu6RRqgKofDko3aGzwkDwIb3PZhGjkS3Mjo+uujHxhH7delA
 xMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695281923; x=1695886723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7RUltoTfDjrQftN2//7LR1fl2JSswr2zk7qtR0CySFE=;
 b=uESJX3NG18nXsiDF2rEPrDk/NTi3PT147IZ/4h8ueViOy9o09DXptb6AvTdb0VY3sU
 qEtEuZM8PtK+oxetVYBux2hwCCRExqSNFuDxCt/56UYM24RmKg6kC7oC2Lux0Kw3Q2T9
 8SwA/ZOTbHYr/Uhg+/aVL0JoxgPtCVVQkCo7AGtwDz/O9nScsQXEjAaqVbtFPxtu7/NF
 J3/86QG0+l1NGIGUETELGlhoBDZSbFU8l/Ht+Xi9kXOivltUE9X1+NHz42WY6NZ+VGJO
 2qD3BN6zldXyVy5QWSVVJONhZ5/N+/zNxexteM9i9d6wmrIucDx8qvg6uNfkA31NoLsi
 k17A==
X-Gm-Message-State: AOJu0YysoPHc+xNt3/FMuPio6+JShd3706jbL8W/jTzt1Mqb9iCP2PPK
 lnHGZYyytyDbOiOdrSp3i4oO8A==
X-Google-Smtp-Source: AGHT+IH59wn5uEzST6n5V9ZIofZNYKYQg1mEUsPdRcxlEeLrC/mYKHD8sj4Kr5yZng4CBFyG8qFeWQ==
X-Received: by 2002:aa7:c786:0:b0:52f:a162:f4c4 with SMTP id
 n6-20020aa7c786000000b0052fa162f4c4mr4041155eds.18.1695281922944; 
 Thu, 21 Sep 2023 00:38:42 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 n12-20020aa7db4c000000b005312b68cb37sm443798edt.28.2023.09.21.00.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:38:42 -0700 (PDT)
Message-ID: <3f9ebfe7-47f8-4aaf-d241-0d6576993bd4@linaro.org>
Date: Thu, 21 Sep 2023 09:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] cxl/vendor: update niagara to only build on linux, add
 KConfig options
Content-Language: en-US
To: Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Gregory Price <gregory.price@memverge.com>
References: <20230920155020.550112-1-gregory.price@memverge.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230920155020.550112-1-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Hi Gregory,

On 20/9/23 17:50, Gregory Price wrote:
> Niagara uses <sys/shm.h> which presently limits its compatibility to
> linux hosts.  Change build to only build it on linux.
> 
> Add Kconfig file for skhynix directory, and make niagara depend on
> CXL_MEM_DEVICE.  Add an explicit flag for niagara.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/cxl/Kconfig                    | 2 ++
>   hw/cxl/vendor/Kconfig             | 1 +
>   hw/cxl/vendor/skhynix/Kconfig     | 4 ++++
>   hw/cxl/vendor/skhynix/meson.build | 4 +++-
>   4 files changed, 10 insertions(+), 1 deletion(-)
>   create mode 100644 hw/cxl/vendor/Kconfig
>   create mode 100644 hw/cxl/vendor/skhynix/Kconfig


> diff --git a/hw/cxl/vendor/skhynix/Kconfig b/hw/cxl/vendor/skhynix/Kconfig
> new file mode 100644
> index 0000000000..382fa0cd6c
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/Kconfig
> @@ -0,0 +1,4 @@
> +config CXL_SKHYNIX_NIAGARA
> +    bool
> +    depends on CXL_MEM_DEVICE

You want:

        depends on CXL_MEM_DEVICE && LINUX

> +    default y if CXL_VENDOR
> diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> index 4e57db65f1..6f194aa517 100644
> --- a/hw/cxl/vendor/skhynix/meson.build
> +++ b/hw/cxl/vendor/skhynix/meson.build
> @@ -1 +1,3 @@
> -system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> +if targetos == 'linux'

(Then this check is not necessary).

> +    system_ss.add(when: 'CONFIG_CXL_SKHYNIX_NIAGARA', if_true: files('skhynix_niagara.c',))
> +endif


