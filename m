Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7378AF7B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaazd-0000uO-JO; Mon, 28 Aug 2023 08:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaayv-0000gg-Ex
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:04:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaays-0002EO-Ec
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:04:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fee87dd251so29110075e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224268; x=1693829068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ez5JVL0kdSz0DJjZsjSPYj75NgxJNgQOQoFuzjZ1Tw=;
 b=YTJjRZ8ugh5KwylHvd41WkB9PPl54uDKGN9V8hszTa+Udj9wdy7mXfB/XOi3kiuACT
 oDaKwZQLlX0JcP5SHbhu43kmQHEd0sOOdQkEkeLx8JrrF59LWRGTYzalEfyoY7yVxQxF
 Dte2De3NhRhjtaD+OaDKfi+JYaIpqlFkXEp51wzPhr5yfHuMJV2H5NkATjRKujc7WylN
 UEtTe4nCYwAbkP2zOyrULYlB6cN+/WVap1DM/NVn5D6xS0mYoIE3oU/bPIwZ/ujMUZNm
 Kn6QCIdtAy4oA3xvOcmFsnR463k83bQTYFc4fwY4Ps6h2YFQ0x/s0G/Ya/PbKw3Co7HR
 lg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224268; x=1693829068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ez5JVL0kdSz0DJjZsjSPYj75NgxJNgQOQoFuzjZ1Tw=;
 b=gxWnuC21FAZCqtlHD2elfVN8JvipkatA1zC/5U+TLV5Y1P891GqYjwWF7lKjGTMqQa
 F7HPfxegfCBJTINNpKd+FYvLotsSjiDLa6Ia/d6BabZVPRPQnpFw98ycs3GalTZJ25fy
 u1kRsOosI+W4MCfQgBfjy3Jux/xg9po0IFPf9wqRbWlCWNgHYNfGxHMgGHLHN0uwGnMV
 L6QpS/V0N/H6vJgWVuDwJYF++QYOwM778zQ9Z1c1IO4k8h8bo4/47Z0XMjMHaDUpFHoj
 R0+wLOdR57GEaf8G3UyOUFQnZgnbVGGT8Bl1kO++I84onYmgwjulSaa2jq+g8I+J48kz
 /jtA==
X-Gm-Message-State: AOJu0YxT11TrBY7gIKRCZx8dZFFaDvZoo++V+AE+iJ+Q/YgFrx2wza49
 RJ4JRbTWp1FDk7nUvdeVBydQ/4qIQqcm+OzY+Sk=
X-Google-Smtp-Source: AGHT+IGuZyyCwmh6lI6fV1frCxEaCvJbx4n6J0lbWSBPTVdPoJQRlbX5hT42mT74HBjkBnc8n+pe9w==
X-Received: by 2002:a05:600c:b42:b0:3fb:b34f:6cd6 with SMTP id
 k2-20020a05600c0b4200b003fbb34f6cd6mr19819594wmr.41.1693224268675; 
 Mon, 28 Aug 2023 05:04:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05600c290900b003fe26244858sm13719819wmd.46.2023.08.28.05.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:04:28 -0700 (PDT)
Message-ID: <65a71168-b195-e9b5-bf62-3049af528bca@linaro.org>
Date: Mon, 28 Aug 2023 14:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/8] hw/acpi/acpi_dev_interface: Remove now unused
 #include "hw/boards.h"
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
 <20230828073609.5710-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
> The "hw/boards.h" is unused since the previous commit. Since its removal
> requires include fixes in various unrelated files to keep the code compiling it
> has been split in a dedicated commit.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/acpi/hmat.h                       | 3 ++-
>   include/hw/acpi/acpi_dev_interface.h | 1 -
>   hw/acpi/cpu.c                        | 1 +
>   hw/acpi/hmat.c                       | 1 +
>   hw/acpi/memory_hotplug.c             | 1 +
>   5 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


