Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D67C86E0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:32:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIGj-0003gT-3B; Fri, 13 Oct 2023 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIGV-0003bL-Qh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:31:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIGT-0002XC-Gz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:31:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so15775255ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697203900; x=1697808700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdrK00LaRo6TB+cIWtK1lfYu1H+xMSxvrwkARDU7aS8=;
 b=OmXME4j0jUEidDGrzO4oeeWRSa6zW5UxIGfnlmZOn0i3VmRPyGSPC8rRXhsZUFxNCv
 sFW9aVN70Up71/oOgWwXB+j8zMxHjTXsV3TAP8eBYUo4h4VS+y1PVqQjl8LA3i9s7oJe
 iUG8AB66FiTYX1WVMBqUN18paSQ8bqJoFwNeGjeDVb/kupVZBfsrUHMjhTEdnyrUhzjH
 0CDnjvE1RKSKdvmWnV/f18FumxsIWC4pYuum52xykxsT9AvCWQ227lk4KlhPeyqnugg4
 3AVeX49LxgYr4Fx1tq8FniIZrSxNEg516R3odVqfqEoNfLPHWB3EYsg+iWGt7GZkVb+t
 FClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203900; x=1697808700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KdrK00LaRo6TB+cIWtK1lfYu1H+xMSxvrwkARDU7aS8=;
 b=Rk/Fs5ulQ4fsNgc2gZW+hF06nYdTODhnU/ZlDRIRTT5TVZ1b17jHGC8DmnN+rg2zDW
 jROIg7IsmmQaC/rfPyTCgGZ2ChRbk0K5ff/K0tAq0NxIy88+cGD/xyu5DVoUwb1bKuUC
 /vLf/UjMK/zALZDwU8byMdfkTiyKAoo/RPBtJXwZqVsNiYo3pPPxU8vFskI8/TcgxHkK
 /BueDU2JBwoQiZ+gIOFnDkBi8295j1GAaa64RQ6bHisn40HwJC2p2JLdMMJmJLLHsrSU
 73WYNssyObbBnzl63XQWr//zexaB4cHe3/TKp+OdUSQt7z75NJ3Aj11PQARrf5khsKBS
 HyTw==
X-Gm-Message-State: AOJu0Yxp7PNNfBQzaFvwdJhGihsk43qpKvK9GHLhyt1YEbvrj2HMHksi
 RG70/3MMy+xAcbiyts66/mawE11xpeuEf0JjOCE=
X-Google-Smtp-Source: AGHT+IF6R0fR4lt3ZcwTUsSGex/fm+XRBGAvdNY+dlcHx1a93Q3GgiO06kmj+YPefyQCpxG+zVUBxw==
X-Received: by 2002:a17:902:db02:b0:1c4:1cd3:8068 with SMTP id
 m2-20020a170902db0200b001c41cd38068mr234928plx.5.1697203899927; 
 Fri, 13 Oct 2023 06:31:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a170903264600b001bbb8d5166bsm3875120plb.123.2023.10.13.06.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:31:39 -0700 (PDT)
Message-ID: <3ceb42c2-eadc-4bda-b457-e83dd30170c1@linaro.org>
Date: Fri, 13 Oct 2023 06:31:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/ppc: Move ppc_cpu_class_by_name() declaration
 to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/13/23 05:56, Philippe Mathieu-Daudé wrote:
> ppc_cpu_class_by_name() is only called in target/ppc/,
> no need to expose outside (in particular to hw/).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h | 2 --
>   target/ppc/cpu.h     | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

