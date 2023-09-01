Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D758E78F72A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:33:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtxr-00056d-6g; Thu, 31 Aug 2023 22:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtxp-0004zY-Hj
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:32:49 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtxn-0003Yx-60
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:32:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-56f84de64b9so941423a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535565; x=1694140365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s538vCkpclK5ATTHW63+oqL5qr7+Lo9fs0+lfXMGLHc=;
 b=i4mJnedfiho0VBaSLeBZpj5G+QFARTf/nBt7T5zrGTFtg7wlfAWi7DUA/UeWihQCT5
 ZftlfQ6M6hMlqsbpovTOg7vvxSYP9gur0NMuq/l8dkz0P6c+/GAIxJc/l05vRRi1DsUM
 xWcQoKi0mT5xMujWWOQnGhhopjqkPTqW4MEQBtrJJVV/QYryIPfLPZKJocZUX7DEGJqo
 Hd+PF4JvUIBdFF2i7cHkbKKeirLOQ6dKcgMK+p3MH5ogxqZUzVSbqG8Juhx42u3d9Fux
 BOnzWGggz4kdE5/Jv1UZxHCkedx5S7RmswyCV8BcpdIkhKKpqvUyAI+/Hfge+7q4T7EQ
 Q/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535565; x=1694140365;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s538vCkpclK5ATTHW63+oqL5qr7+Lo9fs0+lfXMGLHc=;
 b=eviIjixvFkOL6EXPIAHB32IGzUNruneh6DQsV6If9A9g1htyeT142TayGmlrPDWHIT
 NlUeGqfOpCY8r/yNAMLM8Vz3RnWnKS+pvttGKR0sruQp4otno/ajaq3wKgALm6lHlWD2
 vZ64bjoVSvDZmof2YpedoHGzvsC4eaU++AAwmNF7I+31RZiRQCot4/xKGKk+quz5+TDx
 lfAtvydkJhm9D8NL4n0bYerXEVdKI0+KboSHJuT5PM9MHw2GRhGf/iG4RLF0/JQaB8x/
 yRtGKXVpvBX9NQZ00KFp+Q6e9qsjVe0rU8YAG1LvpsdaSubc5yhwQLRLUMga6dxcIndm
 8uBg==
X-Gm-Message-State: AOJu0Yx36Rk9cN9xDFQ3fYxUt7rEL95caczgDWBPGw6cnQAyUvPIUMu1
 KcPCVDcyaPoJJPCM2MKfP4iszZYKeVSQs4oi4fM=
X-Google-Smtp-Source: AGHT+IG1HM+tb4S10O97gmCtNDKxgfFrElgwDNx0TuFyXTw7C7tY716DtXFTtrE56kLXRFRvl9cMzg==
X-Received: by 2002:a17:90a:fe86:b0:269:68e7:bbb9 with SMTP id
 co6-20020a17090afe8600b0026968e7bbb9mr1637279pjb.23.1693535565478; 
 Thu, 31 Aug 2023 19:32:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a005a00b0025dc5749b4csm3840215pjb.21.2023.08.31.19.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 19:32:45 -0700 (PDT)
Message-ID: <05129269-b718-53e0-0a1d-d8640ea9b57f@linaro.org>
Date: Thu, 31 Aug 2023 19:32:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/13] linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

Ping.

On 8/23/23 18:02, Richard Henderson wrote:
> Combine a bunch of smaller linux-user patches:
> 
> Supercedes: 20230801230842.414421-1-deller@gmx.de
> ("[PATCH v2 0/3] linux-user: /proc/cpuinfo fix and content emulation for arm")
> Supercedes: 20230807122206.655701-1-iii@linux.ibm.com
> ("[PATCH v2] linux-user: Emulate the Anonymous: keyword in /proc/self/smaps")
> Supercedes: 20230816181437.572997-1-richard.henderson@linaro.org
> ("[PATCH 0/6] linux-user: Rewrite open_self_maps")
> Supercedes: 20230820204408.327348-1-richard.henderson@linaro.org
> ("[PATCH 0/4] linux-user: shmat/shmdt improvements")
> 
> with some additions.  Patches needing review:
> 
>    01-linux-user-Split-out-cpu-target_proc.h.patch
>    11-linux-user-Use-WITH_MMAP_LOCK_GUARD-in-target_-shmat.patch
>    12-linux-user-Fix-shmdt.patch
>    13-linux-user-Track-shm-regions-with-an-interval-tree.patch
> 
> 
> r~
> 
> 
> Helge Deller (2):
>    linux-user: Emulate /proc/cpuinfo on aarch64 and arm
>    linux-user: Emulate /proc/cpuinfo for Alpha
> 
> Ilya Leoshkevich (1):
>    linux-user: Emulate the Anonymous: keyword in /proc/self/smaps
> 
> Richard Henderson (10):
>    linux-user: Split out cpu/target_proc.h
>    util/selfmap: Use dev_t and ino_t in MapInfo
>    linux-user: Use walk_memory_regions for open_self_maps
>    linux-user: Adjust brk for load_bias
>    linux-user: Show heap address in /proc/pid/maps
>    linux-user: Remove ELF_START_MMAP and image_info.start_mmap
>    linux-user: Move shmat and shmdt implementations to mmap.c
>    linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,shmdt}
>    linux-user: Fix shmdt
>    linux-user: Track shm regions with an interval tree
> 
>   include/qemu/selfmap.h               |   4 +-
>   linux-user/aarch64/target_proc.h     |   1 +
>   linux-user/alpha/target_proc.h       |  67 ++++
>   linux-user/arm/target_proc.h         | 101 ++++++
>   linux-user/cris/target_proc.h        |   1 +
>   linux-user/hexagon/target_proc.h     |   1 +
>   linux-user/hppa/target_proc.h        |  26 ++
>   linux-user/i386/target_proc.h        |   1 +
>   linux-user/loader.h                  |   6 +-
>   linux-user/loongarch64/target_proc.h |   1 +
>   linux-user/m68k/target_proc.h        |  16 +
>   linux-user/microblaze/target_proc.h  |   1 +
>   linux-user/mips/target_proc.h        |   1 +
>   linux-user/mips64/target_proc.h      |   1 +
>   linux-user/nios2/target_proc.h       |   1 +
>   linux-user/openrisc/target_proc.h    |   1 +
>   linux-user/ppc/target_proc.h         |   1 +
>   linux-user/qemu.h                    |   1 -
>   linux-user/riscv/target_proc.h       |  37 ++
>   linux-user/s390x/target_proc.h       | 109 ++++++
>   linux-user/sh4/target_proc.h         |   1 +
>   linux-user/sparc/target_proc.h       |  16 +
>   linux-user/user-mmap.h               |   4 +
>   linux-user/x86_64/target_proc.h      |   1 +
>   linux-user/xtensa/target_proc.h      |   1 +
>   linux-user/elfload.c                 | 170 ++++++---
>   linux-user/mmap.c                    | 168 +++++++++
>   linux-user/syscall.c                 | 514 +++++++--------------------
>   util/selfmap.c                       |  12 +-
>   29 files changed, 828 insertions(+), 437 deletions(-)
>   create mode 100644 linux-user/aarch64/target_proc.h
>   create mode 100644 linux-user/alpha/target_proc.h
>   create mode 100644 linux-user/arm/target_proc.h
>   create mode 100644 linux-user/cris/target_proc.h
>   create mode 100644 linux-user/hexagon/target_proc.h
>   create mode 100644 linux-user/hppa/target_proc.h
>   create mode 100644 linux-user/i386/target_proc.h
>   create mode 100644 linux-user/loongarch64/target_proc.h
>   create mode 100644 linux-user/m68k/target_proc.h
>   create mode 100644 linux-user/microblaze/target_proc.h
>   create mode 100644 linux-user/mips/target_proc.h
>   create mode 100644 linux-user/mips64/target_proc.h
>   create mode 100644 linux-user/nios2/target_proc.h
>   create mode 100644 linux-user/openrisc/target_proc.h
>   create mode 100644 linux-user/ppc/target_proc.h
>   create mode 100644 linux-user/riscv/target_proc.h
>   create mode 100644 linux-user/s390x/target_proc.h
>   create mode 100644 linux-user/sh4/target_proc.h
>   create mode 100644 linux-user/sparc/target_proc.h
>   create mode 100644 linux-user/x86_64/target_proc.h
>   create mode 100644 linux-user/xtensa/target_proc.h
> 


