Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A24725644
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nsF-0006CQ-Tf; Wed, 07 Jun 2023 03:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ns0-0006AS-7B
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:46:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6nru-0003LI-Rn
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:46:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ad458f085so215331f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686123969; x=1688715969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhlc1WTWb6qUkp3RcdvjmxiUYof71kDU4Z2LTzmzunQ=;
 b=XdzmZokUJ7oyakfrjSIv74EQnIEBx1pKhruzK9m5R37waIkhcBjHajr+yQHYyg7k2I
 S42/6tKwSlJyANav3ZQ+cXj+agY69/6hRm2E1iuGObAEuzVJHEuLFSYIhnCEb0u9E9KW
 dl+ecUNj4ypbET9mwd78Q8BF9alVcyCZi3aKmhq9FJVo0C9Ue6rXCbvaESO9LGdFuKTl
 4oZ2g4UF/PLzHuIK0GOgPfQJ3iKII2myqB0HRW20xhuYxRJBwipQqWdkQ5Tz8HJEk4NE
 46CImLq2D+5+6QCGhFP8Td1HgeH8zTyE/0Pz/f6BfQs8CenlTCtrdw2mnTWXmvWQi0BJ
 6Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686123969; x=1688715969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhlc1WTWb6qUkp3RcdvjmxiUYof71kDU4Z2LTzmzunQ=;
 b=SKSRYpL/uVAmQDn4IXJQ2Pd8s2lmOQePYBfUQlkCFmNYFVgBwwbcj5RVFn8qwvbFDG
 tBStEDsrCFeWvkNsobHn8ITTFu6y5mcF0AB5i4QYYi0KzI6HCcRBentyVw1xj5Etc+02
 81GqImU2yhQ4MdpsSIaT4j1+G3S2XMYebqUszB8PGYKxotUggj2ZmEBeaZFzjbcGXvZz
 wawvfhLO2fwrf3dhkJCy+BG+Or15tJ7wwyAlhXhx/3Ty7RIIIgTTw3MdziCcjmzFgXHT
 mFENsStrAWtFLDSVBoobAyTSd9M64Tonh3ShvnZrKw4p9becEZO4gUj9KGIoGMVpml3e
 zoLQ==
X-Gm-Message-State: AC+VfDzT1cKGzfVKe9FLtgCwDhyE2EV8oCTbLbkFFBeRoDAuRD3kY1tr
 ZHcyYHQkJ1UaCjrwMJ6wQJtPKg==
X-Google-Smtp-Source: ACHHUZ5M1xLPCMkVrmN4TWQHbbx5jSporBkXZnk/KQ2v+PWERhlu11wTzeT7fs/Vol4dy7wF+k4PSA==
X-Received: by 2002:a5d:4383:0:b0:30a:f68f:9b94 with SMTP id
 i3-20020a5d4383000000b0030af68f9b94mr9495913wrq.21.1686123969162; 
 Wed, 07 Jun 2023 00:46:09 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 p8-20020a05600c204800b003f723215b6fsm1197528wmg.12.2023.06.07.00.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:46:08 -0700 (PDT)
Message-ID: <8261906e-de0e-6487-ce3a-254087e9253e@linaro.org>
Date: Wed, 7 Jun 2023 09:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] gitlab: Add cross-arm64-kvm-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 Fabiano Rosas <farosas@suse.de>
References: <20230606224609.208550-1-richard.henderson@linaro.org>
 <20230606224609.208550-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606224609.208550-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/6/23 00:46, Richard Henderson wrote:
> We are not currently running a --disable-tcg test for arm64,
> like we are for mips, ppc and s390x.  We have a job for the
> native aarch64 runner, but it is not run by default and it
> is not helpful for normal developer testing without access
> to qemu's private runner.
> 
> Use --without-default-features to eliminate most tests.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 61b8ac86ee..1e0e6c7f2c 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -29,6 +29,14 @@ cross-arm64-user:
>     variables:
>       IMAGE: debian-arm64-cross
>   
> +cross-arm64-kvm-only:
> +  extends: .cross_accel_build_job
> +  needs:
> +    job: arm64-debian-cross-container
> +  variables:
> +    IMAGE: debian-arm64-cross
> +    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
> +
>   cross-i386-user:
>     extends:
>       - .cross_user_build_job

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


