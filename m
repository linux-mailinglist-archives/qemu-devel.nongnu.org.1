Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281878A69B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWng-0006aw-4V; Mon, 28 Aug 2023 03:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qaWnd-0006aU-R1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qaWna-0004KS-O2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693208193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AEK1hgEIe+yoOptBV+HHocL8E2GbM7XvXvBOK9Yiq8=;
 b=Yz5fUikse3Tn5FHawpFksOksicQmqnXe78107eYRjRe8QSHF9u+c7GU0k0+NCZygHY0GYx
 TzKkb4r6Vczy4l5igVtehd/nSJONNiH38wh/xDWUz8XVQOsUBmvPX2KJAHtpuSmhPTGHZB
 FKOb951ljkpt9B5qVfRzTfrFa82tIpE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-ja8XCuKaNji-AMdtCO4jYw-1; Mon, 28 Aug 2023 03:35:26 -0400
X-MC-Unique: ja8XCuKaNji-AMdtCO4jYw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-500983fde5fso3180517e87.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208124; x=1693812924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AEK1hgEIe+yoOptBV+HHocL8E2GbM7XvXvBOK9Yiq8=;
 b=UACBBm/byZYzPs0Yw0dAllNBg4t09pVCWV7WZOs1fhX29S7x31jTWtQaI58uMY7b45
 9fM8ZY2fF2q96dDdbrqAZ/EUjMyfrSeXrgGcxN8Zhyh78fEKIsmyrwsoXPzXIKAb1fET
 3lZSC/sgUqkcwEkYFY0xUgJIhGeCZWayFJ9fg4gRC6TWk5rJNSkPWElZxiQ7+B9McPyX
 8ojpOFJOG0Ym/oPoJYsx+JbGh2afo/evyPUNy3yLDoNUTXSJuaHoROVaAz07CWeGHN3n
 0kbtQJoxFEiBsAcPCZLO/UtG0n5L6gDe07K+R4s3QfISDmNfYz7C4OEfQjoYnKxmgbU/
 afZA==
X-Gm-Message-State: AOJu0Yz/iP4dRs/qYoNRBPRcb36k0tEtA1RwQQWhLNlI9bP409RM9+ue
 QHtxPF+HsD4aIoZzcoK22XJe07HOBD0rrzahY3SvqNDuvfEM8BBr9713McFShSSByUOsqFMR+W/
 JcqzizR5wal2Gm9+tj6mGaQBjJ/tL/r0=
X-Received: by 2002:a05:6512:3996:b0:500:b63f:4db3 with SMTP id
 j22-20020a056512399600b00500b63f4db3mr2836943lfu.35.1693208124326; 
 Mon, 28 Aug 2023 00:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGA8A6PVRNz5amtsL88I+B2IFAbePNrVJK31WXjlkD9D00k66+mx0ee4HfAyRTY7+YcxxxKtqJ0UQGqOICd6g=
X-Received: by 2002:a05:6512:3996:b0:500:b63f:4db3 with SMTP id
 j22-20020a056512399600b00500b63f4db3mr2836917lfu.35.1693208123936; Mon, 28
 Aug 2023 00:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-6-avihaih@nvidia.com>
 <70d4e9ec-f2f1-ccf0-4391-1f16fb15c641@redhat.com>
In-Reply-To: <70d4e9ec-f2f1-ccf0-4391-1f16fb15c641@redhat.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Mon, 28 Aug 2023 15:35:12 +0800
Message-ID: <CAGYh1E_wmCeA_BFEZa=JP+AjAhA2cz9rTPgya16KoRRBkpNTWw@mail.gmail.com>
Subject: Re: [PATCH for-8.2 v3 5/6] vfio/migration: Add P2P support for VFIO
 migration
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Test result of multiple Mellanox CX-7 VFs migration:  PASS
[1] create two VFs and bind them to mlx5_vfio_pci driver
[2] start a VM with two VFs
[3] migrate the VM
[4] check if the VM works well

Tested-by: YangHang Liu <yanghliu@redhat.com>

Best Regards,
YangHang Liu


On Wed, Aug 2, 2023 at 4:43=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> On 8/2/23 10:14, Avihai Horon wrote:
> > VFIO migration uAPI defines an optional intermediate P2P quiescent
> > state. While in the P2P quiescent state, P2P DMA transactions cannot be
> > initiated by the device, but the device can respond to incoming ones.
> > Additionally, all outstanding P2P transactions are guaranteed to have
> > been completed by the time the device enters this state.
> >
> > The purpose of this state is to support migration of multiple devices
> > that might do P2P transactions between themselves.
> >
> > Add support for P2P migration by transitioning all the devices to the
> > P2P quiescent state before stopping or starting the devices. Use the ne=
w
> > VMChangeStateHandler prepare_cb to achieve that behavior.
> >
> > This will allow migration of multiple VFIO devices if all of them
> > support P2P migration.
> >
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
> > ---
> >   docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++-------------=
-
> >   hw/vfio/common.c              |  6 ++-
> >   hw/vfio/migration.c           | 46 +++++++++++++++--
> >   hw/vfio/trace-events          |  1 +
> >   4 files changed, 105 insertions(+), 41 deletions(-)
> >
> > diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.=
rst
> > index b433cb5bb2..605fe60e96 100644
> > --- a/docs/devel/vfio-migration.rst
> > +++ b/docs/devel/vfio-migration.rst
> > @@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and l=
oaded in the destination
> >   before stopping the source VM. Enabling this migration capability wil=
l
> >   guarantee that and thus, can potentially reduce downtime even further=
.
> >
> > -Note that currently VFIO migration is supported only for a single devi=
ce. This
> > -is due to VFIO migration's lack of P2P support. However, P2P support i=
s planned
> > -to be added later on.
> > +To support migration of multiple devices that might do P2P transaction=
s between
> > +themselves, VFIO migration uAPI defines an intermediate P2P quiescent =
state.
> > +While in the P2P quiescent state, P2P DMA transactions cannot be initi=
ated by
> > +the device, but the device can respond to incoming ones. Additionally,=
 all
> > +outstanding P2P transactions are guaranteed to have been completed by =
the time
> > +the device enters this state.
> > +
> > +All the devices that support P2P migration are first transitioned to t=
he P2P
> > +quiescent state and only then are they stopped or started. This makes =
migration
> > +safe P2P-wise, since starting and stopping the devices is not done ato=
mically
> > +for all the devices together.
> > +
> > +Thus, multiple VFIO devices migration is allowed only if all the devic=
es
> > +support P2P migration. Single VFIO device migration is allowed regardl=
ess of
> > +P2P migration support.
> >
> >   A detailed description of the UAPI for VFIO device migration can be f=
ound in
> >   the comment for the ``vfio_device_mig_state`` structure in the header=
 file
> > @@ -132,54 +144,63 @@ will be blocked.
> >   Flow of state changes during Live migration
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -Below is the flow of state change during live migration.
> > +Below is the state change flow during live migration for a VFIO device=
 that
> > +supports both precopy and P2P migration. The flow for devices that don=
't
> > +support it is similar, except that the relevant states for precopy and=
 P2P are
> > +skipped.
> >   The values in the parentheses represent the VM state, the migration s=
tate, and
> >   the VFIO device state, respectively.
> > -The text in the square brackets represents the flow if the VFIO device=
 supports
> > -pre-copy.
> >
> >   Live migration save path
> >   ------------------------
> >
> >   ::
> >
> > -                        QEMU normal running state
> > -                        (RUNNING, _NONE, _RUNNING)
> > -                                  |
> > +                           QEMU normal running state
> > +                           (RUNNING, _NONE, _RUNNING)
> > +                                      |
> >                        migrate_init spawns migration_thread
> > -                Migration thread then calls each device's .save_setup(=
)
> > -                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
> > -                                  |
> > -                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
> > -      If device is active, get pending_bytes by .state_pending_{estima=
te,exact}()
> > -          If total pending_bytes >=3D threshold_size, call .save_live_=
iterate()
> > -                  [Data of VFIO device for pre-copy phase is copied]
> > -        Iterate till total pending bytes converge and are less than th=
reshold
> > -                                  |
> > -  On migration completion, vCPU stops and calls .save_live_complete_pr=
ecopy for
> > -  each active device. The VFIO device is then transitioned into _STOP_=
COPY state
> > -                  (FINISH_MIGRATE, _DEVICE, _STOP_COPY)
> > -                                  |
> > -     For the VFIO device, iterate in .save_live_complete_precopy until
> > -                         pending data is 0
> > -                   (FINISH_MIGRATE, _DEVICE, _STOP)
> > -                                  |
> > -                 (FINISH_MIGRATE, _COMPLETED, _STOP)
> > -             Migraton thread schedules cleanup bottom half and exits
> > +            Migration thread then calls each device's .save_setup()
> > +                          (RUNNING, _SETUP, _PRE_COPY)
> > +                                      |
> > +                         (RUNNING, _ACTIVE, _PRE_COPY)
> > +  If device is active, get pending_bytes by .state_pending_{estimate,e=
xact}()
> > +       If total pending_bytes >=3D threshold_size, call .save_live_ite=
rate()
> > +                Data of VFIO device for pre-copy phase is copied
> > +      Iterate till total pending bytes converge and are less than thre=
shold
> > +                                      |
> > +       On migration completion, the vCPUs and the VFIO device are stop=
ped
> > +              The VFIO device is first put in P2P quiescent state
> > +                    (FINISH_MIGRATE, _ACTIVE, _PRE_COPY_P2P)
> > +                                      |
> > +                Then the VFIO device is put in _STOP_COPY state
> > +                     (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
> > +         .save_live_complete_precopy() is called for each active devic=
e
> > +      For the VFIO device, iterate in .save_live_complete_precopy() un=
til
> > +                               pending data is 0
> > +                                      |
> > +                     (POSTMIGRATE, _COMPLETED, _STOP_COPY)
> > +            Migraton thread schedules cleanup bottom half and exits
> > +                                      |
> > +                           .save_cleanup() is called
> > +                        (POSTMIGRATE, _COMPLETED, _STOP)
> >
> >   Live migration resume path
> >   --------------------------
> >
> >   ::
> >
> > -              Incoming migration calls .load_setup for each device
> > -                       (RESTORE_VM, _ACTIVE, _STOP)
> > -                                 |
> > -       For each device, .load_state is called for that device section =
data
> > -                       (RESTORE_VM, _ACTIVE, _RESUMING)
> > -                                 |
> > -    At the end, .load_cleanup is called for each device and vCPUs are =
started
> > -                       (RUNNING, _NONE, _RUNNING)
> > +             Incoming migration calls .load_setup() for each device
> > +                          (RESTORE_VM, _ACTIVE, _STOP)
> > +                                      |
> > +     For each device, .load_state() is called for that device section =
data
> > +                        (RESTORE_VM, _ACTIVE, _RESUMING)
> > +                                      |
> > +  At the end, .load_cleanup() is called for each device and vCPUs are =
started
> > +              The VFIO device is first put in P2P quiescent state
> > +                        (RUNNING, _ACTIVE, _RUNNING_P2P)
> > +                                      |
> > +                           (RUNNING, _NONE, _RUNNING)
> >
> >   Postcopy
> >   =3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 16cf79a76c..7c3d636025 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -441,14 +441,16 @@ bool vfio_device_state_is_running(VFIODevice *vba=
sedev)
> >   {
> >       VFIOMigration *migration =3D vbasedev->migration;
> >
> > -    return migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING;
> > +    return migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING ||
> > +           migration->device_state =3D=3D VFIO_DEVICE_STATE_RUNNING_P2=
P;
> >   }
> >
> >   bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
> >   {
> >       VFIOMigration *migration =3D vbasedev->migration;
> >
> > -    return migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY;
> > +    return migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY |=
|
> > +           migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE_COPY_P=
2P;
> >   }
> >
> >   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 48f9c23cbe..71855468fe 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -71,8 +71,12 @@ static const char *mig_state_to_str(enum vfio_device=
_mig_state state)
> >           return "STOP_COPY";
> >       case VFIO_DEVICE_STATE_RESUMING:
> >           return "RESUMING";
> > +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> > +        return "RUNNING_P2P";
> >       case VFIO_DEVICE_STATE_PRE_COPY:
> >           return "PRE_COPY";
> > +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> > +        return "PRE_COPY_P2P";
> >       default:
> >           return "UNKNOWN STATE";
> >       }
> > @@ -652,6 +656,39 @@ static const SaveVMHandlers savevm_vfio_handlers =
=3D {
> >
> >   /* ------------------------------------------------------------------=
---- */
> >
> > +static void vfio_vmstate_change_prepare(void *opaque, bool running,
> > +                                        RunState state)
> > +{
> > +    VFIODevice *vbasedev =3D opaque;
> > +    VFIOMigration *migration =3D vbasedev->migration;
> > +    enum vfio_device_mig_state new_state;
> > +    int ret;
> > +
> > +    new_state =3D migration->device_state =3D=3D VFIO_DEVICE_STATE_PRE=
_COPY ?
> > +                    VFIO_DEVICE_STATE_PRE_COPY_P2P :
> > +                    VFIO_DEVICE_STATE_RUNNING_P2P;
> > +
> > +    /*
> > +     * If setting the device in new_state fails, the device should be =
reset.
> > +     * To do so, use ERROR state as a recover state.
> > +     */
> > +    ret =3D vfio_migration_set_state(vbasedev, new_state,
> > +                                   VFIO_DEVICE_STATE_ERROR);
> > +    if (ret) {
> > +        /*
> > +         * Migration should be aborted in this case, but vm_state_noti=
fy()
> > +         * currently does not support reporting failures.
> > +         */
> > +        if (migrate_get_current()->to_dst_file) {
> > +            qemu_file_set_error(migrate_get_current()->to_dst_file, re=
t);
> > +        }
> > +    }
> > +
> > +    trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> > +                                      RunState_str(state),
> > +                                      mig_state_to_str(new_state));
> > +}
> > +
> >   static void vfio_vmstate_change(void *opaque, bool running, RunState =
state)
> >   {
> >       VFIODevice *vbasedev =3D opaque;
> > @@ -758,6 +795,7 @@ static int vfio_migration_init(VFIODevice *vbasedev=
)
> >       char id[256] =3D "";
> >       g_autofree char *path =3D NULL, *oid =3D NULL;
> >       uint64_t mig_flags =3D 0;
> > +    VMChangeStateHandler *prepare_cb;
> >
> >       if (!vbasedev->ops->vfio_get_object) {
> >           return -EINVAL;
> > @@ -798,9 +836,11 @@ static int vfio_migration_init(VFIODevice *vbasede=
v)
> >       register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio=
_handlers,
> >                            vbasedev);
> >
> > -    migration->vm_state =3D qdev_add_vm_change_state_handler(vbasedev-=
>dev,
> > -                                                           vfio_vmstat=
e_change,
> > -                                                           vbasedev);
> > +    prepare_cb =3D migration->mig_flags & VFIO_MIGRATION_P2P ?
> > +                     vfio_vmstate_change_prepare :
> > +                     NULL;
> > +    migration->vm_state =3D qdev_add_vm_change_state_handler_full(
> > +        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
> >       migration->migration_state.notify =3D vfio_migration_state_notifi=
er;
> >       add_migration_state_change_notifier(&migration->migration_state);
> >
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index ee7509e68e..329736a738 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -167,3 +167,4 @@ vfio_save_setup(const char *name, uint64_t data_buf=
fer_size) " (%s) data buffer
> >   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint6=
4_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%=
s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64=
" precopy dirty size 0x%"PRIx64
> >   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t=
 postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t pre=
copy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy s=
ize 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRI=
x64
> >   vfio_vmstate_change(const char *name, int running, const char *reason=
, const char *dev_state) " (%s) running %d reason %s device state %s"
> > +vfio_vmstate_change_prepare(const char *name, int running, const char =
*reason, const char *dev_state) " (%s) running %d reason %s device state %s=
"
>
>


