Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938A724552
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XLf-0001BJ-D8; Tue, 06 Jun 2023 10:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6XLZ-0001B4-Ob
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:07:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6XLX-0004St-RL
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:07:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6da07ff00so62606055e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686060449; x=1688652449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Od1BpR8iWafju+61CMdBy0N/qIwDQHwenzTvjdebB1o=;
 b=kKIuof1Ip6Wh/4V1M6mqSj3Wpo4IXEgxV7nrBfcbYOVnlYL4Liqtpe5Wemop86qXru
 KN/i/02Cfd7YlV2SIXhh6GPcjH3w0wXwbj6F8iOX5+tia2EHDN9/VWFTzKPYW80rxSWZ
 4xJM6wX6DMg0Kdp5ZUWsL++zOjEN2dma/UOjlUvWoV1HQ84O/VtQiXCx8sp1mhDLYzty
 78XdV+BE9Y9ZRQzPoKtp6kwdux6eOneYnRIWiYAEgQL8Xt2CQwKkUahsDEyZzMbHWEig
 Mi4GF+IJVbCphrLy49lKjv5hATIw8YsoEmiWTRo80dFUjhTS1i4ocF6X6Px09krYT8gv
 SelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686060449; x=1688652449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Od1BpR8iWafju+61CMdBy0N/qIwDQHwenzTvjdebB1o=;
 b=JUVf8Bv0iDnj1PYF4Pf0KlZXDt7GQkI0lcIDaf8IVfrjb2vJDUqEd5mzBgoerKBLJw
 Ai6gA51ZbdQzjr/otPqozPnRmS4PK+QyCfFf8euVIk6FjWHHgUNo6jT/hO41AghVN7EK
 kQ/VLe/HgztKXJGAEImBkBxu27WDSKHiGNXkbYFn9eYa88CquUZvx4VRF65Eh2ZRqrfP
 BhVtQ/WLz8Gc3s5JmlwTVvRRpXF5EzwwICiy1IJRZyGo8QzSSk9rZJ3/gwh7IEG4cQuD
 UylOg4I2E5hLPQcOHs5RYiInSuE3gVLn6iGLs1ZDrWCQ+euFKR1+o12EeUU87OLAdvYt
 OtdQ==
X-Gm-Message-State: AC+VfDyxnyzm5HD/naWB6TzQPzk0IHQNbnd+VP6rZITi80pmtjpXeL9f
 NKPxx3nGGvYWp8jMrCo05y5GMQ==
X-Google-Smtp-Source: ACHHUZ4F3e+sCYDNs9bc0tvHQdl+72o26P++mtrk93K8J6zoe1mD/wnvCKS9B/pghPo4L3RQkmbRuw==
X-Received: by 2002:a05:6000:149:b0:2fb:1d3a:93ff with SMTP id
 r9-20020a056000014900b002fb1d3a93ffmr2050679wrx.61.1686060449658; 
 Tue, 06 Jun 2023 07:07:29 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 j5-20020a5d6185000000b0030af05fce4dsm12787384wru.77.2023.06.06.07.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:07:28 -0700 (PDT)
Message-ID: <527f2ea9-a859-af1b-c3a8-8f28700e66dc@linaro.org>
Date: Tue, 6 Jun 2023 16:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] hw/remote/proxy: Remove dubious 'event_notifier-posix.c'
 include
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230606134913.93724-1-philmd@linaro.org>
 <CAFEAcA-EgmjaMJkmiNF62Fqxu72V_UrFJj8Ae+21OL24S8GfQg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-EgmjaMJkmiNF62Fqxu72V_UrFJj8Ae+21OL24S8GfQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 15:59, Peter Maydell wrote:
> On Tue, 6 Jun 2023 at 14:50, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> event_notifier-posix.c is registered in meson's util_ss[] source
>> set, which is built as libqemuutil.a.p library. Both tools and
>> system emulation binaries are linked with qemuutil, so there is
>> no point in including this source file.
>>
>> Introduced in commit bd36adb8df ("multi-process: create IOHUB
>> object to handle irq").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Note, --enable-multiprocess doesn't seem to be covered in CI.
>> ---
>>   hw/remote/proxy.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
>> index 1c7786b52c..2052d721e5 100644
>> --- a/hw/remote/proxy.c
>> +++ b/hw/remote/proxy.c
>> @@ -22,7 +22,6 @@
>>   #include "qom/object.h"
>>   #include "qemu/event_notifier.h"
>>   #include "sysemu/kvm.h"
>> -#include "util/event_notifier-posix.c"
> 
> Including one .c file from another is definitely very weird;
> if it is by some chance not incorrect then it needs a big
> comment describing why it's necessary...

Building QEMU configured with --enable-multiprocess still works,
so this doesn't look (anymore?) necessary.

$ git grep TYPE_PCI_PROXY_DEV
hw/remote/proxy.c:218:    .name          = TYPE_PCI_PROXY_DEV,
include/hw/remote/proxy.h:17:#define TYPE_PCI_PROXY_DEV "x-pci-proxy-dev"

$ ./qemu-system-x86_64 -device help | fgrep proxy
name "x-pci-proxy-dev", bus PCI

