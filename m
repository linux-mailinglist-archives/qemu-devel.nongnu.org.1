Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18F78AF8A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qab0E-0001ev-16; Mon, 28 Aug 2023 08:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaazo-0001XE-DV
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:05:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaazm-0002W3-3X
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:05:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1943651f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224324; x=1693829124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VYb6YdNL2Mb1HKmR3pVDt0M/FrwlRf3Fq62JfswWuJ8=;
 b=nIhokjdmguBv/9JjHv5D3Qd+7tsJqcCq2tyv+LdlBwZZ2hW6EDa+6pot5nLEoF8rLO
 w/uf69ks9yJ80ck6hRBXHr7KWQtj+Tp3pCeB1Zp97lM57QYS4xktS3zIWjmAK3Ff1ibv
 vAC8ylYREg/TyZ4KH/Gv9/rWP1PtjF7+WZoCV6zkbjYEEMuAdz1YdUNJCFFT0NnaRxon
 pSt67dq2iQr5TuE6nPbsR5cvc5SuE/9kXCqDY4huNU7fmg66EBqerCoPcmVLaaRVkEry
 AYhGbQrXmUGDel4OGPzvVsowwzwy0NbZFiYl90g3jmejpFyMwooI9on5yLXDVag6M8Jn
 DVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224324; x=1693829124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYb6YdNL2Mb1HKmR3pVDt0M/FrwlRf3Fq62JfswWuJ8=;
 b=V617ZyhYV+r2YlyfY/I4paooxiVTxG5OF8UFEwhgPd0ozwdqNHPHi4WFb2HanGHPVK
 0msdFHqHkCLU/jeJnwoSRF0nHRJ0dTsNgQzUvgZlmEqRCcgf7dDJABudcsrlNEtj2RtZ
 oVmdmPDB6ymqsPtv5SrwKRAL7JmMB3y1XHUx1w+CIKWMbo8miFUAy3cUJAl02qnMBTVi
 /j3QjCQcTiWeK8Dvx8BASdLZZXiTDV5tty5+7XMIwFWYhaqEWk7iP09pLckPwOLkCZPf
 yPbHf6NoUF1vCKCjcS35SJ3Owmww1sU8Xd2zVQ6lnyqyqdXGPxrL7oDicu3EecftC2ZQ
 gwSw==
X-Gm-Message-State: AOJu0YzZLcfwHwmNvKomyN7hHg7UjadxZUF+V09Sy5RsrHe5gLxj8+2X
 FR8dxYB11QdCVcEahk1gEYjY8w==
X-Google-Smtp-Source: AGHT+IHcbgmWlgp+OSVvWXH3xMI74IX0/ckh9eErwfO68bk1kBMI4WLpZ90CLPWwcf6PQx8WougLEw==
X-Received: by 2002:a5d:6605:0:b0:317:59ea:1c6b with SMTP id
 n5-20020a5d6605000000b0031759ea1c6bmr16515934wru.35.1693224323947; 
 Mon, 28 Aug 2023 05:05:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a056000114b00b0031c6dc684f8sm10416425wrx.20.2023.08.28.05.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:05:23 -0700 (PDT)
Message-ID: <ac32edc4-8c1d-bdc5-bf01-974a75a8d470@linaro.org>
Date: Mon, 28 Aug 2023 14:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 5/8] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20230828073609.5710-1-shentey@gmail.com>
 <20230828073609.5710-6-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/8/23 09:36, Bernhard Beschow wrote:
> Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu any more
> it is the same as TYPE_ACPI_GED.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/acpi/generic_event_device.h |  2 --
>   hw/i386/generic_event_device_x86.c     | 27 --------------------------
>   hw/i386/microvm.c                      |  2 +-
>   hw/i386/meson.build                    |  1 -
>   4 files changed, 1 insertion(+), 31 deletions(-)
>   delete mode 100644 hw/i386/generic_event_device_x86.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


