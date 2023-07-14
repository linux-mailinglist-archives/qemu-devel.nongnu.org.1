Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B95753248
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCdD-0003lX-RI; Fri, 14 Jul 2023 02:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCdB-0003eE-KB
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:50:21 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCdA-0000jr-6e
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:50:21 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a1e6022b93so1257020b6e.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689317418; x=1691909418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6p5bCRzHerebdEZ2o7zzGXyblGD33pILQJCy0Nsxio0=;
 b=CKoLRtJzhYn5t2FNrCpf77DDKhJA71Df+LvnvW4fAnqNHefws0qduCEpBAwAbb25Jb
 BGKnU1tLXQUuac6TKV1DiPPfStUpz1Dz0fgAx9nqPK348gnq1JMIy6qGxm6ZdcaUohmp
 fq3t9RozzRdvga8bIRv0QcQrbQc9HFz9CyDSUAfcdCA+f9QVxOYN08qsINLhDesr95wE
 UhWCVugDm5SVnJY1tgt+4nKxibU3yenAGuhia4ravvKP6Pb2Xvg6kuj0wLYvr62DhFA4
 pvkwe2GTu2l9ziZ6z8FzrATjXRB6UySPkFM3ma2wkiKRAOxbI6WfIcXuoxP2F0IVsd8l
 hWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689317418; x=1691909418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6p5bCRzHerebdEZ2o7zzGXyblGD33pILQJCy0Nsxio0=;
 b=GTMtcMRAtejsVK+fx1T1VenQ3xbEQQQ+PPTAyPu+Lf889ZrS6aUGmO4mq6++rh/MPb
 zF+I2k2CpeXYB0dKEC3HKVCrbjyxTMgd2a8MV9J7P/qUdcboimZ9clfJ8ZexmY71kKbM
 UCgaScNgn4Ut3CavVXxjafqVFjkfMWKPx2BnFRZtUlBHqJqgm1JgZJkk/51Zm1mlvMHB
 DqTxMpn3XDjL3UDIuR5ul8sp9f2wJfEh/tcf5LyFV9bPVAFk7ni9U81RZOYMNaIwdk+i
 cTxefGOdO1UwhiP00g3A++OIe/WrCPSzi4BKtFaI3JwKnOUUIhJwv+5VWQ1pcd2c5u9C
 O9+g==
X-Gm-Message-State: ABy/qLbc9zMIwpY5ck7UnWzfQoZWyg3u2Xw87Q/JHGetGjt2bMfGuy49
 lzc7UJGanem7ZgBFm1dphwzj3g==
X-Google-Smtp-Source: APBJJlGLaR6aP0I7Q3Yyy3t5wE8upZzzhWHwI74W+jdYuQWOCOe4vvIfRvqDX0zUkMeHBfSUnIeSUQ==
X-Received: by 2002:a05:6808:11cf:b0:3a3:fa64:b543 with SMTP id
 p15-20020a05680811cf00b003a3fa64b543mr4199375oiv.12.1689317418054; 
 Thu, 13 Jul 2023 23:50:18 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 f28-20020a63755c000000b005501b24b1c9sm6598281pgn.62.2023.07.13.23.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:50:17 -0700 (PDT)
Message-ID: <4f50754c-ce67-f898-f356-834db14a6e03@linaro.org>
Date: Fri, 14 Jul 2023 07:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/11] hw/char/pl011: Remove duplicated PL011_INT_[RT]X
 definitions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> PL011_INT_TX duplicates INT_TX, and PL011_INT_RX INT_RX.
> Follow other register fields definitions from this file,
> keep the shorter form.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/char/pl011.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

