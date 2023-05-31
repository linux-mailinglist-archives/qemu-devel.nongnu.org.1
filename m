Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B571835A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MDw-0005kf-71; Wed, 31 May 2023 09:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MDs-0005Te-Jx
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:50:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MDp-0001vB-KM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:50:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso8284505e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541035; x=1688133035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oH2gbsOi2KDJi1FxFqwKypEHkGMrcxCuxU1Lu9iVNjg=;
 b=iC3jHldtFaobwEhE7SoFNuxpYcftns2hH7D78/gWT6RiGLWfuMb/Dp42YxBDpj+iyC
 VEYEIQJqHKmYJZ8YQhBJ7y0/y3ELzYJPruG1Ax9cnmyZ0ME65BRUN0YG4Oy5N/Dyltpn
 QjvfA6STAr5qZmeSflzZaD2S+Z/CpD6iYmdpwHdCfzAr4uIon+2YSWwuFVa9GQXswK96
 am6AR7XD4wUhcZ8iU4Fh8T0MHAVcB5/C//T5WWnP9+Sfqxsdvb1C8OiqNbak/o6Acob8
 zYXAIgtjvTHJP1K51EAeLaEuMhmzdCgwDa1UzSK06MvKv/2XSlcJMmOxMHtn+msXi//8
 tG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541035; x=1688133035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oH2gbsOi2KDJi1FxFqwKypEHkGMrcxCuxU1Lu9iVNjg=;
 b=KzWPDNfYh9X9pXvaKZus3cjBzo28Q+JxIxBT5nwjMcj2YqBEw8jWNGYi5mgrGozpgq
 0oPg0YfhmYJ5muMlCj8YeCrNIvSWiHDfmKkUYZYZwN9geFUEIdjOv5rNG9Qoj1WuIGIh
 CMlNiureUtwPim0UjmN9HvwXDXgnP/GIvTIJpEXm+3hGNCcfLArjIuNZzFVMrYpRw0Fi
 2f+FD79wN0jfLKY+B+MpTCu/kXQt35/kWWOAlZRwPjty4+ZbQtO437m/bm5HYeKH5Woe
 xTXnsElXC2abMZcRlkkxOl2k0FMWfQ2PED2G61cYa90mVQz/FG+YYf8+gj01FKAjprrV
 Or0A==
X-Gm-Message-State: AC+VfDyMqAdXOzGSPQl5PIeF4xhkzx/sujYj4ADee5RRvBZtYrGYIh+5
 d/bmmdZim0TaVUUDZxjOFa+6QA==
X-Google-Smtp-Source: ACHHUZ7pKevTmlef4VTYpuWaUf1xRfGq5w/2dpG3twXT4tYR1LGvYYyMuFNhtVhDqEV1Fv9nmrX16A==
X-Received: by 2002:a1c:cc08:0:b0:3f1:7848:6740 with SMTP id
 h8-20020a1ccc08000000b003f178486740mr4638202wmb.8.1685541035239; 
 Wed, 31 May 2023 06:50:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a05600c364600b003f6042d6da0sm20842064wmq.16.2023.05.31.06.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:50:34 -0700 (PDT)
Message-ID: <de7890c0-de5b-061f-7818-1dcb1dcebe33@linaro.org>
Date: Wed, 31 May 2023 15:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 16/23] q800: move escc_orgate device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-17-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-17-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
> Also change the instantiation of the escc_orgate device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 16 +++++++++-------
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


