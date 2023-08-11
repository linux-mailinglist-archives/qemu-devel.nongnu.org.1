Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4C778E67
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 13:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUQkA-0000UN-6n; Fri, 11 Aug 2023 07:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qUQk7-0000Sr-6D
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 07:55:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qUQk5-0000TQ-An
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 07:55:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso16547615e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691754943; x=1692359743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBH8lb1rwU4oToIYPsbTVlYzrCoxfP+0IPvEOTa6IwE=;
 b=QoTvAUqfqz6ZCaTsOD7ZPNzcIhqWn0bDzOglnLMbk0A7n8aRZHnbv1k34FrHMvaH96
 ajZw69zH/NtPVbYMtN3cFdoHanVRUjfLK4ecoueXZU6xtY1J9o7amhXTUzxA5wRUsIRZ
 y4MgAe8xsZJTdN5SF5H7hY6S3IwyjpYTHNgm4MnCkWLKZm/6gbOuoKC60UD6h6qadYrZ
 N2mV19xdRcLkUkIH17WmfNkSUdQ+DOvuWe3reSqmHfi+gA4c8RvI2oCkXJiXM5J2kXJo
 Ivbur+Sb0M3JxzGmA/vNobQhScfl04ocpMZsZXDhgpiVZhtKbWpSTCRTzHXMyj/ND0HP
 txMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691754943; x=1692359743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBH8lb1rwU4oToIYPsbTVlYzrCoxfP+0IPvEOTa6IwE=;
 b=YXAKUeyd9UkBo1SmWCR94ALFmJgxFsaz3izYKINHSXkzbt57gRcaRJ4gMWnq/1S3Mc
 lUXFPCrIu4EyjLQkohjI/DnMaQDhxd3OLGNPRpmBpXxaAhkh8ZCzEDqrxWDbW0DcsksB
 zBD34tpblLHHSzs2g/RyMLA+S094tAAZLVfrha8M+FAvx7weojYxQTzwoq0Sd81lRuxW
 AJNrgl77nLw7RUg3f+rz96kV/hpQ1SW1hSo9f/t8CPH4tzzO78bQ8RDFwSl6MLO5Jt/N
 PjnDITGktmmcMhYVg8FjO/ylk2HFxoIRbvL39TVd7n0Jdk1W+Y+8cmPZcc/xQVPoV8GF
 L4bg==
X-Gm-Message-State: AOJu0YwbBn6Uh+X4lAishK1lAfUhMHp1CH7XoQjlAZWRY1boeo13jX5u
 FxbpZGwUMUAHxGWiMS1W2OgqJA==
X-Google-Smtp-Source: AGHT+IHn74MfjIO2ERAewJy8jSzfSq0Z+pRijL8WBrzliqcr5q6SOwen5wu8w/RBX259G28UwIKv7w==
X-Received: by 2002:adf:f0ca:0:b0:314:3954:7ff6 with SMTP id
 x10-20020adff0ca000000b0031439547ff6mr1187482wro.56.1691754943231; 
 Fri, 11 Aug 2023 04:55:43 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a5d684a000000b0031758e7ba6dsm5164924wrw.40.2023.08.11.04.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 04:55:42 -0700 (PDT)
Date: Fri, 11 Aug 2023 13:55:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: rbagley@ventanamicro.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
Message-ID: <20230811-52e2c90dc3b91e108eb5e4e8@orel>
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-bc15b48d336b79d9ec1f0936@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x343.google.com
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

On Fri, Aug 11, 2023 at 10:25:52AM +0200, Andrew Jones wrote:
> On Thu, Aug 10, 2023 at 06:27:50PM +0200, Andrew Jones wrote:
> > On Thu, Aug 10, 2023 at 09:12:42AM -0700, Palmer Dabbelt wrote:
> > > On Thu, 10 Aug 2023 08:31:46 PDT (-0700), ajones@ventanamicro.com wrote:
> > > > On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagley wrote:
> > > > > The recent commit 36df75a0a9 corrected one aspect of LUI disassembly
> > > > > by recovering the immediate argument from the result of LUI with a
> > > > > shift right by 12. However, the shift right will left-fill with the
> > > > > sign. By applying a mask we recover an unsigned representation of the
> > > > > 20-bit field (which includes a sign bit).
> > > > > 
> > > > > Example:
> > > > > 0xfffff000 >> 12 = 0xffffffff
> > > > > 0xfffff000 >> 12 & 0xfffff = 0x000fffff
> > > > > 
> > > > > Fixes: 36df75a0a9 ("riscv/disas: Fix disas output of upper immediates")
> > > > > Signed-off-by: Richard Bagley <rbagley@ventanamicro.com>
> > > > > ---
> > > > >  disas/riscv.c | 9 ++++++---
> > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/disas/riscv.c b/disas/riscv.c
> > > > > index 4023e3fc65..690eb4a1ac 100644
> > > > > --- a/disas/riscv.c
> > > > > +++ b/disas/riscv.c
> > > > > @@ -4723,9 +4723,12 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
> > > > >              break;
> > > > >          case 'U':
> > > > >              fmt++;
> > > > > -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
> > > > > -            append(buf, tmp, buflen);
> > > > > -            if (*fmt == 'o') {
> > > > > +            if (*fmt == 'i') {
> > > > > +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12 & 0xfffff);
> > > > 
> > > > Why are we correcting LUI's output, but still outputting sign-extended
> > > > values for AUIPC?
> > > > 
> > > > We can't assemble 'auipc a1, 0xffffffff' or 'auipc a1, -1' without getting
> > > > 
> > > >  Error: lui expression not in range 0..1048575
> > > > 
> > > > (and additionally for 0xffffffff)
> > > > 
> > > >  Error: value of 00000ffffffff000 too large for field of 4 bytes at 0000000000000000
> > > > 
> > > > either.
> > > > 
> > > > (I see that the assembler's error messages state 'lui', but I was trying
> > > > 'auipc'.)
> > > > 
> > > > I'm using as from gnu binutils 2.40.0.20230214.
> > > > 
> > > > (And, FWIW, I agree with Richard Henderson that these instructions should
> > > > accept negative values.)
> > > 
> > > I'm kind of lost here, and you saying binutils rejects this syntax?  If
> > > that's the case it's probably just an oversight, can you file a bug in
> > > binutils land so folks can see?
> > 
> > Will do.
> >
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=30746
>

But, to try to bring this thread back to the patch under review. While the
binutils BZ may address our preferred way of providing immediates to the
assembler, this patch is trying to make QEMU's output consistent with
objdump. Since objdump always outputs long immediate values as hex, then
it doesn't need to care about negative signs. QEMU seems to prefer
decimal, though, and so does llvm-objdump, which outputs values for these
instructions in the range 0..1048575. So, I guess this patch is making
QEMU consistent with llvm-objdump.

Back to making suggestions for this patch...

1. The commit message should probably say something along the lines of
   what I just wrote in the preceding paragraph to better explain the
   motivation.

2. Unless I'm missing something, then this patch should also address
   AUIPC.

Thanks,
drew

