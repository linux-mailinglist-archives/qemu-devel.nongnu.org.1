Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA270E968
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:14:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bCq-00069i-UN; Tue, 23 May 2023 19:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bCp-00069H-3O
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:14:15 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bCm-0005gI-Oz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:14:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso81414b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684883651; x=1687475651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3HXXSFzzE9vPZANUSzqXm88OOl0d1ibYrRq257uYQQ=;
 b=N9lOYlrcSHGe8VGvVO2YHrFmoVopZXqZOdmPoILlGltlF5T6nebqKx6spClxsjoKgi
 ldjTKxQXH6zeKN5tv7YQsF/Gvb9EP9vSlv7/GjNvjK32vRpeO9gTpiuXNWHrRdPai4P0
 m166ezq0viLSA5TjsdBb8u2PYJaSEOzAswDEChKTGnzopOQVWeV1ow0gaUXxMmTi/7qc
 nYPjMbioP4rMYir6RC0QATpoMHgl8hTz/a3IICc3eEWQTxrI04mi88Y5LPcXcJrGxnZl
 Hbf98axj0343ct+I+2Z9Gxid/dyRn9MjzO5xn3wux1Jq+WdkPyCMQ/w1sMwbWndR+NO2
 BIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684883651; x=1687475651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3HXXSFzzE9vPZANUSzqXm88OOl0d1ibYrRq257uYQQ=;
 b=L8tbVcBxLd1tXR8YNILoESFq0+YIDQGfOq8TH87O1M151ygt6pphnWqylrbZk49vjx
 6LD0sco5TkgwY0fafmEHe92baVlkt8iZ1ucICAUD8mxqSZYifwyUAipHsu78D7yccrOi
 skoDGB8eU0FGf8/GZFDDK9QRdvJ9fgtdnzN2RpSkoeePKcacT5djg9UgZWfOSATI4IhX
 5be0vc/Bg9+7pwcbxbIlAMz2WarrW8NyDz9EsxU5b5KG9ziKM68lxKIiEexuwkq0wa7H
 u4PFhGJ823LZwVNrr/tnh6MSaT/2FDvogj7CU6UJgIrGyjS9Pk4XDzvlqkGF+EHJJkrn
 ox9g==
X-Gm-Message-State: AC+VfDzUDFdaGB1vPgdcjI+7f8fhJAOKxzfKk6q8DVxaurUlSMVYtP0q
 h62kP7VFRXbZZC3J0Ufl5HgLhg==
X-Google-Smtp-Source: ACHHUZ6WhzKlXYFEeF90wUPucuAC+nKZuNLJAdjeRkbdh93LGZUqAJBQCzb4wzQ9qYsTrbi+7WOrug==
X-Received: by 2002:a17:90a:d513:b0:24d:d377:d1 with SMTP id
 t19-20020a17090ad51300b0024dd37700d1mr15269433pju.45.1684883651024; 
 Tue, 23 May 2023 16:14:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a1709027e8f00b001ab18eaf90esm7410667pla.158.2023.05.23.16.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:14:10 -0700 (PDT)
Message-ID: <a4080577-912c-4cb7-3606-2f911a4365e3@linaro.org>
Date: Tue, 23 May 2023 16:14:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/11] hw/scsi: Rearrange meson.build
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> We will modify this file shortly. Re-arrange it slightly first,
> declaring source sets first.
> 
> No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/scsi/meson.build | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

