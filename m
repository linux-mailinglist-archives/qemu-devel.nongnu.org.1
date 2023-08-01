Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412076A7C7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 06:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQggf-0002lo-1C; Tue, 01 Aug 2023 00:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQggc-0002lY-Ta
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 00:08:42 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQggZ-0003M1-QP
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 00:08:42 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b9c57c4d12so4024148a34.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690862914; x=1691467714;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVlWiuuQI2vY/QG7vl8SXKFZphOwd7VrNaadqDbeQBU=;
 b=lEMMWIKAI5vHgbJ70hOj3rhA/fJ/W8rSc2pGflq9qaPFDWLqeP8Hb7tbNSMpuKhoJy
 b4r6GG9fqY4/be/Cuxoq3afwAMI395JyiknnIZjvhq5o0AZL5qHqVcer+AWbGseVM30w
 2RP/ugOhfpG9wl6RQEJ8JJJxoPYCku/lhbSdQCZTlvl5fXGgx4g3N8en5fPkzf/rnnUI
 WotOpZvtIp2+RlB+ZujBwhNliq2gXX5tIobgKjtQ0h6qx1YexMyQJ4P8K7pFl/gRXix2
 dV8F2C8ubnxT65XTaBo59EOXaX1+P2ndLsIN3IU9JZvB56wcQPJ+UdAykHpdBQUZlXTM
 qHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690862914; x=1691467714;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVlWiuuQI2vY/QG7vl8SXKFZphOwd7VrNaadqDbeQBU=;
 b=Q5qeTuZGh5Usu9Huox6BPt4jtl+2pvTK7QaWA4nzc1s56Xwn0ZZH9pjVHVG0IKm8k3
 FbRLq88zQ9UTfMapehugQifOw7ioI7LHaPk//z3bEXH3bqyNAYhqEdEWXN5TA0QLjSA2
 Cblcdsjh46DR8tsX21iSBqBCHWGOKpMPqiglepxnz8X9n2RP9LdwtFyz9qMVjB+PyIhn
 OaBzxHnVIrHov3sZgVn1MYltwVctDL7AhGelNIvQ9P9P2JQEmgmuZ3FzA60Rky4ecExA
 YKiSSDgekUQiFiAnCZh579SpVRNPmalR8/Pml49dg4N1S2bPFi9UvNS6BGEBVfnEktyB
 baSw==
X-Gm-Message-State: ABy/qLbQekK8/FfM4318uMqX8HYlBvenNaNiQMkaCcNKJ1YciBKLdVfm
 6C6xwIc65j2E/78LnamrmKnvFKxcyKSkd5+IfBY=
X-Google-Smtp-Source: APBJJlG6IaMS7D4CvWtAE9RKuP/oKogAp5vvKvJ4Xx2lJcQR1v3smgP68JdcLBZSeoxfXbM//pwkUA==
X-Received: by 2002:a9d:6c45:0:b0:6b7:57aa:45cc with SMTP id
 g5-20020a9d6c45000000b006b757aa45ccmr11214631otq.15.1690862913801; 
 Mon, 31 Jul 2023 21:08:33 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:6de4:1334:c47c:65d8?
 ([2602:47:d490:6901:6de4:1334:c47c:65d8])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a637119000000b0056456fff676sm1913459pgc.66.2023.07.31.21.08.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 21:08:33 -0700 (PDT)
Message-ID: <03ea7892-37d3-c922-64b6-ed7a4f9911d1@linaro.org>
Date: Mon, 31 Jul 2023 21:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/10] tcg patch queue for rc2
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230731210211.137353-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/31/23 14:02, Richard Henderson wrote:
> The following changes since commit 234320cd0573f286b5f5c95ee6d757cf003999e7:
> 
>    Merge tag 'pull-target-arm-20230731' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-07-31 08:33:44 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230731
> 
> for you to fetch changes up to 8b94ec53f367db7adcc9b59c483ce3e6c7bc3740:
> 
>    target/s390x: Move trans_exc_code update to do_program_interrupt (2023-07-31 12:19:13 -0700)
> 
> ----------------------------------------------------------------
> util/interval-tree: Access left/right/parent atomically
> accel/tcg: Clear gen_tb on buffer overflow
> bsd-user: Specify host page alignment if none specified
> bsd-user: Allocate guest virtual address space
> target/ppc: Disable goto_tb with architectural singlestep
> target/s390x: Move trans_exc_code update to do_program_interrupt
> 
> ----------------------------------------------------------------
> Helge Deller (1):
>        linux-user/armeb: Fix __kernel_cmpxchg() for armeb
> 
> Richard Henderson (8):
>        util/interval-tree: Use qatomic_read for left/right while searching
>        util/interval-tree: Use qatomic_set_mb in rb_link_node
>        util/interval-tree: Introduce pc_parent
>        util/interval-tree: Use qatomic_read/set for rb_parent_color
>        accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow
>        bsd-user: Allocate guest virtual address space
>        target/ppc: Disable goto_tb with architectural singlestep
>        target/s390x: Move trans_exc_code update to do_program_interrupt
> 
> Warner Losh (1):
>        bsd-user: Specify host page alignment if none specified

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


> 
>   accel/tcg/translate-all.c      |  1 +
>   bsd-user/main.c                | 48 ++++++++++++++++++++++---
>   bsd-user/mmap.c                |  3 +-
>   linux-user/arm/cpu_loop.c      |  9 +++--
>   target/ppc/translate.c         |  3 ++
>   target/s390x/tcg/excp_helper.c | 40 ++++++++++++++-------
>   util/interval-tree.c           | 79 +++++++++++++++++++++++++-----------------
>   7 files changed, 132 insertions(+), 51 deletions(-)


