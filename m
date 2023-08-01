Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58776BF79
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxCJ-0007FW-L9; Tue, 01 Aug 2023 17:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxCH-00077E-6q
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:46:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxCF-0001uq-OD
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:46:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso57872195e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926386; x=1691531186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohN9Wz8Tq0p4347pFZnoqJSLq0qtexHWyBZeshms6hA=;
 b=HedgwzAty7/tDKFI/wrwPAowntQywNuKE60cCvIrZGWsvQ8t+gArxDgs7BsIDHZumk
 QJ6AxHmdipcLURD683pNAxK/Pfy0EFxSTOd7WpA8WONW/Ex3aUMcgdtUDgoJniwvpEqL
 BsuB5NISTgVfIH5LD7BfvJYg38OuJZqJtTAFVJwLS46K0KaaIiiyj8rB2kmF8FOwHmTI
 cm+cjQT1u9Z3Lfpu4+BZqdHeOopiSxWC9G5lwj58spblNSV0HPs/miffiq2m0orH/otF
 sAlUInUCBFtvZdL0ER7QANzu4LsguBYL5nxv5DM7MzIanjHZ2tLSl5r3ZHDFRoeQeUV3
 7KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926386; x=1691531186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohN9Wz8Tq0p4347pFZnoqJSLq0qtexHWyBZeshms6hA=;
 b=gBIUFE6vOU77zfWuyu666QhR+gvfVpYTXN+2n0GKTEA2Qbz1s7KMsRNcI7E11HrPlT
 Xq0TUeCDyMyjI7YPOVJaAvIn0vpcFZYeSDoMdcn5bkgBdxeLHs7+x28+xG9ilY9CW4nk
 /vI1JUxJxaXMPTV7r7tYYqhA91JreRePjSsCMZwOAuU3VNS79YmqdypEURFrr3kNmmhl
 EgSlJv/Lm/aE8hDPRd7DY8nB1ZDBw0/eKFW6VN9w5hOh0I2yToPjKLh0kaymKPCPIco2
 KsJl2+4+K5wmJyPmz3TE6gP9KW/jqru0n8xmmJnqzYgZugvqbxiFW1AwqpVlX1hT8V4t
 XivQ==
X-Gm-Message-State: ABy/qLZBUDyP9d6Fm6FUQA62kwXsCxffPskQqvrXM3wQA6xjI5kiGnKP
 eEeinsHG7zdW/Na6qriTPrMH1w==
X-Google-Smtp-Source: APBJJlFU3DryTHV0OXOdhMAjzTaiAqxiGJ4P7KJg3GS5gMMt5yei6ZVUF11fZ2kaiucO4Pmi4ocw0A==
X-Received: by 2002:a05:600c:260c:b0:3fe:15e7:c8a1 with SMTP id
 h12-20020a05600c260c00b003fe15e7c8a1mr3161939wma.16.1690926385983; 
 Tue, 01 Aug 2023 14:46:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a1c740e000000b003fe20db88e2sm12927wmc.18.2023.08.01.14.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:46:25 -0700 (PDT)
Message-ID: <4dfb02d9-b430-9e9a-f3a3-d8d2741919a7@linaro.org>
Date: Tue, 1 Aug 2023 23:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] target/m68k: Fix semihost lseek offset computation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Keith Packard <keithp@keithp.com>
References: <20230801154519.3505531-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801154519.3505531-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 17:45, Peter Maydell wrote:
> The arguments for deposit64 are (value, start, length, fieldval); this
> appears to have thought they were (value, fieldval, start,
> length). Reorder the parameters to match the actual function.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 950272506d ("target/m68k: Use semihosting/syscalls.h")
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Same fix for m68k as Keith Packard just sent for nios2
> ---
>   target/m68k/m68k-semi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued via misc-fixes.


