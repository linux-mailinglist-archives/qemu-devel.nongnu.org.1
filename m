Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5953E7FFE81
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 23:33:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8pZn-0007R7-CL; Thu, 30 Nov 2023 17:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8pZl-0007Qq-6x
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 17:32:05 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8pZf-0002EC-FS
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 17:32:04 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1fa486a0e10so791651fac.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701383518; x=1701988318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SwsiSyMNkvjfd5s3StNC5NWwuLlmlfXm+lcpVaAqzaw=;
 b=dqFJIdWZPd//pSq5k5VgbPZ9/ejcAvuumkKLTZVD3lbFv1383qyhGMT5dHfowrmf/E
 J3+wD8UK6gxGZDr4SGu1nNgd7cwcrVMn7dFh826y9W+NYrrYXM34NGbLEYLi8qt5cWx2
 NxEEFyJ/2sWNYngr9ryDDru9QjXtHuMMCpxifZrYxkDnAjKvJjEEaiEF/N6ndV0/rTz2
 n3B22dBQvO1E3StxtlPL/sdpYT9p+PHRgGiM4EzD7jH+9SwlG/SBBbFq3lBkZ6ovpC5L
 diDnVS/pJ0mgLkdYSa9P3u73lEHMWLMEu22mhXFdBu0vdJb/UrmFlcBiY63ZYTQgFlBr
 71xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701383518; x=1701988318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SwsiSyMNkvjfd5s3StNC5NWwuLlmlfXm+lcpVaAqzaw=;
 b=WZ47sCyNbOdqsos8DxrvptJHtlQvQJ6HCeSR86Lw34yJdDjPiRg5CjUIhMucVZ0Vk6
 faJnjPFDyCpCVaTNFOfEcQDQBx/zax/ueC/EtuYET7OtM5N8rzqmvUugVvDNV46jWx6N
 erju8CxkHAa/EVPBP9+T189cvpQ3d+6e9WQC0xdBtthV2Ryq5uHE6f95brMitUNHckha
 8A+0kuL4irWV4DZ2iJuuwPkg7dYjgmUtnN8Ol0+z/RQvXZOZO8Mp6GknvMj4+F+JbYmF
 X7zXMPp8G3f0Wzw8Cw4IHjr1vFoZu96zCgMxR/KA4B7SYwOkIEkWqHcPsDlY+GyW3r19
 7XVw==
X-Gm-Message-State: AOJu0Yw834OP2aSSrFZMHIo4tDlpPtCwar/eDhDUGO+AMBTQ+yWF0BbC
 MA009qk3iaClM2B4NmfyUyqKxg==
X-Google-Smtp-Source: AGHT+IH3SFDsQV2+eNN8LLhJlM8cdzCqsAddHsixuGLImZCIOIYka/Vxjyp1AxCCZyTyQgJZZpeUNA==
X-Received: by 2002:a05:6870:64a6:b0:1fa:ea94:5da2 with SMTP id
 cz38-20020a05687064a600b001faea945da2mr51585oab.14.1701383517981; 
 Thu, 30 Nov 2023 14:31:57 -0800 (PST)
Received: from [172.20.102.4] (rrcs-71-42-197-3.sw.biz.rr.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 bg14-20020a056830360e00b006d869f25b96sm34882otb.19.2023.11.30.14.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 14:31:57 -0800 (PST)
Message-ID: <a44716ad-aa83-403e-bdf1-a75f6c76f420@linaro.org>
Date: Thu, 30 Nov 2023 16:31:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] accel/tcg: Remove unused tb_invalidate_phys_addr()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231130203241.31099-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231130203241.31099-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 11/30/23 14:32, Philippe Mathieu-Daudé wrote:
> Commit e3f7c801f1 introduced the TCGCPUOps::debug_check_breakpoint()
> handler, and commit 10c37828b2 "moved breakpoint recognition outside
> of translation", so "we no longer need to flush any TBs when changing
> BPs".
> 
> The last target using tb_invalidate_phys_addr() was converted to the
> debug_check_breakpoint(), so this function is now unused. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
> ---
>   include/exec/exec-all.h |  5 -----
>   cpu-target.c            | 29 -----------------------------
>   2 files changed, 34 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

