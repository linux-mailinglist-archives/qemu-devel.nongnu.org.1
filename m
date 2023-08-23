Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCD785C43
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpvW-0001HA-RC; Wed, 23 Aug 2023 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYpvE-00089u-My
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYpvD-0000PN-7h
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692805044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9hXip36oViVNPUKIDiz9Yi+8esAXFl26SzKPkgvWWQ=;
 b=Y7sW5ki60wyVmiseRk0fOuNE5CHlI7OqHu5VIlfdEAemsOhIrxH79wtYbjhXmavEZsLzr9
 Hts7awT77a9GPnDbhG1ZC/qkE8qr78bXucfjBGp68Ui4sMGO2QWGF+f6lJ3VSKOwDOPPnK
 UBlQvID2MsuY+fIT/0G/o9EXSvlXU+0=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--o3HYHqoPouE9BeXKhtCQg-1; Wed, 23 Aug 2023 11:37:20 -0400
X-MC-Unique: -o3HYHqoPouE9BeXKhtCQg-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-44760625ea6so367805137.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692805040; x=1693409840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9hXip36oViVNPUKIDiz9Yi+8esAXFl26SzKPkgvWWQ=;
 b=MfvRTxeloRLXkjSDn36mVtVEsKImhd/RfFDudfAOCN3Jx4JcHA/PeKVSA7hmzomtZj
 bBDQy15MQ0cUKW6TBPfCYp/JN0WwsoiRuSZ//X2Lyyq7lqREHBPANV6ZRxNL3LVoQQyP
 wetg57M/wdM5IGiwtzF6lLWblk5SiLd+Lo3C7MhOLsQicYjJOIHeHq+hFn7igz6QkCzJ
 elDxcCtv6CLG93c7oJUEFwTfjxk19dEKA6OQPR4h44/Xqmws6rd1iE0uRrih0QDSsv81
 DzliL5Jb7rBVZHQGRtiH2sk/iHbkVnOWKmDwMmDPY2fzg5fu0QypmzaBBvDJm0C9vS+A
 80iw==
X-Gm-Message-State: AOJu0YypaITUD6BSIH6vzKHCWhNgZ9EcY38B76RV3xCe6p7gghkyDjgM
 U1Mzm+IDc+ioiHcS06xW/Z2FL7XEBiVMWX0YNNjk5xPscCoM4Ta8WeMs/4bIHoV9NkhIwlD7F/V
 gEjjg7+rbqBHkclI=
X-Received: by 2002:a1f:9c88:0:b0:485:b2ad:bf with SMTP id
 f130-20020a1f9c88000000b00485b2ad00bfmr9002804vke.1.1692805040168; 
 Wed, 23 Aug 2023 08:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf3zhj48hIZZV7Muuc2JXR7Ox02EYMUBZOMUxXgArP7eJNMGWCIyp/g5hvw1M+8U2JumABGg==
X-Received: by 2002:a1f:9c88:0:b0:485:b2ad:bf with SMTP id
 f130-20020a1f9c88000000b00485b2ad00bfmr9002783vke.1.1692805039842; 
 Wed, 23 Aug 2023 08:37:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 jv16-20020a05622aa09000b0040f200feb4fsm3468815qtb.80.2023.08.23.08.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:37:19 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:37:17 -0400
From: Peter Xu <peterx@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] intel-iommu: Report interrupt remapping faults, fix
 return value
Message-ID: <ZOYnraT/QyOUn4uP@x1n>
References: <31bbfc9041690449d3ac891f4431ec82174ee1b4.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31bbfc9041690449d3ac891f4431ec82174ee1b4.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 23, 2023 at 01:23:25PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A generic X86IOMMUClass->int_remap function should not return VT-d
> specific values; fix it to return 0 if the interrupt was successfully
> translated or -EINVAL if not.
> 
> The VTD_FR_IR_xxx values are supposed to be used to actually raise
> faults through the fault reporting mechanism, so do that instead for
> the case where the IRQ is actually being injected.
> 
> There is more work to be done here, as pretranslations for the KVM IRQ
> routing table can't fault; an untranslatable IRQ should be handled in
> userspace and the fault raised only when the IRQ actually happens (if
> indeed the IRTE is still not valid at that time). But we can work on
> that later; we can at least raise faults for the direct case.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Peter Xu <peterx@redhat.com>


-- 
Peter Xu


