Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6957FF033
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:33:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8h8Y-0005O9-R5; Thu, 30 Nov 2023 08:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8h8W-0005Ns-J7
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:31:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8h8V-0005pc-25
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:31:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b4a8db314so7876235e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701351080; x=1701955880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C/yCzubWKQxS7Fy3Kco2IAWc/FIsP2Et/rAFvlXXtYk=;
 b=HcrYSSrlkvGk7lhMsHHdzQB4JQhRZuZ0jQsCl+2Oxzb9YnIcKdqf0yU66bydYT0/+v
 gSqM7gwJ48P208mkUg4EDNdUUqz5gf7UZ+/ZU8LXab63nMkMb8rAdsryoC5pdITSDj6T
 sVZ1oKQkEgEp9D/NX0MmXT630mNLVqiMV9XfngYXLi1pPf+1q0LNysOe5nC3I6Lh5/y9
 3WQ61HOG4UExTv+NDrNmDwjZ0zCNKd3yzLPHfxj/OwqT4f3kJbzSO9deG0dBWu14nFuK
 EXMvWz0AQz1p5UJH0zRUEDVLs3FZQ9u8BFBl/BWJL9VwTJqNP2UkUF0IypccAqY5Gja3
 ISaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701351080; x=1701955880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C/yCzubWKQxS7Fy3Kco2IAWc/FIsP2Et/rAFvlXXtYk=;
 b=BtyDAlWfj1aG6RI7uuvnQcuOtT0CuOF9WF125tEzk4t7+KpplPQ1skH+gJyzMlIZVO
 mxYFlOz+Tl1q3+zmO3A8wgh+W8T7tpAi/2pQaYtXoDygQF5jGJz23P3e2YDS/xvDyx7t
 3HzaJDkFjUUYe4TVf2D6WkTNdWxbmugWRZ6QSyA7AejZKBxoQ7+u6PNtYIb3lG4d4QrU
 Khy0uo1gz8MywRZ3EkndQzaEDKuWCr+FJoKQL1eHCrjJ50IlA/OQV0GaJebdYVoYBD3+
 wYhAjjP/XhmE+bea3D7eVWn/aJH8P/9vessHSIvlBEPNMzkxZTLMm9OOvKptb7oPmRdK
 JH+A==
X-Gm-Message-State: AOJu0Yx7D3Frsj53D3d33vmsoil2i7lbFK8aAjdEK0REulebjj8uQEpD
 Xj8dDyqYrEL3OQmFU0T9WBLFdw==
X-Google-Smtp-Source: AGHT+IH3mYM6u5yqPaWTXEEelKCiAMTv7BDhaqBAydzuRBu/xAoku9xgJaGToArNkflYVngVSZwmKg==
X-Received: by 2002:adf:f4ce:0:b0:333:16b8:4190 with SMTP id
 h14-20020adff4ce000000b0033316b84190mr4405514wrp.11.1701351080628; 
 Thu, 30 Nov 2023 05:31:20 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 g11-20020adff40b000000b00333174445fesm1577772wro.5.2023.11.30.05.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 05:31:20 -0800 (PST)
Message-ID: <73ca9d6c-62d4-412a-b847-f2c421887e96@linaro.org>
Date: Thu, 30 Nov 2023 14:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Do not set CPUState::can_do_io in non-TCG accels
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, kvm@vger.kernel.org
References: <20231129205037.16849-1-philmd@linaro.org>
 <3d8bbcc9-89fb-5631-b109-24a9d08da1f5@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3d8bbcc9-89fb-5631-b109-24a9d08da1f5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Claudio,

On 30/11/23 13:48, Claudio Fontana wrote:
> Hi Philippe,
> 
> took a quick look with
> 
> grep -R can_do_io
> 
> and this seems to be in include/hw/core/cpu.h as well as cpu-common.c,
> 
> maybe there is more meat to address to fully solve this?
> 
> Before we had stuff for reset in cpu-common.c under a
> if (tcg_enabled()) {
> }
> 
> but now we have cpu_exec_reset_hold(),
> should the implementation for tcg of cpu_exec_reset_hold() do that (and potentially other tcg-specific non-arch-specific cpu variables we might need)?

Later we eventually get there:

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9b038b1af5..e2c5cf97dc 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -89,6 +89,9 @@ static void tcg_cpu_reset_hold(CPUState *cpu)

      cpu->accel->icount_extra = 0;
      cpu->accel->mem_io_pc = 0;
+
+    qatomic_set(&cpu->neg.icount_decr.u32, 0);
+    cpu->neg.can_do_io = true;
  }

My branch is huge, I'm trying to split it, maybe I shouldn't have
sent this single non-TCG patch out of it. I'll Cc you.

> If can_do_io is TCG-specific, maybe the whole field existence / visibility can be conditioned on TCG actually being at least compiled-in?
> This might help find problems of the field being used in the wrong context, by virtue of getting an error when compiling with --disable-tcg for example.
> 
> Ciao,
> 
> Claudio


