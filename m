Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B9789FD1
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 16:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaHAK-0002Re-79; Sun, 27 Aug 2023 10:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaHAI-0002Q0-H6
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 10:54:58 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaHAG-0002LL-Fr
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 10:54:58 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-26f4bc74131so1544738a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693148095; x=1693752895;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lqqf668Wa4rZez51Mz1hnOL3VcZYRvztpRqWPxuzqg0=;
 b=j6d9JmeYC2zYr/xh7wZsgGGruJQH3Y6nhCudGAcgjLHsiUJm0smkkNuEeiUG2BesUC
 ECsZiVeoNBUNQk6DdrXFZYLMp59TGE6vgz6Z/0OYSdExK+YgVRjcjv+1OJx7zBb4UouA
 omc/PszJZlSAqpHClcZsydrUSfMDlIfcMo3tEDTChQfKWoq3wOJ9xun28SESGuOcqw6s
 PAzYoAUWmbbcUQZAE547dGeILTxUsqR2pYzajMZEltXmyS+QzIgGtq1Pw6s8+gGdil75
 PDDkDtNdGnbdRPYHAJ7OjraepKhDp6ahNX+FObd3M+Okm+A/jbEFCTmUAMV6wLhfprmB
 eicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693148095; x=1693752895;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lqqf668Wa4rZez51Mz1hnOL3VcZYRvztpRqWPxuzqg0=;
 b=Sb9Fzmo0P3dvy9LYM1GZTR8OTHTvz4LEvqQ0qIv4Riz5Ryi9dBDH1v+ZjDBMbgF6de
 H8sD51MCfQLCCz1Cxmh2xWO3wZP7A3dtTBbfbsaXST+xy7l5IOEcuaOCnhT0fahw5sM5
 nqJL9mC9vMjGQJ5mtG1U6ac+CxS/1NJv67GsCHw/3+eALfvY5muT4tHDsF4v6aUGPdHW
 Gn7Xp7+KPL9vc3xcWtoU+zc6vQz49T8iITUxfR/OZ3PYYpQvnHbHjw/zq5bxGDHR3kim
 2T7UabyBrkdxGn/Qd1nrPZ4GVjO/71I8gKZ9IEqgBfFrs/mBcLSFNl5Z1saauN1GJhck
 Uvtg==
X-Gm-Message-State: AOJu0YxE7CxV64t2N6WWN8SmNu4VOqcOo00BQaddgh6iSnNcgPbu8QX8
 8kIQtGPjIIPrVTHUtSSkEsKRckabVFku/yX/NsM=
X-Google-Smtp-Source: AGHT+IFrvk6Bp65Jf3iuJpD2LDjggRv8JkLFEcc2foUmGJCDAvlD0lAvPNlFUOAP9ot2UoUEfllKyA==
X-Received: by 2002:a17:90a:cb12:b0:26f:6f2a:a11 with SMTP id
 z18-20020a17090acb1200b0026f6f2a0a11mr28330464pjt.12.1693148094999; 
 Sun, 27 Aug 2023 07:54:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 13-20020a17090a030d00b002694da8a9cdsm5446644pje.48.2023.08.27.07.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 07:54:54 -0700 (PDT)
Message-ID: <2f239df2-5cdf-9eef-98af-b208d3ead39b@linaro.org>
Date: Sun, 27 Aug 2023 07:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] softmmu: Use async_run_on_cpu in tcg_commit
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-3-richard.henderson@linaro.org>
In-Reply-To: <20230826232415.80233-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.414,
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

On 8/26/23 16:24, Richard Henderson wrote:
> +static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
> +{
> +    CPUAddressSpace *cpuas = data.host_ptr;
> +
> +    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
> +    tlb_flush(cpu);
> +}

Question: do I need to take the iothread lock here, while re-generating the address space 
dispatch?


r~

