Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A07EF6FD
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 18:34:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r42ik-0004h4-8X; Fri, 17 Nov 2023 12:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=h+oX=G6=gmx.de=deller@kernel.org>)
 id 1r42ii-0004gw-KU
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:33:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=h+oX=G6=gmx.de=deller@kernel.org>)
 id 1r42ig-0005Qm-G4
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:33:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 75420CE2493;
 Fri, 17 Nov 2023 17:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A5CC433C7;
 Fri, 17 Nov 2023 17:33:22 +0000 (UTC)
Date: Fri, 17 Nov 2023 18:33:20 +0100
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 2/2] disas/hppa: Show hexcode of instruction along
 with disassembly
Message-ID: <ZVej4L9FHe9zZF9A@p100>
References: <20231117105309.149225-1-deller@kernel.org>
 <20231117105309.149225-3-deller@kernel.org>
 <6e256fa7-69eb-47de-a06b-f99d66318918@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e256fa7-69eb-47de-a06b-f99d66318918@linaro.org>
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=SRS0=h+oX=G6=gmx.de=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> On 11/17/23 02:53, deller@kernel.org wrote:
> > From: Helge Deller <deller@gmx.de>
> > 
> > On hppa many instructions can be expressed by different bytecodes.
> > To be able to debug qemu translation bugs it's therefore necessary to see the
> > currently executed byte codes without the need to lookup the sequence without
> > the full executable.
> > With this patch the instruction byte code is shown beside the disassembly.
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > ---
> >   disas/hppa.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/disas/hppa.c b/disas/hppa.c
> > index dcf9a47f34..38fc05acc4 100644
> > --- a/disas/hppa.c
> > +++ b/disas/hppa.c
> > @@ -1979,6 +1979,9 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
> >   	  if (opcode->arch == pa20w)
> >   	    continue;
> >   #endif
> > +	  (*info->fprintf_func) (info->stream, " %02x %02x %02x %02x   ",
> > +                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
> > +                (insn >>  8) & 0xff, insn & 0xff);
> >   	  (*info->fprintf_func) (info->stream, "%s", opcode->name);
> >   	  if (!strchr ("cfCY?-+nHNZFIuv{", opcode->args[0]))
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> A possible improvement is to push this outside of the search loop and then change
> 
>      }
> -  (*info->fprintf_func) (info->stream, "#%8x", insn);
> +  info->fprintf_func(info->stream, "<unknown>");
>    return sizeof (insn);
> 
> so the byte decode is shared with the rare case of garbage in the insn stream.

Like below?

From: Helge Deller <deller@gmx.de>
Subject: [PATCH] disas/hppa: Show hexcode of instruction along with
 disassembly

On hppa many instructions can be expressed by different bytecodes.
To be able to debug qemu translation bugs it's therefore necessary to see the
currently executed byte codes without the need to lookup the sequence without
the full executable.
With this patch the instruction byte code is shown beside the disassembly.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/disas/hppa.c b/disas/hppa.c
index dcf9a47f34..cce4f4aa37 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1968,6 +1968,10 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 
   insn = bfd_getb32 (buffer);
 
+  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
+                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
+                (insn >>  8) & 0xff, insn & 0xff);
+
   for (i = 0; i < NUMOPCODES; ++i)
     {
       const struct pa_opcode *opcode = &pa_opcodes[i];
@@ -2826,6 +2830,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 	  return sizeof (insn);
 	}
     }
-  (*info->fprintf_func) (info->stream, "#%8x", insn);
+  info->fprintf_func(info->stream, "<unknown>");
   return sizeof (insn);
 }

