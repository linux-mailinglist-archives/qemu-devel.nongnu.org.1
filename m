Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516E7EC645
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 15:49:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3HBD-0003Qn-3r; Wed, 15 Nov 2023 09:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3HBB-0003PC-GU
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 09:47:45 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3HB6-0000Nu-Nc
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 09:47:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40838915cecso55288575e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700059657; x=1700664457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vkw0S7izseqIgzkkW87TLP0K8eZgtlZhVNMLwo1dlp4=;
 b=XmDAH4KCZSvQh0MbuWyNRFttOxvSqoGKJoUb/DkBQuCtdzhQnx7a8udUp5TSvH7AHE
 KXDZgRJjRMe4qoW1hRxCNl1WISAtSK+zK7b9dztTEiFo0SAcfjcSA4DOXpAYTph4w2+D
 251JsAM63oCEFh468diDyiblr0f3oV7mS/jg9pCuODFgU42P2YzsmlMLf79Sr0Yr0QjG
 1RoRzpSWuQsIn5C0mHZqfrgQp7rDMfvJUrrtvmKpzhb4M6xEwYMiyVZl1gr6EXdSPw8G
 Bu6wql5L1MsO5ZHEjT+idiOD5hj8gdhX+aIMwa3s4Cj+sCe7V75jEfd3fpNKrlbolie9
 uZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700059657; x=1700664457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vkw0S7izseqIgzkkW87TLP0K8eZgtlZhVNMLwo1dlp4=;
 b=IsrsDATEylOdEYCafOu7mFkGrQRWgmhybZOcMoqygDYqDV4hw+LnnmO9BtGR/L6Mk0
 5H9h+Dlblkz1ZQ6uXk4pHFcZh02XPZhlVqWjFrqCAivc4CCca1UBgSW0izoh6FS3BVVK
 3zs6jCqwp/TYdI64SUkvEg++aNX0B13ycb6NL3VmjkFQmMjMuSMOTBUOgWvEMI5RDIiN
 4bS5aL8PR/yynPV83ozIlZJ2QNVM/s/ntyIVeTPWJHjmIREF7X76g5KSfi7vMnlPwWO1
 wR4QV6BGM9qIGaEjoYJw6tciDZlL1qsc1CzqpZ2jAGjsaEk5AaGtzy3UE/IieOThIGRP
 yfXQ==
X-Gm-Message-State: AOJu0YxoUb9SgJVK/75U8Gn2aEZer8N7VEUb/57SLJTGGFhbP0A7TMKu
 dyXl+FaflTloi5/VRtS4uUXZwMJh3O2yMRBRU7I=
X-Google-Smtp-Source: AGHT+IG4atahfpRQWYFgJlsXCHyEtNIFxuqfy7MM0Dxlf5fwxdeE/KS5H1zCADZtWNRSv9xg8t3X0A==
X-Received: by 2002:a05:600c:4f03:b0:406:f833:d853 with SMTP id
 l3-20020a05600c4f0300b00406f833d853mr8693295wmq.15.1700059657507; 
 Wed, 15 Nov 2023 06:47:37 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c350a00b004097881d5f0sm21198422wmq.29.2023.11.15.06.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 06:47:37 -0800 (PST)
Message-ID: <8455c237-2908-4a10-9438-0ed6b5275d92@linaro.org>
Date: Wed, 15 Nov 2023 15:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 0/8] hw/pci-host/designware: QOM shuffling (Host
 bridge <-> Root function)
Content-Language: en-US
To: qemu-devel@nongnu.org, Max Hsu <max.hsu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Greentime Hu <greentime.hu@sifive.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Cc'ing Sifive developers :)

On 12/10/23 14:18, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> While trying this PCI host bridge in a hegerogeneous setup
> I noticed few discrepancies due to the fact that host bridge
> pieces were managed by the root function.
> 
> This series move these pieces (ViewPort and MSI regs) to the
> host bridge side where they belong. Unfortunately this is
> a migration breakage.
> 
> I recommend reviewing using 'git-diff --color-moved=dimmed-zebra'.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (8):
>    hw/pci-host/designware: Declare CPU QOM types using DEFINE_TYPES()
>      macro
>    hw/pci-host/designware: Initialize root function in host bridge
>      realize
>    hw/pci-host/designware: Add 'host_mem' variable for clarity
>    hw/pci-host/designware: Hoist host controller in root function #0
>    hw/pci-host/designware: Keep host reference in DesignwarePCIEViewport
>    hw/pci-host/designware: Move viewports from root func to host bridge
>    hw/pci-host/designware: Move MSI registers from root func to host
>      bridge
>    hw/pci-host/designware: Create ViewPorts during host bridge
>      realization
> 
>   include/hw/pci-host/designware.h |  20 +-
>   hw/pci-host/designware.c         | 376 +++++++++++++++----------------
>   2 files changed, 187 insertions(+), 209 deletions(-)
> 


