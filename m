Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19E82C6FE
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:08:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPgk-0004q8-6P; Fri, 12 Jan 2024 17:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPgh-0004pz-S6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:07:39 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPgg-0001GH-1y
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:07:39 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d50d0c98c3so49927875ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705097256; x=1705702056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dtDt/09P4s20B6Up4p+NSv+bym0bTdcndokBAsGxzkE=;
 b=uDnM0AvQMw+0wZQ33ZvN3eT77eKj2XBU4ygVxys4JI2qnY3t4NCRpaPV87x409SBQh
 M2TRarmB5ZeVaO6wtKgsi3vTBJVTZ/eu4KLTjRrEyrjNHeOK8oK7BgmCllQwRfrluICH
 vAtFSdg7WgaTRbPq/QlRg8f94T9RhHB0M9SbbrZYlTlD1+PdSGr3JpdOq47X6Jo1pTY5
 +QWtGcWjfKWxa6TezzclU8FC9JFAgAgEsljXqEv+gIQ9+WcVAgr3jb5I5hCK7Axb7SXE
 hSfh07oGNsxIkIyK03qD53djGY3Or0rNZ4EhymGUHpDxblQDIhzEcDiRQxCkeJ02+ifF
 WUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705097256; x=1705702056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtDt/09P4s20B6Up4p+NSv+bym0bTdcndokBAsGxzkE=;
 b=QucDOts71BNHu5KAHxAuU5TgH9yZ67Uq6bkL6AvTUX34z+u4z0p+XyCw9JS87OynYv
 c9XUbqexN1oY/2NvMb5+psesPGtJc2nlWggXhicKujb7m2v2Hnpr3xHOLYc5hkjvB9ku
 Qcr7Y8Z2HDuPMIY3R7fsyq+IdIKhGt7oCwn8RT82QEF9VqfgSCOZkGBP4qDj2z8QDMmK
 maxlXwptQdmP8S7Bwq7krAMmMiI3xcrBRH3zVHtjiWebCHRlFoqGQlxq5goP6UC6/BYz
 JKsuI3guWQlAPRdISk+lV8nR2W9A6EFQujEW2xCqi9e5pyNCgtu6Uqt329zPsOJUW5DI
 XNxw==
X-Gm-Message-State: AOJu0Yw+osVmxTBVdw7SwNEdbS7lsr4LB15O3KLViH/RNbb8JNTF/dI3
 8YfQXdzLpiGuMpond1prQ9P/BywH9zt4zg==
X-Google-Smtp-Source: AGHT+IHlORIKyiJLbGhe3iIdepqLUBa1oixTs7nWtbBZWZADkoCVSSlAIleKvhvwINYOw8IRNVL8gg==
X-Received: by 2002:a17:902:d585:b0:1d5:6a32:650 with SMTP id
 k5-20020a170902d58500b001d56a320650mr2228426plh.21.1705097256233; 
 Fri, 12 Jan 2024 14:07:36 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a170902a60d00b001d4b73f60e4sm3641032plq.149.2024.01.12.14.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:07:35 -0800 (PST)
Message-ID: <477fa733-0957-4026-ac06-57d76d4b0388@linaro.org>
Date: Sat, 13 Jan 2024 09:07:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/hppa: Move software power button address back
 into PDC
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Bruno Haible <bruno@clisp.org>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-6-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112102927.35406-6-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/12/24 21:29, deller@kernel.org wrote:
> +static hwaddr soft_power_reg;
>   
>   #define enable_lasi_lan()       0
>   
> @@ -45,7 +45,6 @@ static DeviceState *lasi_dev;
>   
>   static void hppa_powerdown_req(Notifier *n, void *opaque)
>   {
> -    hwaddr soft_power_reg = HPA_POWER_BUTTON;
>       uint32_t val;
>   
>       val = ldl_be_phys(&address_space_memory, soft_power_reg);
> @@ -221,7 +220,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
>       fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
>                       g_memdup(mc->name, len), len);
>   
> -    val = cpu_to_le64(HPA_POWER_BUTTON);
> +    val = cpu_to_le64(soft_power_reg);

I think it would be better to pass this as a parameter to create_fw_cfg, or to drop the 
translated FW_CFG_IO_BASE parameter and merely pass in translate itself.


r~

