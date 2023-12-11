Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5410680DF5C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 00:18:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpW2-00009x-Hu; Mon, 11 Dec 2023 18:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpW0-00009Q-QL
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:16:44 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpVz-0006nj-7O
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:16:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d03bcf27e9so31566185ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702336601; x=1702941401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7uDEa0JjOrTmrII77+8YPdYdLQJufCIk9SxhvO5WfpU=;
 b=mTrLVsyND2FpZ8e0ZNtly1ik+Hqv40c4H2YKZBc0AVNnVkH1wcm3jXZ7de/R5Q4S+u
 qbJAgCNR0Zv0oPL5KUO4pmt3/EsMckcT2UQrRZaT/tfyxRYCnKvYEt19B3ElDsme+k7n
 1+OzR8O6oyxWkxKLo/mt3xVHAzlY56ptFh4pPL0jlF8l5IXTZY+L09OJdwoEK8JnzEJO
 JdPtv24YTNDKSS2A5bZHjs9TPASH1klEn1tjcN9A9HBWpHD7gqw8yBd02E9lSAIhW9PN
 z550GpaBdlrU/jOvfPG8g1fz5Sg4t+ez2kPRd0Hb/jJo++JsPRF8gNCD46lXRaB8VW0W
 Z9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336601; x=1702941401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7uDEa0JjOrTmrII77+8YPdYdLQJufCIk9SxhvO5WfpU=;
 b=wuvYP5fwCcKbRaHNau3rjaC53GSo9s105lh73WH+ZpTlQKgMon1zZocnWNDxWB1Pkt
 qfQ9ZooG6VfLZovcQRwCZqhux50gWL6izY436YZZwU/BhlEppuUr+W2XOyMlzz4REqhH
 f1JdQpyPdxtZ1SSC0KtZbVi4MD6NITLXZeix2A4zJL8ldT6FguGR01KQ64ihBq7cg+iH
 syBHaeOHQw9czU6zKsWxwp2UDugyW4GHaGEDPhZxpwZ08zGAZk2ASX78UD8Ob76RHbCw
 VoxsBsopiTz/a6GdOSEHyBAgaZ2yMhdBepb8eES59aciGuIQgSbkOSYv3piBjG7r0zjB
 NZPA==
X-Gm-Message-State: AOJu0YzCLrCRXEaG2FAldKN002Yw6svI+fEDRR3oZzW+DuQjZUC81zPx
 o99L4C681X7mN7QCTvv6xlWmkg==
X-Google-Smtp-Source: AGHT+IGjIxHtEwMA6yNKqMqo+5edHATNi2Y3lBPtG/LIR6V7yAUI9vDGZrKbeFcCQ0LM4NZnh6Kj1g==
X-Received: by 2002:a17:902:ab49:b0:1d0:6ffe:1ea5 with SMTP id
 ij9-20020a170902ab4900b001d06ffe1ea5mr2797581plb.136.1702336601620; 
 Mon, 11 Dec 2023 15:16:41 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001d1d6f6b67dsm7213405plh.147.2023.12.11.15.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 15:16:41 -0800 (PST)
Message-ID: <488571cb-7770-4183-a760-ae4bd6549531@linaro.org>
Date: Mon, 11 Dec 2023 15:16:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] exec/cpu-all: Remove unused headers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Claudio Fontana <cfontana@suse.de>, Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> Nothing is required from the "qemu/thread.h" and
> "hw/core/cpu.h" headers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 9a7b5737d3..b1e293a08f 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -22,8 +22,6 @@
>   #include "exec/cpu-common.h"
>   #include "exec/memory.h"
>   #include "exec/tswap.h"
> -#include "qemu/thread.h"
> -#include "hw/core/cpu.h"

While thread.h is fine, I'm not sure removing hw/core/cpu.h from cpu-all.h is a good idea, 
and would explain the rather surprising changes to add core/cpu.h to other files.


r~

