Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F802774CBC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTU2u-0000tQ-M2; Tue, 08 Aug 2023 17:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1qTU2r-0000ss-Sm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:15:13 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1qTU2p-0007KR-U9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:15:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686b879f605so4369616b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691529310; x=1692134110; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=TtLUv5fpgSeYlGMdvGB1U/VGXchhPuLHbevjs7/x/hA=;
 b=3dgElO64yIlYh7YKJs1T8g/apPU8VRLXnU5GnF8Od8OkcBGqUWuoQ0sZY4SbPq8Kjc
 D1k7MZzzjmbe5WWRze3WvSt4Ad3drhk9aQ7YTv+io5e7meHdHn0TnGj8grQBNS7wRDZv
 6m+tKVgUowRMIBjWnO923Xbpq4zxXbBRz2rjErOzS/CiszBu76STByFGQIKDaM0dIN8g
 nad71b2/Y9RHCG5nNkCI9TL9bBhPErEMBDH758hVgWYHP8WrWQKCWZh9ohbQ8+JI+317
 zsCaMxMMOKsvJy+PsqFVh3JCUBWRQQSlm2ZAfLvORNeErcZo/KR6FjflCWUIEHy6D843
 LWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529310; x=1692134110;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtLUv5fpgSeYlGMdvGB1U/VGXchhPuLHbevjs7/x/hA=;
 b=DHtIqsaViCIT8W/GWRFriJBzidiKMFtBj9GL3mUNp2oY1gCjvJ0bxS6pOqV7IOPPb0
 NkaSYn2RiIuFLP4ZYJx2L8Od0VVZCTpvgMR7ny+cCHCiUP2DeS1s7f+9hxsRhzMzcaDd
 pl6zw+YTcmKRJNhO3la7QBlJk2z+UfBlcvOTJUXgiX5Dew5qDZqmANR/e47+GJC2lx+V
 fD8KiUGnc2FJ4LMCL6tM2YCKbFlyZg7ERjOYR4/bTMCdf7GKneVLbriKphVN1anYPAuQ
 xj+d2U6R7ZgDEroi272d0qQM8xCkWktt1p9p3WTirUDSNsIzM8Grtj8Jpv3NBjiPdFMe
 V2vQ==
X-Gm-Message-State: AOJu0Yy/0AT4+c4MyGCG5bIuUilaN+Wa8ZTdopEx7RXFFA540s0Jtr9G
 ZFVn0YYRi6288bJaJ8IN4jwUog==
X-Google-Smtp-Source: AGHT+IFp2kCjCitEcZuW2ry4Kvdh+5QI1e0KssRPjqTaEUq1kVYN7LchkF5ePYPMZp/cRvE8+ZtlpA==
X-Received: by 2002:a05:6a20:459:b0:13f:7ffe:855e with SMTP id
 b25-20020a056a20045900b0013f7ffe855emr558938pzb.45.1691529310211; 
 Tue, 08 Aug 2023 14:15:10 -0700 (PDT)
Received: from localhost ([50.221.140.188]) by smtp.gmail.com with ESMTPSA id
 x19-20020a170902ea9300b001b1c4d875f5sm9460712plb.44.2023.08.08.14.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:15:09 -0700 (PDT)
Date: Tue, 08 Aug 2023 14:15:09 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Aug 2023 14:15:06 PDT (-0700)
Subject: Re: [PATCH 1/2] riscv: zicond: make non-experimental
In-Reply-To: <d734a730-f41f-4d3e-01fb-a0876d05c9e2@ventanamicro.com>
CC: Vineet Gupta <vineetg@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Kito Cheng <kito.cheng@gmail.com>, jeffreyalaw@gmail.com
From: Palmer Dabbelt <palmer@rivosinc.com>
To: dbarboza@ventanamicro.com, Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-973b4687-69f6-4c32-976a-60bc068eca86@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=palmer@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 08 Aug 2023 14:10:54 PDT (-0700), dbarboza@ventanamicro.com wrote:
>
>
> On 8/8/23 17:52, Palmer Dabbelt wrote:
>> On Tue, 08 Aug 2023 11:45:49 PDT (-0700), Vineet Gupta wrote:
>>>
>>>
>>> On 8/8/23 11:29, Richard Henderson wrote:
>>>> On 8/8/23 11:17, Vineet Gupta wrote:
>>>>> zicond is now codegen supported in both llvm and gcc.
>>>>
>>>> It is still not in
>>>>
>>>> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
>>>
>>> Right, its been frozen since April though and with support trickling in
>>> rest of tooling it becomes harder to test.
>>> I don't know what exactly QEMU's policy is on this ?
>>
>> IIUC we'd historically marked stuff as non-experimental when it's frozen, largely because ratification is such a nebulous process. There's obviously risk there, but there's risk to anything.  Last I can find is 260b594d8a ("RISC-V: Add Zawrs ISA extension support"), which specifically calls out Zawrs as frozen and IIUC adds support without the "x-" prefix.
>
> If that's the case then I think it's sensible to remove the 'experimental' status
> of zicond as well.
>
>>
>> I can't find anything written down about it, though...
>
> As soon as we agree on an official policy I'll do a doc update. Thanks,

Thanks.  We should probably give Alistair some time to chime in, it's 
still pretty early there.

>
>
> Daniel
>
>>

