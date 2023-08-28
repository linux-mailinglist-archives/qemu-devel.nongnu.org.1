Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1AC78AFBE
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qab5h-0004yd-Lw; Mon, 28 Aug 2023 08:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qab5f-0004wm-1X
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:11:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qab5c-00041N-R2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:11:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so2606468f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224687; x=1693829487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oeFQoPda/6o9ZqPMORBh+U1Pd7poJAVdD6dMrUp5+DY=;
 b=bxSL6WTka0AXcUtR9IWxn9buYutX/zMPinusnvAR9+ATnlO9W4PCKCWynDAyNA6bC3
 EJtNk3xRwXHTZKrq6t6eVGTauAISNimfBxzBwndkNf6NDeqilI9DNADN26Ae7GJUP4Hh
 I0bNdyZohVLhRKrBrwy8igLEhPiF0oWfp4Ly4v2ZRxh/TggvY64Wwc6pD1EDSUSGAYw1
 yXHMbsevOPsSPX/j8yLZJ/YXr1/KJlJdK/9DoSPBjBdXeDmC+e8ac/ZdvUktKK+y/EjZ
 bvE/BDux9UIQzBI6ALZZUxe7mAMeKQql39fYslBq73rUa7C6NpZk+IrStrxmN9OCXlMf
 tU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224687; x=1693829487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeFQoPda/6o9ZqPMORBh+U1Pd7poJAVdD6dMrUp5+DY=;
 b=BmCaKrTJX09gKv7JCfdfUKM5YYr1tjVsHMyAnaYG01Q7wJvQODgCl4KXK1lC04BA2p
 +ZFbDDcSlqvWyPGVn11eheK/qttUA2J4pQ2Dze1Uc1pjqpSXmbVgyqki+o4GuIGBm4Vj
 DStZnoP+Hgt1belGslUoWWmMd5S+JfNeATesXhbZyQeWm02dfO3xxv8kuQzOCX4o8SIU
 O36fCtu5zBY57o8R2wPNvc/N6i5lowb3QTuJTuy9CMY3zElkbZeFF8jjbfJIWdnN0fEO
 G8bZLQnYnOO7mkbOhqITIKlEK1vcpn6L5Fav7Fhozz14sesGuZRwhpW+3mQdpNNGNhc+
 YprQ==
X-Gm-Message-State: AOJu0YxblUznH356KnkzBtyjHatlMJBNeMCjIlbsQp9pZq93nQWYgUBh
 BmV3yUrL6Mi+ZHwIWqIJ9I6ZHw==
X-Google-Smtp-Source: AGHT+IHWj0c98wQ1vABKqhyEvOCHzUSSKvuHqTk91gSUPyutSI5UDD0Ut+/kYUSaZsxHSbqUlGJstw==
X-Received: by 2002:adf:dcc1:0:b0:314:1096:6437 with SMTP id
 x1-20020adfdcc1000000b0031410966437mr22448178wrm.19.1693224687089; 
 Mon, 28 Aug 2023 05:11:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a5d638e000000b0031971ab70c9sm10410977wru.73.2023.08.28.05.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:11:26 -0700 (PDT)
Message-ID: <855cad36-38c1-0da4-5f79-a49be889fdde@linaro.org>
Date: Mon, 28 Aug 2023 14:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/8] hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
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
 <20230828073609.5710-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
> This is x86-specific code, so there is no advantage in using
> pc_madt_cpu_entry() behind an architecture-agnostic interface.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/acpi-common.h  | 3 +--
>   hw/i386/acpi-build.c   | 3 +--
>   hw/i386/acpi-common.c  | 5 ++---
>   hw/i386/acpi-microvm.c | 3 +--
>   4 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


