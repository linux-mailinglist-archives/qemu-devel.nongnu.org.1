Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 402E675B049
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTuz-0005AJ-1Y; Thu, 20 Jul 2023 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTux-0005AB-PP
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:42:07 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTuw-0008PM-0J
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:42:07 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-314313f127fso664229f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689860524; x=1690465324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5AP2a3aQD1ezBtQvvxdghTzMceec+8NRpztRBjesZ4c=;
 b=iiOd3PSTPL6KZWC7qNvXEnx/IUzlejhQd1JrZLhylfJfSztA3+PU2xAyOjCnRZ6Bgq
 eHEUxyiKFAjYDm6hpKf4AfzxBTY3mdyIp35pejzG11K/XuGwxpBcRJM5WsX0OXWUXb6E
 IzcENcnSUAzfMywkMzjmsay1qte0vXMEtVFBA5Vfi6mnYxAl5AV8zXmsNRYlM1EOOCOL
 dL3rwh7T+BDxmUqe2niX4APGQvkVRDL2irAYiXkrM6CukBxUqTxjDse4jl9nBKAXkzrd
 SDYuby+K3w65Xy6vOV6OA5Iu2bMOJRz90SKCYoXC6zRkrrRtZrrI8S33Y4C6HFm5okRd
 pfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689860524; x=1690465324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5AP2a3aQD1ezBtQvvxdghTzMceec+8NRpztRBjesZ4c=;
 b=Mdzn/IYHVR/zzloLBplpXMVoHOGclyc/O+6VoPMNoW2hRtQbtEhTbh1LRjZbZyrMs1
 rq+4uBw508Zf0gLX34ToZj+jn7bQ9gLs42QygLRjEuOjyITZo8iUCkIbspfZ8HtastiF
 2zmCUINyq6ZL94Em2U8ck77dMtSEHMhGfavAhYi39wekioKXCZpWA84TlDcpof9iM9Ud
 3lsuaGRdPjHcBLuRb073mqkqbJSx3Wrc/OygEXEDyeGL2784EznI0f5m7ufnaMu0JYCv
 n/ZLVfd85fYZj1LouILvyGic4xG7jbW2K2R6outIxkoo3AKmrPn0wjqT6EnLsWHRSGiw
 M0Ww==
X-Gm-Message-State: ABy/qLbZaM2+7WG8m3OVxp/cLHv3yIxawLjCwDi8EI6whiqZqxIZzb+q
 c2fvRCgdeGGNIjVAgqgoA1HB6Q==
X-Google-Smtp-Source: APBJJlGEINK81l24hnY8wBnbY3qH83frglNHRc7nEAfFeDd0zZ2ywU+RFSBW+nIc4Nf6IMq9PJBBvQ==
X-Received: by 2002:a5d:6905:0:b0:313:f22c:7549 with SMTP id
 t5-20020a5d6905000000b00313f22c7549mr2053846wru.66.1689860524409; 
 Thu, 20 Jul 2023 06:42:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.214.178])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a1cf70d000000b003fc080acf68sm3991429wmh.34.2023.07.20.06.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 06:42:03 -0700 (PDT)
Message-ID: <c8b31bc5-fbe8-f4d9-c3d4-d1014355639a@linaro.org>
Date: Thu, 20 Jul 2023 15:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] qapi/qdev: Tidy up device_add documentation
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com
References: <20230720071610.1096458-1-armbru@redhat.com>
 <20230720071610.1096458-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720071610.1096458-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 20/7/23 09:16, Markus Armbruster wrote:
> The notes section comes out like this:
> 
>      Notes
> 
>      Additional arguments depend on the type.
> 
>      1. For detailed information about this command, please refer to the
>         ‘docs/qdev-device-use.txt’ file.
> 
>      2. It’s possible to list device properties by running QEMU with the
>         “-device DEVICE,help” command-line argument, where DEVICE is the
>         device’s name
> 
> The first item isn't numbered.  Fix that:
> 
>      1. Additional arguments depend on the type.
> 
>      2. For detailed information about this command, please refer to the
>         ‘docs/qdev-device-use.txt’ file.
> 
>      3. It’s possible to list device properties by running QEMU with the
>         “-device DEVICE,help” command-line argument, where DEVICE is the
>         device’s name
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/qdev.json | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


