Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5367DDFB3
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 11:45:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy8hs-00057t-7f; Wed, 01 Nov 2023 06:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qy8hp-00057O-Kz; Wed, 01 Nov 2023 06:44:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qy8hn-0007gP-H6; Wed, 01 Nov 2023 06:44:13 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D605A75606C;
 Wed,  1 Nov 2023 11:44:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 547C0756062; Wed,  1 Nov 2023 11:44:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4FFC2745681;
 Wed,  1 Nov 2023 11:44:15 +0100 (CET)
Date: Wed, 1 Nov 2023 11:44:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: clg@kaod.org, Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 0/8] Misc clean ups to target/ppc exception handling
In-Reply-To: <cover.1698158152.git.balaton@eik.bme.hu>
Message-ID: <c5d4e1dd-5da9-8efe-20f4-4bcdc24357fe@eik.bme.hu>
References: <cover.1698158152.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 24 Oct 2023, BALATON Zoltan wrote:
> These are some small clean ups for target/ppc/excp_helper.c trying to
> make this code a bit simpler. No functional change is intended. This
> series was submitted before but only partially merged due to freeze
> and conflicting series os thia was postponed then to avoid conflicts.

Ping?

> v4: Rebased on master dropping what was merged
>
> BALATON Zoltan (7):
>  target/ppc: Use env_cpu for cpu_abort in excp_helper
>  target/ppc: Readability improvements in exception handlers
>  target/ppc: Fix gen_sc to use correct nip
>  target/ppc: Simplify syscall exception handlers
>  target/ppc: Clean up ifdefs in excp_helper.c, part 1
>  target/ppc: Clean up ifdefs in excp_helper.c, part 2
>  target/ppc: Clean up ifdefs in excp_helper.c, part 3
>
> Nicholas Piggin (1):
>  target/ppc: Move patching nip from exception handler to helper_scv
>
> target/ppc/cpu.h         |   1 +
> target/ppc/excp_helper.c | 420 ++++++++++++---------------------------
> target/ppc/translate.c   |  16 +-
> 3 files changed, 139 insertions(+), 298 deletions(-)
>
>

