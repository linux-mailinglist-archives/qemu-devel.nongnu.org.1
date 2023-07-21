Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122875BBD2
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 03:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMez7-0006oq-H3; Thu, 20 Jul 2023 21:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qMez5-0006oS-Ge
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 21:31:07 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qMez1-000258-Dp
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 21:31:07 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1b8eb69d641so1110432fac.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 18:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689903056; x=1690507856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZSoHmlHL8/eFHyDGwSFlRu8U6opJePDtjLjy9Ln5hA=;
 b=UbYpbpvUv/AYgS/YZHDAf/QNzfenVplUjQdnHs9T3EbydczWDkPk7exuXbO+R0QdM1
 98MoC3xDI4GlxKVkEq2THev+IrAGuR/obPUA5gdnbT2jYKIfl92LgDV3xQXu+yhW5Hgv
 sg+RMUw/KTvC68t2VjcbVFLVaPNZHjtBd3s/2952Bkvkjdw6yUmFJwLtzTcYF69TJolf
 amweTh3OW2V/bIbQTqHEpeBCCZEC5g//nMzGnd4UMEVWWcc3CPMKF5TlTRekhVAOiz82
 I1WYX/OL8tMUtD4dG4NAWA/ufdkEyuRXYAtFWXwnx9h///s1xIKUf8kK1iuznjWLvEG8
 cLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689903056; x=1690507856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZSoHmlHL8/eFHyDGwSFlRu8U6opJePDtjLjy9Ln5hA=;
 b=T5nxpMMuLRgeywEjYTVy2WrYSIp70JdLraqm03c6dACr8yYWd+hcgr/2aZqSpdvjRp
 7mNRFjdt/y5y5Q8J31Ul21J0HMl+JDykDg4zAeZW7zZM1uOXNXeRDFkR0Re4kjlwpgi3
 HHsgNl3fnvF2tG6rryfEqHtzskGq7jSdYP7zHPdf0nPCtux3T2hxgRcbTlATADpg0ASm
 gbVAzoo0CrpbC12Xt7HAxT4zo4efHDjkDQpswUo2GmoiCaW41QI08rX30sHPJ1oFSL23
 8MAi6E2E00Bi0kPg8qVIZ3S0N1C6hj4A6uQkVFDpG84OMQHh9z97p3g8GbH4VjioGmia
 ANDg==
X-Gm-Message-State: ABy/qLZ2PxcAHAHQQkU0BAgbNY8XouhR76ISLGMIwiAfsoCqwrbfsAUv
 DFVw3BiRQgjw5hyxNuZOPggU3w==
X-Google-Smtp-Source: APBJJlFl8OT7F93Nt27g5Khn7qL3rH4q1YG1BjxgiFQOVz3rTPrXjI6j1ig3WE3RqtR1bAoPBPWquQ==
X-Received: by 2002:a05:6870:a714:b0:1ad:34f5:559e with SMTP id
 g20-20020a056870a71400b001ad34f5559emr521999oam.25.1689903055706; 
 Thu, 20 Jul 2023 18:30:55 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.5]) by smtp.gmail.com with ESMTPSA id
 h18-20020a62b412000000b00682a75a50e3sm1864624pfn.17.2023.07.20.18.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 18:30:55 -0700 (PDT)
Message-ID: <f281b0cf-7b95-64b1-0dc6-5e4d91fa6825@bytedance.com>
Date: Fri, 21 Jul 2023 09:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: PING: [PATCH v3 0/6] Misc fixes for throttle
Content-Language: en-US
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org,
 qemu_oss@crudebyte.com, hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230713064111.558652-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Kevin, Hanna,

Patch 1 -> patch 5 of this series are already reviewed by Alberto(these 
affects throttle framework only), the patch 6 affects qemu block layer, 
would you please review this(in the further step, merge this series if 
this is acceptable)?

On 7/13/23 14:41, zhenwei pi wrote:
> v2 -> v3:
> - patch 1 -> patch 5 are already reviewed by Alberto
> - append patch 6: throttle: use enum ThrottleType instead of bool is_write
> 
> v1 -> v2:
> - rename 'ThrottleTimerType' to 'ThrottleType'
> - add assertion to throttle_schedule_timer
> 
> v1:
> - introduce enum ThrottleTimerType instead of timers[0], timer[1]...
> - support read-only and write-only for throttle
> - adapt related test codes
> - cryptodev uses a write-only throttle timer
> 
> Zhenwei Pi (6):
>    throttle: introduce enum ThrottleType
>    test-throttle: use enum ThrottleType
>    throttle: support read-only and write-only
>    test-throttle: test read only and write only
>    cryptodev: use NULL throttle timer cb for read direction
>    throttle: use enum ThrottleType instead of bool is_write
> 
>   backends/cryptodev.c        | 12 +++---
>   block/throttle-groups.c     |  6 ++-
>   fsdev/qemu-fsdev-throttle.c |  8 ++--
>   include/qemu/throttle.h     | 15 +++++---
>   tests/unit/test-throttle.c  | 76 ++++++++++++++++++++++++++++++++++---
>   util/throttle.c             | 64 +++++++++++++++++++------------
>   6 files changed, 136 insertions(+), 45 deletions(-)
> 

-- 
zhenwei pi

