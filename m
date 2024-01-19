Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC3832CD0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:07:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrNp-0005rj-9E; Fri, 19 Jan 2024 11:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQrNA-0005q2-UV
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:05:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQrN5-000669-Nf
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:05:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33921b95dddso376264f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705680330; x=1706285130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UGKRlPDTJbo1XNpPBAC0xiYxEATkfo5/Bz4KCjNqJWc=;
 b=NUoRy6lb+ssPHbnQ/QSCELqUBCsfXUAXmbLOcnbbotaRS0FicJfwh/nHr+k4K49qhV
 De7s4DUQCZzO8nnRC7D3fsLCCeDm6hBCVNApefM7MDqsVplw5QhRsHqGHDGWi4zbVEDA
 hiLK0/NdiNh8eBiFuSO33syyz7bNvC4ZGhIUV95Gj8T5Y4aXrdMGmSR37RMoNw0Flw6H
 6B2SOy48N2FQIoB93tRSpEE0jfV6aESq1brmRuhMN+xT/W3H8cUS5LqyUSOswb9w0aY8
 QKujBowvj64GuIIpls+MclAAYHv8pkzWMjjfMQ9OO6e2xEId3InccTqGQds7/7wFoL9C
 CuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680330; x=1706285130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGKRlPDTJbo1XNpPBAC0xiYxEATkfo5/Bz4KCjNqJWc=;
 b=AmaRJ9WPaFqgNACifagOO+h67o3rw39NOo4JT55CuElHaIhGOdNyPDcIpjidamBhMD
 Q6rbNMXWfSk/ps6nowcRgAXOw319BK/5/krhWQZiTw6fXchnVa4B1N8FYNvhGjhh4NVD
 bV4dRoblMqq2bKb4iuKv72FSna/sv3rHgWRcq8Cfq0fvLBQQ0BDbXaye+aHPQ71HnaoG
 fAKdrQgEB5OE09AWCUR3uwX0LiYCvx9u5/X/+l2gTdSvD3TsF9HSWH217pAZcv/Ulp9C
 UiJ03oXk4tt/8+jeMqzECRL/Ox+xjLR3q/Vz8ngieamVM4k7PhPfTpfzF+YmZ3ERfm0l
 VGvA==
X-Gm-Message-State: AOJu0YxfJcKAqFOVXnJZYaurVYfxrIIbEOCmvA8KjvY+ah7xluyW23SX
 /vKcPgEsGBWiuJIAjy9Tq49gJphl8ptPJ03mJlHhQqOxfFrYp0dyonRP3L2BGuM=
X-Google-Smtp-Source: AGHT+IF5IVUQPAtwcSpgl6Hm13DKoG50cLN5kzhff8T1D6C1CbQvl/321p5rm0gB8fMjIXYwYyYM6g==
X-Received: by 2002:a05:600c:150b:b0:40e:78e0:adf with SMTP id
 b11-20020a05600c150b00b0040e78e00adfmr52370wmg.182.1705680329785; 
 Fri, 19 Jan 2024 08:05:29 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040e4733aecbsm29425111wmq.15.2024.01.19.08.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 08:05:29 -0800 (PST)
Message-ID: <30632dae-21cf-4134-bf82-cc075a7a4950@linaro.org>
Date: Fri, 19 Jan 2024 17:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/34] target: [PAGE_VARY] Use PAGE_VARY for all
 softmmu targets
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-2-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240119144024.14289-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 19/1/24 15:39, Anton Johansson wrote:
> Allows for future commits to use TargetPageBits to access page bits and
> mask, thus making TARGET_PAGE_* independent of softmmu target.
> 
> In the future, this will also be important fo allowing heterogeneous CPUs
> on the same board.

Yeah I carry an almost similar patch :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/alpha/cpu-param.h      |  6 ++++++
>   target/avr/cpu-param.h        |  6 ++++++
>   target/cris/cpu-param.h       |  7 +++++++
>   target/hppa/cpu-param.h       |  6 ++++++
>   target/i386/cpu-param.h       |  6 ++++++
>   target/loongarch/cpu-param.h  |  5 +++++
>   target/m68k/cpu-param.h       |  6 ++++++
>   target/microblaze/cpu-param.h |  6 ++++--
>   target/nios2/cpu-param.h      |  5 ++++-
>   target/openrisc/cpu-param.h   |  8 +++++++-
>   target/ppc/cpu-param.h        |  6 ++++++
>   target/riscv/cpu-param.h      |  7 +++++++
>   target/rx/cpu-param.h         |  8 +++++++-
>   target/s390x/cpu-param.h      |  8 +++++++-
>   target/sh4/cpu-param.h        |  4 +++-
>   target/sparc/cpu-param.h      | 17 +++++++++++++++--
>   target/tricore/cpu-param.h    |  8 +++++++-
>   target/xtensa/cpu-param.h     |  8 +++++---
>   18 files changed, 114 insertions(+), 13 deletions(-)

