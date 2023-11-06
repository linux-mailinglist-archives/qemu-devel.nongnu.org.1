Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B97E1E75
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:35:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwwh-0007W7-8h; Mon, 06 Nov 2023 05:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qzwwc-0007VR-9C
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:34:58 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qzwwY-0006ZY-LY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:34:58 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo7022519a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699266892; x=1699871692; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zbf7X3lNTx2tNFEjIoUycJCq05+us145GWumPbZLqPo=;
 b=Y4z+b9MNT+SZ4VJ58HuzmE32iaoatKl+Fp9ZEtm86N1+PdMBRTCxi/HxNFXhaohG0e
 QGkClznNIlPuo/RAd4e9hgGVwGJMXwO3FREEAIIWBSJlc9F7+XEAZ9BIojF4YLHYUFBA
 U+nekbG7LHgtw4w8oJMFhB2lXm2Ur/wO9tygpjXAmRY+yMZe4gKB7zhQOj51XQAiY8SQ
 rOkvQaU11BX8N1OChpJVViVasg7EI8HzH2iml1cNnaLwPWexhjNw/WSTvzIrfjf5rHYm
 X/bVIs+vPT52517eA8us/1tMdq5qFZkkVUKyVIDe0RtjGINdY0c9AkJQOkPK/BUguSGr
 2/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699266892; x=1699871692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zbf7X3lNTx2tNFEjIoUycJCq05+us145GWumPbZLqPo=;
 b=u67JNQQYHfKk7gkbc7946WyUaO9rgBiX6RSMnrIkqxCopwFSx4nZzIlJjeqhI7lUpb
 sRVPqMGoWNiCPZS+qhmh4V2owo8R1qxGDfJovHwLFb8SAw76hc88yG6I7EgGS6k9T7sb
 lV1+9MINuQJsOLrR2XcwGUPETbdOz26pHkyfchs33xKktPKtzIl8uHwoxuC02BJcpaIC
 SuQ7XSZsM4r3XAPNBhnJ4hPNgosHcfQzcuu9ES/ZHkH11PIQgiMYk0hWVDOVOYjYVf/v
 zZ2uBFV1Htt1ggcfHQH0gAjA6wMhDqNvIaFWHRRMFmDayMpzAWsljr2zBTJ/jLTCCUF8
 86iw==
X-Gm-Message-State: AOJu0Yydg5uY2v5DOrRNrvDSrSDsbB4Eubw9JydG1ZLlPQEAEe26xm8I
 Jii8DY8MPrgEjn67J8q3T00I7MjFHnmtWyVnZKBTTw==
X-Google-Smtp-Source: AGHT+IHaHCV25nWbJsj5oQ3tVP2gHlxGX6zufRNMUQmB+qyq2YsAh09utPl2UZJMiIsrRGRxBd0W5MHKrmi3zW1b0ns=
X-Received: by 2002:a05:6402:1a39:b0:540:e598:a35f with SMTP id
 be25-20020a0564021a3900b00540e598a35fmr24343605edb.5.1699266892345; Mon, 06
 Nov 2023 02:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20231102094015.208588-1-ethan84@andestech.com>
 <20231102094015.208588-2-ethan84@andestech.com> <ZUOo3fGmqM/gVyTR@x1n>
 <CAFEAcA86B-V0gFLhE9rPK2kG=XeFw7OJ4C==8g2i_WHSLW_HYQ@mail.gmail.com>
 <ZURpIyjhraORROn5@ethan84-VirtualBox>
 <CAFEAcA-1dJnsDyZpf2Dy9XuAdp6CFWSFCzV7eceUJ6RyFLaVPA@mail.gmail.com>
 <ZUhH3Rulnj64whB4@ethan84-VirtualBox>
In-Reply-To: <ZUhH3Rulnj64whB4@ethan84-VirtualBox>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2023 10:34:41 +0000
Message-ID: <CAFEAcA_z1VCyeUFNMDSsxp-UYRLoMm-4=oo86JkJ3fmjoWdq_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start address, 
 end address to MemTxAttrs
To: Ethan Chen <ethan84@andestech.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, 
 pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 in.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 6 Nov 2023 at 01:57, Ethan Chen <ethan84@andestech.com> wrote:
>
> On Fri, Nov 03, 2023 at 10:34:28AM +0000, Peter Maydell wrote:
> > On Fri, 3 Nov 2023 at 03:29, Ethan Chen <ethan84@andestech.com> wrote:
> > >
> > > On Thu, Nov 02, 2023 at 01:53:05PM +0000, Peter Maydell wrote:
> > > > On Thu, 2 Nov 2023 at 13:49, Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Thu, Nov 02, 2023 at 05:40:12PM +0800, Ethan Chen wrote:
> > > > > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > > > > ---
> > > > > >  include/exec/memattrs.h | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> > > > > > index d04170aa27..fc15e5d7d3 100644
> > > > > > --- a/include/exec/memattrs.h
> > > > > > +++ b/include/exec/memattrs.h
> > > > > > @@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
> > > > > >      unsigned int target_tlb_bit0 : 1;
> > > > > >      unsigned int target_tlb_bit1 : 1;
> > > > > >      unsigned int target_tlb_bit2 : 1;
> > > > > > +
> > > > > > +    /* IOPMP support up to 65535 sources */
> > > > > > +    unsigned int iopmp_sid:16;
> > > > >
> > > > > There's MemTxAttrs.requester_id, SID for pci, same length.  Reuse it?
> > > > >
> > > > > > +    /* Transaction infomation for IOPMP */
> > > > > > +    unsigned long long iopmp_start_addr;
> > > > > > +    unsigned long long iopmp_end_addr;
> > > > >
> > > > > PS: encoding addresses into memattrs is.. strange, but since I know nothing
> > > > > about iopmp, I'll leave that for other reviewers.
> > > > >
> > > > > Currently MemTxAttrs are passed as a whole int on the stack, if it keeps
> > > > > growing we may start to consider a pointer, but need to check the side
> > > > > effects of unexpected fields modified within a call.
> > > >
> > > > Yeah, this struct is intended to model the various attributes that
> > > > get passed around on the bus alongside data in real hardware.
> > > > I'm pretty sure no real hardware is passing around start and
> > > > end transaction addresses on its bus with every read and
> > > > write, which suggests that we should be doing this some other
> > > > way than adding these fields to the MemTxAttrs struct.
> > >
> > > For AXI bus ADDR, LEN, SIZE are signals in read/write address channel.
> > > IOPMP will check that start address = ADDR,
> > > and end address = ADDR + LEN * SIZE.
> >
> > Yes, but you don't pass the start and end address on the AXI
> > bus, so they don't go in QEMU's MemTxAttrs either.
>
> I will add those AXI bus signals to MemTxAttrs instead of using start and end
> address in next revision.

What AXI bus signals? You already get address and size in the
actual memory transaction, they don't need to go in the MemTxAttrs.

thanks
-- PMM

