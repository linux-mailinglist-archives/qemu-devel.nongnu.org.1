Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BC7DBE32
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:43:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVL3-0002IE-N4; Mon, 30 Oct 2023 12:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hlrJ=GM=kaod.org=clg@ozlabs.org>)
 id 1qxVL0-0002I2-N3; Mon, 30 Oct 2023 12:42:02 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hlrJ=GM=kaod.org=clg@ozlabs.org>)
 id 1qxVKt-0004YO-7T; Mon, 30 Oct 2023 12:42:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SJzZ02bBfz4wb0;
 Tue, 31 Oct 2023 03:41:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJzYw2tr8z4xQf;
 Tue, 31 Oct 2023 03:41:40 +1100 (AEDT)
Message-ID: <6257f025-a000-4f89-88ae-704f51afdb73@kaod.org>
Date: Mon, 30 Oct 2023 17:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc: qtest already exports qtest_rtas_call()
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231030163834.4638-1-quintela@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231030163834.4638-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=hlrJ=GM=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/30/23 17:38, Juan Quintela wrote:
> Having two functions with the same name is a bad idea.  As spapr only
> uses the function locally, made it static.
> 
> When you compile with clang, you get this compilation error:
> 
> /usr/bin/ld: tests/qtest/libqos/libqos.fa.p/.._libqtest.c.o: in function `qtest_rtas_call':
> /scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:1195: multiple definition of `qtest_rtas_call'; libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_rtas.c.o:/scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/hw/ppc/spapr_rtas.c:536: first defined here
> clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:162: run-ninja] Error 1
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
>   include/hw/ppc/spapr_rtas.h | 10 ----------
>   hw/ppc/spapr_rtas.c         |  4 ++--
>   2 files changed, 2 insertions(+), 12 deletions(-)
>   delete mode 100644 include/hw/ppc/spapr_rtas.h
> 
> diff --git a/include/hw/ppc/spapr_rtas.h b/include/hw/ppc/spapr_rtas.h
> deleted file mode 100644
> index 383611f10f..0000000000
> --- a/include/hw/ppc/spapr_rtas.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#ifndef HW_SPAPR_RTAS_H
> -#define HW_SPAPR_RTAS_H
> -/*
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
> -                         uint32_t nret, uint64_t rets);
> -#endif /* HW_SPAPR_RTAS_H */
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 26c384b261..cec01b2c92 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -531,8 +531,8 @@ target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       return H_PARAMETER;
>   }
>   
> -uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
> -                         uint32_t nret, uint64_t rets)
> +static uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
> +                                uint32_t nret, uint64_t rets)
>   {
>       int token;
>   


