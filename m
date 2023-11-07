Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB17E48DC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:56:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RFb-0002yx-5K; Tue, 07 Nov 2023 13:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RFH-0002vK-ER; Tue, 07 Nov 2023 13:56:21 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RFA-0003Xm-5r; Tue, 07 Nov 2023 13:56:11 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-da041ffef81so6525508276.0; 
 Tue, 07 Nov 2023 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383365; x=1699988165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UN4f5mEfXJiyLaKOEoAxkUMjUSegazNyKqwUZqktWfc=;
 b=O5E/Apv6wiOS3Tu/FON7EOPce9hxbINTkjyn8+xGt3+eUPV95KTIorBIJgFbiQMqON
 3UH2Wqz9Em7g+zgEMP+hh9Or8GPAu+ecf7fG5Qt/1qDH3chOAChgB35qkCi21J32CJOQ
 QYuNDF4FphtsK5jYCKxDQlfVtEA22dHCD6tOdQBYhqxsqViQE7GWtnMfHMAnIBxuRT/d
 foC6oj9yZIHiqcYFEBy0/siV4kNXLqKkdRi8OPYvJqOkmwemsA81cQHfvuSoN+Oz8Gvo
 gQaZcDR6HT1ZV5+DXNT+vPAfHaBLQf/ZT+3s29UX92cx1Se0yc1RZ+stzoWAjl3vCMcH
 rFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383365; x=1699988165;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UN4f5mEfXJiyLaKOEoAxkUMjUSegazNyKqwUZqktWfc=;
 b=Hta0f6vqOU9F3LXH/IFR6zIuaPWOpSTNTmCllxLcR2xIUt0+ylAKThaJRnCi2yJkY+
 jLx/PcXr7Ww17EhMmnS0x+Pyb7qivHPMU75z8CzSw+bnamZi8qfS1HlXibQM7kkF+KtU
 mUff28SBbyeozHN4G8U4nnPGEolj0rGkEZCBl03ZP1hZyVSSNDXPX3FfrE/qL5iF01j0
 4hrlIf1X5imRllj7Gam3cKaHkoysZk/XoTxJW86puzWd4v06pJLvINH3uaDEQAMq6wTe
 zo8KT5jvR/Agu9luucJVhuZEAgfIJ4zYtuVwAjwPcACwsqM1p71+y0KNvRD7Hgb8EKRs
 x+Tg==
X-Gm-Message-State: AOJu0YycvlutnShMAUmVqh/yeifCvxF17yG4bHlUrcqCUvQ211f6k9EF
 0+0quQJOVdaB1+4ghsV6jh4=
X-Google-Smtp-Source: AGHT+IEZubeOnVXbMHjetrNxJ92S+Wm4jNeUceRhYYMN52Gx9A5OhtrwiSArQdzHrFfp8UKEYHK5ig==
X-Received: by 2002:a5b:706:0:b0:d9b:3b3e:5a07 with SMTP id
 g6-20020a5b0706000000b00d9b3b3e5a07mr30858311ybq.5.1699383365529; 
 Tue, 07 Nov 2023 10:56:05 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d7b8a1074d4sm5286568ybl.57.2023.11.07.10.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:56:05 -0800 (PST)
Message-ID: <1bb57350-68a3-47af-8148-0c122eb05b16@gmail.com>
Date: Tue, 7 Nov 2023 15:56:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc: qtest already exports qtest_rtas_call()
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20231030163834.4638-1-quintela@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231030163834.4638-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=danielhb413@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queue in ppc-next after amending this in:


$ git diff
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cec01b2c92..f329693c55 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -38,7 +38,6 @@
  
  #include "hw/ppc/spapr.h"
  #include "hw/ppc/spapr_vio.h"
-#include "hw/ppc/spapr_rtas.h"
  #include "hw/ppc/spapr_cpu_core.h"
  #include "hw/ppc/ppc.h"


Gitlab complained that we were including a non-existing header.




Thanks,

Daniel

On 10/30/23 13:38, Juan Quintela wrote:
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

