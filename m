Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F12CC7C020D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:55:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFzx-00046G-SJ; Tue, 10 Oct 2023 12:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFzv-000463-Oe
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:54:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFzu-0005tj-9j
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:54:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c63164a2b6so321395ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696956857; x=1697561657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTxSCmOxLVP7aaxsgCE0cYf5Cfm7sYgbWSqkpp5IK8E=;
 b=RZcTIJcDUIsIlAQy8Q2mqWuq7/jPMRfWc0Am4ZYvwmXEWkRr+7TQK9hOAX3AnzNcDv
 0ICdEgPfVvAjUivvfjGNIjWfuLoxMUdBsdBAPcmkQXgkBsPae0XZMj4hNjFB6vOFdMkO
 BsZJnnDMz3TqEO/eR+9UlreBuDNEEAwT1zHpkgoRzn4S96JGLEDthlr+GJ2k1k5BfmE+
 LOtlk8zsQbaO1ctjrJMqAELFwU7ySXQGox5zQaZU7rhRczSPak/iBCajXoIh7GxVsZw+
 KDQsOCCySsitSBQxld5+bm3pdFA2+3dpWJzvBykaAVmaGEkzpAckirWojMrFGG5AngUK
 cM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696956857; x=1697561657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTxSCmOxLVP7aaxsgCE0cYf5Cfm7sYgbWSqkpp5IK8E=;
 b=WiLMJxaXOplNAsx1WTzTSz8jhsgoYl7twUGs/HS+619z4mAuppO9bBIuVUjDH/Zheg
 1NI1fj5OpDi2mpw4vbKYxk4EDCAqr29wC18xFxOx7qQHYOM/JbKvBGAzs9XuA69rWZpn
 JSu+9CUEBX96roZi2jXsJXikyhalII9qEjV1lcaXCa5DZxHtMhrf6ylQWMVJx5w2hNK0
 QaejD1/2Ywin0LK+GKv+Ytl4yvsqnPZ/VFLVz6UMmbopCtsuXmemd+GbQIcCsAZyYcYs
 l5DPGz7VqFGk11ig4gW/1cuVyGapyqfaEqSJ+esKRvtxJU9vaRkis7zTPltg9DogCFB+
 Tgww==
X-Gm-Message-State: AOJu0YxiMpEvei52zjDMEA7GRthwR0gJ7bH5tThZM4n/N01dHxETT5AB
 fzCWN0LgWRagz9U2cIy+1q/lYg==
X-Google-Smtp-Source: AGHT+IHkV2TQSUopTVlD16H5tJ0j7H/MCmwv00runpZYz/EHyb2lwLjfMdSNn9DPahvsqGV/+3LUXw==
X-Received: by 2002:a17:902:e807:b0:1bc:5e36:9ab4 with SMTP id
 u7-20020a170902e80700b001bc5e369ab4mr23328609plg.21.1696956856793; 
 Tue, 10 Oct 2023 09:54:16 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a170902f1d300b001bb750189desm1763944plc.255.2023.10.10.09.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 09:54:16 -0700 (PDT)
Message-ID: <66a54841-9f95-46f7-a15f-0b639a956ce8@linaro.org>
Date: Tue, 10 Oct 2023 09:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/mips: Cleanup in preparation of heterogenous
 prototype
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
References: <20231009171443.12145-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231009171443.12145-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/9/23 10:14, Philippe Mathieu-Daudé wrote:
> Prepare few MIPS hardware to be integrated in a
> heterogeneous machine:
> - Restrict MIPS-specific HW declaration to target/mips/
> - Replace MIPSCPU by ArchCPU in common HW
> 
> Philippe Mathieu-Daudé (3):
>    hw/mips: Merge 'hw/mips/cpudevs.h' with 'target/mips/cpu.h'
>    hw/misc/mips_itu: Declare itc_reconfigure() in 'hw/misc/mips_itu.h'
>    hw/misc/mips_itu: Make MIPSITUState target agnostic

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

