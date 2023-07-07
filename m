Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0174B859
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsNH-0007Hs-9I; Fri, 07 Jul 2023 16:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsND-0007Hd-M4
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:48:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsNB-0001eT-Vw
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:48:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57dcso25895915e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762892; x=1691354892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0dVVmySO19sGUVD8imweDYMELgimW0csKtd1/rb8po=;
 b=kyRoRwimOWSrTKP4AEO6reY8TGLoxAqJqeY+7CSQgo4bOKhP/DoXas5vByXo9H0eGP
 zghM6U4SCl1/zt+k6gPI28VuLJZRwDNcIqK3orUP5C6ofPTiqlmPQKoFh3Bqd6aS6DpN
 eOUJtEpQ6dd5E/LXAIbD/JEKFKtRBgdxPNmbRKbzoKknA+4f2VYF5Ls0jXIYvmNhQN6P
 l398gAZ01BjKc33Y1x5QQk55u9H5k0vLsOESB4tj5arRyk9/zgLagEdh8tzrV6eAqv4o
 GI+iF7+1y1bcBoG2EGOXU9tZgvKP1nqJxK26qGC3ZnV39lc88VwkLY8cY+0C0CaanxMU
 XN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762892; x=1691354892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0dVVmySO19sGUVD8imweDYMELgimW0csKtd1/rb8po=;
 b=HirSRROzVW4GZNCpRIoV5XthK3PzNmO9fSDDTEf88Pbl8i9p/qZTlUZGcrFVlRRmhz
 /WiLdgu3YGO/iHcYmlpCLi1TbKSRrXzYTyEllOsDIhBtBSIQAGOdGMDwKbOfioZVCTIE
 Tb0ItrQSFAdeMI7ovQiu0z9fQv1oX4Zho6PlEJSGPUqtkSx5sYEZmv+2cLblR89yNaPF
 u9N3NZhjej5oZ4IOR2a+SUxlEcBJVAJbdCgSD22KsV5UqIeOkQhkv181ve73qZMm4Ac2
 2CKh+NYrZNjJWqlkt67km571/1b1hXAbTJN8wQgmxiRtIwUu+7tcVuL7X7RzrRQLjKOJ
 3Haw==
X-Gm-Message-State: ABy/qLauvh8WgqnMqIjDxSCAUUOGrD1OcooS7B5cCtcf9AMHWV/6Pe5C
 CgUn208stwGttVn6rhKZ3wzVRQ==
X-Google-Smtp-Source: APBJJlHfz+ocbHJhbOOr696CkhywfGOTWxP04XIM6g21VbrJHyezElUUqTfO+3Nyzm9JW48l5fxjZw==
X-Received: by 2002:a1c:cc0d:0:b0:3fb:b1fd:4183 with SMTP id
 h13-20020a1ccc0d000000b003fbb1fd4183mr5053733wmb.12.1688762892113; 
 Fri, 07 Jul 2023 13:48:12 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bcb90000000b003fbdd5d0758sm3348237wmi.22.2023.07.07.13.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:48:11 -0700 (PDT)
Message-ID: <16731b7f-61d8-dac8-96f9-00332f0fa5ab@linaro.org>
Date: Fri, 7 Jul 2023 21:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] hw/virtio: Build vhost-vdpa.o once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230707151719.70613-1-philmd@linaro.org>
 <20230707151719.70613-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707151719.70613-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 16:17, Philippe Mathieu-Daudé wrote:
> The previous commit removed the dependencies on the
> target-specific TARGET_PAGE_FOO macros. We can now
> move vhost-vdpa.c to the 'softmmu_virtio_ss' source
> set to build it once for all our targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

