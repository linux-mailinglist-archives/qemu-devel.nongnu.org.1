Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3682190D
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 10:46:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbL8-0005zN-GI; Tue, 02 Jan 2024 04:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbL5-0005yd-61
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:45:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbL3-0002HF-HU
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:45:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d560818b8so66609845e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704188731; x=1704793531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D5sHdH8s4qL8YDy1fschkSwNx0GWjqxbCOfWlBrG6H8=;
 b=sV9Gw1AjwxDL6nNfr5rlAff0LyH4TP3qgtbneX5G7AE/2es6ClfXjavpUd08q1wz30
 gaOLOgLFTr1J7AbOq8HfRWEyHe+NtW1Wf2rKeae7SgVAMtN+IHpH9/6HfPyXKNzbWHYe
 PEN3UN7jQ8lZTJBCguFTRBP/TOfC3/jZcKjcqkg1WdhkdE0tS2voOT54JAlP3LF3s/Kd
 svJzo4/yibqCFfQboucIESkLJV1VQ2AaOBOjzYqges9gXRZc5KEQJ/f/2cwR9Uq4te4q
 NnP4dD6CLnLKM0DqcTTUP2v29GYDbRUIBJRW3PHgA204KV/kZRU0/Si56LOSn+/II7nZ
 SovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704188731; x=1704793531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D5sHdH8s4qL8YDy1fschkSwNx0GWjqxbCOfWlBrG6H8=;
 b=mU9bGkT5cvM8mGal0lQTksgdS0M2CrYYvF9BD2IByuF/5hagkAHLAH7jfkK6YuR95S
 fM1ExIZ8pELCZ564U92fiXExiN0TKKSRnMA1WyvOVBE1b2JZnx1VbgtGAIA2nwnU1vj9
 vcvP/AjXKPQBVmTJkBU02IXLGSA2cjzO80Qs+Z1IxvwtqsPzpqvnPlI+8Xh/FxsLThDP
 xlSxCc4qfeuhkNQaxhIuP8+KTJlM2fCONAjgVyirdChy0+x2VzUh4IVUenWzQ3AqV6AZ
 zM3/8GkzCbr5YKdyo42AaqzaD6SOSAF9xzVGHwNeiIlZuBQ/3H2zi2vS6/1Bygqmf2F1
 uUxQ==
X-Gm-Message-State: AOJu0YyOYZxa0wXm3iSWF9NsxHIxHrS38zzwmqDydBu3yHW6Igx90CPj
 63x0Pt8GyOnqRPQ9LBdWOLJtkJzS73OsBg==
X-Google-Smtp-Source: AGHT+IGobNEaLIFhhKzy2eu1TD/XRyAnZa3n0wYCOpoieBs11bOXdvCEdsdpkx07H6UHghQM61Oweg==
X-Received: by 2002:a1c:4c14:0:b0:40d:8bc5:d9cb with SMTP id
 z20-20020a1c4c14000000b0040d8bc5d9cbmr548166wmf.110.1704188731402; 
 Tue, 02 Jan 2024 01:45:31 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 l2-20020adfe582000000b003366cf8bda4sm27938746wrm.41.2024.01.02.01.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 01:45:31 -0800 (PST)
Message-ID: <c1dcff9a-a1e7-406f-ac3f-696e4222e7c9@linaro.org>
Date: Tue, 2 Jan 2024 10:45:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/loongarch: move translate modules to tcg/
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, maobibo@loongson.cn
References: <20240102020200.3462097-1-gaosong@loongson.cn>
 <20240102020200.3462097-2-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102020200.3462097-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/1/24 03:02, Song Gao wrote:
> Introduce the target/loongarch/tcg directory. Its purpose is to hold the TCG
> code that is selected by CONFIG_TCG
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/{ => tcg}/constant_timer.c   |  0
>   target/loongarch/{ => tcg}/csr_helper.c       |  0
>   target/loongarch/{ => tcg}/fpu_helper.c       |  0
>   target/loongarch/{ => tcg}/iocsr_helper.c     |  0
>   target/loongarch/{ => tcg}/op_helper.c        |  0
>   target/loongarch/{ => tcg}/tlb_helper.c       |  0
>   target/loongarch/{ => tcg}/translate.c        |  0
>   target/loongarch/{ => tcg}/vec_helper.c       |  0
>   .../{ => tcg}/insn_trans/trans_arith.c.inc    |  0
>   .../{ => tcg}/insn_trans/trans_atomic.c.inc   |  0
>   .../{ => tcg}/insn_trans/trans_bit.c.inc      |  0
>   .../{ => tcg}/insn_trans/trans_branch.c.inc   |  0
>   .../{ => tcg}/insn_trans/trans_extra.c.inc    |  0
>   .../{ => tcg}/insn_trans/trans_farith.c.inc   |  0
>   .../{ => tcg}/insn_trans/trans_fcmp.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_fcnv.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_fmemory.c.inc  |  0
>   .../{ => tcg}/insn_trans/trans_fmov.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_memory.c.inc   |  0
>   .../insn_trans/trans_privileged.c.inc         |  0
>   .../{ => tcg}/insn_trans/trans_shift.c.inc    |  0
>   .../{ => tcg}/insn_trans/trans_vec.c.inc      |  0
>   target/loongarch/meson.build                  | 15 +--------------
>   target/loongarch/tcg/meson.build              | 19 +++++++++++++++++++
>   24 files changed, 20 insertions(+), 14 deletions(-)

>   create mode 100644 target/loongarch/tcg/meson.build
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


