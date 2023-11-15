Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56D7EBACF
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:07:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34N7-0001sq-RT; Tue, 14 Nov 2023 20:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34N5-0001ql-QI
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:07:11 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34N4-0006oK-60
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:07:11 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so6280684b3a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010425; x=1700615225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=okFvJHiAdcLla/TKinrA7d7VqaVy5nrIyjB5j36uDc4=;
 b=Vy45Lu+TSGpqyswoi8V9Cv9DiiloSAS1gxMQZUqQBvru0ckhmLORbXzhlgYz+2Egmr
 VwLA2eM5AjsAaAJDyWYvDRyZ5e7CDuCg8oiyiNvtu1wSQeEBuX/9ce2SRoON+V1btUpj
 hMpWp2sHrd273FxGRh2/qmT7cfRGI4If7N56YYY018Wqacgp9jA4oORNR06u0ZNfBgLt
 49P2x7KP+mMNPUKurMC2K0Gq/9jrhi9OT/AWGalmOVdtBPT7XvG3DW48kE2N4f9ZlLQ/
 F3mfCEkRsJoTXIqe7spnuV3mCAovkLalr7fMr4oX+wl4GtMb2NA4hTjepXW9pd4FzqHQ
 oG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010425; x=1700615225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=okFvJHiAdcLla/TKinrA7d7VqaVy5nrIyjB5j36uDc4=;
 b=lifjZMZ/cTDEwu7o3F9wdIXIuXMEgHaHV3EmKyfsupJVjlbnwohpRPGzCuUK71Bzi5
 pjpddklVpaUhmG/KHeaa/nTDa+NrmEQH7ZeJcSIGvEhqy4iWTI6TfXZO675pvqXI1MsP
 vM+4ong0uv9kaAJXWT1WtGPeY/m4coZ8zzkW1qfVp6a44hpU9Xka2ALQDPxL3sWDm7lu
 0J9HIzEMiwoowmRMu2wuTenL7EepbK0Ux/XLPT9WS6VROSbv4T6KEfiIW+GNilViyfwn
 Od5sdUMcUH9C5mv6FTXY2TE+ad8e8AD9NRy5sc6RPHMsmeMgjDiSPin/n/4GYzpHRXuy
 U/AQ==
X-Gm-Message-State: AOJu0Ywe9TrciyGtQpIU6wAiBGdD0EH7JDlQPRZ3R/V3ni6GUt6NzELJ
 Ckz8XWyUwU4hRK1Q8PPfcqnekQ==
X-Google-Smtp-Source: AGHT+IF23uLdasfPLdk1JTebbV1wXI2ukXi3/iUrg4/xmJiaS2qHRG77jL2ltV0mJML7aYtHPc6YrA==
X-Received: by 2002:a05:6a20:4424:b0:169:7d6f:9f22 with SMTP id
 ce36-20020a056a20442400b001697d6f9f22mr13676274pzb.54.1700010425551; 
 Tue, 14 Nov 2023 17:07:05 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a001a00b0028105e3c7d8sm8707354pja.0.2023.11.14.17.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:07:05 -0800 (PST)
Message-ID: <81e7412b-aaf2-4277-8d44-d28dbb04e3ac@linaro.org>
Date: Tue, 14 Nov 2023 17:07:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/31] target/rx: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-19-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-19-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-rx -cpu ?
> Available CPUs:
>    rx62n-rx-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-rx -cpu ?
> Available CPUs:
>    rx62n
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/rx/cpu.c | 16 ----------------
>   target/rx/cpu.h |  3 ---
>   2 files changed, 19 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

