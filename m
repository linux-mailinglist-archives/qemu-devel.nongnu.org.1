Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E47137B9B02
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHSl-00066s-RU; Thu, 05 Oct 2023 02:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoHSj-0005z4-UC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:03:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoHSh-0004Uq-EU
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:03:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32003aae100so1037023f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696485828; x=1697090628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bx64fSdjt/TVi4cQ10cqycjsS8cR/VqXU/S9qzqRjaI=;
 b=LkUGb/vyzKn7P/DCUjkO1oIpjkPkKON3as9j1XrSKb4+m/WS2x6AZjU2DE5ATzRnAK
 j3BVtPcO9x4fh2/6VGXw1v8aik2AwnJaKKNRKk7G1kzlFkQvX7TsS0AVeXryotS9Ft3U
 xIH3IHakNNVL/ZQEF4Oq5QGj3p4G2DxoFcD9uSD1dRtAHP4ZdBGDgqRy+vF70WFAgfBK
 UmLK4RvJd43gydf8px7KlGAQtUTjb+qDBdl4QUTKfuwQRA0XEUs8EzRTMmWooA+2ruVd
 WLu4Bt1LhYgxO15gpaXEbBliegRhcR9jKBFvicm6tl1IWCEGEz4QwMH6Ed+tbbBqI2ba
 cjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696485828; x=1697090628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bx64fSdjt/TVi4cQ10cqycjsS8cR/VqXU/S9qzqRjaI=;
 b=po4spNEluCCwuTMSBRwifoaMsa7Quj/dEII2OIwGbDLCrwrRbmn3kujLMo3FT//Zb/
 J5qWPDp7gLj3038wdiCpRkK9SlD3ZlIF1+c3B9VBcHnYu57CrtBT/q08rK5Fhept083B
 EnS1D9naVoXXv4AUqUpNRwjvfdNTJ1HKMb3ttezCxdN/mXl1EGeue/nSm/tMY9MZ2Xrc
 HpNKPu0qpxefg3lxSxeM1kJgodxGLYxj1iFVEp89K/MCfaPmA3w6DT3E0OnCYVbZdA3i
 0ZcmUE0Xp0FoYMwbi4CGPT29Gmk0+v+YcK4rn+4KdKeKpZKiqAzgTbPKcsg5JGPgtfrX
 T30Q==
X-Gm-Message-State: AOJu0YyccK5XQ1EO8n60An2lZojh9zQi+vuhtxHvKWBexdbQXnc9ICpX
 xZNt6XXMQHh4elVtuL0E9TnhWQ==
X-Google-Smtp-Source: AGHT+IGZBX/pddta1+hITYQevX+EflSoIQD1qnS6Sup5vtcuo63wTc/xWeResnU+E9UeZX0RlYxaVw==
X-Received: by 2002:a5d:4e42:0:b0:313:f75b:c552 with SMTP id
 r2-20020a5d4e42000000b00313f75bc552mr1201783wrt.15.1696485828613; 
 Wed, 04 Oct 2023 23:03:48 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a5d49ce000000b0030647449730sm886741wrs.74.2023.10.04.23.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:03:48 -0700 (PDT)
Message-ID: <11900163-bca6-daf0-8b70-b0109a7f6957@linaro.org>
Date: Thu, 5 Oct 2023 08:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Content-Language: en-US
To: Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@gmail.com
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004203418.56508-2-tfanelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

Hi Tyler,

On 4/10/23 22:34, Tyler Fanelli wrote:
> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
> well as the ability to build with meson. Add the Rust sev library as a
> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
> APIs provided by it.
> 
> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
> ---
>   meson.build                   | 8 ++++++++
>   meson_options.txt             | 2 ++
>   scripts/meson-buildoptions.sh | 3 +++
>   subprojects/sev.wrap          | 6 ++++++
>   target/i386/meson.build       | 2 +-
>   5 files changed, 20 insertions(+), 1 deletion(-)
>   create mode 100644 subprojects/sev.wrap


> diff --git a/subprojects/sev.wrap b/subprojects/sev.wrap
> new file mode 100644
> index 0000000000..5be1faccf6
> --- /dev/null
> +++ b/subprojects/sev.wrap
> @@ -0,0 +1,6 @@
> +[wrap-git]
> +url = https://github.com/tylerfanelli/sev
> +revision = b81b1da5df50055600a5b0349b0c4afda677cccb

Why use your tree instead of the mainstream one?

Before this gets merged we need to mirror the subproject
on our GitLab namespace, then use the mirror URL here.

