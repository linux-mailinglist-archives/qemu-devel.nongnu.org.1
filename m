Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E976D135
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDWT-0002it-I5; Wed, 02 Aug 2023 11:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRDWR-0002ib-JR
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRDWQ-0001bZ-01
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690989140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0VpReZM2wEqXO0R/dtaGn98WZzYOyXQU+W3KVkwbJQ=;
 b=QQpE9CgnFa7wbzbwVtJzb32CImxddsVmWK8oLdMldw7V61gUhwM1vkc09LhKv5nzKY7L9+
 xL3e5YNXy03cRruiscIsLhjQ7xYjBg4AN9IBJzfAdOzsn8yTEHadACfVa32UP/2pvz6AxO
 xABuizXK9OSRy4gZ6yeD3rMwyUVhk8Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-L4upE4ucOKimeT8XQ04u6w-1; Wed, 02 Aug 2023 11:12:18 -0400
X-MC-Unique: L4upE4ucOKimeT8XQ04u6w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76cb292df12so81726385a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690989137; x=1691593937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0VpReZM2wEqXO0R/dtaGn98WZzYOyXQU+W3KVkwbJQ=;
 b=Pv6AzUImnzXw+VrTDhAzvV6opnoyGO3/ZUtD9BWN3Zep+cCPll+wq2LG42MF+lYbWi
 JEzlmEE6jxW/xQubEIyv6WqbescvHSahuPa13lPfKEfepuvTP8XHWkxZhprAeXg7+Zxe
 TXTtF4FsZ7rPqLDhDU2BqFfhhe0dEOtGsu/7UF23nfedX8L2lCIk8XZkD3Qk8zaNjg2X
 aoNZjNWufwL5KnXd1npFbPy2GmKNyEJlu3FAsds6Y3CjkRBB0wEGk28fgSLXzAiY78kM
 tJZakV7AfLsObZUyyJABcEAcAPL3hVrsXgL8e6aE+AIvvi7lo7vmzRjvmz3Ll3f980C2
 v3VA==
X-Gm-Message-State: ABy/qLYJL7KtvjbbrPwxlthF3rFAbD4ekUhtk6tuhfAT2AbfAr0d9NSy
 gnIcodkq9ziVWICr7BHcetLHrpQ+QObqrXijS/2wrb06jsg4NQbYbxv5xD167vePAGYKB/dv7UB
 3XuWMX0+LKjIwKho=
X-Received: by 2002:a05:620a:1987:b0:76c:a9eb:90bf with SMTP id
 bm7-20020a05620a198700b0076ca9eb90bfmr12483120qkb.3.1690989137703; 
 Wed, 02 Aug 2023 08:12:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFX5Anv3EMJNG6CxGXMMPrPrx/HT4EhDmWFjo219x0Me+0ghu986l9OOEJKWq3pnx1Ah4qUtA==
X-Received: by 2002:a05:620a:1987:b0:76c:a9eb:90bf with SMTP id
 bm7-20020a05620a198700b0076ca9eb90bfmr12483100qkb.3.1690989137422; 
 Wed, 02 Aug 2023 08:12:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a16-20020a05620a125000b00767502e8601sm5088281qkl.35.2023.08.02.08.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 08:12:16 -0700 (PDT)
Date: Wed, 2 Aug 2023 11:12:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/i386/intel_iommu: Fix endianness problems related to
 VTD_IR_TableEntry
Message-ID: <ZMpyT87CzeKTKfn7@x1n>
References: <20230802092837.153689-1-thuth@redhat.com> <ZMph6J8reFmxOpit@x1n>
 <231556af-02cd-a243-acdb-78cec6fd24a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <231556af-02cd-a243-acdb-78cec6fd24a2@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 02, 2023 at 04:14:01PM +0200, Thomas Huth wrote:
> On 02/08/2023 16.02, Peter Xu wrote:
> > On Wed, Aug 02, 2023 at 11:28:37AM +0200, Thomas Huth wrote:
> > >   #if HOST_BIG_ENDIAN
> > > -        uint32_t __reserved_1:8;     /* Reserved 1 */
> > > -        uint32_t vector:8;           /* Interrupt Vector */
> > > -        uint32_t irte_mode:1;        /* IRTE Mode */
> > > -        uint32_t __reserved_0:3;     /* Reserved 0 */
> > > -        uint32_t __avail:4;          /* Available spaces for software */
> > > -        uint32_t delivery_mode:3;    /* Delivery Mode */
> > > -        uint32_t trigger_mode:1;     /* Trigger Mode */
> > > -        uint32_t redir_hint:1;       /* Redirection Hint */
> > > -        uint32_t dest_mode:1;        /* Destination Mode */
> > > -        uint32_t fault_disable:1;    /* Fault Processing Disable */
> > > -        uint32_t present:1;          /* Whether entry present/available */
> > > +        uint64_t dest_id:32;         /* Destination ID */
> > > +        uint64_t __reserved_1:8;     /* Reserved 1 */
> > > +        uint64_t vector:8;           /* Interrupt Vector */
> > > +        uint64_t irte_mode:1;        /* IRTE Mode */
> > > +        uint64_t __reserved_0:3;     /* Reserved 0 */
> > > +        uint64_t __avail:4;          /* Available spaces for software */
> > > +        uint64_t delivery_mode:3;    /* Delivery Mode */
> > > +        uint64_t trigger_mode:1;     /* Trigger Mode */
> > > +        uint64_t redir_hint:1;       /* Redirection Hint */
> > > +        uint64_t dest_mode:1;        /* Destination Mode */
> > > +        uint64_t fault_disable:1;    /* Fault Processing Disable */
> > > +        uint64_t present:1;          /* Whether entry present/available */
> > >   #else
> > > -        uint32_t present:1;          /* Whether entry present/available */
> > > -        uint32_t fault_disable:1;    /* Fault Processing Disable */
> > > -        uint32_t dest_mode:1;        /* Destination Mode */
> > > -        uint32_t redir_hint:1;       /* Redirection Hint */
> > > -        uint32_t trigger_mode:1;     /* Trigger Mode */
> > > -        uint32_t delivery_mode:3;    /* Delivery Mode */
> > > -        uint32_t __avail:4;          /* Available spaces for software */
> > > -        uint32_t __reserved_0:3;     /* Reserved 0 */
> > > -        uint32_t irte_mode:1;        /* IRTE Mode */
> > > -        uint32_t vector:8;           /* Interrupt Vector */
> > > -        uint32_t __reserved_1:8;     /* Reserved 1 */
> > > +        uint64_t present:1;          /* Whether entry present/available */
> > > +        uint64_t fault_disable:1;    /* Fault Processing Disable */
> > > +        uint64_t dest_mode:1;        /* Destination Mode */
> > > +        uint64_t redir_hint:1;       /* Redirection Hint */
> > > +        uint64_t trigger_mode:1;     /* Trigger Mode */
> > > +        uint64_t delivery_mode:3;    /* Delivery Mode */
> > > +        uint64_t __avail:4;          /* Available spaces for software */
> > > +        uint64_t __reserved_0:3;     /* Reserved 0 */
> > > +        uint64_t irte_mode:1;        /* IRTE Mode */
> > > +        uint64_t vector:8;           /* Interrupt Vector */
> > > +        uint64_t __reserved_1:8;     /* Reserved 1 */
> > > +        uint64_t dest_id:32;         /* Destination ID */
> > >   #endif
> > > -        uint32_t dest_id;            /* Destination ID */
> > > -        uint16_t source_id;          /* Source-ID */
> > >   #if HOST_BIG_ENDIAN
> > >           uint64_t __reserved_2:44;    /* Reserved 2 */
> > >           uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> > >           uint64_t sid_q:2;            /* Source-ID Qualifier */
> > > +        uint64_t source_id:16;       /* Source-ID */
> > >   #else
> > > +        uint64_t source_id:16;       /* Source-ID */
> > >           uint64_t sid_q:2;            /* Source-ID Qualifier */
> > >           uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> > >           uint64_t __reserved_2:44;    /* Reserved 2 */
> > 
> > A quick comment before a repost: we can merge the two HOST_BIG_ENDIAN
> > blocks into one now?
> 
> We could, and I also considered it while working on this. But I think it
> would rather decrease the readability of this code. These are two separete
> 64-bit fields, and you might want to compare the big endian version of a
> bitfield to the little endian version next to it. If we merge, it looks
> rather like one big 128-bitfield if you don't look carefully enough, and
> comparision gets worse. So I'd prefer to keep them separate.

We can have a comment for each uint64_t at the top, IMHO better than having
two continuous block having the same "#ifdef" which is OTOH confusing.

Not a huge deal - I saw that the new version is already there.  I'll read
first.  Thanks a lot for fixing these problems.

-- 
Peter Xu


