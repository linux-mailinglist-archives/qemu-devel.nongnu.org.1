Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB6A736945
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYbd-000516-J1; Tue, 20 Jun 2023 06:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYbb-00050B-6L
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:28:59 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYbZ-0001aB-Mb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:28:58 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-518ff822360so5563970a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256936; x=1689848936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lR+qys5PaIboY2qD0y/NWcvOp7lMLa9U2F0bNKWCIIw=;
 b=uu5+sDmsv0tRmCpy5zpKcBQsY58u3befcUengZCH+J/PHwBkPZ70ry8MEGsTrB5LOO
 bMNktjBc9oZ8+fFHgrQaaFvkmA77KAPspgiO76lc1uS1qbMajGDVccdaI4wHgIFIqsQF
 R8SGJbl8p4OOBYRigDIhtc0t4zOIcNin5Gb0vyOG4Z3MIbP83W49qDYZrjH2F6mP1wJl
 vWdtS/fl/nxdyiGLcVUYrNppPlQhT4PYOa7HHAHh/lIz/bAyB9tVPGt6GYZ0FyXb4dAx
 1fo+KRdraHyRBlMoMYPYKIWaqLkyffwqEnN505Yn1vus2C1VO13uyE0eoH32YEl6mqp9
 BZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256936; x=1689848936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lR+qys5PaIboY2qD0y/NWcvOp7lMLa9U2F0bNKWCIIw=;
 b=c6hSgBhMe7ZfwbTSUxys6GF81BZxA4b6Ag4/NMKiMTiS1EWwf312QemC8a/xEbHlLR
 SCj0euRKCZPeNlxJ0uKDchrhoQJdTa4jt07zZqR680UcQtvi/87pKzGzpaDXKvhwaACg
 wvNx00l/xE6uPcN1FaPIVnLLew5vJD54IWBCcHT6O4xTd7wXaAh9VA6rEwhq/SOaSkhK
 91LWv/fVXItosgCoXbhMNvuRumSJ68jD9FJeENf28Yc179bWbIpB42XQndzTrw+Oc8oY
 sRt2tAs8jrkPXnxgDfsnRxoDniTw/VgUhc0V9haSd4HYzzEEVQnAzM66jY6wcTSuvbrr
 f5bQ==
X-Gm-Message-State: AC+VfDzSJLvsBzcitO2EM417ZIXd9EcrhyBLq/8P+7oFyPrBIZ559+hl
 VCd6ToN+Sj76i+mkSvqBJ9SwFw==
X-Google-Smtp-Source: ACHHUZ72OMGPGjLbiQDy4Qvygs6Qb6gwT8e4J/LBBkk3o/6zaotfVAV+2SYi8c+D+ZKAUlIbhceOaw==
X-Received: by 2002:a05:6402:6d8:b0:514:9e2c:90c6 with SMTP id
 n24-20020a05640206d800b005149e2c90c6mr7983341edy.38.1687256936227; 
 Tue, 20 Jun 2023 03:28:56 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 ca22-20020aa7cd76000000b0051bc7483bc7sm948790edb.78.2023.06.20.03.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:28:55 -0700 (PDT)
Message-ID: <28f5dd83-0cc9-82d0-6985-3f200c9cca04@linaro.org>
Date: Tue, 20 Jun 2023 12:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 18/34] target/arm/tcg: Reduce 'helper-gvec.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> Instead of including helper-gvec.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/helper.h             | 1 -
>   target/arm/tcg/translate-a64.c  | 4 ++++
>   target/arm/tcg/translate-gvec.c | 6 ++++++
>   target/arm/tcg/translate-neon.c | 4 ++++
>   target/arm/tcg/translate-sve.c  | 3 +++
>   target/arm/tcg/vec_helper.c     | 4 ++++
>   6 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

