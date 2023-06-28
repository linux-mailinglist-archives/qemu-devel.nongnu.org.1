Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A47410A4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsN-0007Os-Ft; Wed, 28 Jun 2023 08:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETs4-0007KB-Py
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETs3-0006bE-3h
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso18908995e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687953720; x=1690545720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2v+lJBO3ApD0e5taWaLyTywsCleiDpRiInhtI1iPbEI=;
 b=q8f31pXW4rOMSJ06wLesia3v7UkcqZiDVkvjBJsK7IBnYNOKxCQNKRNNTla9KgMipv
 46QrlI65WxVJvGXHK0yp69MRorS5SXmJea2LnQNQwVP4yrWb2b5dwwlBngVdO39RNjOV
 fnOfIVAiG7zdulmrkoVoWlWopH48OtIuXYZT1at+jxlh1TfB/FTx2zAoUH6DLCO9NoLU
 nrOabvfdEIVb4z0MKYwFDkKZ8jnVqlfLSIN1vGEb5iVYHoZ5zb0AijLiYgu+fLVi/FSG
 lQahslWbNpaoNXz5BMW6Co3TDd4DoGkII1SsBtTXdypRlM9EBNWShCfwrwQ0ubYQ/sNm
 bUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687953720; x=1690545720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2v+lJBO3ApD0e5taWaLyTywsCleiDpRiInhtI1iPbEI=;
 b=coWWjKfky4rtGVpu4R8vb1N4U//bJpZnD5exx8EpEwJl8PgwqM3midhP2xeOsCCnfk
 4ihKq30hmSk8fb1mbmacBztJMj5StQU3+FrMCf7M4x/CeWQNZLmJxkk9gVm6yuc/UHcd
 xstmuWtEE52j8THFMQcopKeTpwOWmlb3PRs/BzWFUza491UIwoBAYrZni3Kaw+hxadso
 nJgm/ROHkQ6dqW3h/8IKnx8DA7TunXnT7XzsovtW/7CkmXdCjkUC+V8ptEMcoLyB2IVU
 lHLIzMgeoiBupV4VrPx36rkBmWNhtnnUCj95i7i5eQ3IaqZkZHWkK+L7QjAFjKNTJBdD
 Msbg==
X-Gm-Message-State: AC+VfDzXJ+u8WXSXzCLuPbPmrYmDuXWdR+I7Q3HAYX/r4RPIjzSrn8E6
 FQr2lV/Ne86MKEC+TBcXXfFa3PkMmHDDuCS7KRk=
X-Google-Smtp-Source: ACHHUZ7sEuDF5Ls1bG/Dk+UyzaplCBI36B9PHOWAgpsZktSXyq7IJjRBT8uHR707Wa3nDebDrl/Fyg==
X-Received: by 2002:a1c:ed0b:0:b0:3f7:3651:450c with SMTP id
 l11-20020a1ced0b000000b003f73651450cmr12489003wmh.6.1687953720661; 
 Wed, 28 Jun 2023 05:02:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f90a604885sm13650686wma.34.2023.06.28.05.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:02:00 -0700 (PDT)
Message-ID: <08dc34d7-0619-4df3-3ebd-113d1ed82c27@linaro.org>
Date: Wed, 28 Jun 2023 14:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] accel: Re-enable WHPX cross-build on case sensitive
 filesystems
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230624142211.8888-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230624142211.8888-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 24/6/23 16:22, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    docs/devel/testing: Update the 'Docker Debugging' section
>    accel: Re-enable WHPX cross-build on case sensitive filesystems
> 
>   docs/devel/testing.rst           | 2 +-
>   meson.build                      | 4 ++--
>   target/i386/whpx/whpx-internal.h | 4 ++--
>   target/i386/whpx/whpx-all.c      | 4 ++--
>   4 files changed, 7 insertions(+), 7 deletions(-)

Series queued.


