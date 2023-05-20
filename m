Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2364270A550
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 06:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0E8g-0003sX-Iz; Sat, 20 May 2023 00:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0E8e-0003sK-6B
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:24:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0E8P-0003z2-2G
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:24:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-309382efe13so2482190f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 21:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684556638; x=1687148638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kA74U0YBCDP8AWdZSJYbDDG+Q6IE5pF08wIJjqjbF4g=;
 b=ngokkeLa8rOoGSng0U8Sr1q6xDNYmZrZtZO7WvS/lYfLf3mciHo1PrD2s5E2UImAor
 AfcdpSj995PIhtS8Z8v+Zja2SxsVrLcMvTh5lu1HZwa6pjTUu14+85UgXXl6m5z34bo7
 At7hg0GhmbRRGHo/H7rPwbnKUK+SJFz1iSNiYeRqHjqi+aM1oB8kfNd55/tj9JtQLbpu
 tKHqka/9wylERoUWK4/luEwAU8qspvEKGyZ8IXnYrHKJUEYXS+033GwbNYt5mswWTnzn
 aprqbKPxuz34RX69959CDMQ6jWINcXDCJ51BOOsmtha4trwYuc1eYBuOLsBVc1YbAU5a
 HX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684556638; x=1687148638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kA74U0YBCDP8AWdZSJYbDDG+Q6IE5pF08wIJjqjbF4g=;
 b=DW+UeGc9f5as5aNK0AmqWSGAjBGCXj3S8rwuGodzRkdwz4CYKrL79KZQVeqM+7AWTd
 QkGnXUW56xbyYmKYW/o8CGLadGxnwKy2JVB1Y2exc+WXy6wr/8JStp6lQp0Kj27mMJIX
 j2xomF2qUERPupMYEjt1QMnWuBJX3+pFYrXCPeaB7/G8/sTijqGToNRZYEv6+B9p6ffw
 e8da8AeMz9vdYSg66JGeOGuxYtuYOLWok3b34GhbGBoc3Uw9SGmB2GA0vOlqMfbVgx9h
 I7CAGOyp9e5B71CyxWEblDq0pzzv9aGX/TF6kNrnv4n9MImoWukFco0fZmugWYQAg6rA
 QlcQ==
X-Gm-Message-State: AC+VfDwfQWEBTZYG6xcFjT/ohhbjSwo+mIU/g0azuN0AErtcO6czCo8x
 YoI3Nfd6gc5L57Svet2iwtnreWu2NsEfouOc6x4=
X-Google-Smtp-Source: ACHHUZ6l6xpOVLjCXc0Zzll03vX7xT27wryT02p3lzqvYU+sO6xx7PtLRaNWfBoGHs3zEBi+g8cisg==
X-Received: by 2002:adf:d0cc:0:b0:309:46a4:6378 with SMTP id
 z12-20020adfd0cc000000b0030946a46378mr3157162wrh.12.1684556638752; 
 Fri, 19 May 2023 21:23:58 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 d16-20020a5d5390000000b00301a351a8d6sm716531wrv.84.2023.05.19.21.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 21:23:58 -0700 (PDT)
Message-ID: <6ac36631-b2a6-7cbf-0ce2-eb096ae70382@linaro.org>
Date: Sat, 20 May 2023 06:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 4/8] sysemu: add set_virtual_time to accel ops
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
 <20230519170454.2353945-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519170454.2353945-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/5/23 19:04, Alex Bennée wrote:
> We are about to remove direct calls to individual accelerators for
> this information and will need a central point for plugins to hook
> into time changes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/sysemu/accel-ops.h                     | 18 +++++++++++++++++-
>   include/sysemu/cpu-timers.h                    |  3 ++-
>   softmmu/cpus.c                                 | 11 +++++++++++
>   ...et-virtual-clock.c => cpus-virtual-clock.c} |  5 +++++
>   stubs/meson.build                              |  2 +-
>   5 files changed, 36 insertions(+), 3 deletions(-)
>   rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


