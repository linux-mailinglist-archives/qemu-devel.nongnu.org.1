Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBD724DDD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 22:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6d6n-0003Yk-8D; Tue, 06 Jun 2023 16:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6d6e-0003YF-Sk; Tue, 06 Jun 2023 16:16:45 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6d6b-0000kn-5o; Tue, 06 Jun 2023 16:16:40 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af74ca9f4aso6054664a34.3; 
 Tue, 06 Jun 2023 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686082594; x=1688674594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2b72/deZXSzy2HmrfE4XRqwTPmvjFA2eAzik7R7wuA=;
 b=nqJfM2Sr+r+2wiF24DWoIOVFFspxpDC+mm39xffdjXHb205w9qOg+iRVbn33BsCh39
 H2moe4p0xX1eQrw3fua+TFNbnjJhfXer+M3sTz8htmLR3XNMkVj1dqiOwz4LF5ZOjDmg
 fJpRTbOxfyZpY9e5DmNIUOl9raELyClcEVHlGWphJbULnm0udwyJFyYv6kMVkIDuOINv
 iUH9Y+fVb17C6N4Sr9skvb+crRnlLmq5LGey3/6oiFHgbpl5j/A5ZJXzKTIlrPxgLW7B
 vtuS+wASbCp3e6bIMMIFY4Ff97YTNyapxWsZNCZhqDmChszqlYjyDFLIs1bxe3UofRWf
 N8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686082594; x=1688674594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R2b72/deZXSzy2HmrfE4XRqwTPmvjFA2eAzik7R7wuA=;
 b=gsts4CzNPx/GdgFo8BxylQJuH+RPw0ATWX3EtlUYrCqhvULobMjTIkatf5uGSEyke1
 TDtRlUHtPRSPNWs/qQuQ3P/cX49eFUAGxQMC83Ye2rxlfKZZX6blf9jO2mbpjpc656XY
 Y4Webqvtid6LNK6Ek2WULGrpGlmDajrHTKLkhzEd2wkyo5pWSMjoyl0apWR58/agShqf
 yrbydHSZX3kBW90zBrEmxlDP6D5H9x9cuCAO9Yw0DIsucme8Tf4AVph2hiKvpfmjSSJI
 KghZ/rezB+bELFZVlujikSoroOyKRjy5NNDSofyEGom89JGFaiZ2ofCHsahHTaczzuXg
 Wdpw==
X-Gm-Message-State: AC+VfDzpZagge+qIbT7XYPPeMQnbDs+dnKYCX9rJp2av+x4HqEq8t+CA
 2+XMXuNCmCp9t4hoUTQ47PMLHZuENmg=
X-Google-Smtp-Source: ACHHUZ7a+IIHbYnB0L5m8YQ7KEpUpAJEvVq5LCCcYHv40HVO48RCeYSktPNGC6EwFMzuy4Pz3wmZgA==
X-Received: by 2002:a05:6830:11d4:b0:6b1:6284:909 with SMTP id
 v20-20020a05683011d400b006b162840909mr3084569otq.30.1686082594697; 
 Tue, 06 Jun 2023 13:16:34 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a056830004700b006b15ddfa7basm3179930otp.61.2023.06.06.13.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 13:16:34 -0700 (PDT)
Message-ID: <e7f67494-c4ab-dcd5-6fbe-0a021288eff2@gmail.com>
Date: Tue, 6 Jun 2023 17:16:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Kautuk Consul <kconsul@linux.vnet.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230606192802.666000-1-thuth@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230606192802.666000-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094,
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



On 6/6/23 16:28, Thomas Huth wrote:
> The ppc64 tuxrun tests are currently failing if "slirp" has been
> disabled in the binary since they are using "-netdev user" now.
> We have to skip the test if this network backend is missing.
> 
> Fixes: 6ee3624236 ("improve code coverage for ppc64")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Thomas, let me know if you need me to queue this up. I'll send a PR in the
next few days.


Daniel

>   tests/avocado/tuxrun_baselines.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
> index 3a46e7a745..e12250eabb 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -184,6 +184,7 @@ def common_tuxrun(self,
>   
>       def ppc64_common_tuxrun(self, sums, prefix):
>           # add device args to command line.
> +        self.require_netdev('user')
>           self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
>                            '-device', 'virtio-net,netdev=vnet')
>           self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',

