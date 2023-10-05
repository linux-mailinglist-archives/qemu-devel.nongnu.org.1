Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9C7B9B32
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIJX-0001lT-1M; Thu, 05 Oct 2023 02:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIJU-0001k4-Vf
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:58:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIJT-0005Vo-DC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:58:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-327b7e08456so650515f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696489101; x=1697093901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uvyb+PHHLDs0bLHkxu6L2jQEkGclaB15dNWW9R8Oo98=;
 b=ZuFFGGA2eLw+DeZjm5E1MxzdQ5QEJ0ooWaG6VXoclnoaKqj3dinS+MsYCjukSCUxRI
 5GGIURrB/Vmr/WCDxbWnVzJDccXVAzIgfmTUaPuIVPHIHQUxptgsxnIYbAyh5lCvTZG3
 PGAmpXgQRyQ542NIeg1NkIiNE80y6eFG0DyxgcL0p9bLugatxSaFZIluaGaAka5Hy27L
 JfQ7g2/vj0hk3wJvE89UcXAzfTXKpfBCmmW/EigMQMKGGqaqujnOKLPvx5Mq15DLgGiN
 qXeWlDWufg1a+MZJOxHr9xLBmEkGgejbNNdjL/2RMixunQUGoMkjq3ukp2WzMaHj6ddr
 8mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696489101; x=1697093901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uvyb+PHHLDs0bLHkxu6L2jQEkGclaB15dNWW9R8Oo98=;
 b=akDgsaaXCr0bdwWDn3dLNuuzHQXEKCe0DurZESAAWCpN2fIi3TXHOXstg/HX8vF5pc
 RbRjgsRostHBMl6fWH30+dlASXr6C6/v6LtFWmJ3Tn/6Ral2FU3bTm01Lono8rhbwlEy
 oS9MPTVgMoOONv27A4raDPHT+tBuaotKReweM6n8RHAcGy3f3O89ZNg/ux+DZV+x8/tR
 mDFZvS/BXVabYxBPw0nRmfLx3/IYWnzFNW3MvyVaJD5Bs0ON/qlC8fXZsUcuGLvrExdk
 E4pLwlYRXJT8VOnWrEJTf2JWpv1waX9cWO1mOtel/y6Ut9wNvaLD5UbrD3X/vFCjk/vl
 4EMg==
X-Gm-Message-State: AOJu0Yy4eu9TnUGSLRJeWGf1nb1ywGhw7URtWrnkNjv2bhKyfjQUdfGY
 zK+GqJW4O+VgvVXrHm0bRuybXA==
X-Google-Smtp-Source: AGHT+IGQ6c71jRl94h7Kf8+nK2ldmgv7+Uop6Gy5PYsLuy6M0r8Y8EHdqHCvBSS+ryCl720YlAh73Q==
X-Received: by 2002:adf:ed52:0:b0:31f:fa1a:83fb with SMTP id
 u18-20020adfed52000000b0031ffa1a83fbmr3798159wro.7.1696489101293; 
 Wed, 04 Oct 2023 23:58:21 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a5d4990000000b0031431fb40fasm1003134wrq.89.2023.10.04.23.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:58:20 -0700 (PDT)
Message-ID: <241f98b3-8d23-9fda-5182-8b8a21ef8131@linaro.org>
Date: Thu, 5 Oct 2023 08:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] cutils: Fix get_relocated_path on Windows
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
References: <20231005064726.6945-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231005064726.6945-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/10/23 08:47, Akihiko Odaki wrote:
> get_relocated_path() did not have error handling for PathCchSkipRoot()
> because a path given to get_relocated_path() was expected to be a valid
> path containing a drive letter or UNC server/share path elements on
> Windows, but sometimes it turned out otherwise.
> 
> The paths passed to get_relocated_path() are defined by macros generated
> by Meson. Meson in turn uses a prefix given by the configure script to
> generate them. For Windows, the script passes /qemu as a prefix to
> Meson by default.
> 
> As documented in docs/about/build-platforms.rst, typically MSYS2 is used
> for the build system, but it is also possible to use Linux as well. When
> MSYS2 is used, its Bash variant recognizes /qemu as a MSYS2 path, and
> converts it to a Windows path, adding the MSYS2 prefix including a drive
> letter or UNC server/share path elements. Such a conversion does not
> happen on a shell on Linux however, and /qemu will be passed as is in
> the case.
> 
> Implement a proper error handling of PathCchSkipRoot() in
> get_relocated_path() so that it can handle a path without a drive letter
> or UNC server/share path elements.
> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> V1 -> V2: Compare against S_OK for clarity (Philippe Mathieu-Daudé)
> 
>   util/cutils.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)

Thanks, if Paolo doesn't take it I'll queue it in my next PR.

