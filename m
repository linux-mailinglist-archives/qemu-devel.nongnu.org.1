Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2780EA96
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:41:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD18G-0003u7-1c; Tue, 12 Dec 2023 06:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD18C-0003tv-LB
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:40:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD189-0008FI-FV
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:40:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so64759845e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702381252; x=1702986052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jIMY6LtMvTcgLw5vqa4Cb0r6j9d3B7301jtwprZxGdQ=;
 b=ZSlAPmTt0NmrgbfIfaz5qQCXBByFsXyxDYFA8GBC4ubarUlibQzlXWZPXx1595aT3s
 Iu99YKGrFjvKrDxTCEI1eVhhW4T/Ixs2/7Yn5SwP73DnIHzqKaJ8cWS1FIup0X7JVMVX
 rffLeqeomVdgVHIBPSe2b+WChVyXogCQbuoUpxBIlAxEub1X+PPMjcVk/7i6RRDf1HLY
 8fkiJV8NaGrAzABvLv0664bbsmBQrCYUIqDPAUYsz91g+EkDBaUUz4Xumyo7lWz74sLq
 MMqZfj5xJok9NCK3MFnrmZ5ItKF+0yzyIqtMrhs/dq7UwbLqr5JLiosKF5gtTcXd26Pf
 pXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702381252; x=1702986052;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jIMY6LtMvTcgLw5vqa4Cb0r6j9d3B7301jtwprZxGdQ=;
 b=bXu5546UZtYU9RcJLI45NbxBZw6gfsqnVgCbbvmFMJ3x0BQLsbw3moHzF84Ql2clhy
 Z965t/1AYrEEK+QB2fESsCMtz0e7x9d/8baAjeD8UXoRvcY/48iXsGOUyOTW6cdINyfl
 nf0QkPcNTT+FcpCmzU2styFvFhizUafQgRXgifbgY6uMRiNSqvjkTLKI3+dY+jxaZo8T
 Pq+p2B6LkLeZGeqw01DicocuAZLxzMZIPzQWmI2HSmyVEJGFS1dvwqJQfhH+1Dvjly+j
 qCjzIAPQqkwb68hgEbVIJop4Ho+clNOHzUGRuMn+P67l2LExu0LWE+j+atREVq/psouy
 8Uvg==
X-Gm-Message-State: AOJu0YyiOU7hGR/2OicGsxUvE2+fUDj7pNyJo35FL7l7Yy28qoEOLwUJ
 KxkQFIooR0JpzFgUf/hRKvWZtAPGaLDPZJqqro8jzg==
X-Google-Smtp-Source: AGHT+IEYbh5FGLCXoiGtePFk5H1P9XEDWNPSjqjv7hHnZz+GAGdP0KM4EYFpGRasiZgqINzvAk9dCA==
X-Received: by 2002:a05:600c:1991:b0:40c:4857:e007 with SMTP id
 t17-20020a05600c199100b0040c4857e007mr1551723wmq.0.1702381251908; 
 Tue, 12 Dec 2023 03:40:51 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b0040b3e26872dsm18642141wms.8.2023.12.12.03.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 03:40:51 -0800 (PST)
Message-ID: <38286dc4-9810-460e-ae2d-4f28fdbc36a3@linaro.org>
Date: Tue, 12 Dec 2023 12:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-7-philmd@linaro.org>
 <02cfd4a9-9d6c-4f61-b25e-deb0cbec2838@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <02cfd4a9-9d6c-4f61-b25e-deb0cbec2838@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/12/23 00:00, Richard Henderson wrote:
> On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
>> Nothing in guestfd.c requires "semihosting/uaccess.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   semihosting/guestfd.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
>> index 955c2efbd0..fd7e609790 100644
>> --- a/semihosting/guestfd.c
>> +++ b/semihosting/guestfd.c
>> @@ -15,7 +15,6 @@
>>   #ifdef CONFIG_USER_ONLY
>>   #include "qemu.h"
>>   #else
>> -#include "semihosting/uaccess.h"
> 
> Then I would be surprised if qemu.h is required either -- that's where 
> uaccess is done for user-only.

Indeed we can remove it.

