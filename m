Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32D7A8B86
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1lz-0000uM-Jm; Wed, 20 Sep 2023 14:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qj1lw-0000tF-UT
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qj1lu-0000Vu-Nk
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695233876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U73A62n0d0QOiX+2aNVrsIcYezEK8l8qH7vE1ZK8IgM=;
 b=b9SgbrHnHn4a0WsneVAgeNx3dlDCtcm0KzDxNNL0/Ncnvz3qtS5oZ+cXwQdEi6sRpfuL/N
 Rv95GgdYw3oOZF8hBZTgwImqxLc1pA2JutW4JRcDrqnv7ZzALDKVW31GAra4n9hVAs91BB
 A+OKlOzU5J0rl6q797CUeRoRiKcRRW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-khj0E5-WOXG9uvZ3dWDiUw-1; Wed, 20 Sep 2023 14:17:41 -0400
X-MC-Unique: khj0E5-WOXG9uvZ3dWDiUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 813DB817050;
 Wed, 20 Sep 2023 18:15:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B8D51E3;
 Wed, 20 Sep 2023 18:15:56 +0000 (UTC)
Date: Wed, 20 Sep 2023 19:15:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laine Stump <laine@redhat.com>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <ZQs22Wo+5YXfYvoR@redhat.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230920120142.1a517d0c.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920120142.1a517d0c.alex.williamson@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 20, 2023 at 12:01:42PM -0600, Alex Williamson wrote:
> On Wed, 20 Sep 2023 03:42:20 +0000
> "Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:
> 
> > >-----Original Message-----
> > >From: Cédric Le Goater <clg@redhat.com>
> > >Sent: Wednesday, September 20, 2023 1:08 AM
> > >Subject: Re: [PATCH v1 15/22] Add iommufd configure option
> > >
> > >On 8/30/23 12:37, Zhenzhong Duan wrote:  
> > >> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> > >> iommufd support, enabled by default.  
> > >
> > >Why would someone want to disable support at compile time ? It might  
> > 
> > For those users who only want to support legacy container feature?
> > Let me know if you still prefer to drop this patch, I'm fine with that.
> > 
> > >have been useful for dev but now QEMU should self-adjust at runtime
> > >depending only on the host capabilities AFAIUI. Am I missing something ?  
> > 
> > IOMMUFD doesn't support all features of legacy container, so QEMU
> > doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> > We need to specify it explicitly to use IOMMUFD as below:
> > 
> >     -object iommufd,id=iommufd0
> >     -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
> 
> There's an important point here that maybe we've let slip for too long.
> Laine had asked in an internal forum whether the switch to IOMMUFD was
> visible to the guest.  I replied that it wasn't, but this note about
> IOMMUFD vs container features jogged my memory that I think we still
> lack p2p support with IOMMUFD, ie. IOMMU mapping of device MMIO.  It
> seemed like there was something else too, but I don't recall without
> some research.
> 
> Ideally we'd have feature parity and libvirt could simply use the
> native IOMMUFD interface whenever both the kernel and QEMU support it.
> 
> Without that parity, when does libvirt decide to use IOMMUFD?
> 
> How would libvirt know if some future IOMMUFD does have parity?
> 
> Does the XML direct this through some new interpretation of the driver
> field? ex. "vfio-container" vs "vfio-iommufd" where "vfio" becomes an
> alias or priority preference.  Thanks,

Right now a host device would have


  <hostdev mode='subsystem' type='mdev' model='vfio-pci'>
   ...
  </hostdev>

where model could also accept 'vfio-ccw' / 'vfio-ap' on s390x IIUC.

If the use of IOMMUFD has guest ABI feature differences, then we
would need to treat this as a new device model in libvirt, ie add
vfio-iommu-pci model.   Does thos iommufd work with vfio-ccw / vfio-ap
too ? If so we'd need new models for those too in libvirt.

The downside of this is that it means no appication is going to
use iommufd mode without having explicit coding done to make it
aware of the new model in libvirt.

If we /want/ apps to move over to iommufd approach in a finite
short timeframe then IMHO achieving feature parity is critical
as feature partiy would let libvirt switch over to it automatically
and avoid the pain of updating any apps. This would be my preference,
as exposing the iommufd concept to apps feels wrong - this is an
internal impl detail ideally. Again we must have feature parity
for this to work though.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


