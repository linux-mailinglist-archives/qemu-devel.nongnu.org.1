Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C672A765D89
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7Yz-0005Vq-7f; Thu, 27 Jul 2023 16:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Yu-0005T9-76
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Yr-00031J-SW
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690489572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lK7q/PNrnTqJeodFvh3DN1YVV8pYI71vpHd8SgAAXIM=;
 b=URDOzQ6CQyvFH8NMkHQJafIPaVF/RpcwzhCaeDT+5JC+fBaEdjuZWwKeCLA7o3T6Xro4+I
 KgkpAe3S4wXMVQsLSlGyPFRubFhGxrpERysj7pqeDFyJp9s5S81TpSla6V1aAotCDd69f+
 NsCB8JgAcm1eLacMmAmTSgQUyZk6ANw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-hx2dUFRPO5-aiS8uoAwaGw-1; Thu, 27 Jul 2023 16:26:08 -0400
X-MC-Unique: hx2dUFRPO5-aiS8uoAwaGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C0FC3811F22;
 Thu, 27 Jul 2023 20:26:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB3ED2014F87;
 Thu, 27 Jul 2023 20:26:07 +0000 (UTC)
Date: Thu, 27 Jul 2023 16:26:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: longpeng2@huawei.com
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
Message-ID: <20230727202605.GB986673@fedora>
References: <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
 <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
 <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
 <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
 <CAJaqyWet7vjS+4qy5TWBWm9j7jyf8Cm4rv_0t-eYB-PMDrKjpQ@mail.gmail.com>
 <64443883-5e35-0088-561f-4f0e77c59037@redhat.com>
 <CAJaqyWd-bdA5CgdEvMoiAOWGUzUZV+Urvd4WW7+BFqSbhC0FqQ@mail.gmail.com>
 <bc1f4b18-8bf9-f8ac-fa47-babde355e340@redhat.com>
 <CAJaqyWcqGU7iBEuSgDWuWQY_D8GcavBbjnywnf+xqqS+SpAq9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O+WA7KY4t6jydAzZ"
Content-Disposition: inline
In-Reply-To: <CAJaqyWcqGU7iBEuSgDWuWQY_D8GcavBbjnywnf+xqqS+SpAq9Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--O+WA7KY4t6jydAzZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 02:49:04PM +0200, Eugenio Perez Martin wrote:
> On Wed, Jul 26, 2023 at 8:57=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com=
> wrote:
> >
> > On 25.07.23 20:53, Eugenio Perez Martin wrote:
> > > On Tue, Jul 25, 2023 at 3:09=E2=80=AFPM Hanna Czenczek <hreitz@redhat=
=2Ecom> wrote:
> > >> On 25.07.23 12:03, Eugenio Perez Martin wrote:
> > >>> On Tue, Jul 25, 2023 at 9:53=E2=80=AFAM Hanna Czenczek <hreitz@redh=
at.com> wrote:
> > >>>> On 24.07.23 17:48, Eugenio Perez Martin wrote:
> > >>>>> On Fri, Jul 21, 2023 at 6:07=E2=80=AFPM Hanna Czenczek <hreitz@re=
dhat.com> wrote:
> > >>>>>> On 21.07.23 17:25, Eugenio Perez Martin wrote:
> > >>>>>>> On Tue, Jul 11, 2023 at 5:52=E2=80=AFPM Hanna Czenczek <hreitz@=
redhat.com> wrote:
> > >>>>>>>> Move the `suspended` field from vhost_vdpa into the global vho=
st_dev
> > >>>>>>>> struct, so vhost_dev_stop() can check whether the back-end has=
 been
> > >>>>>>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it=
 has,
> > >>>>>>>> there is no need to reset it; the reset is just a fall-back to=
 stop
> > >>>>>>>> device operations for back-ends that do not support suspend.
> > >>>>>>>>
> > >>>>>>>> Unfortunately, for vDPA specifically, RESUME is not yet implem=
ented, so
> > >>>>>>>> when the device is re-started, we still have to do the reset t=
o have it
> > >>>>>>>> un-suspend.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > >>>>>>>> ---
> > >>>>>>>>      include/hw/virtio/vhost-vdpa.h |  2 --
> > >>>>>>>>      include/hw/virtio/vhost.h      |  8 ++++++++
> > >>>>>>>>      hw/virtio/vhost-vdpa.c         | 11 +++++++----
> > >>>>>>>>      hw/virtio/vhost.c              |  8 +++++++-
> > >>>>>>>>      4 files changed, 22 insertions(+), 7 deletions(-)
> > >>>>>>>>
> > >>>>>>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virti=
o/vhost-vdpa.h
> > >>>>>>>> index e64bfc7f98..72c3686b7f 100644
> > >>>>>>>> --- a/include/hw/virtio/vhost-vdpa.h
> > >>>>>>>> +++ b/include/hw/virtio/vhost-vdpa.h
> > >>>>>>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
> > >>>>>>>>          bool shadow_vqs_enabled;
> > >>>>>>>>          /* Vdpa must send shadow addresses as IOTLB key for d=
ata queues, not GPA */
> > >>>>>>>>          bool shadow_data;
> > >>>>>>>> -    /* Device suspended successfully */
> > >>>>>>>> -    bool suspended;
> > >>>>>>>>          /* IOVA mapping used by the Shadow Virtqueue */
> > >>>>>>>>          VhostIOVATree *iova_tree;
> > >>>>>>>>          GPtrArray *shadow_vqs;
> > >>>>>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vho=
st.h
> > >>>>>>>> index 6a173cb9fa..69bf59d630 100644
> > >>>>>>>> --- a/include/hw/virtio/vhost.h
> > >>>>>>>> +++ b/include/hw/virtio/vhost.h
> > >>>>>>>> @@ -120,6 +120,14 @@ struct vhost_dev {
> > >>>>>>>>          uint64_t backend_cap;
> > >>>>>>>>          /* @started: is the vhost device started? */
> > >>>>>>>>          bool started;
> > >>>>>>>> +    /**
> > >>>>>>>> +     * @suspended: Whether the vhost device is currently susp=
ended.  Set
> > >>>>>>>> +     * and reset by implementations (vhost-user, vhost-vdpa, =
=2E..), which
> > >>>>>>>> +     * are supposed to automatically suspend/resume in their
> > >>>>>>>> +     * vhost_dev_start handlers as required.  Must also be cl=
eared when
> > >>>>>>>> +     * the device is reset.
> > >>>>>>>> +     */
> > >>>>>>>> +    bool suspended;
> > >>>>>>>>          bool log_enabled;
> > >>>>>>>>          uint64_t log_size;
> > >>>>>>>>          Error *migration_blocker;
> > >>>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > >>>>>>>> index 7b7dee468e..f7fd19a203 100644
> > >>>>>>>> --- a/hw/virtio/vhost-vdpa.c
> > >>>>>>>> +++ b/hw/virtio/vhost-vdpa.c
> > >>>>>>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(stru=
ct vhost_dev *dev,
> > >>>>>>>>
> > >>>>>>>>      static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> > >>>>>>>>      {
> > >>>>>>>> -    struct vhost_vdpa *v =3D dev->opaque;
> > >>>>>>>>          int ret;
> > >>>>>>>>          uint8_t status =3D 0;
> > >>>>>>>>
> > >>>>>>>>          ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &=
status);
> > >>>>>>>>          trace_vhost_vdpa_reset_device(dev);
> > >>>>>>>> -    v->suspended =3D false;
> > >>>>>>>> +    dev->suspended =3D false;
> > >>>>>>>>          return ret;
> > >>>>>>>>      }
> > >>>>>>>>
> > >>>>>>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vh=
ost_dev *dev)
> > >>>>>>>>              if (unlikely(r)) {
> > >>>>>>>>                  error_report("Cannot suspend: %s(%d)", g_stre=
rror(errno), errno);
> > >>>>>>>>              } else {
> > >>>>>>>> -            v->suspended =3D true;
> > >>>>>>>> +            dev->suspended =3D true;
> > >>>>>>>>                  return;
> > >>>>>>>>              }
> > >>>>>>>>          }
> > >>>>>>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct =
vhost_dev *dev, bool started)
> > >>>>>>>>                  return -1;
> > >>>>>>>>              }
> > >>>>>>>>              vhost_vdpa_set_vring_ready(dev);
> > >>>>>>>> +        if (dev->suspended) {
> > >>>>>>>> +            /* TODO: When RESUME is available, use it instead=
 of resetting */
> > >>>>>>>> +            vhost_vdpa_reset_status(dev);
> > >>>>>>> How is that we reset the status at each vhost_vdpa_dev_start? T=
hat
> > >>>>>>> will clean all the vqs configured, features negotiated, etc. in=
 the
> > >>>>>>> vDPA device. Or am I missing something?
> > >>>>>> What alternative do you propose?  We don=E2=80=99t have RESUME f=
or vDPA in qemu,
> > >>>>>> but we somehow need to lift the previous SUSPEND so the device w=
ill
> > >>>>>> again respond to guest requests, do we not?
> > >>>>>>
> > >>>>> Reset also clears the suspend state in vDPA, and it should be cal=
led
> > >>>>> at vhost_dev_stop. So the device should never be in suspended sta=
te
> > >>>>> here. Does that solve your concerns?
> > >>>> My intention with this patch was precisely not to reset in
> > >>>> vhost_dev_stop when suspending is supported.  So now I=E2=80=99m m=
ore confused
> > >>>> than before.
> > >>>>
> > >>> At this moment, I think that should be focused as an optimization a=
nd
> > >>> not to be included in the main series.
> > >> It is absolutely not an optimization but vital for my use case.
> > >> virtiofsd does not currently implement resetting, but if it did (and=
 we
> > >> want this support in the future), resetting it during stop/cont woul=
d be
> > >> catastrophic.  There must be a way to have qemu not issue a reset.  =
This
> > >> patch is the reason why this series exists.
> > >>
> > > Sorry, I see I confused things with the first reply. Let me do a reca=
p.
> > >
> > > If I understand the problem correctly, your use case requires that
> > > qemu does not reset the device before the device state is fetched with
> > > virtio_save in the case of a migration.
> >
> > That is only part of the problem, the bigger picture has nothing to do
> > with migration at all.  The problem is that when the VM is paused
> > (stop), we invoke vhost_dev_stop(), and when it is resumed (cont), we
> > invoke vhost_dev_start().  To me, it therefore sounds absolutely wrong
> > to reset the back-end in either of these functions.  For stateless
> > devices, it was determined to not be an issue (I still find it extremely
> > strange), and as far as I=E2=80=99ve understood, we=E2=80=99ve come to =
the agreement
> > that it=E2=80=99s basically a fallback for when there is no other way t=
o stop
> > the back-end.  But stateful devices like virtio-fs would be completely
> > broken by resetting them there.
> >
> > Therefore, if virtiofsd did implement reset through SET_STATUS,
> > stop/cont would break it today.  Maybe other vhost-user devices, too,
> > which just implement RESET_OWNER/RESET_DEVICE, which aren=E2=80=99t eve=
n called
> > when the device is supposed to be reset in vhost_dev_stop() (patch 6).
> >
> > So not just because of migration, but in general, there must be a way
> > for back-ends to force qemu not to reset them in vhost_dev_start()/stop=
().
> >
> > Or we stop using vhost_dev_start()/stop() when the VM is paused/resumed
> > (stop/cont).
> >
>=20
> Yes, that comes back to the thread [1].
>=20
> As a third alternative, you can keep vhost_dev_start and let the
> function check the current state and initialize the device only if
> needed. But you can keep symmetrical functions and call one or another
> at the device's code, of course. Not sure what is cleaner or requires
> less changes.
>=20
> > > This is understandable and I
> > > think we have a solution for that: to move the vhost_ops call to
> > > virtio_reset and the end of virtio_save.
> >
> > Why would we reset the device in virtio_save()?
> >
>=20
> If the VM continues in the source because of whatever reason,
> vhost_dev_start would expect the device to be clean. You can test it
> with the command "cont" after the LM.
>=20
> > > To remove the reset call from
> > > vhost_dev_stop is somehow mandatory, as it is called before
> > > virtio_save.
> > >
> > > But we cannot move to vhost_vdpa_dev_start, as proposed here. The rea=
sons are:
> > > * All the features, vq parameters, etc are set before any
> > > vhost_vdpa_dev_start call. To reset at any vhost_vdpa_dev_start would
> > > wipe them.
> > > * The device needs to hold all the resources until it is reset. Things
> > > like descriptor status etc.
> > >
> > > And, regarding the comment "When RESUME is available, use it instead
> > > of resetting", we cannot use resume to replace reset in all cases.
> > > This is because the semantics are different.
> > >
> > > For example, vhost_dev_stop and vhost_dev_start are also called when
> > > the guest reset by itself the device. You can check it rmmoding and
> > > modprobing virtio-net driver, for example. In this case, the driver
> > > expects to find all vqs to start with 0, but the resume must not reset
> > > these indexes.
> >
> > This isn=E2=80=99t quite clear to me.  I understand this to mean that t=
here must
> > be a reset somewhere in vhost_dev_stop() and/or vhost_dev_start().  But
> > above, you proposed moving the reset from vhost_dev_stop() into
> > virtio_reset().  Is virtio_reset() called in addition to
> > vhost_dev_stop() and vhost_dev_start() when the guest driver is changed?
> >
>=20
> Right. Maybe another option is virtio_set_status?
>=20
> The point is that other parts of qemu / guest trust the device to be
> reset after (current version of) vhost_dev_stop, so if we are going to
> move the reset it must be added to the callers at least. To trace
> these callers is needed, so maybe it is easy to add another function
> (vhost_dev_suspend?), your first alternative.
>=20
> > Because we can=E2=80=99t have an always-present reset in vhost_dev_stop=
() or
> > vhost_dev_start().  It just doesn=E2=80=99t work with stop/cont.  At th=
e same
> > time, I understand that you say we must have it because
> > vhost_dev_{stop,start}() are also used when the guest driver changes.
> > Consequently, it sounds clear to me that using the exact same functions
> > in stop/cont and when the guest driver is unloaded/loaded is and has
> > always been wrong.  Because in stop/cont, the guest driver never
> > changes, so we shouldn=E2=80=99t tell the back-end that it did (by send=
ing
> > SET_STATUS(0)).
> >
>=20
> Talking just about vhost_net here, the device dumps all the state
> (like vqs) to qemu in vhost_dev_stop. That is what allows to have, for
> example, an unified code in migrating: qemu only needs to know how to
> migrate its emulated device, and vhost code just writes or read at
> suspend / continue or live migrating. To suspend and continue is the
> same operation actually for vhost_net.

Hi Longpeng,
This discussion made me realize that --device vhost-vdpa-device-pci does
not support stateful vDPA devices.

For example, a vdpa-net device that implements the controlq will lose
state (e.g. packet receive filtering) when the guest is stopped with the
QEMU 'stop' command.

QEMU needs to use the VHOST_VDPA_RESUME ioctl so it can resume stateful
devices instead of resetting them across 'stop'/'cont'.

Whatever solution we agree on in this thread should also work for
vhost-vdpa and solve the issue for --device vhost-vdpa-device-pci.

Stefan

--O+WA7KY4t6jydAzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTC0t0ACgkQnKSrs4Gr
c8jjJggAgxBv944bL8fqCaz+b0YuusgRvrBfAL0bWTezSZCSNIGR0PZpzIiZXcLp
YQr7SAPTHRub1YJXOGnKIz9ZOEHJ1pgKgBMZ6C8QtEBENCH5SPIyqhEiqNrA4gvU
vtOhl08QS0cX16hc+llrQpErc7oKksEU2tkFEh5RMwtdHmC8Cs/YagtTdxFzleHu
77tAKec0rFvyKEcXLsnH2Cdl9p7bTjZ3zyOKB5AKLErA48mzzsG7B1eybULYXH5y
iVlNFkh20PSSeEyrLQZboXVm6ym0v5z7NQ7RJQaDqfGQAG+iPyFF3iwRmEvwNjAa
MRo2a8GXbu30VJeLwwOeJn96eMm2Xg==
=ifdt
-----END PGP SIGNATURE-----

--O+WA7KY4t6jydAzZ--


