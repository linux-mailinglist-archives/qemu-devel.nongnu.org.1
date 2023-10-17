Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8867CCF49
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 23:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsrcG-0001am-CJ; Tue, 17 Oct 2023 17:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qsrcE-0001Yz-D0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 17:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qsrcB-0003kv-Qt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 17:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697578114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pjcOvJEfBClTWsUV+S5cGGOzxlJRZyVS+qfFtWS/g/A=;
 b=Jyxy3vJH+UAxTC6ugU3oY1bK9MoCOMPps2TRUbuZthEU26V7+i6Pf6LC5jHnA00Mjo9OD0
 eK0Av9yRsFBctp245Whbr+E0UvdHFfeEtv2STG1eKg0EEbP7TAVWQAQKDpX7uvOhwZg4NN
 25FtgS5YVv/MF12iKfY18sUXPr5eb7Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Y_4pD8XPNSyKYdPWuUWQlA-1; Tue, 17 Oct 2023 17:28:33 -0400
X-MC-Unique: Y_4pD8XPNSyKYdPWuUWQlA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so1156695e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 14:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697578112; x=1698182912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjcOvJEfBClTWsUV+S5cGGOzxlJRZyVS+qfFtWS/g/A=;
 b=hzziyfNu29mFtyyNIK4xCB2sNgMyhRA1OFvhRhl8sHSwV6o3bO6BAWiwWn16npIOSh
 wfjQ5a3i5aLe/iSz5sjgMdTDXD/Ude3QswRNAkmbvwU5S1UznXTHu3WfmBwc2lyEBU7B
 gDj4LdRCidtVTsp3ojbTfKcoWY6wrjhNVYsWybUY8TtUWaxHASMi2QLfqw/YJdRe4Bnx
 wDLNP1GTdr7Fv0GeRwCISvIiydut6OiQsHYBxFNc7SLHLesQhhgjZ9dIAZtJW/1ENvsV
 1OgEcTJ7UHFmveCcSdALA1528Nkp+PmOPYIXW4zzOiWMcP43kKH2HS3XTbV8Oj7ouJ9m
 wXkA==
X-Gm-Message-State: AOJu0Ywhtxr2oEq9eRvELqRyXf1LH6RGet93pAECUts6bTXH0+B+Zlu+
 v0QTrMSeIRlh/CFTX7AYJCI6ngP93VTnrSxO7sSF5HDII55AtBW7dU19ISlUkD6gyl6BeLDcg7x
 qZ4o1qhHQ4iJ1eqs=
X-Received: by 2002:a05:600c:3b93:b0:405:3455:567e with SMTP id
 n19-20020a05600c3b9300b004053455567emr2501313wms.5.1697578111880; 
 Tue, 17 Oct 2023 14:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHapMCRF1C7DVyJ35u77fkoBhuca21NlABOO52pFszVxMcrcjnm8ksRHhtCaqb0trRupoZHsg==
X-Received: by 2002:a05:600c:3b93:b0:405:3455:567e with SMTP id
 n19-20020a05600c3b9300b004053455567emr2501294wms.5.1697578111508; 
 Tue, 17 Oct 2023 14:28:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:9034:d2b3:ddb0:eaed:63ba])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c1d8a00b003fe23b10fdfsm10761842wms.36.2023.10.17.14.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 14:28:30 -0700 (PDT)
Date: Tue, 17 Oct 2023 17:28:26 -0400
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
Message-ID: <20231017172812-mutt-send-email-mst@kernel.org>
References: <31bbfc9041690449d3ac891f4431ec82174ee1b4.camel@infradead.org>
 <ZOYnraT/QyOUn4uP@x1n>
 <c72aa2174f60f184e87636a0a3a0394ef8e7afd3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72aa2174f60f184e87636a0a3a0394ef8e7afd3.camel@infradead.org>
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

On Tue, Oct 17, 2023 at 10:19:55PM +0100, David Woodhouse wrote:
> On Wed, 2023-08-23 at 11:37 -0400, Peter Xu wrote:
> > On Wed, Aug 23, 2023 at 01:23:25PM +0100, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > 
> > > A generic X86IOMMUClass->int_remap function should not return VT-d
> > > specific values; fix it to return 0 if the interrupt was successfully
> > > translated or -EINVAL if not.
> > > 
> > > The VTD_FR_IR_xxx values are supposed to be used to actually raise
> > > faults through the fault reporting mechanism, so do that instead for
> > > the case where the IRQ is actually being injected.
> > > 
> > > There is more work to be done here, as pretranslations for the KVM IRQ
> > > routing table can't fault; an untranslatable IRQ should be handled in
> > > userspace and the fault raised only when the IRQ actually happens (if
> > > indeed the IRTE is still not valid at that time). But we can work on
> > > that later; we can at least raise faults for the direct case.
> > > 
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > Acked-by: Peter Xu <peterx@redhat.com>
> 
> Thanks.
> 
> What do I do with this next? It's still lurking in my working tree.
> 
> 

Not sure how I lost it. Sorry. Will pick up.


