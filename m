Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD17E0196
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 11:35:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyrVq-0001dJ-Et; Fri, 03 Nov 2023 06:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyrVo-0001YO-FF
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:34:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyrVi-0007er-6z
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:34:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so3783576a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699007679; x=1699612479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7MBSReJr7/RZobr0kARCBIFw/Mu4RNvqu9rsmDd5hJg=;
 b=Z0TF0x9zCa3yd6vN9ldg99oDritVx+Au1yLxdHmOFs+kttkLVpdMmfYc62dHQrHI6E
 PYz25inLZHaofDyafP0DcmZKYjcBR60/U4oe8h1Jr4V4gHjnb7WFy1E1UnqFZEeoMy42
 r/5K4XFwMdoyMwX0LAUa5Wbt5ZY0ToUYGVt++JaSx4BoJVgvtKQe5t5RdGqNFgFeI0me
 GQmbkSCs7Lpn8Apc02HvO6W/yhSjM+6x4yHyPn71VQsFssbgIxLCpQW1BVMNI1dm/H78
 nOLWn+zPJ2QyosgOrc7GFKOG6P0hR46e+jEgBGJDOta8B56mZSgGmlDelucXW0FitbVk
 oHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699007679; x=1699612479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7MBSReJr7/RZobr0kARCBIFw/Mu4RNvqu9rsmDd5hJg=;
 b=mqbjn8gH29motrYaZPgLLCQ6qjX/lfteuSw6d0wNscMc/a/IzZ1QLsfdXkcgcAEpv9
 EYY+JeJHvOJ0Bfak1rTtREEUSzzQQeT/ig2lPmr+Xps9DHi/00hnZL6CFH05Prh4eBM3
 i2nwr9GvQkTnXEHrf640UYDhhsagO1AxIykuIsol9yRcgrZZ4PjA4ePB1AsfFSTRZfEu
 eo7Ax2qVOVu05Hv8HnYlE1nDou3eY23YWXzpqvWgie3I4YaRxXLrzy33xLjGA9Yp7Tge
 VzrAQY2oG907JrDafGWmQZIR7BO8v3qaobiZDgABcUEuJPRJZQxjRk8E9V8fm7ZXVedO
 ZCZA==
X-Gm-Message-State: AOJu0YyjHRy29Lhg6gRMT+S+8hbtL/05a6tkOy4CzRYPGcR5iKqhKgs/
 Pcguo+FoKAdlZ+/N7WDWamDP/cGFLvmwDRdfJSCBHA==
X-Google-Smtp-Source: AGHT+IEtGI12iISl8e0E+UvxodiZaLCk75Tqo63auRf9k9szrkLajBERA0lypads4z19/pOOp8sd+jWaAeWlYhdCwnQ=
X-Received: by 2002:aa7:c75a:0:b0:533:5d3d:7efe with SMTP id
 c26-20020aa7c75a000000b005335d3d7efemr2046122eds.6.1699007679417; Fri, 03 Nov
 2023 03:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231102094015.208588-1-ethan84@andestech.com>
 <20231102094015.208588-2-ethan84@andestech.com> <ZUOo3fGmqM/gVyTR@x1n>
 <CAFEAcA86B-V0gFLhE9rPK2kG=XeFw7OJ4C==8g2i_WHSLW_HYQ@mail.gmail.com>
 <ZURpIyjhraORROn5@ethan84-VirtualBox>
In-Reply-To: <ZURpIyjhraORROn5@ethan84-VirtualBox>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 10:34:28 +0000
Message-ID: <CAFEAcA-1dJnsDyZpf2Dy9XuAdp6CFWSFCzV7eceUJ6RyFLaVPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start address, 
 end address to MemTxAttrs
To: Ethan Chen <ethan84@andestech.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, 
 pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 in.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 3 Nov 2023 at 03:29, Ethan Chen <ethan84@andestech.com> wrote:
>
> On Thu, Nov 02, 2023 at 01:53:05PM +0000, Peter Maydell wrote:
> > On Thu, 2 Nov 2023 at 13:49, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Nov 02, 2023 at 05:40:12PM +0800, Ethan Chen wrote:
> > > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > > ---
> > > >  include/exec/memattrs.h | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> > > > index d04170aa27..fc15e5d7d3 100644
> > > > --- a/include/exec/memattrs.h
> > > > +++ b/include/exec/memattrs.h
> > > > @@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
> > > >      unsigned int target_tlb_bit0 : 1;
> > > >      unsigned int target_tlb_bit1 : 1;
> > > >      unsigned int target_tlb_bit2 : 1;
> > > > +
> > > > +    /* IOPMP support up to 65535 sources */
> > > > +    unsigned int iopmp_sid:16;
> > >
> > > There's MemTxAttrs.requester_id, SID for pci, same length.  Reuse it?
> > >
> > > > +    /* Transaction infomation for IOPMP */
> > > > +    unsigned long long iopmp_start_addr;
> > > > +    unsigned long long iopmp_end_addr;
> > >
> > > PS: encoding addresses into memattrs is.. strange, but since I know nothing
> > > about iopmp, I'll leave that for other reviewers.
> > >
> > > Currently MemTxAttrs are passed as a whole int on the stack, if it keeps
> > > growing we may start to consider a pointer, but need to check the side
> > > effects of unexpected fields modified within a call.
> >
> > Yeah, this struct is intended to model the various attributes that
> > get passed around on the bus alongside data in real hardware.
> > I'm pretty sure no real hardware is passing around start and
> > end transaction addresses on its bus with every read and
> > write, which suggests that we should be doing this some other
> > way than adding these fields to the MemTxAttrs struct.
>
> For AXI bus ADDR, LEN, SIZE are signals in read/write address channel.
> IOPMP will check that start address = ADDR,
> and end address = ADDR + LEN * SIZE.

Yes, but you don't pass the start and end address on the AXI
bus, so they don't go in QEMU's MemTxAttrs either.

thanks
-- PMM

