Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6074AD2F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:36:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgwV-00049j-OY; Fri, 07 Jul 2023 04:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgwT-00049a-JF
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:35:53 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgwR-0004pl-Sn
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:35:53 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b70bfc8db5so10417141fa.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688718950; x=1691310950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SGyMmHvhxRCZqQz0K/XBdLWl1N84DYhS7hSr4N3ao3o=;
 b=w2pVCQAe1JyQpH2NTavcC5Rb9yMfdGjOjIMGOL5sU7TdS6NfNZ9NQyBCE7SLFaBXAS
 5p2bqgFXdZoucHK0W54kO0cigWVceoYr0M/gjsD5loSNGTU+cA5gtI1iQgTwSn2u69SM
 /jwmAWRisknzfFfPB3TIGEwN169zUEjEhq2BEm23gj3YB2zxuuOqPNiCXCbH8bCnTW6V
 /I3DBoQPCyQOSk5toSWMiGMFo6q1qMl+GTSUWQMuhVj90p2jrR5Sz632SkqzKwTHqRAz
 UvAGEEvPfbPykexe3ceCjfe9Vh0epjgbxosr8sBznAfZj/OYAeNZ4Q6gTMJZ4xbVXOMO
 D74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688718950; x=1691310950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SGyMmHvhxRCZqQz0K/XBdLWl1N84DYhS7hSr4N3ao3o=;
 b=imvCG3gm5bm4LPUrpXhgNNB1Bu+4Bp9soucFU50dL0jpBWVCuAKEuOyKnGpasQUY9S
 pk8bcyfQjLFy+azY1lkhphX0QXcyNr7GRZzgq8ompi7TABGGCdGYPPkH8Loxy24v6BWa
 UoOCbK+odt/GTwncpUy6LuaQhhNXy/jLzo75kdq7YvtmYcab/citjfT0c1c1jiFvhRQv
 kJ38jj+73LP/YI9N9L/BT3LOFunYsGoHeGrzCQ5PDz8Dp/R3AbXQ0WaPefxXDKpXFzz7
 eWetE9dOl+hjXeML7E9ooax+NQOJi+uZt4IJdqut4YWRH/DJRoRW/LaCQ8pE+qkpIhY4
 x3yw==
X-Gm-Message-State: ABy/qLaPixkHyyx8+gseCUbYmk+gvYOt5J+JJlpzPzBvcsrdCl/ktREn
 Agwlt5uD9hQPLeEqL4nAdH7K/w==
X-Google-Smtp-Source: APBJJlFqtnhTMwF74hY95EpKzrev+IUE7EEvHPPnmQpItgY60rVy9yL6USR6GKnEGeziS5HY7VrfuA==
X-Received: by 2002:a2e:3612:0:b0:2b2:1f2f:705f with SMTP id
 d18-20020a2e3612000000b002b21f2f705fmr3162289lja.4.1688718949967; 
 Fri, 07 Jul 2023 01:35:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 v19-20020aa7d9d3000000b0051e069ebee3sm1744546eds.14.2023.07.07.01.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:35:49 -0700 (PDT)
Message-ID: <88d3d3ba-7d32-bb77-5335-a373cd327b11@linaro.org>
Date: Fri, 7 Jul 2023 10:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20230707083105.746811-1-kkostiuk@redhat.com>
 <20230707083105.746811-3-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707083105.746811-3-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/7/23 10:31, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/install.cpp   | 13 +++++++------
>   qga/vss-win32/requester.cpp |  9 +++++----
>   2 files changed, 12 insertions(+), 10 deletions(-)


> @@ -304,9 +305,9 @@ STDAPI COMRegister(void)
>       }
>       strcpy(tlbPath, dllPath);
>       strcpy(tlbPath+n-3, "tlb");
> -    fprintf(stderr, "Registering " QGA_PROVIDER_NAME ":\n");
> -    fprintf(stderr, "  %s\n", dllPath);
> -    fprintf(stderr, "  %s\n", tlbPath);
> +    qga_debug("Registering " QGA_PROVIDER_NAME ":");
> +    qga_debug("  %s", dllPath);
> +    qga_debug("  %s", tlbPath);

What about:

        qga_debug("Registering " QGA_PROVIDER_NAME ":  %s  %s",
                  dllPath, tlbPath);

>       if (!PathFileExists(tlbPath)) {
>           hr = HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
>           errmsg(hr, "Failed to lookup tlb");
> @@ -517,7 +518,7 @@ namespace _com_util
>           }
>   
>           if (mbstowcs(bstr, ascii, len) == (size_t)-1) {
> -            fprintf(stderr, "Failed to convert string '%s' into BSTR", ascii);
> +            qga_debug("Failed to convert string '%s' into BSTR", ascii);
>               bstr[0] = 0;
>           }
>           return bstr;


