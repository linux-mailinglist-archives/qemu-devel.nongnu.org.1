Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA7D7222DF
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6754-0005Sp-Vk; Mon, 05 Jun 2023 06:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6752-0005SB-4E
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:04:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6750-0000hq-Ff
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:04:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f7378a75c0so9949355e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685959487; x=1688551487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WbInYu1zOKkkpmxrrMxIxyvmmduPJ3FvKHru4KNxDUY=;
 b=yP5jgSDOe64aLwBgNDKYj70YMl5tEwyI9jv800CATNy1AmXaXEgO2uaHqBD89RdsfB
 qozwNsW50LQr7O1M7kvQCOOHxVit2eJJn5DWPkmkM7xAu88+CvZe9nxfCfNBd3Mv5n4f
 gQ/yFj+GgKBa5qlgF1QrfU/wKI7NKdP5MmHH7cZG+r/L4ErsYmNNqVqzvrtbzyn9K2+5
 daTBNeB1gmQ9yJVDuoA8MZ/w/eiNMgc+SKoJnyvbWFZwGhxlzmJRy2qqX+j8qAI0hl2O
 i022Z6Db7HAjk/p2X13W/t959mekCaJY+iG6qySs5ATRuQF4S4Kit4hn9nLTnHaOY+br
 ooGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685959487; x=1688551487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WbInYu1zOKkkpmxrrMxIxyvmmduPJ3FvKHru4KNxDUY=;
 b=SCNXamXZDLuJT5re9DBF7flNWjMMGzpfb2/HRZDEgvdQQJNZemSku1gdwqaYCza0FH
 aRSCRWWmrFruV9hNkFYWljv7Dl7YHIhV2tQu9XzxKB4JcJV82jYKe+JjlOUhureJaFLj
 3M289FfjJe6XSUuEh55LvYLRYrUyHvG2NLP0tX4ZSWS6CYtHNUPZ7fGDrxuBxCeJhtuM
 Xg/WhxY6Zbe4K09g2b+Mo+8shqXviyl8392SoqZEUS0gnlAZmr6TDZnVv8pKpX6uCxDb
 aGxCFdmaU+66EAvowwbBEOSt7koj1Zn5XO3dHaL3TGqvtfXBMSJ5ivwVKTFiPpHj5S5b
 HrKA==
X-Gm-Message-State: AC+VfDwRs0lEvKS5CquNLHp6INPJ2RAQXsqcrWn+WtORmBQ5iqp0B+Un
 BaClp7hxVpzWfUYVpX4Zmr21pg==
X-Google-Smtp-Source: ACHHUZ4XbMZfKdOjSFqMR0t7Ttyv44gfnP+lipOtWAUicVtg4BhNRmSRbho9LQH4UMGicCNFMU9czA==
X-Received: by 2002:a05:600c:2054:b0:3f7:aad8:4e05 with SMTP id
 p20-20020a05600c205400b003f7aad84e05mr1604941wmg.11.1685959487493; 
 Mon, 05 Jun 2023 03:04:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c1d1200b003f61177faffsm23898341wms.0.2023.06.05.03.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:04:47 -0700 (PDT)
Message-ID: <ecd2e684-dd9c-58b1-ce13-62c0db64d9c5@linaro.org>
Date: Mon, 5 Jun 2023 12:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] scripts: remove dead file
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230603214342.471752-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603214342.471752-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/6/23 23:43, Paolo Bonzini wrote:
> scripts/test-driver.py was used when "make check" was already using meson
> introspection data, but it did not execute "meson test".  It is dead since
> commit 3d2f73ef75e ("build: use "meson test" as the test harness", 2021-12-23).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/test-driver.py | 35 -----------------------------------
>   1 file changed, 35 deletions(-)
>   delete mode 100644 scripts/test-driver.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


