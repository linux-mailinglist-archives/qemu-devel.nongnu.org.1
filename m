Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87273E741
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDqgP-00067c-MW; Mon, 26 Jun 2023 14:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDqgM-00066M-CO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 14:11:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDqgK-0003t9-Ip
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 14:11:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fa8692a006so28348865e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687803079; x=1690395079;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6Lx1fwPwb5e6Q7oy1UH+cuTuqfMyUC1FEhKzuiLETY=;
 b=cLiVS1YHDLR3tzys8o+QM86A+MPD/MwLmGwzodw+cYdwHgx6RlLnnGTNQMGJdxNkKC
 OuZX9pZ1Mu3S/WyvAK+n5n3YdxtPMrgvkT6UDHSWndh/BxEQhqulTG5tSXnGnsaqZLRB
 d0sF44mrQKEYN8PsqSdCHFV8+p3y891Nqjkc7hwzPE28CM5I8ZwrrNtANIAVzaZfGtNu
 4MbM0cmVkXuX0y/tiQlLVrbvODm88MGAz6vJERyQP+BCoNCvPOSZfJ0K2jqtho1V/djC
 m0heAQ1a7+L66blQ2I/4N2fAOaEi0jeKnxnpKltZ07PP+eK7cpPy35BO2UcQnbuZiLzk
 sW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687803079; x=1690395079;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6Lx1fwPwb5e6Q7oy1UH+cuTuqfMyUC1FEhKzuiLETY=;
 b=jkdTurmjMsDlDavDVdWa3JDWsYnFhngf+9ylzZydEzUpev/wEBK0byrtpQuAX3VYAO
 Qu8mjVDthDoENEbufXHfs/FLKeQ6nAsNxogqgJbJVPGuEmUq79p5vCUVYzOYX8k0XeIj
 Oq2LZHeRoqg9tE6z5uD1yE9wda7Us89P3q0X3a9+ribEptZ8btnmFsMUE0dtUvaV27WJ
 YrMWfVmsYN85x+fyHlCqO3ExuNPaE8+PgC1RnPI4xyS1ibgBe8AFKk9H7Qu1im+tC0sd
 hOaKLwWVqk4/eBCfk8VLWgpiJVB6/bAQnc8VPtI8TG/MUsiyKIk59N0oxKfePjGuSx0q
 AGeQ==
X-Gm-Message-State: AC+VfDyfPW1D8pEx11330QIXsCmTRNviTVYKk5Ty2pFr2y4G86dNzMan
 LEF1SzGeyIvehgTmNKtCPf7ZkNGubTwid+i6FWb5+rQp
X-Google-Smtp-Source: ACHHUZ59JMvjJ5wm8sAmZg796kkJolf1Fnk2mn5B0GjNtXgpWGLaZfF2OV88O7wioK8E3P+VJhfS9g==
X-Received: by 2002:a05:600c:b4b:b0:3fa:8218:85ff with SMTP id
 k11-20020a05600c0b4b00b003fa821885ffmr6610075wmr.31.1687803078774; 
 Mon, 26 Jun 2023 11:11:18 -0700 (PDT)
Received: from [192.168.157.227] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c210800b003f9b4330880sm8421631wml.29.2023.06.26.11.11.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 11:11:18 -0700 (PDT)
Message-ID: <f20f75ee-e213-7cb6-b26a-370a6b19b3f6@linaro.org>
Date: Mon, 26 Jun 2023 20:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/22] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230626153945.76180-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/26/23 17:39, Richard Henderson wrote:
> The following changes since commit 390e8fc6b0e7b521c9eceb8dfe0958e141009ab9:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu  into staging (2023-06-26 16:05:45 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230626
> 
> for you to fetch changes up to a0eaae08c7c6a59c185cf646b02f4167b2ac6ec0:
> 
>    accel/tcg: Renumber TLB_DISCARD_WRITE (2023-06-26 17:33:00 +0200)
> 
> ----------------------------------------------------------------
> accel/tcg: Replace target_ulong in some APIs
> accel/tcg: Remove CONFIG_PROFILER
> accel/tcg: Store some tlb flags in CPUTLBEntryFull
> tcg: Issue memory barriers as required for the guest memory model
> tcg: Fix temporary variable in tcg_gen_gvec_andcs

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


