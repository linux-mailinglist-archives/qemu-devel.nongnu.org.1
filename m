Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCF87CF3F8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPFW-0001Y5-J5; Thu, 19 Oct 2023 05:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtPFU-0001O0-Fh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtPFQ-0006X2-4K
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697707395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WyLcUPHtfbwR5iPsldid+h/rFbvL5xLR+xTTX/yt/c=;
 b=SHzIJaBftrwYK1H1tZAsnXT+ImJdma8AqKsIke1T33/5VXLYjL22rvIbW0SZoxXvwUAqjx
 dVHZdH8NroRSVrsXUzA5DSUoMrHM0g8OEjEl9CAOozorDJAt455BCSwzbbo2gMTgePrHLh
 bxvFEg+UQhAV2SKbgHVIZC8rs6Kady4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-W1LM7j0AMcios_YFVU4JWQ-1; Thu, 19 Oct 2023 05:23:12 -0400
X-MC-Unique: W1LM7j0AMcios_YFVU4JWQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079630993dso6712526e87.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697707391; x=1698312191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WyLcUPHtfbwR5iPsldid+h/rFbvL5xLR+xTTX/yt/c=;
 b=iZ5YSdLqj0Ijtg6Px1kVC2L5hZY1bmlvHp2MlTY3cxOCHMOZloxJW/gc/Qyg1JQC5j
 aVlwmuxRsaNpRHC2DNNLgFXsaXKk+TwM8KbpLmunfUAwipsxukSVR+8VXsZ4m4G+R0+n
 uAs66zVLBLMEdmW8V/ERnx8/tvlxUQlNNTTxrJpV5Ut8S7aAM2/f7Kz3LNdpv0e1XHur
 c3T7SWshGrBbDhgpTun3BOmM+WpmFd6PaAKqRf3K57faVhMfctpPlY/MOIvig5HYVLDb
 JjLBivpkdXzorQUxps6gP+ltGlY/o5PisdG5fCI91tpSNzNnJC6PHFXXbdy4ugdpCm9K
 21UQ==
X-Gm-Message-State: AOJu0Yw6PaDbF7XgNKQuc7XtROLUxeNsnnP02Krw5P/UXsArUV6WTiAl
 Jgub0lFXgrQ8CYglZD7kYPpoNbnTPaIu+1VBQlq+1v35wfIfTEBY6AvNOATnxCg/057h1TiIkMB
 pPaDY1yL1bmfeplo=
X-Received: by 2002:a05:6512:3584:b0:507:b935:9f5f with SMTP id
 m4-20020a056512358400b00507b9359f5fmr1018454lfr.24.1697707390994; 
 Thu, 19 Oct 2023 02:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOes4g3ZAbBGS7tQdEjrdM4/kivYVl+CYh/7o2EDH+JRgFh74aqdjMYiRlaOcFJvMBUCF0Nw==
X-Received: by 2002:a05:6512:3584:b0:507:b935:9f5f with SMTP id
 m4-20020a056512358400b00507b9359f5fmr1018440lfr.24.1697707390583; 
 Thu, 19 Oct 2023 02:23:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c19d400b0040841e79715sm2372694wmq.27.2023.10.19.02.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:23:10 -0700 (PDT)
Date: Thu, 19 Oct 2023 05:23:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linuxarm@huawei.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Michael Tokarev <mjt@tls.msk.ru>, Fan Ni <fan.ni@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20231019052242-mutt-send-email-mst@kernel.org>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
 <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
 <20231018103907-mutt-send-email-mst@kernel.org>
 <20231018172239.00005f3d@Huawei.com>
 <20231018173142.00003739@Huawei.com>
 <20231019100547.00003eef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019100547.00003eef@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 19, 2023 at 10:09:24AM +0100, Jonathan Cameron wrote:
> On Wed, 18 Oct 2023 17:31:42 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 18 Oct 2023 17:22:39 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Wed, 18 Oct 2023 10:40:45 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Thu, Oct 12, 2023 at 03:05:12PM +0100, Jonathan Cameron wrote:    
> > > > > Establishing that only register accesses of size 4 and 8 can occur
> > > > > using these functions requires looking at their callers. Make it
> > > > > easier to see that by using switch statements.
> > > > > Assertions are used to enforce that the register storage is of the
> > > > > matching size, allowing fixed values to be used for divisors of
> > > > > the array indices.
> > > > > 
> > > > > Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>      
> > > > 
> > > > Fails with clang:
> > > > 
> > > > ../hw/cxl/cxl-component-utils.c:130:9: error: expected expression
> > > >         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> > > >         ^
> > > > ../include/qemu/compiler.h:76:30: note: expanded from macro 'QEMU_BUILD_BUG_ON'
> > > > #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
> > > >                              ^
> > > > ../include/qemu/compiler.h:74:36: note: expanded from macro 'QEMU_BUILD_BUG_MSG'
> > > > #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
> > > >                                    ^
> > > > 1 error generated.
> > > > 
> > > > See e.g.
> > > > 
> > > > https://gitlab.com/mstredhat/qemu/-/jobs/5320879531    
> > > 
> > > Thanks. Will see if I can figure out what is going wrong.
> > > This code seems cursed.  I need to figure out a way to run the CI again.
> > > Ran into credit problems I couldn't solve last time I tried.
> > > 
> > > In meantime I can replicate this locally but not immediately obvious to me
> > > why it is failing.  
> > 
> > Any clang experts around?  This seems to be fixed by reducing the scope
> > 
> > case 4:
> > {
> > 	QEMU_BUILD_BUG_ON();
> > }
> > I have no idea why though...
> > 
> 
> For anyone following along I asked a friendly compiler guy...
> 
> https://github.com/llvm/llvm-project/issues/69572
> 
> Given that we realistically need to work around this whatever the outcome
> I'll add some brackets and send an update.
> 
> thanks,
> 
> Jonathan

We don't seem to use QEMU_BUILD_BUG_ON outside of functions - just add
brackets inside it?

> > 
> > > 
> > > Jonathan
> > >   
> > > > 
> > > > 
> > > >     
> > > > > ---
> > > > > v4: Use QEMU_BUILD_BUG_ON() instead of static_assert with missing
> > > > >     error message.
> > > > > 
> > > > >  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
> > > > >  1 file changed, 42 insertions(+), 23 deletions(-)
> > > > > 
> > > > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > > > index f3bbf0fd13..d1997a52e6 100644
> > > > > --- a/hw/cxl/cxl-component-utils.c
> > > > > +++ b/hw/cxl/cxl-component-utils.c
> > > > > @@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> > > > >      CXLComponentState *cxl_cstate = opaque;
> > > > >      ComponentRegisters *cregs = &cxl_cstate->crb;
> > > > >  
> > > > > -    if (size == 8) {
> > > > > +    switch (size) {
> > > > > +    case 4:
> > > > > +        if (cregs->special_ops && cregs->special_ops->read) {
> > > > > +            return cregs->special_ops->read(cxl_cstate, offset, 4);
> > > > > +        } else {
> > > > > +            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > > > > +            return cregs->cache_mem_registers[offset / 4];
> > > > > +        }
> > > > > +    case 8:
> > > > >          qemu_log_mask(LOG_UNIMP,
> > > > >                        "CXL 8 byte cache mem registers not implemented\n");
> > > > >          return 0;
> > > > > -    }
> > > > > -
> > > > > -    if (cregs->special_ops && cregs->special_ops->read) {
> > > > > -        return cregs->special_ops->read(cxl_cstate, offset, size);
> > > > > -    } else {
> > > > > -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > > > > +    default:
> > > > > +        /*
> > > > > +         * In line with specifiction limitaions on access sizes, this
> > > > > +         * routine is not called with other sizes.
> > > > > +         */
> > > > > +        g_assert_not_reached();
> > > > >      }
> > > > >  }
> > > > >  
> > > > > @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> > > > >      ComponentRegisters *cregs = &cxl_cstate->crb;
> > > > >      uint32_t mask;
> > > > >  
> > > > > -    if (size == 8) {
> > > > > +    switch (size) {
> > > > > +    case 4:
> > > > > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> > > > > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > > > > +        mask = cregs->cache_mem_regs_write_mask[offset / 4];
> > > > > +        value &= mask;
> > > > > +        /* RO bits should remain constant. Done by reading existing value */
> > > > > +        value |= ~mask & cregs->cache_mem_registers[offset / 4];
> > > > > +        if (cregs->special_ops && cregs->special_ops->write) {
> > > > > +            cregs->special_ops->write(cxl_cstate, offset, value, size);
> > > > > +            return;
> > > > > +        }
> > > > > +
> > > > > +        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > > > > +            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> > > > > +            dumb_hdm_handler(cxl_cstate, offset, value);
> > > > > +        } else {
> > > > > +            cregs->cache_mem_registers[offset / 4] = value;
> > > > > +        }
> > > > > +        return;
> > > > > +    case 8:
> > > > >          qemu_log_mask(LOG_UNIMP,
> > > > >                        "CXL 8 byte cache mem registers not implemented\n");
> > > > >          return;
> > > > > -    }
> > > > > -    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
> > > > > -    value &= mask;
> > > > > -    /* RO bits should remain constant. Done by reading existing value */
> > > > > -    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > > > > -    if (cregs->special_ops && cregs->special_ops->write) {
> > > > > -        cregs->special_ops->write(cxl_cstate, offset, value, size);
> > > > > -        return;
> > > > > -    }
> > > > > -
> > > > > -    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > > > > -        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> > > > > -        dumb_hdm_handler(cxl_cstate, offset, value);
> > > > > -    } else {
> > > > > -        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> > > > > +    default:
> > > > > +        /*
> > > > > +         * In line with specifiction limitaions on access sizes, this
> > > > > +         * routine is not called with other sizes.
> > > > > +         */
> > > > > +        g_assert_not_reached();
> > > > >      }
> > > > >  }
> > > > >  
> > > > > -- 
> > > > > 2.39.2      
> > > > 
> > > >     
> > >   
> > 
> > 
> > 


