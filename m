Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C3721657
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 13:21:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5lm2-0004cU-Mz; Sun, 04 Jun 2023 07:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q5llx-0004bv-5Y
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 07:19:45 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q5llu-0008Ci-4v
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 07:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Reply-To:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=05WhHvkABMxJVfTB8hAeOHJs5UW59SL7qJyEJ6+8gio=; b=VRFyeH7bpqNZJ1BmczYViGxYz3
 Pa7WSBBO//XC3+PQSt8AAWkJBfb8ULc44TZZaIHc0onlxFyQ5rmZBvMGgMXEZLMjwS61QvoOO9GDm
 eV2chvLeBkpgMteecJAtwHVADw5M7JrRQm44TC+Qf+AmD9k6d9+lB5HpAO45iLAT7IuI=;
Message-ID: <494da21f-4376-2c3c-c7de-19544a0d0f9b@rev.ng>
Date: Sun, 4 Jun 2023 13:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 20/48] tcg: Pass TCGHelperInfo to tcg_gen_callN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-21-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230531040330.8950-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SCC_BODY_URI_ONLY=1.439, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 5/31/23 06:03, Richard Henderson wrote:
> In preparation for compiling tcg/ only once, eliminate
> the all_helpers array.  Instantiate the info structs for
> the generic helpers in accel/tcg/, and the structs for
> the target-specific helpers in each translate.c.
>
> Since we don't see all of the info structs at startup,
> initialize at first use, using g_once_init_* to make
> sure we don't race while doing so.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/helper-gen.h      |  65 ++++++++++++--------
>   include/exec/helper-tcg.h      |  75 -----------------------
>   include/qemu/typedefs.h        |   1 +
>   include/tcg/helper-info.h      |   9 ++-
>   include/tcg/tcg.h              |   2 +-
>   accel/tcg/plugin-gen.c         |   5 ++
>   accel/tcg/tcg-runtime.c        |   4 ++
>   target/alpha/translate.c       |   3 +
>   target/arm/tcg/translate.c     |   3 +
>   target/avr/translate.c         |   5 ++
>   target/cris/translate.c        |   6 +-
>   target/hexagon/translate.c     |   4 ++
>   target/hppa/translate.c        |   5 ++
>   target/i386/tcg/translate.c    |   5 ++
>   target/loongarch/translate.c   |   4 ++
>   target/m68k/translate.c        |   3 +
>   target/microblaze/translate.c  |   4 ++
>   target/mips/tcg/translate.c    |   5 ++
>   target/nios2/translate.c       |   5 ++
>   target/openrisc/translate.c    |   5 ++
>   target/ppc/translate.c         |   4 ++
>   target/riscv/translate.c       |   4 ++
>   target/rx/translate.c          |   5 ++
>   target/s390x/tcg/translate.c   |   4 ++
>   target/sh4/translate.c         |   4 ++
>   target/sparc/translate.c       |   3 +
>   target/tricore/translate.c     |   5 ++
>   target/xtensa/translate.c      |   4 ++
>   tcg/tcg.c                      | 108 ++++++++++++---------------------
>   include/exec/helper-info.c.inc |  95 +++++++++++++++++++++++++++++
>   30 files changed, 279 insertions(+), 175 deletions(-)
>   delete mode 100644 include/exec/helper-tcg.h
>   create mode 100644 include/exec/helper-info.c.inc
Reviewed-by: Anton Johansson <anjo@rev.ng>

