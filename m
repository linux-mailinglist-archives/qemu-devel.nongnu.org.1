Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CE7A0BF3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqOV-0000fs-Pk; Thu, 14 Sep 2023 13:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOQ-0000bk-2r
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOO-0006yS-6e
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fb7fb537dso1158715b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713478; x=1695318278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W+VTyNmbt72ImfVbZmqWcSdjdmdd6W12HDDJbibJtxU=;
 b=EYW8gHXvjr9f8gxOVco56E4zXdmCK+1Ohhah2AKWVz8sJ893AeYMx/42xTyoNaZRcK
 M/Vf/LcynYnkcWdOYl6Mq8VYqHMBbMIkWoj2vqOigSqhpyNCz0VDj/eNkSRkAXHmJ9xL
 JK8kwSfBInwNUNLUC/1Dzr0m5glMqJ4VRIzU/LejOoDin3tEWRLdUbPhi4QGxBq+7dJS
 wjhY3U2B+h3nc2LF/jpJZ7sFO+y3MIbYzH/kRloC3UGnVCdgLJGh90ILHEY0z1bBQikM
 xoGX0Ovh7mTSy3i0DHpFlhHC72Irw1cg0PgTVt1r72QoPZlGyu9GVK4/1N3I9A5J/xPr
 PoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713478; x=1695318278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+VTyNmbt72ImfVbZmqWcSdjdmdd6W12HDDJbibJtxU=;
 b=WT9Cv1fJe9JxRThyT5/bo88c0aVgp+J4jGqul83YW068FQL6vgrKhdme44uF5MgDje
 IcGF12kxAmFp8S4BghYgunnOJ3x6lqjunh+brAVtKM3nWqdGN0IH2Cos43/CMFBJF3DZ
 C1GezGnA5D2prKmYwY36WsLoxbjzLbeewYiz8K8yLq92lIsoSZv2k0nz5zCXtODnEH0+
 QU1TwVmGABkinhA35vOVSKrHT+/7hH8KtAPDAcf+tGbFlByEz3e+0aLIGcGnav9mRh06
 Hx/1jGXiLf6VuV99zNDQGL7sKAZjExCuN6LotvXAGf9tG5NajzSYrnsgOEi0i9N2p4Q5
 4CpQ==
X-Gm-Message-State: AOJu0YxmIGwKzVAS40dewsNQrPgIooR4/2vTF59+Qu/fAUZso4bpXi8p
 3ALZjUz3eiLbix4oWsv0SvTM9hytLcBFXrlmIKg=
X-Google-Smtp-Source: AGHT+IHjnqjdltsGI9H8Np7atC+7NpQDrwl+QXt/nYOFVyWUAaGyCEGSJsf0t1ux3hgLkx5Bv9O3yQ==
X-Received: by 2002:a05:6a21:329c:b0:12e:98a3:77b7 with SMTP id
 yt28-20020a056a21329c00b0012e98a377b7mr7240084pzb.59.1694713477687; 
 Thu, 14 Sep 2023 10:44:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0068c5bd3c3b4sm1588933pfn.206.2023.09.14.10.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:44:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 0/6] accel/tcg: Always require can_do_io (#1866)
Date: Thu, 14 Sep 2023 10:44:30 -0700
Message-Id: <20230914174436.1597356-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The problem exposed by the fix for #1826 (et al) is that the TB that
contains the i/o instruction that alters the address space continues
on to issue other i/o instructions.

Since #1826 deferred the update to the address space, these subsequent
i/o instructions do not reference the correct address space, and things
go awry from there.

Ideally we would treat changes to the address space as specially, but
that knowledge is buried quite far down in the device models.  We don't
find out that such a change is coming until quite late such that we
cannot undo all of the other side effects and start over.

The only alternative would seem to be to treat all i/o pesimistically
and end the TB after any i/o, exactly as we do for icount.

I'm not pleased about this, because an eyeball of avocado times
suggests a slowdown.  No doubt caused by most i/o having to go
through cpu_io_recompile.

I begin to wonder if #1826 should be solved differently, like *not*
caching MemoryRegionSections within the cpu tlb, and looking up the
physical address within the address space during the i/o itself.
But even that seems like it would work only for the more common case
where the address space reorg only changes devices.  For the odd case
where an address space reorg changes RAM, we still have the result
of the phys addr lookup cached via the adjustment to host memory.

So this seems like the most reasonable solution.

Follow-up patches could optimize setting of can_do_io, and replace
previous TranslationBlocks so that we only go through cpu_io_recompile
once for a particular bit of guest code, rather than every single time.


r~


Richard Henderson (6):
  accel/tcg: Avoid load of icount_decr if unused
  accel/tcg: Hoist CF_MEMI_ONLY check outside translation loop
  accel/tcg: Track current value of can_do_io in the TB
  accel/tcg: Improve setting of can_do_io at start of TB
  accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
  accel/tcg: Always require can_do_io

 include/exec/translator.h   |  2 ++
 accel/tcg/cpu-exec.c        |  2 +-
 accel/tcg/tb-maint.c        |  6 ++--
 accel/tcg/translator.c      | 72 ++++++++++++++++++-------------------
 target/mips/tcg/translate.c |  1 -
 5 files changed, 41 insertions(+), 42 deletions(-)

-- 
2.34.1


