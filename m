Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E0A987D7E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Sep 2024 06:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HG-000393-Ey; Fri, 27 Sep 2024 00:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HE-000346-RC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HD-0006G1-GT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3J50xKQ+QB1VBzFCFjRhZUWwg8xtzJm5W8vJLUmJzhc=;
 b=c1rMUe1aLXbR5t5a0JJ4z9GrET+ACwHNVf2lUrYXerhI9OcdIRzRuJE5iWYGd/DLz8ZV17
 2KHB6NSuLNpy6fG2/SgXLsxElRFiObniFaOL/xN5sF10BH5cSBfe7vrl4u1on9QT8jgCAX
 UqXN1XifM7QsNzpXeU9qzo0xaPnQKPw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-sdiaT96FNt6UYgkHAwnQ1g-1; Fri, 27 Sep 2024 00:08:14 -0400
X-MC-Unique: sdiaT96FNt6UYgkHAwnQ1g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e08735ed9dso2134984a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410093; x=1728014893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3J50xKQ+QB1VBzFCFjRhZUWwg8xtzJm5W8vJLUmJzhc=;
 b=vJkm6c/7kIn0R+zUFgSEDBwn8vJsx8qMHmgVoleuelWCAyD1pW1b4SHTeBugfD13Zs
 YRaLT724jhiO2OSXtwyMQUrguEP2QzQUN7YpLXYmMglEjYqEKySFE2bCJuJ0Dz/RN++E
 yyA/SuCup6/jNmSnsrbS14hE4zvk7ihK8Y1O6C86NsjdFkvBMn7Ixe5rM09StNR82jph
 o/kVf481d9XkSf7iCKep7UAP/fk5DK6ADZ//laaJk1gS451RIyiSzt66nrn/TOxrfBIR
 hLVKQT2fOrtwTudVIBdVwP3/ipGuU1Yuqe56owADLM9980KghiCaVD7iaXQGr4mOiy22
 UTnw==
X-Gm-Message-State: AOJu0YzYVu8yl/NWGjWV+ZirLp07TZSNHn5l171IsU3Go+Ee5VJjLW/P
 LsXXJhRGDW3QJCUiyV7XGpkgvpLbsxrT3fzoK543rtCuCRqnp7X2fYEvldKa91HwZzb1v/CDB5i
 48h2x/6LUbNbk8K7C04SUsC3LsuKSHMuOD8t6/ajoT1dlZWJICXk22fvo13JFqJab5CRFku/W/d
 9Dl+WDQ4pWrktxIp4Z3jWDGUds93s=
X-Received: by 2002:a17:90a:bf03:b0:2dd:6969:208e with SMTP id
 98e67ed59e1d1-2e0b899c3admr2379712a91.3.1727410093334; 
 Thu, 26 Sep 2024 21:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7ONwEGYQvT5BBjI+rRKYZNPQDO//6uQgLqdEzAZYSWrTt4OwCidrkXX1+JI/pxuua/6Y3fAP361N8v75bdDY=
X-Received: by 2002:a17:90a:bf03:b0:2dd:6969:208e with SMTP id
 98e67ed59e1d1-2e0b899c3admr2379691a91.3.1727410092905; Thu, 26 Sep 2024
 21:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-10-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-10-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:07:59 +0800
Message-ID: <CACGkMEvN6gHjuoeHtZWLwKXUpDNqWZCGcFnGwhJRRy64XL9ZkA@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 11, 2024 at 1:26=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> According to spec, Page-Selective-within-Domain Invalidation (11b):
>
> 1. IOTLB entries caching second-stage mappings (PGTT=3D010b) or pass-thro=
ugh
> (PGTT=3D100b) mappings associated with the specified domain-id and the
> input-address range are invalidated.
> 2. IOTLB entries caching first-stage (PGTT=3D001b) or nested (PGTT=3D011b=
)
> mapping associated with specified domain-id are invalidated.
>
> So per spec definition the Page-Selective-within-Domain Invalidation
> needs to flush first stage and nested cached IOTLB enties as well.
>
> We don't support nested yet and pass-through mapping is never cached,
> so what in iotlb cache are only first-stage and second-stage mappings.
>
> Add a tag pgtt in VTDIOTLBEntry to mark PGTT type of the mapping and
> invalidate entries based on PGTT type.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


