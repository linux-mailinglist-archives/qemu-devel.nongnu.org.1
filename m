Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59772C2D4
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fmE-0004Gf-Gv; Mon, 12 Jun 2023 07:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8fm1-00046E-AO
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flz-0006Yh-R7
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso43757185e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569506; x=1689161506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8XqRzO0DLqQsI7QUxhQi3SwxWhCNH6bWWUB+LzPeMlM=;
 b=QJks7RSQCeG3CZFni3FQUSw9SiB/tbQuesaK44LWZYcKep1wOvEqYL6t53hQp3zroZ
 CUFg07NJNcbKfKL1CyA27wI46hfmr5JNFWjRLH8kdF7YR4AyFLv3NmGBFxpnkdiv9UZV
 ejfP1jzmPHbtlUWu9cd7NuzP5zx2U9PGba1SHUkdvCI/0f3vW2FKQ8+iqZUjZr9lG4ME
 y7Zl6OVQbm6ixzqnhKyIKLrIf2ypYv2MWSzgPXfYZPNbfpnmvhN3hfMkd8gDgaswbUSJ
 S5fEVNFSg6QeePKoSuA2JeLWKIe208WW9cF/dbkq7QNexxS8b4HHlpkdmUlfJK4p9d9p
 qawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569506; x=1689161506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XqRzO0DLqQsI7QUxhQi3SwxWhCNH6bWWUB+LzPeMlM=;
 b=JLf9+3NDt3tMvIOQXBQs2itzMNfBR0Dz74t2rpNhv1zgYR8ihYK6LjZuH63kiLJCzt
 he+q6FaZN+bCzlBa9Ap2CaCeKe1EzZJBsBHYN7BrczyvFn8tgTvqSQW/8mP5SSGk/bT3
 QbEFtVVNk8sQk7ZGmJOrHZgisXwglgzh74f7ORqJwKwUe2Q2D1kuTmgsRv9wwe5JcMR8
 JwrymHq2tRM4Z4rf0SviTqrH8kAPkFHwujjeHCQJLA7n3CQG+G99yXNt3XLOSd3jCwed
 GRWVEtleoquXCMTn8zXcy5hxLD6dWgDfeaCj4cfB4+xVj2m0ZN0q6wu1XcaxGlK7zoSt
 qxzw==
X-Gm-Message-State: AC+VfDxrctML06JebEYAW1uFcX0P/ebHw+mkFBTnr/dRNas62YyVDh5m
 jHRAorI0ZBQa/PMF+RYvhtkLBw==
X-Google-Smtp-Source: ACHHUZ7sCc9nqhcDaVUppkLZk+EJj+/kAesB5VeDkTEc1LUsQq88IbotffIUTjU06fxVVaI6fBrKXg==
X-Received: by 2002:a05:600c:2312:b0:3f7:f8d7:cc72 with SMTP id
 18-20020a05600c231200b003f7f8d7cc72mr7977915wmo.27.1686569506489; 
 Mon, 12 Jun 2023 04:31:46 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 o40-20020a05600c512800b003f4283f5c1bsm12637006wms.2.2023.06.12.04.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:46 -0700 (PDT)
Message-ID: <548f9dbc-9abf-3a98-9334-7783d476b0e8@linaro.org>
Date: Mon, 12 Jun 2023 12:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 03/15] hw/pci-host/q35: Initialize PCMachineState::bus in
 board code
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> The Q35 PCI host currently sets the PC machine's PCI bus attribute
> through global state, thereby assuming the machine to be a PC machine.
> The Q35 machine code already holds on to Q35's pci bus attribute, so can
> easily set its own property while preserving encapsulation.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_q35.c  | 4 +++-
>   hw/pci-host/q35.c | 1 -
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


