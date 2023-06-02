Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626A720075
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q532U-0004hH-LC; Fri, 02 Jun 2023 07:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q532S-0004h8-QP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:33:48 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q532Q-0006r4-Rr
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Reply-To:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l+hEgOKkrnno4+yZyruFB4BbpR7XYTho2lzaxFo+hBw=; b=vABCb6XXOOC4XitVd+ONd2+jqr
 6NB413ig7C9fpJ9vUsHAsQclfhgwSmwcW6o6C6qjttLhMhrsjtYQ4mrr93LpUgMtDfjA6c18aC2tC
 UvBqQahh1I3950XQ0y2sRozDhGgDG2tpLZFuFsl1FM+12NGWt6U5T/DizGF0GJS+SY3E=;
Message-ID: <8fc7cac9-9ece-7702-3c10-cec5d31931e2@rev.ng>
Date: Fri, 2 Jun 2023 13:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 06/48] tcg: Widen CPUTLBEntry comparators to 64-bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-7-richard.henderson@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <20230531040330.8950-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 SCC_BODY_URI_ONLY=0.666, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 5/31/23 06:02, Richard Henderson wrote:
> This makes CPUTLBEntry agnostic to the address size of the guest.
> When 32-bit addresses are in effect, we can simply read the low
> 32 bits of the 64-bit field.  Similarly when we need to update
> the field for setting TLB_NOTDIRTY.
>
> For TCG backends that could in theory be big-endian, but in
> practice are not (arm, loongarch, riscv), use QEMU_BUILD_BUG_ON
> to document and ensure this is not accidentally missed.
>
> For s390x, which is always big-endian, use HOST_BIG_ENDIAN anyway,
> to document the reason for the adjustment.
>
> For sparc64 and ppc64, always perform a 64-bit load, and rely on
> the following 32-bit comparison to ignore the high bits.
>
> Rearrange mips and ppc if ladders for clarity.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-defs.h          | 37 +++++++++++---------------------
>   include/exec/cpu_ldst.h          | 19 ++++++++++------
>   accel/tcg/cputlb.c               |  8 +++++--
>   tcg/aarch64/tcg-target.c.inc     |  1 +
>   tcg/arm/tcg-target.c.inc         |  1 +
>   tcg/loongarch64/tcg-target.c.inc |  1 +
>   tcg/mips/tcg-target.c.inc        | 13 ++++++-----
>   tcg/ppc/tcg-target.c.inc         | 28 +++++++++++++-----------
>   tcg/riscv/tcg-target.c.inc       |  1 +
>   tcg/s390x/tcg-target.c.inc       |  1 +
>   tcg/sparc64/tcg-target.c.inc     |  8 +++++--
>   11 files changed, 67 insertions(+), 51 deletions(-)
Reviewed-by: Anton Johansson <anjo@rev.ng>

