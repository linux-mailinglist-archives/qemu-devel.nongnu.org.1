Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2340971658B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40q0-0000ie-7B; Tue, 30 May 2023 11:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40pu-0000a7-IB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:00:34 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40ps-0002VS-OX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:00:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso3138773b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685458831; x=1688050831;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AYXZbKv8lfR/eHY2MbMJH24MJ9CXRAkZvAZstDC/gB8=;
 b=K9Ol1XdYs5LWI11Yj7FUHYylEaPKcna2lIea9pnPy5lOALJDds24TriIgjtGEb9NmK
 r/tnlsXl5Eqh3ZzEryG8LTWsxJDY3rOyYiZg1EsRmBVwpU9ZDs2OCpT2qOI4FUJlH5XM
 PRl/xFRWsvl3LCwTjAld5Zv+ZwaQOSkPw0tCUslJa0nWr1vs2jsvbEFA3KWWAX+DST4W
 VCYeRcJqREHJ3r/MiVanRa9JUcnlYFz0Q1p9HKuQTUnEHCs/WjJB4RVmbVr9P6ZTv6xc
 q28kYBPKwzuKS6lBNVfjEKSI4QnZL3ulQp9g9O41Jn6RhE3bKg2ew1BERld5lX/yG/Ca
 sOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458831; x=1688050831;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AYXZbKv8lfR/eHY2MbMJH24MJ9CXRAkZvAZstDC/gB8=;
 b=d1LQUvK9IwvZsQT8QHuykHJsVwGaSYrFK7ny5TNU8ikHcQ7KX1C1DV1j8Da0lGmZIl
 iv/npxAxruptpL5/O5VBF2wtagVpXeJ4kH9nONWe6OhpP7EbvK+qMvFpzmY19tTxUXhV
 QxKXJ1AvDInkldlZxcJtBppraihBh5s2wf7H4wJKArZ3ew/1ex42TVE+8H+98+/4n1SY
 pbGgt1GEAyOyTG0O0Qy5DhkOsH3Ocky8o2cOFIlSSHOFAoinYfzZiEm9NUyQBTA1Oa5L
 HSriD83l8nWZfinNNgM9c5weMdICmPt8msvU4N9z3LCPtJ8rkdJcLAmCZK/d7v9JY0tm
 P48Q==
X-Gm-Message-State: AC+VfDxuVt7g921pBN3mPftfhN29M/S+pxoHLCX9r6Gkj0pm3xEvDkVw
 V8TRmSuaVVQwg73FjHVo1PyAiRIt8sEcl89aFdc=
X-Google-Smtp-Source: ACHHUZ4X+aiouVuYBiKU4KC5HOPBeu0TJYmYWtvx6OhlYbqbQtKkHuY5q9m77dak7Tyfk8DBKXmzBw==
X-Received: by 2002:a05:6a00:4509:b0:64d:2365:fbab with SMTP id
 cw9-20020a056a00450900b0064d2365fbabmr3103979pfb.4.1685458830459; 
 Tue, 30 May 2023 08:00:30 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a62a50c000000b0063d44634d8csm1736360pfm.71.2023.05.30.08.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 08:00:30 -0700 (PDT)
Message-ID: <8696ef96-7287-b059-261b-d06d1d3b0c25@linaro.org>
Date: Tue, 30 May 2023 08:00:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re:
 tests/avocado/virtio-gpu.py:VirtioGPUx86.test_vhost_user_vga_virgl: ERROR
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <7b9511f8-eca4-8a27-9d4e-31a6f16a6bb0@linaro.org>
In-Reply-To: <7b9511f8-eca4-8a27-9d4e-31a6f16a6bb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Ping.

On 5/25/23 10:00, Richard Henderson wrote:
> Hi guys,
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4352476431
> https://gitlab.com/qemu-project/qemu/-/jobs/4352476434
> 
> This test ERRORs on the azure k8s runners with
> 
> qemu-system-x86_64: egl: no drm render node available
> qemu-system-x86_64: egl: render node init failed
> 
> Can we please SKIP the test if the required resource is not available?
> 
> 
> r~


