Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050687A1E0A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7Z5-0003ai-Tk; Fri, 15 Sep 2023 08:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qh7Yx-0003a1-J1
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:04:43 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qh7Yv-0007Ev-I6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:04:42 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcd7a207f7so32747221fa.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694779480; x=1695384280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=P6eM/yXaj8PkWr4TkEd5T8HyKUWTDYyMeFOOkASi5e4=;
 b=UYVdstXXQVbAPlzr7f6z/y2lBeTZHUorXOtoqD9vFbRgkzArJn+UvOJ97WwFaJp8lU
 TCxE+spUTQoO9uOj7tYfiEvot2lwXc0GeZCcvFEi9lEEEMEhpKXFf9O3cF8c8wxSSyTw
 U7GcQJ8HXgX2loH0jtFQF6iDSFURY6eZnL9NwYJeku4AAHCynBaCHFuVXu0lWArQnvbk
 uCfbZeZh9Qr5fAiYGv2Gyf7gLjULDjYSRqqIGf8z5203Y3yCaqxbrtcwnwnP80IHJXVF
 m3N0dbzeuKv82zI+8xfzq3m86urRcUT8HTCu6Gh2UalNxfCMb8dstSUBE/JAaRvV2GM8
 kZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694779480; x=1695384280;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P6eM/yXaj8PkWr4TkEd5T8HyKUWTDYyMeFOOkASi5e4=;
 b=W7JABt3YU468P+1xneiFutMr13ed4TauLNKdePhu6IsZ4CWKIzGhB+pd+nO7XGl6Ci
 JfA9F4rEetN+/CehPUs+f6GZtOwNM1ofMnDXK+P5z3yiplimNpXwOgWTYSlSvNyY5+D0
 /6L2pxfapVsl7NSZLl9MVzmrNhChNR+hmN+TCe16DrSkjxU0ZNkox7Qz0eB6CpK+JJcO
 qZ6fXkjG2PNhWbIgiZlPvrNrR9Xu8hI14BKKbgxjE74I3sjohKFAI/VT0jdLMxzNNQuv
 4wkUAPGscQvc/t9HmTjhjvF7tT0FDyLHCyOsX9xjGUkUh8JbxAh59aJGzU7lK3yKuV6r
 RNlQ==
X-Gm-Message-State: AOJu0YzXHcopPO522c59uD85rb5vCT/ZwmGVf3stqBwQb+QsTnCgpwfB
 /wcnD6xbI6cmS8ibpc8Wxsfe4A==
X-Google-Smtp-Source: AGHT+IHVZVPa9Y87BoU8Xv4kj9Ep7b0KDtHjnc2vqmZYi89DJxA5OTCKQHyVR7Y1sQkufrHJhBbHyw==
X-Received: by 2002:a2e:924f:0:b0:2bb:b1da:27be with SMTP id
 v15-20020a2e924f000000b002bbb1da27bemr1376020ljg.45.1694779479724; 
 Fri, 15 Sep 2023 05:04:39 -0700 (PDT)
Received: from [192.168.200.206] (83.21.94.247.ipv4.supernova.orange.pl.
 [83.21.94.247]) by smtp.gmail.com with ESMTPSA id
 z2-20020a05651c022200b002bceae8b9fasm686129ljn.109.2023.09.15.05.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 05:04:39 -0700 (PDT)
Message-ID: <27a83a16-20ff-47e5-b71b-82e6b9ea832e@linaro.org>
Date: Fri, 15 Sep 2023 14:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
Content-Language: pl-PL, en-GB, en-HK
To: Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230915115535.129834-1-quic_llindhol@quicinc.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230915115535.129834-1-quic_llindhol@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 15.09.2023 o 13:55, Leif Lindholm pisze:
> This set reworks the handling of private peripheral interrupts in virt
> to use INTIDs instead of PPI IDs, to make it easier to cross reference
> against Arm's Base System Architecture specification.
> 
> It then breaks those definitions out into a separate header and switches
> sbsa-ref to use the same header instead of defining its own values
> locally.
> 
> Changes since RFC:
> - Compilation tested
> - Reordered patches 1-2 as suggested by Philippe.
> 
> Leif Lindholm (3):
>    {include/}hw/arm: refactor virt PPI logic
>    include/hw/arm: move BSA definitions to bsa.h
>    hw/arm/sbsa-ref: use bsa.h for PPI definitions
> 
>   hw/arm/sbsa-ref.c        | 23 +++++++++++------------
>   hw/arm/virt-acpi-build.c |  4 ++--
>   hw/arm/virt.c            |  9 +++++----
>   include/hw/arm/bsa.h     | 35 +++++++++++++++++++++++++++++++++++
>   include/hw/arm/virt.h    | 12 +-----------
>   5 files changed, 54 insertions(+), 29 deletions(-)
>   create mode 100644 include/hw/arm/bsa.h
> 

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

