Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542657DF458
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:53:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyY8V-0001lf-07; Thu, 02 Nov 2023 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyY8P-0001ky-OE
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:53:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyY8N-0007Em-EL
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:53:21 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so1668346a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698933197; x=1699537997; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YfZWgoM1x8TQ0lnaFbcYcK+AJXVT/7K1tzc8O0CeNQs=;
 b=X2ZxS9Km8Ldn9lFKKjGyA/cnAYHsPU/Itgn5tphzrCkj/n2G0bQ04qGlAgXiEFmxFK
 ZehPdmVZJtv06PLWb+RC9vKKkXmYSeZrjILgkpfm0CVxnt+C6jPea5EQqZNBKjMjeI4F
 baeUL6WA/0IyXQdiBSh5e4ed3Dr9QJm0zvHcE7n9ra4lqw17utqoQ1Pikk4OcNRWaOvL
 XpmCUpCsZPxn6ziyr4DKiKWHn39DMBJHTptC7oMoH+Dv+ev9Uhe5AtPMHntQDn6ZIlfL
 ngNPajP5bT11GxfwItqnRfxmZP7Zj6mpumPUqoAB3WGQw7WsCYjrERwVUWCOgqDA8Hvq
 f+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698933197; x=1699537997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfZWgoM1x8TQ0lnaFbcYcK+AJXVT/7K1tzc8O0CeNQs=;
 b=OCdaUs+cp288th+jcSUZemrD1ZF9QV33jRHfsboxk6umivFsfAt7PCeQNCInPqkQlc
 EsT42QOk4k1ggp4bBFpRwoict9HjO7FvUTrwhvpIR3ErcjkfNG5XXce5pEr38d0TrrH3
 Ss3QEVE7zSe4gKiZMXd9kdDMVENVrf91vGIo609ko76y4Qp1Aec0F2Jst8gklF1PTSNR
 4sowgXoycTJO4xxiDwpcZZ2YfKW03W4DdD0UvjhjiQRNiDFDDzqZe3A7H5DN4cFhHW71
 3L/U3qvHGhnthp/hJA9/qupmFbPigyqgxroQdNF9cUVTBjWXolF3au0eQSqSIS+jRimt
 4QZA==
X-Gm-Message-State: AOJu0Ywtxuaja66a2jw26MTF3xz8E+lG6O0EPklOQBSbcaks9WdZB0+K
 GfmcPpfK6Xi5zIjz7CRvoarz38wlUQkPTJQH86pGXg==
X-Google-Smtp-Source: AGHT+IFFcaK8DSdBlct2Fb+NQ6h/K7Vb2R9wxrZBBkzZFIIJcWqTJEbYLO7PWgH88QuJq6OeZxrNwXYd8BHbbedbXro=
X-Received: by 2002:a50:a6dd:0:b0:543:8498:fda5 with SMTP id
 f29-20020a50a6dd000000b005438498fda5mr5097822edc.14.1698933196988; Thu, 02
 Nov 2023 06:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231102094015.208588-1-ethan84@andestech.com>
 <20231102094015.208588-2-ethan84@andestech.com> <ZUOo3fGmqM/gVyTR@x1n>
In-Reply-To: <ZUOo3fGmqM/gVyTR@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 13:53:05 +0000
Message-ID: <CAFEAcA86B-V0gFLhE9rPK2kG=XeFw7OJ4C==8g2i_WHSLW_HYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start address, 
 end address to MemTxAttrs
To: Peter Xu <peterx@redhat.com>
Cc: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org, 
 richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, in.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 2 Nov 2023 at 13:49, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Nov 02, 2023 at 05:40:12PM +0800, Ethan Chen wrote:
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >  include/exec/memattrs.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> > index d04170aa27..fc15e5d7d3 100644
> > --- a/include/exec/memattrs.h
> > +++ b/include/exec/memattrs.h
> > @@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
> >      unsigned int target_tlb_bit0 : 1;
> >      unsigned int target_tlb_bit1 : 1;
> >      unsigned int target_tlb_bit2 : 1;
> > +
> > +    /* IOPMP support up to 65535 sources */
> > +    unsigned int iopmp_sid:16;
>
> There's MemTxAttrs.requester_id, SID for pci, same length.  Reuse it?
>
> > +    /* Transaction infomation for IOPMP */
> > +    unsigned long long iopmp_start_addr;
> > +    unsigned long long iopmp_end_addr;
>
> PS: encoding addresses into memattrs is.. strange, but since I know nothing
> about iopmp, I'll leave that for other reviewers.
>
> Currently MemTxAttrs are passed as a whole int on the stack, if it keeps
> growing we may start to consider a pointer, but need to check the side
> effects of unexpected fields modified within a call.

Yeah, this struct is intended to model the various attributes that
get passed around on the bus alongside data in real hardware.
I'm pretty sure no real hardware is passing around start and
end transaction addresses on its bus with every read and
write, which suggests that we should be doing this some other
way than adding these fields to the MemTxAttrs struct.

thanks
-- PMM

