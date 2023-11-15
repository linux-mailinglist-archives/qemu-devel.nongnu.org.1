Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50B7DFE69
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qykss-00005L-Dx; Thu, 02 Nov 2023 23:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qyksi-0008W4-0g; Thu, 02 Nov 2023 23:30:00 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qyksg-0008O3-34; Thu, 02 Nov 2023 23:29:59 -0400
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3A33TfPW039862;
 Fri, 3 Nov 2023 11:29:41 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Fri, 3 Nov 2023
 11:29:39 +0800
Date: Fri, 3 Nov 2023 11:29:39 +0800
To: Peter Maydell <peter.maydell@linaro.org>
CC: Peter Xu <peterx@redhat.com>, <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <in.meng@windriver.com>, <liweiwei@iscas.ac.cn>,
 <dbarboza@ventanamicro.com>, <hiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, <david@redhat.com>
Subject: Re: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start
 address, end address to MemTxAttrs
Message-ID: <ZURpIyjhraORROn5@ethan84-VirtualBox>
References: <20231102094015.208588-1-ethan84@andestech.com>
 <20231102094015.208588-2-ethan84@andestech.com>
 <ZUOo3fGmqM/gVyTR@x1n>
 <CAFEAcA86B-V0gFLhE9rPK2kG=XeFw7OJ4C==8g2i_WHSLW_HYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA86B-V0gFLhE9rPK2kG=XeFw7OJ4C==8g2i_WHSLW_HYQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3A33TfPW039862
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 02, 2023 at 01:53:05PM +0000, Peter Maydell wrote:
> On Thu, 2 Nov 2023 at 13:49, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Nov 02, 2023 at 05:40:12PM +0800, Ethan Chen wrote:
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  include/exec/memattrs.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> > > index d04170aa27..fc15e5d7d3 100644
> > > --- a/include/exec/memattrs.h
> > > +++ b/include/exec/memattrs.h
> > > @@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
> > >      unsigned int target_tlb_bit0 : 1;
> > >      unsigned int target_tlb_bit1 : 1;
> > >      unsigned int target_tlb_bit2 : 1;
> > > +
> > > +    /* IOPMP support up to 65535 sources */
> > > +    unsigned int iopmp_sid:16;
> >
> > There's MemTxAttrs.requester_id, SID for pci, same length.  Reuse it?
> >
> > > +    /* Transaction infomation for IOPMP */
> > > +    unsigned long long iopmp_start_addr;
> > > +    unsigned long long iopmp_end_addr;
> >
> > PS: encoding addresses into memattrs is.. strange, but since I know nothing
> > about iopmp, I'll leave that for other reviewers.
> >
> > Currently MemTxAttrs are passed as a whole int on the stack, if it keeps
> > growing we may start to consider a pointer, but need to check the side
> > effects of unexpected fields modified within a call.
> 
> Yeah, this struct is intended to model the various attributes that
> get passed around on the bus alongside data in real hardware.
> I'm pretty sure no real hardware is passing around start and
> end transaction addresses on its bus with every read and
> write, which suggests that we should be doing this some other
> way than adding these fields to the MemTxAttrs struct.

For AXI bus ADDR, LEN, SIZE are signals in read/write address channel.
IOPMP will check that start address = ADDR, 
and end address = ADDR + LEN * SIZE.

Thanks,
Ethan Chen




