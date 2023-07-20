Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31175AD41
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 13:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMS4e-0003Hy-9M; Thu, 20 Jul 2023 07:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qMS4Y-0003B6-AC
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:43:55 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qMS4W-0007Kg-4h
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:43:54 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-560b56b638eso494195eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689853431; x=1690458231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAtscJzfuVZzlKqvjmTStEcltdK78ZUfEt8lDkpuPVs=;
 b=OmUyEMfgfKEcpSUY/1m23EPdHA8V7NlH+4gWijn7R0gyVXGP3/v2gec9flkzlQIB5e
 yLnHCScmHzScNukM9LXn4vzT27dvSwwjxz3qC4dK9eXcGa2Q1SdX9EoYwvWp7KgWPFzK
 QeUxyinMQl+fZT0rq7IbwgU1xZA21VFm+V1FEqROmr8CVNbqKXxxF4VTfTqKrvkwiMwW
 P+DXk0X8rlejXRRw2Eqg3xNcppXVp+I0ljM1Q73eLDz+iQjp99dL9Jof+8lmWYlEEqt5
 GsPH5n1T3yQ8eknoLPQPNGwBpNYGSmcHW/cxrtpzeLXAu1+cwOY964h7FTIh0yZT9MlW
 ndaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689853431; x=1690458231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAtscJzfuVZzlKqvjmTStEcltdK78ZUfEt8lDkpuPVs=;
 b=D5If2odjc+G6u80JoIgpSVHc4rMtenFx6UaQeWcwupUCIJZCcCXfM1bYITPwoEtJ4I
 Rb7/EPWeywheoS6eXjf70PLX04usIfxBZn4orkLFiD/uP+V+40phZKl1l9FnrT4e8llZ
 nCTQH5rZePv8TbZMWsLGVZQSoovyOmFRYEMKcKC7RsX+EH+jrfdeehMg1u9UgaQ1HEFL
 zxjOMLNgjBg/dBDiD4AbLKnuBBTmN1KeVRZWHwQPt5pveOtK30uCLPeRAz2PlbmXBj2s
 AURg8TBRpMpQDPupil7nP/SNhZaySDnCueossTdK3QABJ6bfmkdJ1xM5EmDZSBmN9OoP
 uwBw==
X-Gm-Message-State: ABy/qLaWHC2CWxE5rBPcx1Q5kKnpUuObipofB4NSDxAw7s0P2QlqjOOw
 i2neQz/KVn472j6BfEsGrbkJ7M7uNRGGVzpk8eg=
X-Google-Smtp-Source: APBJJlHx14KsKJzPStJiopwyxUOQnmAaMfibUeQ4wXgkDdIZimAoIuNdA9Ak4O+AfQ/0W2pdfj6RchZgUsBWLSDe4V8=
X-Received: by 2002:a4a:5211:0:b0:563:4eeb:b5ea with SMTP id
 d17-20020a4a5211000000b005634eebb5eamr1781709oob.4.1689853430642; Thu, 20 Jul
 2023 04:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-2-hreitz@redhat.com>
 <20230718155700.GJ44841@fedora>
 <940a0545-c4ec-cd99-62b2-9e5d007ce9bf@redhat.com>
In-Reply-To: <940a0545-c4ec-cd99-62b2-9e5d007ce9bf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 20 Jul 2023 07:43:37 -0400
Message-ID: <CAJSP0QW=P-J4SzPO+kvMCCDsnDWpu_Vainv_fE7UHaD2SMN+OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vhost-user.rst: Migrating back-end-internal state
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, German Maglione <gmaglione@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 19 Jul 2023 at 12:35, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 18.07.23 17:57, Stefan Hajnoczi wrote:
> > On Wed, Jul 12, 2023 at 01:16:59PM +0200, Hanna Czenczek wrote:
> >> For vhost-user devices, qemu can migrate the virtio state, but not the
> >> back-end's internal state.  To do so, we need to be able to transfer
> >> this internal state between front-end (qemu) and back-end.
> >>
> >> At this point, this new feature is added for the purpose of virtio-fs
> >> migration.  Because virtiofsd's internal state will not be too large, =
we
> >> believe it is best to transfer it as a single binary blob after the
> >> streaming phase.
> >>
> >> These are the additions to the protocol:
> >> - New vhost-user protocol feature VHOST_USER_PROTOCOL_F_MIGRATORY_STAT=
E
> > It's not 100% clear whether "migratory" is related to live migration or
> > something else. I don't like the name :P.
> >
> > The name "VHOST_USER_PROTOCOL_F_DEVICE_STATE" would be more obviously
> > associated with SET_DEVICE_STATE_FD and CHECK_DEVICE_STATE than
> > "MIGRATORY_STATE".
>
> Sure, sure.  Naming things is hard. :)
>
> >> - SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a pip=
e
> >>    over which to transfer the state.
> > Does it need to be a pipe or can it be another type of file (e.g. UNIX
> > domain socket)?
>
> It=E2=80=99s difficult to say, honestly.  It can be anything, but I=E2=80=
=99m not sure
> how to describe that in this specification.
>
> It must be any FD into which the state sender can write the state and
> signal end of state by closing its FD; and from which the state receiver
> can read the state, terminated by seeing an EOF.  As you say, that
> doesn=E2=80=99t mean that the sender has to write the state into the FD, =
nor
> that the receiver has to read it (into memory), it=E2=80=99s just that ei=
ther
> side must ensure the other can do it.
>
> > In the future the fd may become bi-directional. Pipes are
> > uni-directional on Linux.
> >
> > I suggest calling it a "file descriptor" and not mentioning "pipes"
> > explicitly.
>
> Works here in the commit message, but in the document, we need to be
> explicit about the requirements for this FD, i.e. the way in which
> front-end and back-end can expect the FD to be usable.  Calling it a
> =E2=80=9Cpipe=E2=80=9D was a simple way, but you=E2=80=99re right, it=E2=
=80=99s more general than that.
>
> >> - CHECK_DEVICE_STATE: After the state has been transferred through the
> >>    pipe, the front-end invokes this function to verify success.  There=
 is
> >>    no in-band way (through the pipe) to indicate failure, so we need t=
o
> >>    check explicitly.
> >>
> >> Once the transfer pipe has been established via SET_DEVICE_STATE_FD
> >> (which includes establishing the direction of transfer and migration
> >> phase), the sending side writes its data into the pipe, and the readin=
g
> >> side reads it until it sees an EOF.  Then, the front-end will check fo=
r
> >> success via CHECK_DEVICE_STATE, which on the destination side includes
> >> checking for integrity (i.e. errors during deserialization).
> >>
> >> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>   docs/interop/vhost-user.rst | 87 +++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 87 insertions(+)
> >>
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index ac6be34c4c..c98dfeca25 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -334,6 +334,7 @@ in the ancillary data:
> >>   * ``VHOST_USER_SET_VRING_ERR``
> >>   * ``VHOST_USER_SET_BACKEND_REQ_FD`` (previous name ``VHOST_USER_SET_=
SLAVE_REQ_FD``)
> >>   * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGH=
T_SHMFD``)
> >> +* ``VHOST_USER_SET_DEVICE_STATE_FD``
> >>
> >>   If *front-end* is unable to send the full message or receives a wron=
g
> >>   reply it will close the connection. An optional reconnection mechani=
sm
> >> @@ -497,6 +498,44 @@ it performs WAKE ioctl's on the userfaultfd to wa=
ke the stalled
> >>   back-end.  The front-end indicates support for this via the
> >>   ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` feature.
> >>
> >> +.. _migrating_backend_state:
> >> +
> >> +Migrating back-end state
> >> +^^^^^^^^^^^^^^^^^^^^^^^^
> >> +
> >> +If the back-end has internal state that is to be sent from source to
> >> +destination,
> > Migration and the terms "source" and "destination" have not been
> > defined. Here is a suggestion for an introductory paragraph:
> >
> >    Migrating device state involves transferring the state from one
> >    back-end, called the source, to another back-end, called the
> >    destination. After migration, the destination transparently resumes
> >    operation without requiring the driver to re-initialize the device a=
t
> >    the VIRTIO level. If the migration fails, then the source can
> >    transparently resume operation until another migration attempt is
> >    made.
>
> You=E2=80=99re right, thanks!  Maybe I=E2=80=99ll try to be even more ver=
bose here, and
> include what VM and guest do.
>
> >> the front-end may be able to store and transfer it via an
> >> +internal migration stream.  Support for this is negotiated with the
> >> +``VHOST_USER_PROTOCOL_F_MIGRATORY_STATE`` feature.
> >> +
> >> +First, a channel over which the state is transferred is established o=
n
> >> +the source side using the ``VHOST_USER_SET_DEVICE_STATE_FD`` message.
> >> +This message has two parameters:
> >> +
> >> +* Direction of transfer: On the source, the data is saved, transferri=
ng
> >> +  it from the back-end to the front-end.  On the destination, the dat=
a
> >> +  is loaded, transferring it from the front-end to the back-end.
> >> +
> >> +* Migration phase: Currently, only the period after memory transfer
> > "memory transfer" is vague. This sentence is referring to VM live
> > migration and guest RAM but it may be better to focus on just the devic=
e
> > perspective and not the VM:
>
> The device perspective does include guest RAM, though, because the
> back-end must log its memory modifications, so it is very much involved
> in that process.  I think it=E2=80=99s a good idea to note that the state
> transfer will occur afterwards.

Okay. Please use "memory mapped regions" the first time memory is
mentioned, the same term that the vhost-user specification uses at the
beginning of the Migration section. That way it's clear exactly what
"memory" is.

>
> >    Migration is currently only supported while the device is suspended
> >    and all of its rings are stopped. In the future, additional phases
> >    might be support to allow iterative migration while the device is
> >    running.
>
> In any case, I=E2=80=99ll happily add this last sentence.
>
> >> +  before switch-over is supported, in which the device is suspended a=
nd
> >> +  all of its rings are stopped.
> >> +
> >> +Then, the writing end will write all the data it has, signalling the =
end
> >> +of data by closing its end of the pipe.  The reading end must read al=
l
> >> +of this data and process it:
> >> +
> >> +* If saving, the front-end will transfer this data to the destination=
,
> > To be extra clear:
> >
> >    ...transfer this data to the destination through some
> >    implementation-specific means.
>
> Yep!
>
> >> +  where it is loaded into the destination back-end.
> >> +
> >> +* If loading, the back-end must deserialize its internal state from t=
he
> >> +  transferred data and be set up to resume operation.
> > "and be set up to resume operation" is a little unclear to me. I guess
> > it means "in preparation for VHOST_USER_RESUME".
>
> I don=E2=80=99t think the back-end on the destination will receive a RESU=
ME.  It
> never gets a SUSPEND, after all.  So this is about resuming operation
> once the vrings are kicked, and resuming it like it was left on the
> source when the back-end was SUSPEND-ed there.

This shows that the spec does not spell out how operation is resumed
on the destination (or source, in case of failure). Can you extend
this part of the spec to explain it?

>
> >> +
> >> +After the front-end has seen all data transferred (saving: seen an EO=
F
> >> +on the pipe; loading: closed its end of the pipe), it sends the
> >> +``VHOST_USER_CHECK_DEVICE_STATE`` message to verify that data transfe=
r
> >> +was successful in the back-end, too.  The back-end responds once it
> >> +knows whether the tranfer and processing was successful or not.
> >> +
> >>   Memory access
> >>   -------------
> >>
> >> @@ -891,6 +930,7 @@ Protocol features
> >>     #define VHOST_USER_PROTOCOL_F_STATUS               16
> >>     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >>     #define VHOST_USER_PROTOCOL_F_SUSPEND              18
> >> +  #define VHOST_USER_PROTOCOL_F_MIGRATORY_STATE      19
> >>
> >>   Front-end message types
> >>   -----------------------
> >> @@ -1471,6 +1511,53 @@ Front-end message types
> >>     before.  The back-end must again begin processing rings that are n=
ot
> >>     stopped, and it may resume background operations.
> >>
> >> +``VHOST_USER_SET_DEVICE_STATE_FD``
> >> +  :id: 43
> >> +  :equivalent ioctl: N/A
> >> +  :request payload: device state transfer parameters
> >> +  :reply payload: ``u64``
> >> +
> >> +  The front-end negotiates a pipe over which to transfer the back-end=
=E2=80=99s
> >> +  internal state during migration.  For this purpose, this message is
> >> +  accompanied by a file descriptor that is to be the back-end=E2=80=
=99s end of
> >> +  the pipe.  If the back-end can provide a more efficient pipe (i.e.
> >> +  because it internally already has a pipe into/from which to
> >> +  put/receive state), it can ignore this and reply with a different f=
ile
> >> +  descriptor to serve as the front-end=E2=80=99s end.
> >> +
> >> +  The request payload contains parameters for the subsequent data
> >> +  transfer, as described in the :ref:`Migrating back-end state
> >> +  <migrating_backend_state>` section.  That section also explains the
> >> +  data transfer itself.
> >> +
> >> +  The value returned is both an indication for success, and whether a
> >> +  new pipe file descriptor is returned: Bits 0=E2=80=937 are 0 on suc=
cess, and
> >> +  non-zero on error.  Bit 8 is the invalid FD flag; this flag is set
> >> +  when there is no file descriptor returned.  When this flag is not s=
et,
> >> +  the front-end must use the returned file descriptor as its end of t=
he
> >> +  pipe.  The back-end must not both indicate an error and return a fi=
le
> >> +  descriptor.
> > Is the invalid FD flag necessary? The front-end can check whether or no=
t
> > an fd was passed along with the result, so I'm not sure why the result
> > also needs to communicate this.
>
> If the front-end can check this, shouldn=E2=80=99t the back-end also gene=
rally
> be able to check whether the front-end has passed an FD in the ancillary
> data?  We do have this flag in messages sent by the front-end that can
> optionally provide an FD (SET_VRING_KICK, SET_VRING_CALL), so I thought
> it would be good for symmetry to keep this convention every time an FD
> is optional in communication between front-end and back-end, in either
> direction.

Consistency is good. I wasn't aware that the other messages do that.
In that case, no complaints from me.

Stefan

