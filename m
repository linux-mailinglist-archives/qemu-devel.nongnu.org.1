Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBC7474FF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhg9-0002FQ-Oz; Tue, 04 Jul 2023 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhg7-0002F4-LT
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:10:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhg5-0007oL-Vd
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:10:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso43670955e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688483452; x=1691075452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxJNamGujTqekxZv8Xd3cZEGe2Qa01rUdrndG/LwTHg=;
 b=J8JYDqepJdiWyP+0XzWYCbPsS+mgejtAfCZPo0mUpIJdJkCBah2rGTO7yVRO9oWnLN
 3IsVqJCuTOSuG39DRW+riEd6ZOlOX8ZchBgbnkf91eJMZ+6A5F45E2q8SeLO5fb4etz1
 PA8nj0RlxgA9HKAah8H1J1IV/o26RbXwUVW+PYtShhoTQBaeuOGSP+H6//xFLubVcsAE
 vlikXZKus43CGgSj4pS1YLttzrC5F9ngnsovk2C0T1/5yb255aqoHSIRXVtKUcTvgyM7
 squChmaCfH6jcsrTi3hz4vIJrMcxv+jFG3I6LloNwXLwQnl7xpjbeHq/zz4vVpfH4vj7
 eMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688483452; x=1691075452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxJNamGujTqekxZv8Xd3cZEGe2Qa01rUdrndG/LwTHg=;
 b=NMfSG5Ls0N0K/4J9pBqGKqyk0xT7u6ySrroPFqTX2HngHgz72ERzkkBhSLYx/mT6B6
 zcUox1A5pFjEbxeogXMCfEB1gOYMa/52SYoGPntEFzkAJw3V5o+2yLR3SMA+9uu6v+Ag
 QlPZbMo0CG3NRTI/Hns0d1c3FUAtTd0d4CfMt8i6t8d4cgVYndul3O2GeFp9Wp5pnOKx
 vMUS9fgBCFo2nY9+gJ0ShDd0Pm3D9bkYnVxItnfUyJGSC/COlYf8j04gHCrptip604UR
 1HKcxN/Q8ChmB09S1Z1LvEF/a5wL9FSCqLVvL1T86RnmMYOsEQovwqqNIIJvs+jHqmD+
 zA2w==
X-Gm-Message-State: AC+VfDxJsQ/iDN+P/jt6yvgfA4O31f4zNyw0JARKUKG04/l1AoLwLiiX
 adlPXJgZoXE+jMeai8Jql8uMUCkyTNSFkxboRxg=
X-Google-Smtp-Source: ACHHUZ5Ladt9jF1i2AKRSTknX4H78x84+g2q6LbuRH1DEYZnZSynmLPvL0qbFxj6ZCBQR/E7jL7iZw==
X-Received: by 2002:a05:600c:218f:b0:3fa:a6ce:54ad with SMTP id
 e15-20020a05600c218f00b003faa6ce54admr10894221wme.6.1688483451885; 
 Tue, 04 Jul 2023 08:10:51 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 d13-20020adfe88d000000b0031438257aa9sm5192187wrm.36.2023.07.04.08.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:10:51 -0700 (PDT)
Message-ID: <af213c9e-aadc-940f-2850-c4127617620a@linaro.org>
Date: Tue, 4 Jul 2023 17:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 00/19] hw/timer/arm_timer: QOM'ify ARM_TIMER and
 correct sysbus/irq in ICP_PIT
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?Q?Thomas_Venri=c3=a8s?= <thomas.venries@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 16:49, Philippe Mathieu-Daudé wrote:
> This series converts the ARM_TIMER model to QOM.
> 
> Doing so we also correct an abuse of SysBus IRQ in
> the ICP PIT model.
> 
> Since v1:
> - Added pm215's R-b tags
> - Addressed Mark/Peter review comments
>    - Drop '*State' suffix from structure names
>    - Use OR-IRQ gate

(forgot to mention migration normally taken care of)

>    - Drop sp804_unrealize()
>    - Implement Resettable API
> - MMIO-map timer regions into parents
Also, from here it should be easier to add the
ARM AP804 used by BCM2835; see Thomas Venriès's
patch v2:
https://patchwork.kernel.org/project/qemu-devel/patch/1507728290-6062-1-git-send-email-thomas.venries@gmail.com/


