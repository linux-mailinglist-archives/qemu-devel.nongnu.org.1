Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE8B9029F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Sep 2025 12:41:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dyY-0002C6-EH; Mon, 22 Sep 2025 06:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v0dyU-0002Bt-Oc
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:40:50 -0400
Received: from mail.avm.de ([2001:bf0:244:244::119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v0dyN-0005MC-Dm
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:40:46 -0400
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68d127a3-7628-7f0000032729-7f000001e9c8-1
 for <multiple-recipients>; Mon, 22 Sep 2025 12:40:35 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Mon, 22 Sep 2025 12:40:35 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025092212403541-10476 ;
 Mon, 22 Sep 2025 12:40:35 +0200 
Date: Mon, 22 Sep 2025 12:40:33 +0200
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <32x5pe3iz6v2vu5imktyxwajk4vdhamhc7yhfmtzuylcvdkunl@wvdfyo23zueh>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250919160526-mutt-send-email-mst@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 22.09.2025 12:40:35,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 22.09.2025 12:40:35, Serialize complete at 22.09.2025 12:40:35
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-purgate-ID: 149429::1758537635-B8D10866-F92CCF38/0/0
X-purgate-type: clean
X-purgate-size: 4634
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::119;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Christian Speich <c.speich@avm.de>
From:  Christian Speich via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > This removes the change introduced in [1] that prevents the use of
> > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > 
> > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > 
> > Signed-off-by: Christian Speich <c.speich@avm.de>
> > ---
> > vhost-user-device and vhost-user-device-pci started out as user
> > creatable devices. This was changed in [1] when the vhost-user-base was
> > introduced.
> > 
> > The reason given is to prevent user confusion. Searching qemu-discuss or
> > google for "vhost-user-device" I've seen no confused users.
> > 
> > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > 24.04. With newer QEMU versions we now need to patch, distribute and
> > maintain our own QEMU packages, which is non-trivial.
> > 
> > So I want to propose lifting this restriction to make this feature
> > usable without a custom QEMU.
> > 
> > [1]: 6275989647efb708f126eb4f880e593792301ed4
> 
> The confusion is after someone reuses the ID you are claiming without
> telling anyone and then linux guests will start binding that driver to
> your device.

Thanks for clarifciation, In our use-case we use mac80211_hwsim which is
in linux upstream (with the ID 29). So I think a potential reuse here
is something that linux upstream already deals with.

> 
> 
> We want people doing this kind of thing to *at a minimum*
> go ahead and register a device id with the virtio TC,
> but really to write and publish a spec.

I understand this desire, I'm not sure how this relates with the ability
to let a user create a vhost-user-device or not.

Kind Regards,
Christian

> 
> 
> > ---
> >  docs/system/devices/vhost-user.rst | 10 ----------
> >  hw/virtio/vhost-user-device-pci.c  |  3 ---
> >  hw/virtio/vhost-user-device.c      |  3 ---
> >  3 files changed, 16 deletions(-)
> > 
> > diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> > index 35259d8ec7c666aa0c56497b8261f48d77216ad5..2d130f9767dbb1cbb85cef43c63dc9a8d7b30d4a 100644
> > --- a/docs/system/devices/vhost-user.rst
> > +++ b/docs/system/devices/vhost-user.rst
> > @@ -73,16 +73,6 @@ all the required parameters including:
> >    - The ``num_vqs`` it needs and their ``vq_size``
> >    - The ``config_size`` if needed
> >  
> > -.. note::
> > -  To prevent user confusion you cannot currently instantiate
> > -  vhost-user-device without first patching out::
> > -
> > -    /* Reason: stop inexperienced users confusing themselves */
> > -    dc->user_creatable = false;
> > -
> > -  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> > -  rebuilding.
> > -
> >  vhost-user daemon
> >  =================
> >  
> > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
> > index f10bac874e78429c633752a4ce9db28385b3bb07..c76a856c9b9a67d941a93929244216658ff2a156 100644
> > --- a/hw/virtio/vhost-user-device-pci.c
> > +++ b/hw/virtio/vhost-user-device-pci.c
> > @@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
> >      VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> >      PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> >  
> > -    /* Reason: stop users confusing themselves */
> > -    dc->user_creatable = false;
> > -
> >      k->realize = vhost_user_device_pci_realize;
> >      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> >      pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> > diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
> > index 3939bdf755222a281da8ca22243d7d4f16990a66..1bea496afd0137ba9b42009f6252acf6800528d1 100644
> > --- a/hw/virtio/vhost-user-device.c
> > +++ b/hw/virtio/vhost-user-device.c
> > @@ -41,9 +41,6 @@ static void vud_class_init(ObjectClass *klass, const void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >  
> > -    /* Reason: stop inexperienced users confusing themselves */
> > -    dc->user_creatable = false;
> > -
> >      device_class_set_props(dc, vud_properties);
> >      dc->vmsd = &vud_vmstate;
> >      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > 
> > ---
> > base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
> > change-id: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2
> > 
> > Best regards,
> > -- 
> > Christian Speich <c.speich@avm.de>
> 
> 

