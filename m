Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5B7A828C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwqN-0003VP-CJ; Wed, 20 Sep 2023 09:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiwqL-0003Qf-Gm
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiwqJ-0007Av-F7
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695214930;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pn9tQFZSmkS90/ZhO+Tany+xtrvcQ5vG8LuN7U7+Xek=;
 b=Yqtn1fNLEAW0SgMSPPSHoTiWY4ZYe3rSAcniwnMuvNOu3Kui0KV7d8R3+OzgieYkBD8M4S
 4NFW+jxjpD6fnEl1gdMIaD6OSGH6xS4P1XuePVTfvQpDIeGFZTz/HPBbwjVeVDoJpt4D9L
 D7m4dpyytxIz/yyGX0v1aLwa/I2LrhQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-pvpa_F3IMmKluyHG_TXq3A-1; Wed, 20 Sep 2023 09:02:06 -0400
X-MC-Unique: pvpa_F3IMmKluyHG_TXq3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB6F2100E2E1;
 Wed, 20 Sep 2023 13:02:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 005AC40C2009;
 Wed, 20 Sep 2023 13:01:46 +0000 (UTC)
Date: Wed, 20 Sep 2023 14:01:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <ZQrtMxCnbcXvwLMc@redhat.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920125103.GS13733@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Wed, Sep 20, 2023 at 09:51:03AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 02:19:42PM +0200, Cédric Le Goater wrote:
> > On 9/20/23 05:42, Duan, Zhenzhong wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Cédric Le Goater <clg@redhat.com>
> > > > Sent: Wednesday, September 20, 2023 1:08 AM
> > > > Subject: Re: [PATCH v1 15/22] Add iommufd configure option
> > > > 
> > > > On 8/30/23 12:37, Zhenzhong Duan wrote:
> > > > > This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> > > > > iommufd support, enabled by default.
> > > > 
> > > > Why would someone want to disable support at compile time ? It might
> > > 
> > > For those users who only want to support legacy container feature?
> > > Let me know if you still prefer to drop this patch, I'm fine with that.
> > 
> > I think it is too early.
> > 
> > > > have been useful for dev but now QEMU should self-adjust at runtime
> > > > depending only on the host capabilities AFAIUI. Am I missing something ?
> > > 
> > > IOMMUFD doesn't support all features of legacy container, so QEMU
> > > doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> > > We need to specify it explicitly to use IOMMUFD as below:
> > > 
> > >      -object iommufd,id=iommufd0
> > >      -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
> > 
> > OK. I am not sure this is the correct interface yet. At first glance,
> > I wouldn't introduce a new object for a simple backend depending on a
> > kernel interface. I would tend to prefer a "iommu-something" property
> > of the vfio-pci device with string values: "legacy", "iommufd", "default"
> > and define the various interfaces (the ops you proposed) for each
> > depending on the user preference and the capabilities of the host and
> > possibly the device.
> 
> I think the idea came from Alex? The major point is to be able to have
> libvirt open /dev/iommufd and FD pass it into qemu and then share that
> single FD across all VFIOs. qemu will typically not be able to
> self-open /dev/iommufd as it is root-only.
> 
> So the object is not exactly for the backend, the object is for the
> file descriptor.

Assuming we must have the exact same FD used for all vfio-pci devices,
then using -object iommufd is the least worst way to get that FD
injected into QEMU from libvirt. It is a little sucky in that when
hotplugging/unplugging devices, libvirt has to think about whether or
not it has to object_add/object_del  the iommufd> again I don't see
better options considering the need to have a single global FD.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


