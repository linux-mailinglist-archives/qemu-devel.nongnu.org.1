Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D378AF77
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaays-0000Uo-KG; Mon, 28 Aug 2023 08:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaayJ-0000Im-1y
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:03:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaayG-00024M-Q6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:03:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so28061495e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224225; x=1693829025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RpXaOCor80C0wwQ56UOzzSMzMVli4wekjrzM8fH9G4w=;
 b=Z6biGmeuS6b7D3SAeTNVlRn8fRDNheErRi3MOQB+pNYvaNT9CcUP1AMFLzHOOli93u
 w61Xkr4oVYxydxEY4yh5Q18/YzUlal84b5O6bKebK3SbrGTVu07OQMgjlJdkZnSyH1Uu
 Btt5F3TSleIdRqJucvyskP8gdo98Gubf2NX4Syv1VYkCyS9Cqg6lPAgQXRi6b0z1MKSA
 iXBdxMLENYr0kG3hqx/pXdHF4Bk+C1jksUsgf7Z8yUjPrFpaYWj+GanMGYK1H9eq8fi4
 oA0Lh3a2YJAiAGjNj3C2rQ+C/iNgqMZQJ4WpytxeSp/IqYdHtIRwAOfaO+J2guXwduzK
 bpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224225; x=1693829025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RpXaOCor80C0wwQ56UOzzSMzMVli4wekjrzM8fH9G4w=;
 b=GXfdb36if9IrWcdJz5xuo4j369EXvGMMeSJoxvwQPU0Au1lHsUai8fN07XoEZnznWh
 acL37nJE/78RCaV14qlNJtqnBxmzI1oA1k7MpAoKmgw5Umlriv6IFGZBFFIodvmPZ5vj
 V5SdS7P1y2+87NNZ/Pl57SZHSZv6mBtal4DFnuirbGd+SNfu7QB/Uq3yaFlCbo0uwXRw
 F1CRCDnEj3K/u+ij+KbozADe/Y1dORVE6qkP8ebzo1N9QNUWEJXc874fe3F6UX4nVjuO
 ZNdmihwqi+gy6XD6dmG2PFku9uoYm8eEVZAH52Kt3vtKVIqEiz7urdV+wypV55WAOrJw
 yQ1g==
X-Gm-Message-State: AOJu0Yz7mb+wGxbnNV8ZU22JA1U8CspK0KJdqT/l8Ho9yOLuHlkXI6DL
 Y62mj6I00ewzhUaxtacJFF2qRA==
X-Google-Smtp-Source: AGHT+IEe00PNlb9YhUSo8ipcSSzswk84/LkkXcsQjrYLuwXRnXVl1nl901/TZFBS+1D7xhAZLDvBDA==
X-Received: by 2002:a05:600c:2211:b0:401:b705:ebea with SMTP id
 z17-20020a05600c221100b00401b705ebeamr6682091wml.12.1693224224874; 
 Mon, 28 Aug 2023 05:03:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c028c00b003feef5b0bb7sm10577261wmk.40.2023.08.28.05.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:03:44 -0700 (PDT)
Message-ID: <fd1f75d0-02b0-8fa3-705b-69095437a505@linaro.org>
Date: Mon, 28 Aug 2023 14:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/8] hw/acpi/acpi_dev_interface: Remove now unused
 madt_cpu virtual method
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
 <20230828073609.5710-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-4-shentey@gmail.com>
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
> This virtual method was always set to the x86-specific pc_madt_cpu_entry(),
> even in piix4 which is also used in MIPS. The previous changes use
> pc_madt_cpu_entry() otherwise, so madt_cpu can be dropped.
> 
> Since pc_madt_cpu_entry() is now only used in x86-specific code, the stub
> in hw/acpi/acpi-x86-stub can be removed as well.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/acpi/acpi_dev_interface.h | 2 --
>   hw/acpi/acpi-x86-stub.c              | 6 ------
>   hw/acpi/piix4.c                      | 2 --
>   hw/i386/generic_event_device_x86.c   | 9 ---------
>   hw/isa/lpc_ich9.c                    | 1 -
>   5 files changed, 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


