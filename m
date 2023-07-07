Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1171F74B842
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsK6-000170-Dl; Fri, 07 Jul 2023 16:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsK3-000101-EN
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:44:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsK0-0005d7-Pd
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:44:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fc04692e20so3066945e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762693; x=1691354693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/fM2Nus+c0BHDllAAHvAP9sed/vy1dy/EvSkyMfoXc=;
 b=bFtGgefbxTym02LbRs/oxpIm/bUTW3aHwzU2nuyRJKetxLtAaQr7c5HlkbM3eoV7lu
 qBoSeqRUrjCE5jSlQPGnu84fknE9MvimrLo5iMm81Xp8/n0UB1XPF0KYxUE3IyeaT/Mz
 F0952zZ8mtauwTz5xJ6UffuxXcT2eaYx4xXP9AwYa9bOjTlA/eJ6zJDDKOkPVjaxdssh
 gFJXSt7dnd2MHTeSWWzFsSgFB/6KZdyRA1frWrrNEeTvUYxZ846eruP7EYQxnKsncwVZ
 qgML0s5FUuMHu4KyLTLjH/g2weDnAklUf4Uq/gibnrUDfjQSQpQPv1hXlKi+fEcYZrCt
 Eorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762693; x=1691354693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m/fM2Nus+c0BHDllAAHvAP9sed/vy1dy/EvSkyMfoXc=;
 b=PFHsng8TbYizgy1CW1GJn7JcnuxH0Ds/19+g5DraqSOuSqUL3x7LS5Mbp63UFs63bq
 gMTACazmLKb3pRrjr4WajKsaq5g8jSQVWl1wbza8cGNkZDK/QujJJy3XBYgKqPMIVZY6
 KJYyoOgxwJ6S43DJzy9qFAGmaFUeZEu0Naizn4kxy3gyMuUgYuHo0MmRucDulqTQ7RZ0
 Ze90VEQjkwwohB5l6jjrJ16HybsRhw9Ls21kg552b8vs4QOrEZRfF9lLrD0HHjwbD033
 deoS4ZQ4HJdYMk8cGTOJ4RrmjNpEuwwxxLD+xIupZrwrzESPzFbBQwE9pAqYHrg5mZsq
 4ZbQ==
X-Gm-Message-State: ABy/qLYaYqr7dSSxWFPRcRvErC1RFokx8p/3BV248AsV/OQSya3yrV0W
 PFRUzYLDY4u0k7eJkKMDu7+mqA==
X-Google-Smtp-Source: APBJJlHz5ZKM8zjdkgHcWHAxgX99ajKOoZR9SXibrwrDkdNEVK70LNrQf4rsT2z8S2BFyh4lIoI6kQ==
X-Received: by 2002:a05:600c:210:b0:3fc:5fa:e2a9 with SMTP id
 16-20020a05600c021000b003fc05fae2a9mr21293wmi.41.1688762693362; 
 Fri, 07 Jul 2023 13:44:53 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c0b4600b003fc00892c13sm2090835wmr.35.2023.07.07.13.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:44:52 -0700 (PDT)
Message-ID: <64ab81c2-554b-ea62-3ffb-e955f25acece@linaro.org>
Date: Fri, 7 Jul 2023 21:44:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/6] hw/virtio: Propagate page_mask to
 vhost_vdpa_section_end()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230707151719.70613-1-philmd@linaro.org>
 <20230707151719.70613-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707151719.70613-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 16:17, Philippe Mathieu-Daudé wrote:
> Propagate TARGET_PAGE_MASK (see the previous commit for
> rationale).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/vhost-vdpa.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

