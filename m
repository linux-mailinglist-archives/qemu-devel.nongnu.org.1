Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD373B90E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCh7l-0008IC-6T; Fri, 23 Jun 2023 09:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCh7i-0008H2-Ub; Fri, 23 Jun 2023 09:46:50 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCh7g-0005jl-MV; Fri, 23 Jun 2023 09:46:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qndnc2xndz4x04;
 Fri, 23 Jun 2023 23:46:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QndnY4tBWz4wgm;
 Fri, 23 Jun 2023 23:46:41 +1000 (AEST)
Message-ID: <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org>
Date: Fri, 23 Jun 2023 15:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Content-Language: en-US
To: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com
References: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Anushree,

On 6/23/23 13:09, Anushree Mathur wrote:
> Hi everyone,
> 
> I was trying to boot rhel9.3 image with upstream qemu-system-ppc64 -smp 2 option and observed a segfault (qemu crash).
> 
> qemu command line used:
> 
> qemu-system-ppc64 -name Rhel9.3.ppc64le -smp 2 -m 16G -vga none -nographic -machine pseries -cpu POWER10 -accel tcg -device virtio-scsi-pci -drive file=/home/rh93.qcow2,if=none,format=qcow2,id=hd0 -device scsi-hd,drive=hd0 -boot c
> 
> After doing a git bisect, I found the first bad commit which introduced this issue is below:

Could you please open a gitlab issue on QEMU project ?

  https://gitlab.com/qemu-project/qemu/-/issues

Thanks,

C.

> [qemu]# git bisect good
> 20b6643324a79860dcdfe811ffe4a79942bca21e is the first bad commit
> commit 20b6643324a79860dcdfe811ffe4a79942bca21e
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Dec 5 17:45:02 2022 -0600
> 
>      tcg/ppc: Reorg goto_tb implementation
> 
>      The old ppc64 implementation replaces 2 or 4 insns, which leaves a race
>      condition in which a thread could be stopped at a PC in the middle of
>      the sequence, and when restarted does not see the complete address
>      computation and branches to nowhere.
> 
>      The new implemetation replaces only one insn, swapping between
> 
>              b       <dest>
>      and
>              mtctr   r31
> 
>      falling through to a general-case indirect branch.
> 
>      Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>   tcg/ppc/tcg-target.c.inc | 152 +++++++++++++----------------------------------
>   tcg/ppc/tcg-target.h     |   3 +-
>   2 files changed, 41 insertions(+), 114 deletions(-)
> [qemu]#
> 
> Can someone please take a look and suggest a fix to resolve this issue?
> 
> Thanks in advance.
> Regards,
> Anushree-Mathur
> 
> 


