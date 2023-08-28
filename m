Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578B78B75E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahAy-0005NM-M3; Mon, 28 Aug 2023 14:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahAY-0005Hd-7P
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:41:00 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahAU-00087I-8O
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:40:57 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so1618572a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248052; x=1693852852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++uvodA5NKDQhXzfndJt/8NAJXwtfk3ugys3ZqfQVdo=;
 b=IW0Gkk+DwcTP5RupLgv+GCReaWgyOac+6M5Wqy2dhZqiIo/GMS7KPOmOTZhTmeLgzR
 IqlbOoft84ft3y20gBlEuC555VgOww2a9O6re7VJu/S/I22YDkBB1oIwRCaWmv1M5DXb
 +YdnRuEQz5R6HCBSB5fYYWLdg+AEq41+EGfu7YcyvLKY+M8YWRmWJEvri3YQDbukP4GB
 eZU9Ffl2hOnIIu53CJpjxK7aOlaAGLe/hhWwlz8L9XrxUaMgY54hCfYjqDb66xw2BJJz
 9pylJGMZ9GGI2/vugl22mEaF99EJjhEqCg4RDSWMMg7Y4Lg/KPcjQrFHdF0sUyM3UOb4
 XZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248052; x=1693852852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=++uvodA5NKDQhXzfndJt/8NAJXwtfk3ugys3ZqfQVdo=;
 b=eg15QuUdJ7VCGSBeHZ6e3F6X3PiAJ4ivAhNWZXZlvA+XaiYqhwDQUGp7KgX5S7YR0F
 sp+h3BZY1lfpeHydu76X3Z4S1aseKSae0fBLCp00r31SbMENkYPcWm6y+8yzFMeUqoT/
 6toNOanHSeJJpYj+puxJyHe6yDPiWRJnr8KBY75T0Y1xFN64aKKZl9l2GRW92QzaTyjG
 d2mr6tdEC7tE8lHorMfziui4CRTQ+HpNLXxVz9niyVRiKXnhYA75U31DKWZV/3Up62wG
 arquwFR1eFk5Y7iuls6ekgkPTpFzs/jVzcIflIW1X+4VSSSzrEbJlwNILPOtyi5geCfG
 Sw9g==
X-Gm-Message-State: AOJu0YxoGPB33fxude1g0/fKX5lZSKdeO7UAMe1HCQ2N+JETTMmINi3f
 idnLCfxZLElFxVYwyMRKFlgtAQ==
X-Google-Smtp-Source: AGHT+IHg4pvZ6/0EzyquiNmMtfIvOPdCdcxMnpcUdQwc1muUz/uVhD100T3jzZ57MIJ+q0hNkOq1Gw==
X-Received: by 2002:a05:6a20:4308:b0:140:6fa9:7001 with SMTP id
 h8-20020a056a20430800b001406fa97001mr25644913pzk.40.1693248052557; 
 Mon, 28 Aug 2023 11:40:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 cl7-20020a056a0032c700b006887be16675sm1172898pfb.205.2023.08.28.11.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:40:52 -0700 (PDT)
Message-ID: <37e187bd-a21e-f9a2-ec51-a114cb5083aa@linaro.org>
Date: Mon, 28 Aug 2023 11:40:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] target/helper: Remove unnecessary 'qemu/main-loop.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20230828145545.81165-1-philmd@linaro.org>
 <20230828145545.81165-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828145545.81165-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 07:55, Philippe Mathieu-Daudé wrote:
> "qemu/main-loop.h" declares functions related to QEMU's
> main loop mutex, which these files don't access. Remove
> the unused "qemu/main-loop.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/pmu.h                   | 2 --
>   target/xtensa/mmu_helper.c           | 2 --
>   target/xtensa/op_helper.c            | 2 --

At least these 3 files do two things.


r~

