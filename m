Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7FD82BC72
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 09:43:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOD7u-0007RR-Cl; Fri, 12 Jan 2024 03:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOD7t-0007RJ-7v
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:42:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOD7r-000144-P0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:42:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d480c6342dso48246835ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705048970; x=1705653770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxh0IfdfNP7LuqI4KjZND4CNlTTnCO3IvSf5YMNtZF4=;
 b=QfhRUz8G4QYQf8k00TMoqQwnK2MzV+7zwg/+zy2EOUEKsc2hU10lhZ67+OovSodgDs
 NuDGcVhgrpG/nZK+p1G8xDsxVEACXuAxOA86kHQpK9pVcEeHl5EPbim8VE7OogWSGnB/
 5dK9THLpmGaXVl0ytG1RkC4q9PJ8cA832egxAPGwXoitHbSR3SF1rPxO92ujyPvyJzLE
 O3ca2Mszhb9gVXqVIS2LKSnOz9B5FHlX//gtM59RLvI3GcWJiAr7pWzjZlYKGcVLBd0P
 G6rZX36jjSevkfCttsFK0MigfJ4YjXZb3TmMbvhpgiZgoKZRa+U25acMBywvlB7+34BD
 eaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705048970; x=1705653770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uxh0IfdfNP7LuqI4KjZND4CNlTTnCO3IvSf5YMNtZF4=;
 b=MaeXjEbiZX/thoeLDVlL99y2JW4LQ7cfUJgLq6/WYAh678fHSgW+9TUrlKR4u0FfrN
 BConlm9cxyLNc3M66plbx5dbXNHOo84oxI+/8Ptdp0oFa5edNpBrEhcc03s+L0jPZC64
 hfqqqC7LBPq/YBNdr4dusBz+t0P5HuT0yiF4uMDuPZGDXeAAX8B9P1UZDmabVYQSKzwm
 izegU0HMey4AiyJh5gqZYYp5lcr5xi/32RXc2ZScObNP89r/+7uZ/FpEK9d13FN+erNl
 Frh8vpWkmikQv2IjbTPG2YuTwixIYBbmXrraGI1k4iHFmF1DCl5Kg+wPyU/wLe7N9NF3
 jCIQ==
X-Gm-Message-State: AOJu0YwVgvyszMYjo1HqC1sLrNORSjSfrIDGcr9m/SrkVbbjdPpcDQYB
 7wKUBfHDT4jmF2RwY3rDrYqm5tEzx4awrg==
X-Google-Smtp-Source: AGHT+IG4/LcuUlzK4rD6lXep3DzbugGL0b+sbsBU1UwJFy2vOqLYQI8ruoJCkI0dj2uIwplemwdmRQ==
X-Received: by 2002:a17:902:7b88:b0:1d4:4c8c:b138 with SMTP id
 w8-20020a1709027b8800b001d44c8cb138mr592223pll.59.1705048970570; 
 Fri, 12 Jan 2024 00:42:50 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:6327:94c1:b7f6:cf28?
 ([2001:8004:2728:2ad6:6327:94c1:b7f6:cf28])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001d35223d0besm2588160plg.251.2024.01.12.00.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 00:42:50 -0800 (PST)
Message-ID: <8a381e87-6b91-417a-9c2d-1f2c5547131e@linaro.org>
Date: Fri, 12 Jan 2024 19:42:44 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] contrib/plugins/hotblocks: migrate to new per_vcpu
 API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-10-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/hotblocks.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

