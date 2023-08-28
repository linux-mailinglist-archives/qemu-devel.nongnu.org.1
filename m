Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9B78AF75
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaax7-0008Bp-EY; Mon, 28 Aug 2023 08:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaax5-0008Bc-Ew
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:02:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaax3-0001wZ-6d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:02:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so29004185e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224155; x=1693828955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JMx+qZwEch+GWzNF4uKtXIEKXRCJwOwAUz5z7lF6uaw=;
 b=asE0zwHp7bvjDW+8uXiNJ0P4JjnsSTSVceztjzNW8PoOSAKAuOTDzl0fyfLk9nMHjJ
 Cs/ENgPgl95XizR3oD3AHzSag2S9gF3xhGLL4voEdpHUNh55GIBPm/N7dNWvpks0nYWM
 /jsDai5v2AvByBdMFqxULb2xvJXKE6H3HtaQUQwOEYAsk7Z8/Fi1RB9qc1d1YkGM/diJ
 NlcL0psRSOs113D2IgosZqehFScsCkLrzd3TR9rem9Sh7k0U1ivk09xhX7xbvS8hn5pJ
 bYYqvyJUODlHwOmTMyC9g3+6jrMK3y1KZtJKMrEQ7ETRzOdqSvlq+CdVDqNpq0Cox8Re
 uOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224155; x=1693828955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JMx+qZwEch+GWzNF4uKtXIEKXRCJwOwAUz5z7lF6uaw=;
 b=DL8SNW4aGtlOV+qUew73AXf1zct96Nm1bODvreNCoz/06Z9F0C5BoiZl+4qsSjhXb9
 dmTd4A/vbN57Ait9MxBfFWxW4AbjADOgiv1CpeIQydlobZTgd3Dy/IryPS5shQcL/ShB
 Y67ran3hPhbOctd/tvYYJUObeEe3VCgCgfzzO+mx3wE0zCaulHxUsVswzf8MV+QdlytU
 ZVL8vuE2LE+8D4b8EB7BB2zLVU/4dY5QqFFVxpJqGyq9wMrZ6zyx6ArvGoXhOYQLFskM
 b/f5jfUkyq0F0noksN4dec92QgrlZ6U8Dj/Vjxy6az2eL3hekzRekl9z0V06i3Zyzh0g
 1b2w==
X-Gm-Message-State: AOJu0YxHyF5OnfsAdX6SMj+15Bz5sWQnuV9Y4eBcxfTa0fkDy4qa8vEv
 iNVusVz16YOQoubtYIMBtQbclQ==
X-Google-Smtp-Source: AGHT+IFDvejJHJPBqTQvmJAGSgaROiHFklikPAA9GzY8tExJWxs/ddJyYhhf9u8hXu5FHPRD9GfP4w==
X-Received: by 2002:a05:600c:211:b0:401:23fc:1f92 with SMTP id
 17-20020a05600c021100b0040123fc1f92mr8809516wmi.25.1693224155199; 
 Mon, 28 Aug 2023 05:02:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a5d538f000000b0031ae8d86af4sm10342106wrv.103.2023.08.28.05.02.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:02:34 -0700 (PDT)
Message-ID: <d5fd4be3-0c4f-701a-7d44-b898d2690e6e@linaro.org>
Date: Mon, 28 Aug 2023 14:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/8] hw/acpi/cpu: Have build_cpus_aml() take a
 build_madt_cpu_fn callback
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
 <20230828073609.5710-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
> build_cpus_aml() is architecture independent but needs to create architecture-
> specific CPU AML. So far this was achieved by using a virtual method from
> TYPE_ACPI_DEVICE_IF. However, build_cpus_aml() would resolve this interface from
> global (!) state. This makes it quite incomprehensible where this interface
> comes from (TYPE_PIIX4_PM?, TYPE_ICH9_LPC_DEVICE?, TYPE_ACPI_GED_X86?) an can
> lead to crashes when the generic code is ported to new architectures.
> 
> So far, build_cpus_aml() is only called in architecture-specific code -- and
> only in x86. We can therefore simply pass pc_madt_cpu_entry() as callback to
> build_cpus_aml(). This is the same callback that would be used through
> TYPE_ACPI_DEVICE_IF.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/acpi/cpu.h | 6 +++++-
>   hw/acpi/cpu.c         | 8 ++------
>   hw/i386/acpi-build.c  | 4 ++--
>   3 files changed, 9 insertions(+), 9 deletions(-)

Nice cleanup.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


