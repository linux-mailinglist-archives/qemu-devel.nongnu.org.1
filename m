Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD47B7EAA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0cC-0005Gq-6p; Wed, 04 Oct 2023 08:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0b4-0002ky-Ko
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:03:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0aq-0001Uw-F1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:03:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso20901015e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420986; x=1697025786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5M6K0MFXwRhUOt/MGBFSyTxLejRBkATmsturnncN2LA=;
 b=Fwm/tTuxDC7F+9B+yUKSfmRSu9bBKOUqHXhK4C+kLPIAuSJgWnWbIClhdFIwF9f8kQ
 IE1n751po9Jzf1KqSz/GgbBxx/TcTWn/DYYfSJhXhutpU2j9senhs4qYC9vwcO0vcJZZ
 dO8Ap5y72u8h4hwrcNGpK8ogLNZ5IBhQ2eK8u17zjFClguYsWc8iHS4Qwpkln+X9ZaaO
 lp0XfagAis5sEtFpeHmxSnI5gn00ps/tqn5DyGjLh8Uz1c/OroAlfhx4IHUN81susyVS
 MAj4puH5z/xiG5PHcWrBH3AdnUla2QGjO8JV7M+nEzgr/dXSzJ2DL9X168vN7Luf/WTA
 61Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420986; x=1697025786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5M6K0MFXwRhUOt/MGBFSyTxLejRBkATmsturnncN2LA=;
 b=fqFVlZpGTALhecjPNLUvO8bd9+q6Icnh95Q808bFYHY72CIbxNCVeuFPKPtjmC8M5K
 xuLpH2JU1xcuUg5eV4fZ+lmFQFdWxmARSv95Ff8Qy2duXWW6xaLkZ9mj/6+2CL267lZG
 RhAWIm9jdT6WICYXybKrG14EKn8T1+hKK/oXLsFZTrgMo7QKDOYeoErdD6fwSts02qzV
 tC9URunCFPJH4ws+Lr1VWqRBofI2bnThRYxfk7oiey8mmcz8/WYONwbQ55KbwBLmMgQ9
 40/A7s+REmxJg/2gcEFg1Zrbet0PcRViIah8IzQrf3ZSnScrpphteOgNBM5p30k2QNqX
 f3sA==
X-Gm-Message-State: AOJu0Yz5eIEb36I3px+w3G5G5R9nU/bzC2MZ+FhMIDpm4+y+CTuS+w6i
 3JimUcMskne5w/uEmxhWNYxR5URvGMoz5yPFi8Q=
X-Google-Smtp-Source: AGHT+IHt+fi1D5aZxOAg0Xo9Idt6UvjbsjOm2b+G8uLHj+jcEY5t9ehmyzyLQ1Ux+UPZ8vUkDXIRpA==
X-Received: by 2002:a05:600c:21d1:b0:406:53ab:a9af with SMTP id
 x17-20020a05600c21d100b0040653aba9afmr2070621wmj.10.1696420985646; 
 Wed, 04 Oct 2023 05:03:05 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 x9-20020a05600c21c900b003fefe70ec9csm1365054wmj.10.2023.10.04.05.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 05:03:05 -0700 (PDT)
Message-ID: <e3341fd8-b122-ac6a-4a55-07fa80c5142f@linaro.org>
Date: Wed, 4 Oct 2023 14:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 13/13] system: Rename softmmu/ directory as system/
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20231004090629.37473-1-philmd@linaro.org>
 <20231004090629.37473-14-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004090629.37473-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/23 11:06, Philippe Mathieu-Daudé wrote:
> The softmmu/ directory contains files specific to system
> emulation. Rename it as system/. Update meson rules, the
> MAINTAINERS file and all the documentation and comments.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

>   include/sysemu/runstate-action.h        |  2 +-

>   rename {softmmu => system}/timers-state.h (100%)
>   create mode 100644 system/trace.h
>   rename {softmmu => system}/arch_init.c (100%)
>   rename {softmmu => system}/async-teardown.c (100%)
>   rename {softmmu => system}/balloon.c (100%)
>   rename {softmmu => system}/bootdevice.c (100%)
>   rename {softmmu => system}/cpu-throttle.c (100%)
>   rename {softmmu => system}/cpu-timers.c (100%)
>   rename {softmmu => system}/cpus.c (100%)
>   rename {softmmu => system}/datadir.c (100%)
>   rename {softmmu => system}/device_tree.c (100%)
>   rename {softmmu => system}/dirtylimit.c (100%)
>   rename {softmmu => system}/dma-helpers.c (100%)
>   rename {softmmu => system}/globals.c (100%)
>   rename {softmmu => system}/icount.c (100%)
>   rename {softmmu => system}/ioport.c (100%)
>   rename {softmmu => system}/main.c (100%)
>   rename {softmmu => system}/memory.c (100%)
>   rename {softmmu => system}/memory_mapping.c (100%)
>   rename {softmmu => system}/physmem.c (99%)
>   rename {softmmu => system}/qdev-monitor.c (100%)
>   rename {softmmu => system}/qemu-seccomp.c (100%)
>   rename {softmmu => system}/qtest.c (100%)
>   rename {softmmu => system}/rtc.c (100%)
>   rename {softmmu => system}/runstate-action.c (100%)
>   rename {softmmu => system}/runstate-hmp-cmds.c (100%)
>   rename {softmmu => system}/runstate.c (100%)
>   rename {softmmu => system}/tpm-hmp-cmds.c (100%)
>   rename {softmmu => system}/tpm.c (100%)
>   rename {softmmu => system}/vl.c (100%)
>   rename {softmmu => system}/watchpoint.c (100%)
>   rename {softmmu => system}/meson.build (100%)
>   rename {softmmu => system}/trace-events (100%)

Maybe I should also move include/sysemu/ -> include/system/
to keep it coherent?

