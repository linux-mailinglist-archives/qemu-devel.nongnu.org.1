Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4E76A1DA
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 22:28:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQZTp-0002Hh-Au; Mon, 31 Jul 2023 16:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQZTi-0002G6-Bw
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQZTf-0005IY-W8
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690835210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLhLysqVuVrKGkVc9Gdi/oOyeDHUUHWW9t4KvZkSC+U=;
 b=BcLhElKLc3GchIU5N3vwe8HZUTI2l+i+cVMak6Y0H8VFQTvqbl2thAoIi5RtRdLTFxvFpL
 1JICy6F8bKEmIcVG+FcD2f7b56ewbL9DF2OVPGqXL1njZQY5xtcOUEa1u8NHSeehgjPRT6
 nUB/YSWszYZBioRbBx6Vi63QnvHNXj0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-CqqUlM0FM4qGaHkxi7zAog-1; Mon, 31 Jul 2023 16:26:48 -0400
X-MC-Unique: CqqUlM0FM4qGaHkxi7zAog-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-767c4cc8d84so94494785a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 13:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690835207; x=1691440007;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLhLysqVuVrKGkVc9Gdi/oOyeDHUUHWW9t4KvZkSC+U=;
 b=fiGoDVWcfJkmYCHnI+q5mZ50twKEwytzyU1qOHV8n1nEz/fNhr8TsIv5jrQOQ5qGLk
 zby3KpcrRYp7C4LlB4NdNaXu8XLilCO0kW95PhtUu1vvXV+hTZ/0Btp0QtQkz+FBuNtG
 /PHpReFEPYNP7GIX4SV03718XazkJVfZhPKKFqsnEZ2Lk92egdsTRCBQqcAyFe6riWZx
 LXlyZ3DmZ3Af2nglfQE2RXXwM0vCrL2Lh3iGdkD4RprlVj3VaQNlvW5hww0jE/OJM2f2
 BdfdXj6Qda0Z6p0/b47xvSLRBRCOzq3vRuwM2IURsf14OJaeQo9p+Okd1LBa9wW1oRWu
 Suuw==
X-Gm-Message-State: ABy/qLYQ3BsjKYcOmqDoMBcYMGNi2VFT3EObdy89JqT3v/EU64AbNeGI
 9wU338mEdlgDEFU4P1OjhaaFwRf5gg5/ry9Ucn5GUdaqwhTJr9kGiIUHZG4U76S439d1xs8K635
 DaTz61jyuhy2vUeE=
X-Received: by 2002:a05:620a:46a9:b0:768:1cb7:4514 with SMTP id
 bq41-20020a05620a46a900b007681cb74514mr9593242qkb.2.1690835207566; 
 Mon, 31 Jul 2023 13:26:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlwxCSwqc6+m+IkV0XOks/oibGIpNZVVe6/iB2cEKTBvbjailCm44KtageVYHpQYknLFrGXg==
X-Received: by 2002:a05:620a:46a9:b0:768:1cb7:4514 with SMTP id
 bq41-20020a05620a46a900b007681cb74514mr9593222qkb.2.1690835207234; 
 Mon, 31 Jul 2023 13:26:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m16-20020ae9f210000000b00767da10efb6sm1197282qkg.97.2023.07.31.13.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 13:26:46 -0700 (PDT)
Date: Mon, 31 Jul 2023 16:26:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 4/6] hw/i386/intel_iommu: Fix VTD_IR_TableEntry for
 ms_struct layout
Message-ID: <ZMgZBNEutnsDxk8A@x1n>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-5-thuth@redhat.com>
 <ZMPSsCjZhj0AQeS0@redhat.com>
 <12453b16-5fee-63aa-7292-feb2133675b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12453b16-5fee-63aa-7292-feb2133675b6@redhat.com>
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

On Mon, Jul 31, 2023 at 10:20:40AM +0200, Thomas Huth wrote:
> On 28/07/2023 16.37, Daniel P. Berrangé wrote:
> > On Fri, Jul 28, 2023 at 04:27:46PM +0200, Thomas Huth wrote:
> > > We might want to compile QEMU with Clang on Windows - but it
> > > does not support the __attribute__((gcc_struct)) yet. So we
> > > have to make sure that the structs will stay the same when
> > > the compiler uses the "ms_struct" layout. The VTD_IR_TableEntry
> > > struct is affected - rewrite it a little bit so that it works
> > > fine with both struct layouts.
> > > 
> > > Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   include/hw/i386/intel_iommu.h | 14 ++++++++------
> > >   hw/i386/intel_iommu.c         |  2 +-
> > >   2 files changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > > index 89dcbc5e1e..08bf220393 100644
> > > --- a/include/hw/i386/intel_iommu.h
> > > +++ b/include/hw/i386/intel_iommu.h
> > > @@ -204,18 +204,20 @@ union VTD_IR_TableEntry {
> > >   #endif
> > >           uint32_t dest_id;            /* Destination ID */
> > >           uint16_t source_id;          /* Source-ID */
> > > +        uint16_t __reserved_2;       /* Reserved 2 */
> > >   #if HOST_BIG_ENDIAN
> > > -        uint64_t __reserved_2:44;    /* Reserved 2 */
> > > -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> > > -        uint64_t sid_q:2;            /* Source-ID Qualifier */
> > > +        uint32_t __reserved_3:28;    /* Reserved 3 */
> > > +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
> > > +        uint32_t sid_q:2;            /* Source-ID Qualifier */
> > >   #else
> > > -        uint64_t sid_q:2;            /* Source-ID Qualifier */
> > > -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> > > -        uint64_t __reserved_2:44;    /* Reserved 2 */
> > > +        uint32_t sid_q:2;            /* Source-ID Qualifier */
> > > +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
> > > +        uint32_t __reserved_3:28;    /* Reserved 3 */
> > 
> > Hasn't this has changed the struct layout in the else clause
> > 
> >   Old layout:
> > 
> >     source_id : 16
> >     sid_q : 2
> >     sid_vtype : 2
> >     reserved_2 : 44
> > 
> >   New layout
> > 
> >     source_id : 16
> >     reserved_2 : 16
> >     sid_q : 2
> >     sid_vtype : 2
> >     reserved_3 : 28
> 
> Drat, you're right, I missed the fact that the whole stuff is read and
> written via the uint64_t data[2] part from the union in the code ... :-(

Yes, that's actually part of the VT-d spec.

> 
> > Was there something wrong with the change I suggested to
> > just make source_id be a bitfield too:
> > 
> >         uint64_t source_id: 16;          /* Source-ID */
> > 
> > which could make ms_struct layout avoid padding to the following
> > bitfields.
> 
> That likely works, but I think we then need to add it then twice, one time
> in the HOST_BIG_ENDIAN at the end, and one time in the #else part?
> 
> Anyway, that whole code looks like it's completely wrong on big endian
> machines. The struct is read via dma_memory_read() from guest memory, but
> then the values are never byte-swapped, except for the error_report and
> trace functions, e.g. entry->irte.present is used without calling
> le64_to_cpu() first.
> entry->irte.source_id is swapped with le32_to_cpu() which looks also wrong
> since this is a 16 bit field.
> 
> Sigh. This is another good example why we shouldn't use bitfields at all in
> structures that exchange data. As Richard suggested in his reply, this
> really should be rewritten, e.g. with the stuff from hw/registerfields.h.

I can definitely review the iommu-side changes if someone would like to
finally enable that for either clang or whatever purpose.  Sorry if it
never worked..

But then if it's broken for 7 years since the start, it probably also means
no one ever used it on big endian hosts, either, as a functionality.. so
another approach is we can opt-out VT-d as a whole for big endian, if
that's easier.

Thanks,

-- 
Peter Xu


