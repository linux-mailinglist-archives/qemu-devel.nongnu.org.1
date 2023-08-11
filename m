Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8B779082
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 15:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qURwP-0006gf-D4; Fri, 11 Aug 2023 09:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1qURwK-0006gC-UY
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:12:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1qURwJ-0003QC-4p
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:12:28 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so4126773a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1691759543; x=1692364343;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nBZWSP2C3HyntujncHEI7Q7XZucXTZ9+eGCGM7A26ew=;
 b=h2HO4iCIJiqKjDjIaCp9UDgyDYO7mSFdfVSHprcIqMVFp8qCpFF2jf5VHUdzBgxGPU
 M3vtXPdyGo8gxNMnMguW4Ibk8B1xJp8GSAi8vdPJCN471rkabQUCrzRhrhpaBWegEPQk
 4St2JX/EHj41JP4kEUO7vMh41kgOzlO0ZX9dp+MQUvgzWZTBczWechfBhlstAKW70ocj
 7zQPu00ShHC3TH1BiZcWLkBqHaOvZpCQtLydwCTSBrZpL9wBL7oqCYqWf0bInmu6QZZF
 ypM8RyUI5a72CtuW80WoxGemrlTZD+ziLkxOdVvXplOSKIBMN6WN3YNg7c5/rBmGX5h0
 5igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691759543; x=1692364343;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nBZWSP2C3HyntujncHEI7Q7XZucXTZ9+eGCGM7A26ew=;
 b=TqizZTzyUDE5ahgHHkSgMSrydo2g+7/TIpK9S2RjQnf9k/UczRd2Vc8U8QA6Y1wvA3
 NYw51cdKqbJfFtB+wJJY+8SnQbRU9wENVDJaDK6mA91Th+DntJyeoSFvllNqnqfOqE2w
 MjvCp5NEPFjv3lG+E3C5etG5q7ARwd8gNOHjuFuVV1nnrzbASP/mabZkMyZofM4xwz2q
 8OW4tMosq25krao99fX7usRW7YxNyDZc68b6vYhl06VVV/bSvb9L98eK2nwUjKdJwPQ1
 bFs5Gv0/yZFM+4s+8qICkP9BGquT6/hQH4BJRqz4MkyTF18qucNPl44zKdYgYGsdkEyY
 i2Eg==
X-Gm-Message-State: AOJu0Yy9DVT+Z5merM/45YJljj0+n4YGupXxV1mQRMnYcCIByleRo9Wu
 aVd3TTGequTB5050b6hmkXlgHKCDbTicVnahrrAzVR3M69XUS3zS80w=
X-Google-Smtp-Source: AGHT+IH/Ai3tYY2Som0oRGkhZdVewshjhBNk+HhYWsybZ8rDPt+0AK7Hklygk+OFSQYFST8iSEn4yiX52OXyLCtXJwQ=
X-Received: by 2002:aa7:dc06:0:b0:522:2add:5841 with SMTP id
 b6-20020aa7dc06000000b005222add5841mr2096014edu.7.1691759543395; Fri, 11 Aug
 2023 06:12:23 -0700 (PDT)
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 11 Aug 2023 15:12:12 +0200
Message-ID: <CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com>
Subject: RFC: guest INTEL GDS mitigation status on patched host
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tao1.su@linux.intel.com,
 xiaoyao.li@intel.com, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: permerror client-ip=2a00:1450:4864:20::52a;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi folks on the list:

I'm testing the latest Downfall cpu vulnerability mitigation. what I
notice is when both host and guest are using patched kernel +
microcode eg kernel 5.15.125 +  intel-microcode 20230808 on affected
server eg Icelake server.

The mitigation status inside guest is:

Vulnerabilities:
  Gather data sampling:  Unknown: Dependent on hyp
                         ervisor status
-----------------------------------> this one.
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Vulnerable: Clear CPU buf
                         fers attempted, no microc
                         ode; SMT Host state unkno
                         wn
  Retbleed:              Not affected
  Spec rstack overflow:  Not affected
  Spec store bypass:     Mitigation; Speculative S
                         tore Bypass disabled via
                         prctl and seccomp
  Spectre v1:            Mitigation; usercopy/swap
                         gs barriers and __user po
                         inter sanitization
  Spectre v2:            Mitigation; Enhanced IBRS
                         , IBPB conditional, RSB f
                         illing, PBRSB-eIBRS SW se
                         quence
  Srbds:                 Not affected
  Tsx async abort:       Not affected

According to kernel commit below
commit 81ac7e5d741742d650b4ed6186c4826c1a0631a7
Author: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Date:   Wed Jul 12 19:43:14 2023 -0700

    KVM: Add GDS_NO support to KVM

    Gather Data Sampling (GDS) is a transient execution attack using
    gather instructions from the AVX2 and AVX512 extensions. This attack
    allows malicious code to infer data that was previously stored in
    vector registers. Systems that are not vulnerable to GDS will set the
    GDS_NO bit of the IA32_ARCH_CAPABILITIES MSR. This is useful for VM
    guests that may think they are on vulnerable systems that are, in
    fact, not affected. Guests that are running on affected hosts where
    the mitigation is enabled are protected as if they were running
    on an unaffected system.

    On all hosts that are not affected or that are mitigated, set the
    GDS_NO bit.

    Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

KVM also has the support of GDS_NO, but seems qemu side doesn't pass
the info to guest, that's why it is unknown. IMO qemu should pass
GDS_NO if the host is already patched.

Is Intel or anyone already working on the qemu patch? I know it's not
a must, but good to do.

Thx!
Jinpu Wang @ IONOS Cloud

