Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA83719AA7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gBz-0002vc-Ot; Thu, 01 Jun 2023 07:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4gBn-0002up-6t
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4gBl-0006xi-Cp
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685617792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umOEsvoVpN+CfaNYbLVn29TbYSELlGs1n6uz37Sg2A4=;
 b=iIAnjAMxa/t0mkfy3frm8C+Nem50v1cUKHaHDuHcdnvZdpBBs0LcPovk5s1O5+CIBK0a5l
 3u9yNhhI3iODniiGdNSPNOIsIoqrMc+eZMoGvrLoPkq9K0qcWiAZAmy0gwJX0lFE8aPyQe
 ci2r22dNP5f86jk2c66JtVs8z65HbSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-zeSIHC4EOUqx0YgqmAhUEQ-1; Thu, 01 Jun 2023 07:09:51 -0400
X-MC-Unique: zeSIHC4EOUqx0YgqmAhUEQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso4934495e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685617790; x=1688209790;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=umOEsvoVpN+CfaNYbLVn29TbYSELlGs1n6uz37Sg2A4=;
 b=kjptxMgmQBJb4m4P40tJg98pTFBj+G75JsWq12CID+4+RPKhkMqcN2tuYzOKvDZnFo
 qm++ry6NIvjhlItNuv+FM9AgxRqLeJ33+Ubg+OsafcRBuN0dCR8+H+2Wig7qQJzV3Chv
 5Bis+l4+U06EtYGlSl5xr8RqhefxKJBmg3QfWglCQrIa3BXhvC+aF4/lB16ZAj/IiAba
 u9rDWtKkL1/dukouymw7nxbeMlvlZ1b0Va0iw/daj+w8XkwvvdcGmgBB9EQOtZI81+dO
 U3nCYNaAkDZKTEveoi5LqQHdbJLSaNoLs7/TJRVnJ7oZqZX6amlYJKyu7bPlgVZ+RhiH
 53VQ==
X-Gm-Message-State: AC+VfDyy8ALGLe4RMVSbi8xj4AC4af7Zg+U68RR+n2hBj3VFJOWaMNQD
 kyUeWsh8rXTnKfUORNQxE7k0yaVBZ68dyuFtzpQzLDV4i105jTp78/YnJt65mBMeJ2yl+7cCTsq
 98M6MckMKzW2UPj8=
X-Received: by 2002:a5d:69c7:0:b0:30a:f2bf:65d9 with SMTP id
 s7-20020a5d69c7000000b0030af2bf65d9mr1365882wrw.52.1685617789830; 
 Thu, 01 Jun 2023 04:09:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4eSz/YXvs7y7V8PMkdH+v0hfPKAHMSVDnBSK+OC2Y9kNd2SqMXCliVwgclOCPC3hr5/8JFBQ==
X-Received: by 2002:a5d:69c7:0:b0:30a:f2bf:65d9 with SMTP id
 s7-20020a5d69c7000000b0030af2bf65d9mr1365855wrw.52.1685617789527; 
 Thu, 01 Jun 2023 04:09:49 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 m7-20020a056000180700b003062d815fa6sm9949140wrh.85.2023.06.01.04.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:09:48 -0700 (PDT)
Date: Thu, 1 Jun 2023 07:09:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com, jusual@redhat.com,
 jon.grimm@amd.com, santosh.Shukla@amd.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1024
Message-ID: <20230601070912-mutt-send-email-mst@kernel.org>
References: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
 <39a49814-28d8-ffc8-42b4-3af14bb9dd47@oracle.com>
 <ZHhwOrfXMjjOmcAK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHhwOrfXMjjOmcAK@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 11:17:30AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 01, 2023 at 11:09:45AM +0100, Joao Martins wrote:
> > 
> > 
> > On 31/05/2023 23:51, Suravee Suthikulpanit wrote:
> > > Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> > > arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
> > > 
> > > In case KVM could not support the specified number of vcpus, QEMU would
> > > return the following error message:
> > > 
> > >   qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument
> > > 
> > > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > ---
> > > 
> > > Changes from V1:
> > > (https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
> > >  * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)
> > > 
> > > Note:
> > >  From the last discussion, Daniel mentioned that SMBIO 2.1 tables might
> > >  cause overflow at approx 720 CPUs, and it might require using the
> > >  SMBIO 3.0 entry point. Also, we might need to change the default for
> > >  the x86 machine type to SMBIO 3.0. However, I do not know the status
> > >  of this.
> > > 
> > I suspect smbios 3.0 (64-bit entry point) is already supported.
> > 
> > With current qemu and all the smbios fixes in the last cycle, perhaps this is
> > mainly just setting smbios_entry_point_type to SMBIOS_ENTRY_POINT_TYPE_64 if
> > MachineState::smp::max_cpus is bigger than 720 (e.g. in pc_q35_init()?)
> 
> The need for the 64-bit entry point depends on a combination of RAM config
> and CPU count. IMHO we need to unconditionally switch the latest machine
> types to use the 64-bit entry point by default, rather than trying to infer
> some special condition to dynamically change on the fly.

Yes, makes sense.

> Before doing that we need confirmation that our firmware builds in qemu.git
> (SeaBIOS and EDK2) will be happy with the 64-bit EP. I suspect they should
> be fine by now, but I've CC'd Gerd to confirm.
> 
> With regards,
> Daniel



