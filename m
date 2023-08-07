Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0550772E60
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 20:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT5QZ-0001kQ-Ps; Mon, 07 Aug 2023 14:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT5QX-0001jj-Lm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:58:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT5QV-00046e-VZ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:58:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so42997795ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691434678; x=1692039478;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbqYJz7aAuK4vi+LmP15zAZX14eUPinYOJ9R5vB+cxY=;
 b=El2wlRFgm/MF3XP6q6EDZdiZmxP+lQ+BPulYVDVDnyB6MdknZGQ/uekKbtbUJzPgYJ
 SrU0TVVGMsfN8UvgjnQTvB1ISNAzbF12RmpFukkbzXmIbQRCMNfq2z8ZBCFTzw+b52g3
 HcZxEsLtXWBL9uGNVtslFY9BSdI3WzCttIBU8dSpF2f+o+ZWQz7QkM3NXaDiTFVslxH5
 MUHJpudPLT6/JsOVG04eGCrT6Owej+WMxDNM/694H7p+6U+ucb1mh7ES34q3lwG2Dlxt
 3SjkKboJbRV9lv+K1kHZIY2s7CPJcMn2l6IVerd9dvu849CVyJUFnUSa2h+pCu2q3G74
 0nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691434678; x=1692039478;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sbqYJz7aAuK4vi+LmP15zAZX14eUPinYOJ9R5vB+cxY=;
 b=TYKgoUmPZOSwB5tCIXNrns2c+TmG2Akt3wbWr+hO9FCIPbtXizg+//D/lUwH/NVoG/
 gI0DkNGozAuwm8ztHKE5MdT8/tOKrE1owLTtDWUPgNhMRpwKW/bMRbaB0tejYFk2+shp
 SzbL14M1/+5ba3q9NOtr6VOyjQnvQuXSujee9cikx58MOa6iavGsluU7IaTpdO/9+Guu
 EsOyWF8UcXJ6e1P3amJvt2dAECUnkimKR2KhdA3bakJMxuU/i+0KHJjTVozGwVHE1qnA
 mz+PQccNlNa+usJYIJRD/+JJQWAFQdSTdowy7vOtyHsxRKAtktJO3YYeg0T4fqiA2yCh
 r6Hw==
X-Gm-Message-State: AOJu0YzOLPte53yfjXyb1pqVHgZVLMU6Z3YQDhhqSbX5opukTSawifzl
 TVGXs0Vz4UvQRpbZpVE9NmFagg==
X-Google-Smtp-Source: AGHT+IH6E73dfNd1FfmWkYYBXOXW1bv9FaFWIdV5O4DOD8aZlO8flEcsrOUmRQ66/C4/hPKm3vISkA==
X-Received: by 2002:a17:902:8f98:b0:1bb:a125:f828 with SMTP id
 z24-20020a1709028f9800b001bba125f828mr9398891plo.68.1691434678041; 
 Mon, 07 Aug 2023 11:57:58 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170903228100b001bba669a7eesm7208736plh.52.2023.08.07.11.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 11:57:57 -0700 (PDT)
Message-ID: <ce229125-2e60-a9f4-76db-2a682f3e8009@linaro.org>
Date: Mon, 7 Aug 2023 11:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg/i386: Check for shorter instruction sequence for
 ARITH_AND
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230807142807.60719-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807142807.60719-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 07:28, Helge Deller wrote:
> The tcg uses tgen_arithi(ARITH_AND) during fast CPU TLB lookups,
> which e.g. translates to:
> 
> 0x7ff5b011556a:  48 81 e6 00 f0 ff ff     andq     $0xfffffffffffff000, %rsi
> 
> In case the upper 48 bits are all set, the shorter sequence to operate
> on the lower 16 bits of the target reg (si) can be used, which will then
> be a 2 bytes shorter instruction sequence:
> 
> 0x7f4488097b31:  66 81 e6 00 f0           andw     $0xf000, %si
> 
> Signed-off-by: Helge Deller <deller@gmx.de>


Current Intel optimization guidelines

https://www.intel.com/content/www/us/en/content-details/671488/intel-64-and-ia-32-architectures-optimization-reference-manual.html

Section 3.4.2.3, Length Changing Prefixes, suggests that using 16-byte operands slows 
decode from 1 cycle to 6 cycles.

Section 3.5.2.3, Partial Register Stalls, says that Skylake has fixed the major issues 
that older microarchitectures had with such stalls, but that these operations have two 
additional cycles of delay.

So on balance I don't think this is a good tradeoff.


r~

