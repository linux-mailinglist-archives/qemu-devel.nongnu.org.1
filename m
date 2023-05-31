Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10771838D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MEW-0006mB-Vv; Wed, 31 May 2023 09:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MEV-0006m2-HM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:51:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MEQ-0002ka-55
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:51:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so44630315e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541076; x=1688133076;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ry3KA2sXbqHETkI1VpNebVl6aRWo7vwsLDbGv6juC0k=;
 b=msSztJODC0Ar8T7E+f1m0eYfzq55OTqYMR8Ct14XzxzhE8viBCX+mQM8bhoH23u/Gg
 T5rO3rJHCnM94yQ3X4tT2vcvS6Qn/XZsbhGN2tPLbdBhv9JRKpzXHGdKs0mn6DKG1KNl
 kWG2cLgdPflZCORA8FQoESIYDFG5sFWzaxZ2sMWbbLEfWot7HrfkbsHmT1zwdt/4Jk6p
 Ty/NHpNW84HD+E9Qkq5hjWdOB63i8AmnFS7m5It5y+lwXTJHb2Y9iaOF1BM2oWcdE9Al
 iUuj6J1NA6S7itaj4u8jxQ/3Tc0sRjOOzYW27y72pwaeISkq0Zz7Slv4K1VQo7SAn6HH
 d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541076; x=1688133076;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ry3KA2sXbqHETkI1VpNebVl6aRWo7vwsLDbGv6juC0k=;
 b=QODpUmrxe79wB36FIDB52qPwQwTtk1HqFXmQ2vi0swlncX0D+lBzjJu8XfKSLzeTV4
 FsPZaP6CIQ3kJ4N5KCFuVYUBujV68Hhm2wKmXxsbGxFxf9uyzitZYE+LEDKKWsiGCHo0
 a7WucRy5NVr0zHWeBKnKYJn51LrDgFKrYxEs6A6Vlcx6DgVmD2n5ke8Pig59G9x8oj9r
 B3JZ6pSyJw0TEXuvamTKQTQvVlCJHbB2RbYb3/nfvymqD26PWp7+3l6PnZXILC7hABcv
 VsdGGyn9tDdUupy4L3ZLWCsLMuuYEe0OgRNEyf5J9t9Wx24oK4Zhnm/Lo9KJ+r7+ZY6Q
 uE0A==
X-Gm-Message-State: AC+VfDwcknk2EHGDjVhOtv+3hgvWk0vt3edGJmMBqqK2HumHqb0wDzWa
 WG0R0rFU47nF+DiRg20A+9LoNQfzBE7HjvivQa8=
X-Google-Smtp-Source: ACHHUZ6N/yFkELtb+jb8xs3riPQyg4uc/JgrC33PSpA4jzI72YwJ6RNKe4zY9NQcykIru1A8JsDfGg==
X-Received: by 2002:a5d:5144:0:b0:30a:e8e8:c172 with SMTP id
 u4-20020a5d5144000000b0030ae8e8c172mr4134723wrt.26.1685541076618; 
 Wed, 31 May 2023 06:51:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b003048477729asm6911294wrm.81.2023.05.31.06.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:51:16 -0700 (PDT)
Message-ID: <80208165-4483-f84c-2d01-9ecb0b6dc828@linaro.org>
Date: Wed, 31 May 2023 15:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 17/23] q800: move ESP device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-18-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-18-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the ESP device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 9 +++++----
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


