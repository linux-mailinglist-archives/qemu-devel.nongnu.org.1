Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D24742128
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmFH-0008O6-Vq; Thu, 29 Jun 2023 03:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmF9-0008N5-Bf
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:39:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmF7-0004e9-JT
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:39:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79f0so5220625e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688024343; x=1690616343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qECXYrj8MIm8zCylgCNJjXYjp8F3KSy8d0JicrLa21g=;
 b=XI48jbtz5Xz7yqxQBrNeKkKyvSRYD+5QsdO5t6MnC+oDS/Ja6xtwoNmxN7GznozIRD
 hjHoMrJzodAEcF1CVJBD5fc5jhSTw1kMNgVGaOtp0QxJiwyf6ADE6WWTdYUST2MLyt+n
 Go+ACsTBWyeXQZawA5Xz8PhDyAuN/6d0enVqZDjZp0utp1AAiolNkTqZo4mr6lgZN+6f
 b8UlhLvDZaMa4e2ii5G5kx6vvceD2mjmfh9W1YFO7ei3tS7Xs+Pv6/xwkeLovzQ242BO
 mPWHYI6cAC3SbP+i28DKCT4ANw3tbSLpAEAoJC07vjcEZ5uEKfC+makS7d7KR3bINZfZ
 Py9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024343; x=1690616343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qECXYrj8MIm8zCylgCNJjXYjp8F3KSy8d0JicrLa21g=;
 b=WDBAPa3RQzIpx6qk26LtIOeUnO89IOX2goAC1MxPnegl7pfhembJB0V9SrFpvXaNaC
 YijGLCueSU7zBVhZSeFe+e5D15tVtEUEf27fW+ovWy/ftORU4tXSF2Qa8bZY3ji84Syb
 jRm7F6/JFw0RttFIMs0YxhIsM2vD2khZRQ+eosEJaisymtrtLARMS7fNMBnlA6F8aCn+
 j9odzFcBUg8v5iXtd3lL09RYxgnzQV/74e1kR2YUCq1a+TPxH02QS+NGKPZ5HVIwndR/
 m0YM0NtTBxNMLiNAJh7ItiM/NyCsKfppnoQLF+Dw7OAaHB8DCB/BYes9qBAs/xnERTTc
 7PTg==
X-Gm-Message-State: AC+VfDw4xPs+OZHlZ2skpulFEtXQuoSExQ/ZwifnxjGWfGQrh3IZ1cWT
 Ki9XB+2IQmwfLduumyoGaYaPqw==
X-Google-Smtp-Source: ACHHUZ7WjYFJritN7ELD1q/RscjReyDU0KloaaguhI3uitFxS96B5DcCKSi+LXUZrKMwUAeXUlMt2w==
X-Received: by 2002:a7b:c3cf:0:b0:3fa:85ad:6672 with SMTP id
 t15-20020a7bc3cf000000b003fa85ad6672mr17938679wmj.41.1688024343558; 
 Thu, 29 Jun 2023 00:39:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 a10-20020adfdd0a000000b0030af15d7e41sm15437920wrm.4.2023.06.29.00.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:39:03 -0700 (PDT)
Message-ID: <ba29fa72-5bbb-8d94-de7a-26bcc27d4294@linaro.org>
Date: Thu, 29 Jun 2023 09:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 15/16] hw/i386/pc_piix: Turn some local variables into
 initializers
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20230628195204.1241-1-shentey@gmail.com>
 <20230628195204.1241-16-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628195204.1241-16-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/6/23 21:52, Bernhard Beschow wrote:
> Eliminates an else branch.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_piix.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


