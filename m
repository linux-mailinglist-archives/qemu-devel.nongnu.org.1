Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDB745699
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:59:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGESU-0002mE-8c; Mon, 03 Jul 2023 03:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGESS-0002m5-Jw
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:58:52 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGESQ-0001Zv-Sz
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:58:52 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-992e22c09edso223221066b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688371129; x=1690963129;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2RTrk9r0npLB6VVfE9gM4aH3g+lEt+BZMii0ZQnaXDs=;
 b=tr8lNFp7t+y1hBddluqrqWhFOhSLCnPAO3VZs8W2FHmuP5RjAR3zh2WV1kpApbK7Mn
 gVMo0eGqQJxs1ZPrftf4A+OONyqypD+yUUrqvqRrKMmWfxE/crSFHVUVgLovG6rmgIEn
 EupVFPDX8XXj5/GrlHniUrbAMRGpnlsMfdazHZtPhhfNh79F6GDbCGmKLESAlB7mpwFl
 mqrgExuaDgeGv/wLjhSGRSVZ0QSnYEKb03v3W57H2TYwhZRjUQFdOq2Xy+KCEqWZPCQ5
 S/carNjnzidbwQjk/I5f4ynZ256oxow53OV03vE4od7YVd1XrQJTJFs89V8AFCx/XHQD
 Djpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688371129; x=1690963129;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2RTrk9r0npLB6VVfE9gM4aH3g+lEt+BZMii0ZQnaXDs=;
 b=FiP/YRMORbAJ6cGO4qaEEDWXjgodY30XulXgE8C5PmDDIuofSBdnX7c2kK5AdeZbpY
 jddJBvCx1BkOKPUlq6UgXZXtEzJiylxTlFSU93iiE8I9qy+WqHqdZmC0hO1Or8JELUHD
 eAeZnMLYYYR3SqArmRHz+sa9sRR3u1ka2m87wXjvP2yuZCI4QWA5SFKeh/R4zivHxT8N
 PSgEhQTAju5YYpvNYZ7QZKeW1pgHGshakoAEsAji8W0vwjHnKZfJI68TAuuiC57wI1Zv
 /Z3jc48VBQPftwpQKHCe9iyxyROglsRHM7dZcvGOPFDomAhEDY6WUp5I+f/KVa4+Jdmx
 TyHg==
X-Gm-Message-State: ABy/qLZ+3Gh8XzsJgHVBxX2GIr6EfK2FSg9mwHSvjjwgctphxvnKDFU0
 4fPj+SeUjL6TnAKW1a4aDq0TMXaRuoV7mDIEA/Q=
X-Google-Smtp-Source: APBJJlGpHLijESC1znSffi2sTlGY+UvMSZb8lfKuFpO2c3uBIw4+K/+ZxhDslJsa193RlVNq0yj9yQ==
X-Received: by 2002:a17:906:4093:b0:978:8937:19ba with SMTP id
 u19-20020a170906409300b00978893719bamr5754839ejj.44.1688371129359; 
 Mon, 03 Jul 2023 00:58:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 oz26-20020a170906cd1a00b00992b3ea1ee3sm5282904ejb.159.2023.07.03.00.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:58:49 -0700 (PDT)
Message-ID: <45698914-50e7-6cbf-14c2-28b53022aa16@linaro.org>
Date: Mon, 3 Jul 2023 09:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 06/21] q800: allow accesses to RAM area even if less
 memory is available
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> MacOS attempts a series of writes and reads over the entire RAM area in order
> to determine the amount of RAM within the machine. Allow accesses to the
> entire RAM area ignoring writes and always reading zero for areas where there
> is no physical RAM installed to allow MacOS to detect the memory size without
> faulting.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


