Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F276A242
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 22:54:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQZtu-0006qr-N0; Mon, 31 Jul 2023 16:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qQZts-0006qX-EB
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qQZtq-0003lX-RZ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690836833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iSPj40jGo0mbAGM/twFQB5Z7XJTh5m0CeXBNYsz5tQ=;
 b=DWyqEw+2uwXb4TGb1S3CtSgcCxoggN+O6u2mBv8ZLHDycYZNG7uvSbND+VObngVz8V5+Q4
 PpBBH4IPNfjrwLOPbBsMY+h1zX1y6/hWHyyvRdu7Q3NseWXAzsvY+X7+VdV7vWKXE0tyEP
 fM9ESVKTb3BIhV+Osw+gDI5BE0xqh7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-k4fGewtBMiiB8U-Nn2glmA-1; Mon, 31 Jul 2023 16:53:52 -0400
X-MC-Unique: k4fGewtBMiiB8U-Nn2glmA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so2705315f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 13:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690836830; x=1691441630;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/iSPj40jGo0mbAGM/twFQB5Z7XJTh5m0CeXBNYsz5tQ=;
 b=Wg0sP9n2Svp5dz/vwkan5vs73H+woM6ygUWmnoPtg0wkuZRJC2uxfkQUzNBHHEqHjM
 X57c+0LL3sCs1uJX2m4D/DnoDnFCUZQrQBUu12Al0MjkokyAkljaaB6BOoD3SgLKGoUX
 bvTrKnFY6OZxlE2+Yb7tNBNNKdEHF25ZkiS0vGaAu8vsUMDFopwwjK3OKhX6vFwFTgHj
 Oz57mOyaaALtBagfA7+beRerrQHfF5vVftiabecLtwSzzuGxBXPR8qcKGgTHkcUeHx7S
 eGkwJnfzddLMsFs3JYUqN3Rqh/cB/iVEtiOL3YBUdHmVc/DcW5kr3b9OFDoVxy2zRvD8
 ht6g==
X-Gm-Message-State: ABy/qLYCKGTDrSimBE+yW5XvK8ZsD4T8e+tWJ2YW3jeYYFGS+c6royYs
 9IAXEMjjeLcmTxirKlG8YF6jodiAuNVrM28RQ4aQkRpDv0GxsQNpWzUMGrvKMXKEM8X3sWPqULM
 9zramH+V5d8r4k/BCc+UwMGM=
X-Received: by 2002:a5d:4746:0:b0:317:3d78:c313 with SMTP id
 o6-20020a5d4746000000b003173d78c313mr663613wrs.60.1690836830423; 
 Mon, 31 Jul 2023 13:53:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqvPvQ47mNo38F5EMk+9IRT5t3HquwHAxfYkG8c4+VfTrYi1x85D5ktXXgKRppssszYT8F6Q==
X-Received: by 2002:a5d:4746:0:b0:317:3d78:c313 with SMTP id
 o6-20020a5d4746000000b003173d78c313mr663602wrs.60.1690836830086; 
 Mon, 31 Jul 2023 13:53:50 -0700 (PDT)
Received: from redhat.com ([2.52.21.81]) by smtp.gmail.com with ESMTPSA id
 c3-20020a056000104300b003141e629cb6sm13895701wrx.101.2023.07.31.13.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 13:53:49 -0700 (PDT)
Date: Mon, 31 Jul 2023 16:53:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 4/6] hw/i386/intel_iommu: Fix VTD_IR_TableEntry for
 ms_struct layout
Message-ID: <20230731165306-mutt-send-email-mst@kernel.org>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-5-thuth@redhat.com>
 <ZMPSsCjZhj0AQeS0@redhat.com>
 <12453b16-5fee-63aa-7292-feb2133675b6@redhat.com>
 <ZMgZBNEutnsDxk8A@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMgZBNEutnsDxk8A@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Jul 31, 2023 at 04:26:44PM -0400, Peter Xu wrote:
> On Mon, Jul 31, 2023 at 10:20:40AM +0200, Thomas Huth wrote:
> > On 28/07/2023 16.37, Daniel P. Berrangé wrote:
> > > On Fri, Jul 28, 2023 at 04:27:46PM +0200, Thomas Huth wrote:
> > > > We might want to compile QEMU with Clang on Windows - but it
> > > > does not support the __attribute__((gcc_struct)) yet. So we
> > > > have to make sure that the structs will stay the same when
> > > > the compiler uses the "ms_struct" layout. The VTD_IR_TableEntry
> > > > struct is affected - rewrite it a little bit so that it works
> > > > fine with both struct layouts.
> > > > 
> > > > Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   include/hw/i386/intel_iommu.h | 14 ++++++++------
> > > >   hw/i386/intel_iommu.c         |  2 +-
> > > >   2 files changed, 9 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > > > index 89dcbc5e1e..08bf220393 100644
> > > > --- a/include/hw/i386/intel_iommu.h
> > > > +++ b/include/hw/i386/intel_iommu.h
> > > > @@ -204,18 +204,20 @@ union VTD_IR_TableEntry {
> > > >   #endif
> > > >           uint32_t dest_id;            /* Destination ID */
> > > >           uint16_t source_id;          /* Source-ID */
> > > > +        uint16_t __reserved_2;       /* Reserved 2 */
> > > >   #if HOST_BIG_ENDIAN
> > > > -        uint64_t __reserved_2:44;    /* Reserved 2 */
> > > > -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> > > > -        uint64_t sid_q:2;            /* Source-ID Qualifier */
> > > > +        uint32_t __reserved_3:28;    /* Reserved 3 */
> > > > +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
> > > > +        uint32_t sid_q:2;            /* Source-ID Qualifier */
> > > >   #else
> > > > -        uint64_t sid_q:2;            /* Source-ID Qualifier */
> > > > -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> > > > -        uint64_t __reserved_2:44;    /* Reserved 2 */
> > > > +        uint32_t sid_q:2;            /* Source-ID Qualifier */
> > > > +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
> > > > +        uint32_t __reserved_3:28;    /* Reserved 3 */
> > > 
> > > Hasn't this has changed the struct layout in the else clause
> > > 
> > >   Old layout:
> > > 
> > >     source_id : 16
> > >     sid_q : 2
> > >     sid_vtype : 2
> > >     reserved_2 : 44
> > > 
> > >   New layout
> > > 
> > >     source_id : 16
> > >     reserved_2 : 16
> > >     sid_q : 2
> > >     sid_vtype : 2
> > >     reserved_3 : 28
> > 
> > Drat, you're right, I missed the fact that the whole stuff is read and
> > written via the uint64_t data[2] part from the union in the code ... :-(
> 
> Yes, that's actually part of the VT-d spec.
> 
> > 
> > > Was there something wrong with the change I suggested to
> > > just make source_id be a bitfield too:
> > > 
> > >         uint64_t source_id: 16;          /* Source-ID */
> > > 
> > > which could make ms_struct layout avoid padding to the following
> > > bitfields.
> > 
> > That likely works, but I think we then need to add it then twice, one time
> > in the HOST_BIG_ENDIAN at the end, and one time in the #else part?
> > 
> > Anyway, that whole code looks like it's completely wrong on big endian
> > machines. The struct is read via dma_memory_read() from guest memory, but
> > then the values are never byte-swapped, except for the error_report and
> > trace functions, e.g. entry->irte.present is used without calling
> > le64_to_cpu() first.
> > entry->irte.source_id is swapped with le32_to_cpu() which looks also wrong
> > since this is a 16 bit field.
> > 
> > Sigh. This is another good example why we shouldn't use bitfields at all in
> > structures that exchange data. As Richard suggested in his reply, this
> > really should be rewritten, e.g. with the stuff from hw/registerfields.h.
> 
> I can definitely review the iommu-side changes if someone would like to
> finally enable that for either clang or whatever purpose.  Sorry if it
> never worked..
> 
> But then if it's broken for 7 years since the start, it probably also means
> no one ever used it on big endian hosts, either, as a functionality.. so
> another approach is we can opt-out VT-d as a whole for big endian, if
> that's easier.
> 
> Thanks,

Let's just fix it properly please. Bad code proliferates.


-- 
MST


