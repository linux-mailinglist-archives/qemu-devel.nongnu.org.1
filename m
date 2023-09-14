Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBA47A01A0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:25:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjWl-0007td-Kj; Thu, 14 Sep 2023 06:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjWi-0007q7-Mt
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:24:48 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjWh-0002L8-Dn
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ol20vlYk3jx0fedYiAcumpE3/heB57WlhbUSi/y5mGI=; b=fUnQVoPXvZDn0oHI2cOni6DIPr
 Ph1W7JTepoLJ1NQkP9NrkLTytAfdlRWHSPxbxaqREvhfNh3V9cGGfW14hd7vOMw2GI8Cb1n8NQdSK
 44AR/lszHvJQUJDi+MsBe08iltbtsZRQWbEk8+OFRRqUh9viTA61q4bS1Mv39N1c93ew=;
Message-ID: <7297f45e-1b96-4689-9cad-18282bd1cba7@rev.ng>
Date: Thu, 14 Sep 2023 12:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] accel/tcg: Move CPUNegativeOffsetState into
 CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-9-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 04:44, Richard Henderson wrote:
> Retain the separate structure to emphasize its importance.
> Enforce CPUArchState always follows CPUState without padding.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h    | 22 +++++++++-------------
>   include/hw/core/cpu.h     | 14 ++++++++++++--
>   target/alpha/cpu.h        |  1 -
>   target/arm/cpu.h          |  1 -
>   target/avr/cpu.h          |  1 -
>   target/cris/cpu.h         |  1 -
>   target/hexagon/cpu.h      |  2 +-
>   target/hppa/cpu.h         |  1 -
>   target/i386/cpu.h         |  1 -
>   target/loongarch/cpu.h    |  1 -
>   target/m68k/cpu.h         |  1 -
>   target/microblaze/cpu.h   |  6 +++---
>   target/mips/cpu.h         |  4 ++--
>   target/nios2/cpu.h        |  1 -
>   target/openrisc/cpu.h     |  1 -
>   target/ppc/cpu.h          |  1 -
>   target/riscv/cpu.h        |  2 +-
>   target/rx/cpu.h           |  1 -
>   target/s390x/cpu.h        |  1 -
>   target/sh4/cpu.h          |  1 -
>   target/sparc/cpu.h        |  1 -
>   target/tricore/cpu.h      |  1 -
>   target/xtensa/cpu.h       |  3 +--
>   accel/tcg/translate-all.c |  4 ++--
>   accel/tcg/translator.c    |  8 ++++----
>   25 files changed, 35 insertions(+), 46 deletions(-)
>
Reviewed-by: Anton Johansson <anjo@rev.ng>

