Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96670E48E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Wfv-0003L8-2W; Tue, 23 May 2023 14:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Wfm-0003ID-44
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:23:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Wfk-0003G5-Ef
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:23:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so91179b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866224; x=1687458224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZeUMxqK2a0mu+0TJQHf1Ip6p3nNOkf26yqQPPbHPByQ=;
 b=Q97y8woPiLfMXj4qu1nr52H6yESJIndqAu4KXxkOky47RC/Kq4GFXh7ilLECmMC+18
 ZgS6pT7GwG+b71Z13XkFNo3o0TDD0QSwlu7DsRtJo4uS+xZViKEgCHE6KeVtaP00bgeZ
 SzHf6JSLuFajahRJ+FZOQaN9bqTgq/1oOtvw+Q5MxMIOdf36GMS/pyQKAspdHtRkX5G9
 mL3gK4+EzkenMNT17UbGvCL8KPUzB7Fcftn9qrgSNs5WYe6Gix2PWct5gX/2aKn/hVpU
 JaomVtvN39ELFIr5yX1e+xwlw/OT7PlI9P3xDNNExNLcTyzBGLKmIHdWQA1hG/Tlu468
 XFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866224; x=1687458224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeUMxqK2a0mu+0TJQHf1Ip6p3nNOkf26yqQPPbHPByQ=;
 b=K4mEKI7u4s/SQ/+k8aQkNTdxtamSFE/Qgegif7BuYsoRPRuBqsDu6Kbg+BAWKNwSyw
 1pyVqWvf+4PNtRfCwcZk0mJBbIrjvUJIeEjJUF9Z9BEmUlJtRjBn7WmJ5Z6EriL2PtRu
 QOiS4IdvjdYmb/ViiYNWzJjUe0c7usI0YpjYnlYdje9Bin2avh8DIWL45v5zJdasH1UH
 3W9kq+ccxbzB96xeJ63wRbyopUZEaoQF9cscvaLdQjWkX1P8LRqHpHzUAvv1bKN4KGIr
 fKTF25sN2F2e6EyGvv6Q56Lj+iEsEEUGAMC1CFKQpNHFBrJs84n+wlf5rJyCSBp3ihpA
 50Zg==
X-Gm-Message-State: AC+VfDxmC6TAjBgmQz9mNjp47lGAPgl/EBriOJEiCgbSXjAGZDzXAwpS
 AXHDU3BBRSgYk+1SR4132SWJcw==
X-Google-Smtp-Source: ACHHUZ6rvQl2uTHmz6YVzvO1tbphNz7W9BlFxL1zKtQW+AHNfdrjYqfaRv8kDbxaXwCUjsgXoyzZpg==
X-Received: by 2002:a05:6a21:6d9f:b0:10a:e388:fcb5 with SMTP id
 wl31-20020a056a216d9f00b0010ae388fcb5mr14163944pzb.13.1684866224659; 
 Tue, 23 May 2023 11:23:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 bs5-20020a632805000000b0051eff0a70d7sm6245240pgb.94.2023.05.23.11.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:23:44 -0700 (PDT)
Message-ID: <fb306418-0f6d-1b5d-6d48-16d8319f1eed@linaro.org>
Date: Tue, 23 May 2023 11:23:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] hw/pci/pci: Simplify pci_bar_address() using
 MACHINE_GET_CLASS() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230523061207.48818-1-philmd@linaro.org>
 <20230523061207.48818-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523061207.48818-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/22/23 23:12, Philippe Mathieu-Daudé wrote:
> Remove unnecessary intermediate variables.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/pci/pci.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

