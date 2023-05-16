Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF16704F8A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyuvG-0008Nr-FX; Tue, 16 May 2023 09:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pyuuu-0008HZ-2J; Tue, 16 May 2023 09:40:44 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pyuup-0002bh-Kk; Tue, 16 May 2023 09:40:38 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-55a64f0053fso205112577b3.3; 
 Tue, 16 May 2023 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684244433; x=1686836433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bfnPYpJGo4AgocZMqhh2rlk/4kAsQIs33P74mWWIMMw=;
 b=q8bNWKI1NM3zC1af4FiEWKRCsR9PSdOSLDNyupSkqRCf/R4sNgDLLWEfSFh5dgHhUk
 3TC2G27Xno/pfCfIavM6/c6KC9WFxg53bLHdZJ49HjWKwJybGdTx/xesWYxLRfmpadpj
 QBGEs/ziWNniBBujH6/BrXSo6EDRDlaepgtbGajFW9HYMwiXKKbH2kXXDoHbJLafmcw5
 2GE+4uW2aHa7uBcP58ZtEdynPPdLsQzQIYGKOSQB8O+Val/SNDO30eeK+WQrxl2cK+07
 lK1h14jhOqUhYAHnBPEYmYga1rziQX2cpT/CpVGUAvDGpOONV3yts2Ek/yimA2PCCdFT
 YYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684244433; x=1686836433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfnPYpJGo4AgocZMqhh2rlk/4kAsQIs33P74mWWIMMw=;
 b=iiZWGf9KdjKBW/1z3rdP6SLaTFkQpUqDj0ylm/aG2DCQuI0iblFzkbBnYubUdv8ZMX
 iBafRZRChKTLEAwdAFzB0zFtvP0b+Thp1zhipsKjLrGbfwZGlJ1pO4CMfAWCrJ14iafm
 kE4kW8mSUIVBZWqQkWOc03rwGkV5rOqL1NdpIfsBWv/ilLWZBfYHbvJdpD1+qtknosuM
 I5jW+sjxGfbKBNxq2iI7CPz1TrWxczBv/WowKX716otJoBp3+GD2rJFJHC3hyRRcfgfS
 62yfE5S7qtgmuuKF8a0vriVwr9mfRftEOWPTK88CSbjR/JJREXMRDMAEQoG/nE7bg8b3
 2kOA==
X-Gm-Message-State: AC+VfDwVEGF+uCFD415Q+tOP+lWM8nJb0HhV4oy7L5QN743bGZKk/Tl4
 eCKzsEPV4cnxJ7oGORZl8QWjeiS+Q++zEY472N4M32Ea
X-Google-Smtp-Source: ACHHUZ54aHknz51tnRUqUgjoK4IkhehY+O/Pog98eJ27EUyjp1289frGMl3a/N8bsnSqfs/K/KOcpZE/7THpEBjrZqY=
X-Received: by 2002:a0d:dc86:0:b0:560:befc:6682 with SMTP id
 f128-20020a0ddc86000000b00560befc6682mr19891324ywe.42.1684244433303; Tue, 16
 May 2023 06:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230516102016.581877-1-thuth@redhat.com>
In-Reply-To: <20230516102016.581877-1-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 May 2023 09:40:21 -0400
Message-ID: <CAJSP0QUMB51Y_FFx4KozwwDVJAFYmCdHvfEpNz3+aD8r0PmSng@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Fam Zheng <fam@euphon.net>, 
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 16 May 2023 at 06:20, Thomas Huth <thuth@redhat.com> wrote:
>
> We cannot use the generic reentrancy guard in the LSI code, so
> we have to manually prevent endless reentrancy here. The problematic
> lsi_execute_script() function has already a way to detect whether
> too many instructions have been executed - we just have to slightly
> change the logic here that it also takes into account if the function
> has been called too often in a reentrant way.
>
> The code in fuzz-lsi53c895a-test.c has been taken from an earlier
> patch by Mauro Matteo Cascella.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1563
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/scsi/lsi53c895a.c               |  7 ++++++-
>  tests/qtest/fuzz-lsi53c895a-test.c | 33 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 048436352b..8b34199ab8 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1134,10 +1134,13 @@ static void lsi_execute_script(LSIState *s)
>      uint32_t addr, addr_high;
>      int opcode;
>      int insn_processed = 0;
> +    static int reentrancy_level;
> +
> +    reentrancy_level++;
>
>      s->istat1 |= LSI_ISTAT1_SRUN;
>  again:
> -    if (++insn_processed > LSI_MAX_INSN) {
> +    if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {

Why 8 and not some other number?

>          /* Some windows drivers make the device spin waiting for a memory
>             location to change.  If we have been executed a lot of code then
>             assume this is the case and force an unexpected device disconnect.
> @@ -1596,6 +1599,8 @@ again:
>          }
>      }
>      trace_lsi_execute_script_stop();
> +
> +    reentrancy_level--;
>  }
>
>  static uint8_t lsi_reg_readb(LSIState *s, int offset)
> diff --git a/tests/qtest/fuzz-lsi53c895a-test.c b/tests/qtest/fuzz-lsi53c895a-test.c
> index 2012bd54b7..1b55928b9f 100644
> --- a/tests/qtest/fuzz-lsi53c895a-test.c
> +++ b/tests/qtest/fuzz-lsi53c895a-test.c
> @@ -8,6 +8,36 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>
> +/*
> + * This used to trigger a DMA reentrancy issue
> + * leading to memory corruption bugs like stack
> + * overflow or use-after-free
> + * https://gitlab.com/qemu-project/qemu/-/issues/1563
> + */
> +static void test_lsi_dma_reentrancy(void)
> +{
> +    QTestState *s;
> +
> +    s = qtest_init("-M q35 -m 512M -nodefaults "
> +                   "-blockdev driver=null-co,node-name=null0 "
> +                   "-device lsi53c810 -device scsi-cd,drive=null0");
> +
> +    qtest_outl(s, 0xcf8, 0x80000804); /* PCI Command Register */
> +    qtest_outw(s, 0xcfc, 0x7);        /* Enables accesses */
> +    qtest_outl(s, 0xcf8, 0x80000814); /* Memory Bar 1 */
> +    qtest_outl(s, 0xcfc, 0xff100000); /* Set MMIO Address*/
> +    qtest_outl(s, 0xcf8, 0x80000818); /* Memory Bar 2 */
> +    qtest_outl(s, 0xcfc, 0xff000000); /* Set RAM Address*/
> +    qtest_writel(s, 0xff000000, 0xc0000024);
> +    qtest_writel(s, 0xff000114, 0x00000080);
> +    qtest_writel(s, 0xff00012c, 0xff000000);
> +    qtest_writel(s, 0xff000004, 0xff000114);
> +    qtest_writel(s, 0xff000008, 0xff100014);
> +    qtest_writel(s, 0xff10002f, 0x000000ff);
> +
> +    qtest_quit(s);
> +}
> +
>  /*
>   * This used to trigger a UAF in lsi_do_msgout()
>   * https://gitlab.com/qemu-project/qemu/-/issues/972
> @@ -124,5 +154,8 @@ int main(int argc, char **argv)
>      qtest_add_func("fuzz/lsi53c895a/lsi_do_msgout_cancel_req",
>                     test_lsi_do_msgout_cancel_req);
>
> +    qtest_add_func("fuzz/lsi53c895a/lsi_dma_reentrancy",
> +                   test_lsi_dma_reentrancy);
> +
>      return g_test_run();
>  }
> --
> 2.31.1
>
>

