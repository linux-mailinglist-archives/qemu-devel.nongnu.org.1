Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AAE81ED71
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 09:50:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPbX-0003Y1-CR; Wed, 27 Dec 2023 03:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPbV-0003Xs-1R
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:49:29 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPbS-0006Gv-VQ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:49:28 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2345aaeb05so537124366b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703666965; x=1704271765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1j2XA9h4S+ROg27iagpHrgN0EXpr8nb4//1UHE5nDKo=;
 b=bdtEq7bH0TZ/YVHJaGsQSFu/3zexyaiQ+EohgHQ+OP1yhobu7aMi7D9QQL5KDlVXKP
 rhKuRdsJq1wg9VdK3XsN5dswTJl8O9tNGIQyZJo5xBnwfYKhFFRn7pTfDOcAg99PaxQU
 Ftd31RlNkDgjSmvjYD+z2GsMavfmQlE4w0uaoRhEXnSEcnW5nRjdBCp5T244pUVGZ4kP
 HnjDNqBi2KBWqMK/GV51eXJnQGLnxkDPNMQ8MnLyYB63PyXzIntLZHZ+qDCX2dbL4Ryw
 C75dgPdvKiE0HGf80Z22YglJcsGTJSNPbBa9tg1Kc9oFtIiwApVEK5gk+NhqdsPlquup
 KwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703666965; x=1704271765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1j2XA9h4S+ROg27iagpHrgN0EXpr8nb4//1UHE5nDKo=;
 b=AjtGRn86UP10wlGKTdTCTTZ1bV3+FCx/fV4wX4GA/feBZdSOEcUP029zS3Fv89s1f3
 3Uwzk/lrt9gqiRiWuFhEAyLnSSbDOA4ffMsEy/WDr/CIOhjcSDkfcDI1wTn5qWjT3CNX
 b6AMUKtmpYXKGJZP1C3qbxy1W6RP5E1/nOn+BtcqiAtRuYCuc7XPv+wBVD++wrpQ81lf
 FLnUKjbiKbOiTPB/6BfWf6dPs52hnfGsuqJHemm006FDJosupnt5VJ/kyY8d7epHkwuD
 mcJ/jAEeRQ7548cTbh7iHqu7KSODeaPuGo5Bg5ISyL86ixq3toANybFcpFRY1p3Ls+Qb
 F1tg==
X-Gm-Message-State: AOJu0YwvyI2ezZhYKIEqcddrBzt2ac+aU9WjPCDW2SZyntt08vDx/7jf
 QhT70s+vwCCqcgwLPRaDpFTgXdcg3RDS1g==
X-Google-Smtp-Source: AGHT+IE1WDZDvn7vNFuuelsIUGPs19x1L6uK9cCo+aZE+0YznX+OpwmZ8wYCcHw0Y3n/WSpnD71gyA==
X-Received: by 2002:a17:906:3cf:b0:a26:eee7:dd46 with SMTP id
 c15-20020a17090603cf00b00a26eee7dd46mr1681555eja.134.1703666964752; 
 Wed, 27 Dec 2023 00:49:24 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a17090791c100b00a26fc7b2aefsm2023243ejz.171.2023.12.27.00.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 00:49:24 -0800 (PST)
Message-ID: <e420ed19-c7a1-4f1e-a625-f5caef8492ea@linaro.org>
Date: Wed, 27 Dec 2023 09:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] hw/loongarch: Add init_cmdline
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, maobibo@loongson.cn
References: <20231227080821.3216113-1-gaosong@loongson.cn>
 <20231227080821.3216113-5-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231227080821.3216113-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Hi,

On 27/12/23 09:08, Song Gao wrote:
> Add init_cmline and set boot_info->a0, a1
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c    | 20 ++++++++++++++++++++
>   target/loongarch/cpu.h |  2 ++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index faff880153..27eae6f0cb 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -13,6 +13,7 @@
>   #include "elf.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/reset.h"
> +#include <asm-generic/setup.h>

Build failure on Darwin host:

[1135/1207] Compiling C object 
libqemu-loongarch64-softmmu.fa.p/hw_loongarch_boot.c.o
FAILED: libqemu-loongarch64-softmmu.fa.p/hw_loongarch_boot.c.o
../../hw/loongarch/boot.c:16:10: fatal error: 'asm-generic/setup.h' file 
not found
#include <asm-generic/setup.h>
          ^~~~~~~~~~~~~~~~~~~~~
1 error generated.
ninja: build stopped: subcommand failed.


