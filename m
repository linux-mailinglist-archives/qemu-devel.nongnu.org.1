Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F277CE196
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8lD-0004b1-Pv; Wed, 18 Oct 2023 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ku-0004TM-Gy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ks-0005OE-Hl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FUyh8BzYHWoqJopFeUMYQGe0JhgBnHMDgO9OdO72O2Q=;
 b=GF/2p7Wl6M5FEatgCJkraSjzbpb+bUGcRnej2466z1ad3FEWMo1WeutmWrsJPxPAZAluUe
 uKet2WIVvPA1jkYxBhuXhOMbEvQiFAtS8+dSLxl8WORJ/w+FYRJ6ywX9Xh3x/w1deAhYCG
 K8gIyBF5YX3T7vLZVsQWnHDG4oN/5zY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-mph8cBsLON-yLAtL0HLCMQ-1; Wed, 18 Oct 2023 11:46:39 -0400
X-MC-Unique: mph8cBsLON-yLAtL0HLCMQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso66449481fa.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643997; x=1698248797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUyh8BzYHWoqJopFeUMYQGe0JhgBnHMDgO9OdO72O2Q=;
 b=euEaNaAmgchmEcCh5JSZxne7ccH81E1P0ssusfi36CcDnnfNDcwIgExS9AhqHXZQhr
 G0aeEKYdU+N1+Xu9fjY1LE5/Bz8DjF5WcPXxIPfla37JG2xugXSuOAsBirPB41iM2290
 LAaeKyo0wkKdfVYcDtKAmkqZ3euz4Fyy7ogkT7GV4lIOPi1yRqCVBRPgU7fvvLMJgjtM
 9cGIctneeVKU16robRPIpVlHZ8njFRKiq/Cbg1J2wCBU1o9lQAs/kiRuZ99y3KwelELK
 tCOcMHDW8HWNuOfr4o+GxwWUQ5dd1YgoPlEESDGkqeTL8W1ChJN4PH8Jq0eGySCkVDPn
 d/fw==
X-Gm-Message-State: AOJu0Yy/mDosrRDqduYgleW2cUl35fsZdkynrqWi8WPQSbtnVo4rOI9x
 ij2D23cs7dWJvkoVpzq6iPJ7/VceHghdlUl6OpaK8cnKyuhTKFNlU0QIyuK0GLAKK+cnjAM8imt
 TX14H0T/PaJBTrqc=
X-Received: by 2002:a05:651c:1994:b0:2c5:7fe:8260 with SMTP id
 bx20-20020a05651c199400b002c507fe8260mr5337486ljb.4.1697643997559; 
 Wed, 18 Oct 2023 08:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVu4Meu4RsMRpjwVZX/W6y1wNokkv27axmbliaz7MfftswmPn4CWKsvVRL/xdAIv9hXGF6eg==
X-Received: by 2002:a05:651c:1994:b0:2c5:7fe:8260 with SMTP id
 bx20-20020a05651c199400b002c507fe8260mr5337474ljb.4.1697643997340; 
 Wed, 18 Oct 2023 08:46:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c220600b0040684abb623sm1947076wml.24.2023.10.18.08.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:46:36 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:46:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] intel-iommu: Report interrupt remapping faults, fix
 return value
Message-ID: <20231018114617-mutt-send-email-mst@kernel.org>
References: <31bbfc9041690449d3ac891f4431ec82174ee1b4.camel@infradead.org>
 <ZOYnraT/QyOUn4uP@x1n>
 <c72aa2174f60f184e87636a0a3a0394ef8e7afd3.camel@infradead.org>
 <20231017172812-mutt-send-email-mst@kernel.org>
 <a62712bed8b86b6d4ebe1cc8deda6528d8e02032.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62712bed8b86b6d4ebe1cc8deda6528d8e02032.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 17, 2023 at 10:29:39PM +0100, David Woodhouse wrote:
> On Tue, 2023-10-17 at 17:28 -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 17, 2023 at 10:19:55PM +0100, David Woodhouse wrote:
> > > On Wed, 2023-08-23 at 11:37 -0400, Peter Xu wrote:
> > > > On Wed, Aug 23, 2023 at 01:23:25PM +0100, David Woodhouse wrote:
> > > > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > > > 
> > > > > A generic X86IOMMUClass->int_remap function should not return VT-d
> > > > > specific values; fix it to return 0 if the interrupt was successfully
> > > > > translated or -EINVAL if not.
> > > > > 
> > > > > The VTD_FR_IR_xxx values are supposed to be used to actually raise
> > > > > faults through the fault reporting mechanism, so do that instead for
> > > > > the case where the IRQ is actually being injected.
> > > > > 
> > > > > There is more work to be done here, as pretranslations for the KVM IRQ
> > > > > routing table can't fault; an untranslatable IRQ should be handled in
> > > > > userspace and the fault raised only when the IRQ actually happens (if
> > > > > indeed the IRTE is still not valid at that time). But we can work on
> > > > > that later; we can at least raise faults for the direct case.
> > > > > 
> > > > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > > 
> > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Thanks.
> > > 
> > > What do I do with this next? It's still lurking in my working tree.
> > > 
> > > 
> > 
> > Not sure how I lost it. Sorry. Will pick up.
> 
> I think I just posted it at the wrong time of the release cycle.
> Thanks.
> 



I fixed some tab-indent issues and picked it up.


