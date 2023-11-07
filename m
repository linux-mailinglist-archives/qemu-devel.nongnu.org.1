Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BBE7E3B19
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:26:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KDk-0008D3-Bx; Tue, 07 Nov 2023 06:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KDP-00084O-7O
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:25:51 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KDM-000074-Mj
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:25:50 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-543c3756521so9209950a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699356347; x=1699961147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ORNEDFI9RqhLx/HRTgMGoDJrd1LTn93L8793jDfz29A=;
 b=L5Ak7NcP9zOenat5w+NMpSM3pMkQ9xU2m4velUagm4a+Kwo8wkk5IamcNakjYM+gDv
 Rxe6Vpcd1/IS0V+NcDUwmdesnOf1ZkZj9TdlTk5srgg4arjjCYlVu6CIfdEKXnPhUtsO
 mpzc5kkrySluJTNfq6O69ZnQR2KfRZWJtZNMI3H9N6MYuy66b5N4TZImBgVh75tsFZlj
 x4209j24AcmcJHwB3ulunfXITnZD349IgQYPHrRmGhnFgUqkDDhINh8Fnb110d0pnEvx
 PEcc6OCCwL5+HEUD54fUfqTq0OGMw4QIs9Lm6F9nbX9HxDfibPSPprH4PPRgviFaa+7w
 UQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699356347; x=1699961147;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ORNEDFI9RqhLx/HRTgMGoDJrd1LTn93L8793jDfz29A=;
 b=Ed05PjrC9sYzL6W2yoFXqtQh4GjaSkd0LpOe64mEwr0ByIDpnkD7Oezc1AUjvCQ4J5
 Yd12lX0YP1BTJkdQvCsVVnr52UOfdHijqYlZ19O4bEmlWYF+KcOt5b/rzkYIowFr57oL
 Zxshp+Eb8MIxnE8UO2K3ZORoXMcZZ3Ru/4vCMw5Bvg+YDT/nFGrvkeoguceuXe0oVTM5
 gfh7BH0UC7FtD8a+Bx+vD8DOSg3NqI2yTSBa0VuzmB1n2JNnolwrcLBh4VLIQC2saO1c
 1pVHuE17W15eXfk94FsjIu85OzqBsQWAJ2evKLKhGL2j+NKx3rEJLLFQUnvBW1GcNSIe
 dlgQ==
X-Gm-Message-State: AOJu0YwOUlAHZs98eOXB2puPGAzi3JElm3Cx8GjCfO35nX+5Cf1GORS0
 VEuPQXU/68i9qx8Jk1rE0VMQFPgSI21iaZimppk=
X-Google-Smtp-Source: AGHT+IFInRYDPmLWM8of6S48qSYIIZKBCqTtaSGYqSxzBlzsKS3dZlLI87/CMsuBoosknKEtouuMCA==
X-Received: by 2002:a50:d5d4:0:b0:53e:98c6:5100 with SMTP id
 g20-20020a50d5d4000000b0053e98c65100mr26559515edj.30.1699356347052; 
 Tue, 07 Nov 2023 03:25:47 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 b67-20020a509f49000000b0053d9f427a6bsm5488119edf.71.2023.11.07.03.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:25:46 -0800 (PST)
Message-ID: <4bcede6b-3673-42ea-96b2-a4caa3a0c12c@linaro.org>
Date: Tue, 7 Nov 2023 12:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] MAINTAINERS: Add hw/display/sii9022.c to the
 Versatile Express section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231020060936.524988-1-thuth@redhat.com>
 <20231020060936.524988-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231020060936.524988-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 20/10/23 08:09, Thomas Huth wrote:
> This graphics adapter is only used by the Versatile Express machine,
> so add it to the corresonding section in MAINTAINERS.

Typo "corresponding".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 34f9036df8..4a7339130e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1006,6 +1006,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/arm/vexpress.c
> +F: hw/display/sii9022.c
>   F: docs/system/arm/vexpress.rst
>   
>   Versatile PB


