Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A837BF830
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9cL-00086E-Ns; Tue, 10 Oct 2023 06:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qq9cJ-00083H-8a
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qq9c3-00074T-Rr
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696932307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7MOtbSqPeCK/bLleFu9vUnR1YoV66HNIIpBiCs5pXs=;
 b=N9iPwiWsITc+MOkT91MeUxDdKK1IF87fQI42kEiImJK6WRFMX7nZMgKB6m7+meNW1/+JsI
 lP2b7Sr9XorrFOnAXnaHmkC94PZ8vkoys72HZVD91QoxXeRyNe6Yy/yYEB9FtaOMhtpPlb
 FXB2OGZZ/30NpaDUcVAITW0EkKplQts=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-L_sqvo6xPvqCSsEfQDbG_g-1; Tue, 10 Oct 2023 06:04:56 -0400
X-MC-Unique: L_sqvo6xPvqCSsEfQDbG_g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b989422300so103965566b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 03:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696932295; x=1697537095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7MOtbSqPeCK/bLleFu9vUnR1YoV66HNIIpBiCs5pXs=;
 b=Z8xTu8p62UH7t6EtI9qFKWARqDGCQ7FBMBJjtQIvW8TGXgknWdZZQ4oFHDFA4miDdw
 K4f2HqCnuDGowdZ+wavCvZcthN0h27YpFOWeAfCFO90D4Xs8fJ/Heb2HNbVfzaBXgnXX
 /GNQa0xanE6rGy+WF69cP1IBcaPYKNhvGTXaP5Iy5fONbcrc7WKEmPHE0xda3SxS1zgy
 XN5tDQJUJd+q5rllEfgUPt+800Hsy7Ml6DPK0c8Q61765pgCYp9sKGwLRuovMEZGZ0Md
 5ymQxFCZD3XqI9qo6MtFYfxTUkwVIED6jZ6nmByxTQcuH6zHgNDuPeeE6xwHySZCPt1u
 sqiQ==
X-Gm-Message-State: AOJu0Yx6/CDDX+BhI4P8D7DouByk7sXWXwFt4X53A8vX8AAh4Wk8uzVJ
 nmQVn8rQvnZc9rt3ldku1vqf4z8vNql9acdzH1w/lERD7Cea4HdphZCICb7gcCemb6lUuk4Qqnk
 t8uNAX0GzMHUhpjMv7vChvsAIexeD/nk=
X-Received: by 2002:a17:907:a48c:b0:9b9:24bb:e9c7 with SMTP id
 vp12-20020a170907a48c00b009b924bbe9c7mr14852787ejc.5.1696932295208; 
 Tue, 10 Oct 2023 03:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAWatglw7sfaPz8FhB+6WpdDG7gY/OxbgMwPHzIb7YYi8yhy9jpMa2+vGH6fs6jJlUzDwC0ScD9IWm0eytkWA=
X-Received: by 2002:a17:907:a48c:b0:9b9:24bb:e9c7 with SMTP id
 vp12-20020a170907a48c00b009b924bbe9c7mr14852764ejc.5.1696932294830; Tue, 10
 Oct 2023 03:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <CAJh=p+5OFrx4nP5rYKrgZ_y02n358wy70c4L0L4fHKQUo9fU5Q@mail.gmail.com>
 <ccfb153c-0e2e-15dd-b543-5b5a8bebbff4@nvidia.com>
In-Reply-To: <ccfb153c-0e2e-15dd-b543-5b5a8bebbff4@nvidia.com>
From: German Maglione <gmaglione@redhat.com>
Date: Tue, 10 Oct 2023 12:04:18 +0200
Message-ID: <CAJh=p+7XjQdwHFjpm5Oi-Y64MEtUhkpF0Q=RWMKqfg5bypF8iQ@mail.gmail.com>
Subject: Re: [Virtio-fs] (no subject)
To: Yajun Wu <yajunw@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Parav Pandit <parav@nvidia.com>, Anton Kuchin <antonkuchin@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Oct 10, 2023 at 4:57=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
>
> On 10/9/2023 6:28 PM, German Maglione wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Sat, Oct 7, 2023 at 4:23=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wro=
te:
> >>
> >> On 10/6/2023 6:34 PM, Michael S. Tsirkin wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
> >>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
> >>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
> >>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
> >>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
> >>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
> >>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote=
:
> >>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote=
:
> >>>>>>>>>>> There is no clearly defined purpose for the virtio status byt=
e in
> >>>>>>>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and =
for virtio
> >>>>>>>>>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY=
_ACK
> >>>>>>>>>>> protocol extension, it is possible for SET_FEATURES to return=
 errors
> >>>>>>>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
> >>>>>>>>>>>
> >>>>>>>>>>> As for implementations, SET_STATUS is not widely implemented.=
  dpdk does
> >>>>>>>>>>> implement it, but only uses it to signal feature negotiation =
failure.
> >>>>>>>>>>> While it does log reset requests (SET_STATUS 0) as such, it e=
ffectively
> >>>>>>>>>>> ignores them, in contrast to RESET_OWNER (which is deprecated=
, and today
> >>>>>>>>>>> means the same thing as RESET_DEVICE).
> >>>>>>>>>>>
> >>>>>>>>>>> While qemu superficially has support for [GS]ET_STATUS, it do=
es not
> >>>>>>>>>>> forward the guest-set status byte, but instead just makes it =
up
> >>>>>>>>>>> internally, and actually completely ignores what the back-end=
 returns,
> >>>>>>>>>>> only using it as the template for a subsequent SET_STATUS to =
add single
> >>>>>>>>>>> bits to it.  Notably, after setting FEATURES_OK, it never rea=
ds it back
> >>>>>>>>>>> to see whether the flag is still set, which is the only way i=
n which
> >>>>>>>>>>> dpdk uses the status byte.
> >>>>>>>>>>>
> >>>>>>>>>>> As-is, no front-end or back-end can rely on the other side ha=
ndling this
> >>>>>>>>>>> field in a useful manner, and it also provides no practical u=
se over
> >>>>>>>>>>> other mechanisms the vhost-user protocol has, which are more =
clearly
> >>>>>>>>>>> defined.  Deprecate it.
> >>>>>>>>>>>
> >>>>>>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>       docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-=
------
> >>>>>>>>>>>       1 file changed, 21 insertions(+), 7 deletions(-)
> >>>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>>>> SET_STATUS is the only way to signal failure to acknowledge FEA=
TURES_OK.
> >>>>>>>>> The fact current backends never check errors does not mean they=
 never
> >>>>>>>>> will. So no, not applying this.
> >>>>>>>> Can this not be done with REPLY_ACK?  I.e., with the following m=
essage
> >>>>>>>> order:
> >>>>>>>>
> >>>>>>>> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATUR=
ES is
> >>>>>>>> present
> >>>>>>>> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_=
REPLY_ACK
> >>>>>>>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
> >>>>>>>> 4. SET_FEATURES with need_reply
> >>>>>>>>
> >>>>>>>> If not, the problem is that qemu has sent SET_STATUS 0 for a whi=
le when the
> >>>>>>>> vCPUs are stopped, which generally seems to request a device res=
et.  If we
> >>>>>>>> don=E2=80=99t state at least that SET_STATUS 0 is to be ignored,=
 back-ends that will
> >>>>>>>> implement SET_STATUS later may break with at least these qemu ve=
rsions.  But
> >>>>>>>> documenting that a particular use of the status byte is to be ig=
nored would
> >>>>>>>> be really strange.
> >>>>>>>>
> >>>>>>>> Hanna
> >>>>>>> Hmm I guess. Though just following virtio spec seems cleaner to m=
e...
> >>>>>>> vhost-user reconfigures the state fully on start.
> >>>>>> Not the internal device state, though.  virtiofsd has internal sta=
te, and
> >>>>>> other devices like vhost-gpu back-ends would probably, too.
> >>>>>>
> >>>>>> Stefan has recently sent a series
> >>>>>> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709=
.html) to
> >>>>>> put the reset (RESET_DEVICE) into virtio_reset() (when we really n=
eed a
> >>>>>> reset).
> >>>>>>
> >>>>>> I really don=E2=80=99t like our current approach with the status b=
yte. Following the
> >>>>>> virtio specification to me would mean that the guest directly cont=
rols this
> >>>>>> byte, which it does not.  qemu makes up values as it deems appropr=
iate, and
> >>>>>> this includes sending a SET_STATUS 0 when the guest is just paused=
, i.e.
> >>>>>> when the guest really doesn=E2=80=99t want a device reset.
> >>>>>>
> >>>>>> That means that qemu does not treat this as a virtio device field =
(because
> >>>>>> that would mean exposing it to the guest driver), but instead trea=
ts it as
> >>>>>> part of the vhost(-user) protocol.  It doesn=E2=80=99t feel right =
to me that we use
> >>>>>> a virtio-defined feature for communication on the vhost level, i.e=
. between
> >>>>>> front-end and back-end, and not between guest driver and device.  =
I think
> >>>>>> all vhost-level protocol features should be fully defined in the v=
host-user
> >>>>>> specification, which REPLY_ACK is.
> >>>>> Hmm that makes sense. Maybe we should have done what stefan's patch
> >>>>> is doing.
> >>>>>
> >>>>> Do look at the original commit that introduced it to understand why
> >>>>> it was added.
> >>>> I don=E2=80=99t understand why this was added to the stop/cont code,=
 though.  If it
> >>>> is time consuming to make these changes, why are they done every tim=
e the VM
> >>>> is paused
> >>>> and resumed?  It makes sense that this would be done for the initial
> >>>> configuration (where a reset also wouldn=E2=80=99t hurt), but here i=
t seems wrong.
> >>>>
> >>>> (To be clear, a reset in the stop/cont code is wrong, because it bre=
aks
> >>>> stateful devices.)
> >>>>
> >>>> Also, note the newer commits 6f8be29ec17 and c3716f260bf.  The reset=
 as
> >>>> originally introduced was wrong even for non-stateful devices, becau=
se it
> >>>> occurred before we fetched the state (vring indices) so we could res=
tore it
> >>>> later.  I don=E2=80=99t know how 923b8921d21 was tested, but if the =
back-end used
> >>>> for testing implemented SET_STATUS 0 as a reset, it could not have s=
urvived
> >>>> either migration or a stop/cont in general, because the vring indice=
s would
> >>>> have been reset to 0.
> >>>>
> >>>> What I=E2=80=99m saying is, 923b8921d21 introduced SET_STATUS calls =
that broke all
> >>>> devices that would implement them as per virtio spec, and even today=
 it=E2=80=99s
> >>>> broken for stateful devices.  The mentioned performance issue is lik=
ely
> >>>> real, but we can=E2=80=99t address it by making up SET_STATUS calls =
that are wrong.
> >>>>
> >>>> I concede that I didn=E2=80=99t think about DRIVER_OK.  Personally, =
I would do all
> >>>> final configuration that would happen upon a DRIVER_OK once the firs=
t vring
> >>>> is started (i.e. receives a kick).  That has the added benefit of be=
ing
> >>>> asynchronous because it doesn=E2=80=99t block any vhost-user message=
s (which are
> >>>> synchronous, and thus block downtime).
> >>>>
> >>>> Hanna
> >>> For better or worse kick is per ring. It's out of spec to start rings
> >>> that were not kicked but I guess you could do configuration ...
> >>> Seems somewhat asymmetrical though.
> >>>
> >>> Let's wait until next week, hopefully Yajun Wu will answer.
> >> The main motivation of adding VHOST_USER_SET_STATUS is to let backend
> >> DPDK know
> >> when DRIVER_OK bit is valid. It's an indication of all VQ configuratio=
n
> >> has sent,
> >> otherwise DPDK has to rely on first queue pair is ready, then
> >> receiving/applying
> >> VQ configuration one by one.
> >>
> >> During live migration, configuring VQ one by one is very time consumin=
g.
> >> For VIRTIO
> >> net vDPA, HW needs to know how many VQs are enabled to set
> >> RSS(Receive-Side Scaling).
> >>
> >> If you don=E2=80=99t want SET_STATUS message, backend can remove proto=
col
> >> feature bit
> >> VHOST_USER_PROTOCOL_F_STATUS.
> >> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device
> >> close/reset.
> > This is incorrect, resetting the device on GET_VRING_BASE breaks
> > the stop/cont. Since you don't want to reset the VQs on stop/cont.
> Sorry for the misunderstanding, dpdk vhost backend framework doesn't
> have RESET concept(only device level .dev_conf and .dev_close). On
> receiving DRIVER_OK does dev_conf, on receiving GET_VRING_BASE does
> dev_close. For every VM suspend/resume, dpdk issues dev_close then dev_co=
nf.

(sorry I did not explain myself well)
I meant that resetting the VQs upon receiveng GET_VRING_BASE makes the
backend to fail if qemu continues after a "stop". I notice that in dpdk,
when it receives a GET_VRING_BASE[0], it calls 'vring_invalidate(dev, vq);'=
[1],
resetting the VQ[2], doing that is incorrect.

[0] https://github.com/DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L2135
[1] https://github.com/DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L2201
[2] https://github.com/DPDK/dpdk/blob/main/lib/vhost/vhost.c#L580

> >
> >> I'm not involved in discussion about adding SET_STATUS in Vhost
> >> protocol. This feature
> >> is essential for vDPA(same as vhost-vdpa implements VHOST_VDPA_SET_STA=
TUS).
> >>
> >> Thanks,
> >> Yajun
> >>>>>> Now, we could hand full control of the status byte to the guest, a=
nd that
> >>>>>> would make me content.  But I feel like that doesn=E2=80=99t reall=
y work, because
> >>>>>> qemu needs to intercept the status byte anyway (it needs to know w=
hen there
> >>>>>> is a reset, probably wants to know when the device is configured, =
etc.), so
> >>>>>> I don=E2=80=99t think having the status byte in vhost-user really =
gains us much when
> >>>>>> qemu could translate status byte changes to/from other vhost-user =
commands.
> >>>>>>
> >>>>>> Hanna
> >>>>> well it intercepts it but I think it could pass it on unchanged.
> >>>>>
> >>>>>
> >>>>>>> I guess symmetry was the
> >>>>>>> point. So I don't see why SET_STATUS 0 has to be ignored.
> >>>>>>>
> >>>>>>>
> >>>>>>> SET_STATUS was introduced by:
> >>>>>>>
> >>>>>>> commit 923b8921d210763359e96246a58658ac0db6c645
> >>>>>>> Author: Yajun Wu <yajunw@nvidia.com>
> >>>>>>> Date:   Mon Oct 17 14:44:52 2022 +0800
> >>>>>>>
> >>>>>>>         vhost-user: Support vhost_dev_start
> >>>>>>>
> >>>>>>> CC the author.
> >>>>>>>
> >> _______________________________________________
> >> Virtio-fs mailing list
> >> Virtio-fs@redhat.com
> >> https://listman.redhat.com/mailman/listinfo/virtio-fs
> >
> >
> > --
> > German
> >
>


--=20
German


