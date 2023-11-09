Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC97E7324
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 22:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1C7n-0003PF-R0; Thu, 09 Nov 2023 15:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1C7l-0003O6-Pd
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 15:59:37 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1C7k-0000qs-2C
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 15:59:37 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso214624866b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699563574; x=1700168374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svm0yThTtq8dOQFqwbF6rfIJTlUxfuXW5nfvYjPCdUY=;
 b=b/+wXe+E36c7LC2kLYMebpuKPJECjauWoeSd52PA2YuLAi+hD5pHOoWKT2jg/wrtLk
 cFqEqA0BblcbCVBcgkLdiPxflezhZb82ZbfqxIscHf4NppZtO7tgMpurNCwzA91WRUnP
 2ZJPZIpDqkq+tJuyzuHAwEbngU+yqTMnFndVsBjSrl14CJgAQGwLPNewpJuLjp8c8mZB
 IMG06LpEldONiIjv6foDhZKHHp+CVVSzzUyNDofUzUp2Hp/nKh6icDblwJFbSpugXvM3
 ofK+KtRCN4ZmKRWjmLicJWCX/K7YUa+hxgsSVxQdwu5LzeZPrLbIE4iz0pMhP8av74i9
 RxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699563574; x=1700168374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svm0yThTtq8dOQFqwbF6rfIJTlUxfuXW5nfvYjPCdUY=;
 b=lBshSxQB1386htXo1KBfBoMke3dRGT8pvjJkfTDrwcKMl2KVHrfN6hW5KV7dIUGeXu
 +HAlenHQoAiNtDU0m65imru6zuu3QCB6N7QoPnFuLqbJfLcnCMPk2Eea3cwbGCqDNhD6
 Ku26HIt6o7zkk4CyHn94Y0g0EwZ9ZMNq5obEvG0mfH6OFHWdkOgzBGOqkTfCK7FU5xfq
 tMeWInjepP5JHceFKYP+dWlnu+lDSLU5GHh5nQAuF6ttDXOVa9ypuI98fEZgXiyx2P41
 WP5Mg/IQs/MwXu9YonOVh1IbIeGpPzRDslmhZPXkaRytbf/M5dxhrqHtjZUzzU5621ip
 YNpA==
X-Gm-Message-State: AOJu0Yw5UfmYwbuPz8O6TWph05AnyPvbK0HiYEzal8DpdkuDpwVoKbT8
 LVudm3wQ26ZHoIBtvsEabpJttQ==
X-Google-Smtp-Source: AGHT+IEFkXsFm9Iw2dGE6OGl4HAHkXfMURlEyDjaVT2ZvsI7z4/1Qq7HRM1gCVE1/IkP7IJGB/GKxA==
X-Received: by 2002:a17:906:d553:b0:9be:45b3:3116 with SMTP id
 cr19-20020a170906d55300b009be45b33116mr5920986ejc.71.1699563574062; 
 Thu, 09 Nov 2023 12:59:34 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 lg5-20020a170906f88500b00992b2c55c67sm3029093ejb.156.2023.11.09.12.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 12:59:33 -0800 (PST)
Message-ID: <4ffed8f5-6624-4488-a74f-567cbd926b78@linaro.org>
Date: Thu, 9 Nov 2023 21:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async) FIFO
 to avoid blocking the main loop
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
References: <20231109192814.95977-1-philmd@linaro.org>
 <CAFEAcA8MJeX1Jk_-ONP1nNgHYadL7Oa8P3jGQXwNoofQnJWk8g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8MJeX1Jk_-ONP1nNgHYadL7Oa8P3jGQXwNoofQnJWk8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Hi Peter,

On 9/11/23 20:29, Peter Maydell wrote:
> On Thu, 9 Nov 2023 at 19:28, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Missing review: #10
>>
>> Hi,
>>
>> This series add support for (async) FIFO on the transmit path
>> of the PL011 UART.
> 
> Hi; what's the rationale for the "for-8.2" targeting here?
> What bug are we fixing?

The bug is on Trusted Substrate when the ZynqMP machine is used:
https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=149574

Regards,

Phil.

