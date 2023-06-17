Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678F733F5D
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 10:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAQtZ-0005tF-9h; Sat, 17 Jun 2023 04:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAQtH-0005og-EV
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 04:02:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAQtF-00047q-Q7
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 04:02:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f8cdb12719so11784565e9.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686988952; x=1689580952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMYpi9XBuh2MAN7znyzeTDv+BDPTl8aocp3T2vjgXYY=;
 b=HAkL+4mZhiC8PbZ6rEZFhlOoUarXkZciMloo9S8xb9YGPJebESnXzunElzxAghiEKp
 PG1XrVuxEB+96PzyRYk95wPhLzJH8ZeqaeMHdLg6wRsoghh2rZ97xKs5/9POl5w9nDR5
 +9OgC9mrax6RuYAXUu42IVDlDZdzwM71vAe8vcWfgf/qIV+7NyuRPs4U6QKnsZ32EY8k
 nDPIBoZpNpLtme+MAbJzzOXA4Oz5RQkMxQ8HyKj1edZgjtzidKWqx+c1sHSH2zpZ8chV
 Y9LjHsc2Q3E9Ms6NgwInPJo/32WBBJA8uQa2Z4VF9/VLkluCXEeHPXrb4ljxm/Tg5KsD
 wN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686988952; x=1689580952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMYpi9XBuh2MAN7znyzeTDv+BDPTl8aocp3T2vjgXYY=;
 b=Xe5cZ568Qmz9ZjzUEz6Z0GPT49PaQjpHgJeUT5DYby0wILA9Q25qqGV7fl8F9EM/3V
 e1XhvCbEAV/IbE4fRZ/FpN1OTxrfvnvbGV2a6vAcoOrbS0KCAf3RXQQWqBGQQIg66QMZ
 qdNwVddg4rxIytZtCRz2msi6vh4/HgrCM52WxScMOvynO0g2TRcHg9Zgn9AM6xtF4vsM
 oMgSXjqaulAS+ldh60fO7qGju+rdTmYfW1zOecr1GEBtOo34kJBU1TDKGdSJ8bYbH7ZL
 gMXOkD3S443eVQJfRbI/GHqyDGBYu7ts5BqWWoZqufvkMknhUcqSDJ4RfHR1UKfKfY4r
 wJNQ==
X-Gm-Message-State: AC+VfDxiyJkRjlG6WypMPIyIcPQgHiW8+mB5F9US5X2N9q67WzjWgzSc
 /HdkhRJLJsE3hNW+pDGD6RX5kQ==
X-Google-Smtp-Source: ACHHUZ6ocdKmhQAR7kvgFrIZyxpSr+LoGBqIBNn0sgbME55iIHscXguNAc7oG3JpxG3RiGjscb0/gQ==
X-Received: by 2002:a7b:ce16:0:b0:3f6:2391:be99 with SMTP id
 m22-20020a7bce16000000b003f62391be99mr3064379wmc.35.1686988952118; 
 Sat, 17 Jun 2023 01:02:32 -0700 (PDT)
Received: from [192.168.157.227] ([176.176.141.220])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c229100b003f7ff6b1201sm4262696wmf.29.2023.06.17.01.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jun 2023 01:02:31 -0700 (PDT)
Message-ID: <639c0904-b09f-d6e9-cda5-b4dc59673600@linaro.org>
Date: Sat, 17 Jun 2023 10:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v5 00/11] xenpvh5-tag
Content-Language: en-US
To: Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, vikram.garhwal@amd.com
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/16/23 01:52, Stefano Stabellini wrote:
> Hi Peter, Richard,
> 
> Vikram fixed the gitlab test problem yet again. I appended a tiny qtest
> fix at the end of the series.
> 
> Cheers,
> 
> Stefano
> 
> 
> The following changes since commit 7efd65423ab22e6f5890ca08ae40c84d6660242f:
> 
>    Merge tag 'pull-riscv-to-apply-20230614' ofhttps://github.com/alistair23/qemu  into staging (2023-06-14 05:28:51 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/sstabellini/qemu.git  xenpvh5-tag
> 
> for you to fetch changes up to d8a714eba68cd7221d44a6acb6b8a69cf6f2f86b:
> 
>    test/qtest: add xepvh to skip list for qtest (2023-06-15 16:46:58 -0700)
> 
> ----------------------------------------------------------------
> Stefano Stabellini (5):
>        hw/i386/xen/xen-hvm: move x86-specific fields out of XenIOState
>        xen-hvm: reorganize xen-hvm and move common function to xen-hvm-common
>        include/hw/xen/xen_common: return error from xen_create_ioreq_server
>        hw/xen/xen-hvm-common: skip ioreq creation on ioreq registration failure
>        meson.build: do not set have_xen_pci_passthrough for aarch64 targets
> 
> Vikram Garhwal (6):
>        hw/i386/xen/: move xen-mapcache.c to hw/xen/
>        hw/i386/xen: rearrange xen_hvm_init_pc
>        hw/xen/xen-hvm-common: Use g_new and error_report
>        hw/arm: introduce xenpvh machine
>        meson.build: enable xenpv machine build for ARM
>        test/qtest: add xepvh to skip list for qtest

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


