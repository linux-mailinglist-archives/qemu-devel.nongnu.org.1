Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B599578E7B1
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcnC-0002r7-3b; Thu, 31 Aug 2023 04:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcnA-0002q9-HW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:12:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcn8-0005jk-9A
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:12:40 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99cdb0fd093so56420566b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693469557; x=1694074357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ET1drrAeR+50pLLuvmRQuMFng/wLuH3/v7BWsoxcmXo=;
 b=TAKED8QSTtdPDyyehIhvGRlpAH3FweEt21cp6IJeTE8edTpL5+G/f67unwwZB65Olg
 ox3BGCdtGwV62r8nOodInJcuur05cRbm05i/BbwRYqx36YGxJiq8+Tn3Cpce3zV4dd8t
 0XR98NxoDbyixkeWXh0b/6PjhCV2KCHGUg8rV/cDo2xfsd0ajmN3vgHmAl3X6QErafid
 JhkgHSTiITo89sJeQycvZyMyx4Fs1urshZvQ73iOvWkhycmwkFDiXv+o5cyySlVvS1Wo
 jZK84JwYTIQmRzkl9Md+veWRhJxYjNT/6KM6DfZGkcU1Np9lEejooZxAw9hSuZNYaD1j
 fdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693469557; x=1694074357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ET1drrAeR+50pLLuvmRQuMFng/wLuH3/v7BWsoxcmXo=;
 b=k+/fVUadx+JhNR7X4Y4bS2t6awHX2DHvIPhu7w55AD7vJwZrn988mpBy8kkZdlu9zz
 AFNk8/1rS2d8OFgOuZ9pvNwYuOzBgyuCy04sJUhJI1pBA/TrCqlUr52XTp6HYcJWBGCx
 E2T9w51vR830rX1N9ZGoCQF5+peWejsrXKP5rxg5Gwhu3KhjlsQjkVFXkcGmMc7V2yyU
 PhUmDmnR4FPFY6J2VAesS2PFSvUi14ehy7nL8eQpFnBsprkHHIxbnsJj1smZcqeRVmqc
 RO+W2rQXYKT19PmNPp9nhR+YA/1P7TenW3Yvw6s26EF4tXOdFTDa9/b8Hqt9GSG2qQxU
 1H2g==
X-Gm-Message-State: AOJu0YyBfkZgyPzq6j3Q6ycajdMM9diZOeaFKJTyP9I36dDcVPsEJnUy
 z94s6bMHnfqTwB9kHd5+4ho0tw==
X-Google-Smtp-Source: AGHT+IEEZo5m33tGZg15SJ1iqv2x57yPQ3pcdVjQBLULLoPCPnWFsVPOuqBfcRZaw7d88wNSb0ywEA==
X-Received: by 2002:a17:906:32d8:b0:9a5:ce62:6e19 with SMTP id
 k24-20020a17090632d800b009a5ce626e19mr3049441ejk.69.1693469556822; 
 Thu, 31 Aug 2023 01:12:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 rl21-20020a170907217500b0099315454e76sm466386ejb.211.2023.08.31.01.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:12:36 -0700 (PDT)
Message-ID: <996b4057-6d64-3803-792b-f6c49dd9f3bf@linaro.org>
Date: Thu, 31 Aug 2023 10:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 01/12] build: Only define OS_OBJECT_USE_OBJC with gcc
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-2-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830161425.91946-2-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 30/8/23 18:14, Alexander Graf wrote:
> Recent versions of macOS use clang instead of gcc. The OS_OBJECT_USE_OBJC
> define is only necessary when building with gcc. Let's not define it when
> building with clang.
> 
> With this patch, I can successfully include GCD headers in QEMU when
> building with clang.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   meson.build | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..0d6a0015a1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -224,7 +224,9 @@ qemu_ldflags = []
>   if targetos == 'darwin'
>     # Disable attempts to use ObjectiveC features in os/object.h since they
>     # won't work when we're compiling with gcc as a C compiler.
> -  qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
> +  if compiler.get_id() == 'gcc'
> +    qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
> +  endif
>   elif targetos == 'solaris'
>     # needed for CMSG_ macros in sys/socket.h
>     qemu_common_flags += '-D_XOPEN_SOURCE=600'

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


