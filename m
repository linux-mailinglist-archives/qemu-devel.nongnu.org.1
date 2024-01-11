Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E63CC82A806
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpBJ-0007nY-EW; Thu, 11 Jan 2024 02:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNpBH-0007nK-DY
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNpBF-000660-EP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704956923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rnVEHGxyJRtUiMM7F5Hf6q6XEGztF5YoA9q0bBjTpG0=;
 b=RQv4135022CXSVSVBX4pzspVdNmtAswv415WpyBRwa7u48tDV7aT831TJPuaSx45Mjb7Ga
 E86iwOFxo15Gaes/dU6GsNc9+3HL9wUSjpIcLoKLeFUOZFMkBA6fp8W2XK5ozmke1SQs6M
 HeanpJvQ7Yszq1LHsAvZ3hWI0BHHheE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-cLCAh8nfMNWgjaP7RVAApw-1; Thu, 11 Jan 2024 02:08:41 -0500
X-MC-Unique: cLCAh8nfMNWgjaP7RVAApw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a280f442420so234001766b.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704956920; x=1705561720;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnVEHGxyJRtUiMM7F5Hf6q6XEGztF5YoA9q0bBjTpG0=;
 b=b3ICmbkfwvHow2RmssKNBp5XUb4gcbOY3iKi8/s12nglMFa3zqqQaJzG6EE+pbRZSh
 KHocqxNgZlgR+VH/el7Tq8tBxwjRWtA7kyrbgc2ITDCWuRMq60co3gKj4DjuHwne+rKU
 siqKPi2yusXorG5HC41boPt9F+y73GpVF/TJAySqTDlmU3U4MgZbYDkavvihLd1qVQXM
 5MqFwG3lvjoxzzXTEDNJkv6dTu5NwyieWayl5ek1uMY5xXIxM6rIV9C9k5hdaQAwjH/F
 o+i1IQkvCYIkOjtiaAzHMI+QtzS/fznj0XW80GraeK0hAWfJs42iuvIPDxeq/9+eZCN4
 oNPQ==
X-Gm-Message-State: AOJu0YwLVkwXKGF4rVd9QYda/lex2BLSkIoHu5dfbNILxbcRdB562ZEk
 6FzYvHJwQMonGvDinywvrRBIh+GeFfIj7p8MY9mKDP4qi4/G8HIM/PGBwurwfy8Fo1mz9fvNwH1
 MnQBvk/bA9GGE4AjGBXVjukU=
X-Received: by 2002:a17:906:b797:b0:a2c:34e8:5526 with SMTP id
 dt23-20020a170906b79700b00a2c34e85526mr336637ejb.120.1704956920718; 
 Wed, 10 Jan 2024 23:08:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvosmKNXd9YhLZDM5tTYeXh0a7YJztxdDDaFpslsjlmJveAkozd6pUybvN/ShQW9b6QL1zDw==
X-Received: by 2002:a17:906:b797:b0:a2c:34e8:5526 with SMTP id
 dt23-20020a170906b79700b00a2c34e85526mr336632ejb.120.1704956920452; 
 Wed, 10 Jan 2024 23:08:40 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 bt16-20020a170906b15000b00a2ada87f6a1sm232139ejb.90.2024.01.10.23.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 23:08:40 -0800 (PST)
Message-ID: <3d30c1b6-1de1-418e-80f6-3d693375142a@redhat.com>
Date: Thu, 11 Jan 2024 08:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gitlab: Introduce Loongarch64 runner
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Beraldo Leal <bleal@redhat.com>,
 WANG Xuerui <git@xen0n.name>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Xianglai Li <lixianglai@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-2-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240102172239.69452-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
> Full build config to run CI tests on a Loongarch64 host.
> 
> Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
> in their CI namespace settings, see:
> https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/ci-jobs.rst.inc                    |  6 ++++++
>   .gitlab-ci.d/custom-runners.yml               |  1 +
>   .../openeuler-22.03-loongarch64.yml           | 21 +++++++++++++++++++
>   3 files changed, 28 insertions(+)
>   create mode 100644 .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
> 
...
> diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
> index 8e5b9500f4..152ace4492 100644
> --- a/.gitlab-ci.d/custom-runners.yml
> +++ b/.gitlab-ci.d/custom-runners.yml
> @@ -32,3 +32,4 @@ include:
>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
>     - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
> +  - local: '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
> diff --git a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
> new file mode 100644
> index 0000000000..86d18f820e
> --- /dev/null
> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
> @@ -0,0 +1,21 @@
> +openeuler-22.03-loongarch64-all:
> + extends: .custom_runner_template
> + needs: []
> + stage: build
> + tags:
> + - oe2203
> + - loongarch64
> + rules:
> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> +   when: manual
> +   allow_failure: true
> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
> +   when: manual
> +   allow_failure: true
> + script:
> + - mkdir build
> + - cd build
> + - ../configure
> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> + - make --output-sync -j`nproc --ignore=40`
> + - make --output-sync -j`nproc --ignore=40` check

Does this system really have more than 40 CPU threads? Or is this a 
copy-n-past from one of the other scripts? In the latter case, I'd suggest 
to adjust the --ignore=40 to a more reasonable value.

  Thomas


