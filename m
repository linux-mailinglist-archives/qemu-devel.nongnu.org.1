Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C5720D9F
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Hys-0008Vm-Pp; Fri, 02 Jun 2023 23:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Hyp-0008V0-Sq
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:31:03 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Hyo-0005Bw-3t
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:31:03 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5289ce6be53so3010524a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685763060; x=1688355060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fVO11osr2WstJ75ZO8yVWXRosy8XF2DV4DFhAwaowtk=;
 b=hhMUyeYDR9U25LLNNDg5ZfgRnNbQEh3JKeak0trWbkEL21dFq52Jp4UethT3D8H1Kg
 xQ1qZulb+Ymozu0I9kRrw6nt3DnfLXIOBBu8NBOYaowAVHcoRbxBff5qws56YK7wqhxT
 RUj14vX5KmIKz2nuSwrOU1iEXnJUq1v7x2tWoud9MQj++jPl4ZfMz302LxmxWM3KSzvw
 rpfN+xM69UyOIueZVM6rRrFZDoC55FgF8d4iorJCpqPgF4yqEF5kIvvUtTMG4wr33GSs
 gvdZTV2KMjO1fHj075Vv/I/85PGfAd9631xEgA9cjCWrud8ilaYWCBwdMf5Wkwjg5cgT
 OjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685763060; x=1688355060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fVO11osr2WstJ75ZO8yVWXRosy8XF2DV4DFhAwaowtk=;
 b=KJnQJVjNvjHFlp6yJjLVztxKRVGKVZIftxaut3JW5V192DxjKX/LHHPPvWfCmRT5fY
 pt1hiN8vsECydCE8Kq0IudVLelgnkZMqXivUyO8ggicA3uhOTrIKDmXa7iDzkcnK4V79
 lYZwn2AfcBc6rVjJvLBqigiXYHH8JX/H99+VFmOy672//PZiYU26o0eneUp3zxZ4UQqm
 9Nbf9XzzaCVxkNGcwi65pNCzn218CQhAx7WDLgT4Bp/4TmQPjRaeKGvY7C7Vb0N9Kpcg
 hLPJNTOM9+hA5gId8rdEANc4VQ84Lbw5SUUvgDMuowA7pH5fnqN2O1358ecOboxog3DH
 +/Lg==
X-Gm-Message-State: AC+VfDzBNsubRiyPaCaD19VTNDTsNym6WXnF4Vaw94BYoPLB1npRF9Yx
 H8+SPWxwDjMygKACj/sDuJgD0Q==
X-Google-Smtp-Source: ACHHUZ6nVbCfXb18EWNOGHmYh+FhY4nKH4zHB4OsdJfpgorbeWBsKWOBZzN59JQ4SNtzODTA388b+g==
X-Received: by 2002:a17:902:9887:b0:1a9:80a0:47ef with SMTP id
 s7-20020a170902988700b001a980a047efmr1288661plp.20.1685763060277; 
 Fri, 02 Jun 2023 20:31:00 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170903228600b001a9873495f2sm2070283plh.233.2023.06.02.20.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:30:59 -0700 (PDT)
Message-ID: <be1cae90-8acb-7185-7bdf-24d3348bf251@linaro.org>
Date: Fri, 2 Jun 2023 20:30:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
References: <20230602163452.521305-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602163452.521305-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/2/23 09:34, Thomas Huth wrote:
> There is no need to disable this useful compiler warning for
> all versions of the SDL. Unfortunately, various versions are
> buggy (beside SDL 2.0.8, the version 2.26.0 and 2.26.1 are
> broken, too, seehttps://github.com/libsdl-org/SDL/issues/6619  ),
> but we can use a simple compiler check to see whether we need
> the -Wno-undef or not.
> 
> This also enables the printing of the version number with
> good versions of the SDL in the summary of the meson output
> again.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   v2: Compile test code instead of hard-coding the version number

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

