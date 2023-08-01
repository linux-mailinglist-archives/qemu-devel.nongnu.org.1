Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA676A57F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 02:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQd9A-0007Sx-Lf; Mon, 31 Jul 2023 20:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQd99-0007Sk-EL
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 20:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQd97-0000Sn-G4
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 20:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690849312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JqVW3nKS6ih7lr1bT/HdEeWmAfLdL43H1rrm50D/ao=;
 b=AeAW4m9tHosIISHXrBGK2SCT8g+AgQBijP31nAhazAUV5K2NLCGu/nehszJWc/SoQpGmhT
 qNeFEbEUDpg67aiMCYxbHAnKE00ZU4gf3zm4lt+UOE2MgfzQdE8msHjMIMV3yGLKtq8eBc
 U2VXBnM71CJOfwRz3kfs8iwMoRoG9WY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-n8pk8ynBP6G-6G5jVBHkjg-1; Mon, 31 Jul 2023 20:21:50 -0400
X-MC-Unique: n8pk8ynBP6G-6G5jVBHkjg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-767c4cc8d84so98581785a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 17:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690849310; x=1691454110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JqVW3nKS6ih7lr1bT/HdEeWmAfLdL43H1rrm50D/ao=;
 b=jwH5RWR4bUrCU8WIwx1i5787K+JFWoG9REzivjrxx3JDmny+oltw2cSCGHucjlLpiM
 i2G8SAUUcmRZBpX7tW7gqyJrS6wkG52bzK/GBi68DUKmiFZKne0KMxJqT5pWQXyVpHqU
 +jxqxl9Cj89SBQ8Gc3CjSvkjClHGO73pi62AcpoPJidfYQ15upUG5cCHZ9qjgC8nB9+Y
 kq9r9NbSDeTBXT8DXbRnpj4DBfjMmhMdKznOYWXxgToj/u/sTJaVEGFFxOeA1dKIRwpx
 cVXn+L05dltA17y+ibzwYEvKTUIavZFmWxCdvCRDzYFYppJeotFDkwak1shRlC61FJqu
 ZZYQ==
X-Gm-Message-State: ABy/qLaKApSFYwJw/McJK3oCuF37/jC4aBY4bxQ7HpezFJFlcvsTDXFD
 XVBO6mivBcawaYCYRF5Vl61oA6Ik+9M9/TDSG2J3+18fZlVQm/SdN8JMjt6dNoozkypRXvZcxhV
 NzDijBPD81ClHPPU=
X-Received: by 2002:a05:620a:24d0:b0:767:f2e7:47c0 with SMTP id
 m16-20020a05620a24d000b00767f2e747c0mr11473020qkn.1.1690849310109; 
 Mon, 31 Jul 2023 17:21:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkB2xrFKwX29nFK0UU7HJMjyCVFqFuyruoxfJ4KYdJp/fi0G+JCL4IHqQH3QsZS+VEOSY1iQ==
X-Received: by 2002:a05:620a:24d0:b0:767:f2e7:47c0 with SMTP id
 m16-20020a05620a24d000b00767f2e747c0mr11472985qkn.1.1690849309634; 
 Mon, 31 Jul 2023 17:21:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h26-20020a05620a10ba00b00767ba88f0c9sm3725129qkk.7.2023.07.31.17.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 17:21:49 -0700 (PDT)
Date: Mon, 31 Jul 2023 20:21:46 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 04/19] memory: Introduce memory_region_can_be_private()
Message-ID: <ZMhQGi6MuHfyvNS9@x1n>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-5-xiaoyao.li@intel.com>
 <ZMgma0cRi/lkTKSz@x1n> <ZMgo3mGKtoQ7QsB+@google.com>
 <20230731173607-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731173607-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jul 31, 2023 at 05:36:37PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 31, 2023 at 02:34:22PM -0700, Sean Christopherson wrote:
> > On Mon, Jul 31, 2023, Peter Xu wrote:
> > > On Mon, Jul 31, 2023 at 12:21:46PM -0400, Xiaoyao Li wrote:
> > > > +bool memory_region_can_be_private(MemoryRegion *mr)
> > > > +{
> > > > +    return mr->ram_block && mr->ram_block->gmem_fd >= 0;
> > > > +}
> > > 
> > > This is not really MAP_PRIVATE, am I right?  If so, is there still chance
> > > we rename it (it seems to be also in the kernel proposal all across..)?
> > 
> > Yes and yes.
> > 
> > > I worry it can be very confusing in the future against MAP_PRIVATE /
> > > MAP_SHARED otherwise.
> > 
> > Heh, it's already quite confusing at times.  I'm definitely open to naming that
> > doesn't collide with MAP_{PRIVATE,SHARED}, especially if someone can come with a
> > naming scheme that includes a succinct way to describe memory that is shared
> > between two or more VMs, but is accessible to _only_ those VMs.
> 
> Standard solution is a technology specific prefix.
> protect_shared, encrypt_shared etc.

Agreed, a prefix could definitely help (if nothing better comes at last..).
If e.g. "encrypted" too long to be applied everywhere in var names and
functions, maybe it can also be "enc_{private|shared}".

Thanks,

-- 
Peter Xu


