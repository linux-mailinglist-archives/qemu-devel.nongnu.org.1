Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FC07F29C0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:05:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Ncq-0004lm-AC; Tue, 21 Nov 2023 05:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r5Nck-0004kk-M8
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:04:55 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r5Ncf-0002vC-LL
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:04:54 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso4302617b3a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700560965; x=1701165765;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HH3as98g+pL7aUgU3z4eFKBoe2Kby+zr9+8vRpV99TQ=;
 b=D58zbGjBZWF1PIlqWXXch3km79U2vHnRBZzbqmC7mPrGy65NNvlOIgWLg9C0UgmZNW
 qxxfNV1gAfhNuvdKgivLfMOU+OflmEpbcpJlatiOSBkrXbkM2JuTAWuInI0RA4/rH3xO
 gytN2wCOpO4pIV9elZeDX83btb7oYHrJC4nr8ZhnAd7KFTj8+aQ15XkSSncvCtesSBuu
 hZbKZTFRCaYDi0robUAdNhdJv4dl0eApqMYroOuTrXeXhWF0kfZjH7LKRXmJH9+dQsa5
 NQdQLGLkRRHwUawW96n01qzdVbxTrBTybJIxJmSGSLA3lD9gkh74Hu2MLH0q5RjJxDhn
 +V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700560965; x=1701165765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HH3as98g+pL7aUgU3z4eFKBoe2Kby+zr9+8vRpV99TQ=;
 b=f6FXGi7ZzojVmm0DlYMT9t6a4I8fd5576WBAvEQHZW4JaqB/oEXYPVOUSF+O29UwiH
 4viVt5cqd3FbM8UxXXIVx9jyYtZyQH3yuF5B+HJ9fgsUklApeWDESDKIZelJnl4lEgoW
 +Klb9dqe86GGNNMDH3QpRYsBKQ6Bsl4qnSywRfwjrMEP9bPI3H1F6bj5OpfGpJZ99clu
 wv92MmqfeVr0XSTvFloBvILKtFEIYVzZZ7vTpnFNd2PRU/D+uQrf5fSVZE5kFVO1+XSH
 nnLy8s7TxILxFZGWDadjmEu1k5zOu5sGXyOncOli3BYI+B0i9evtBkeURL0RJSGNl+Rj
 UhCQ==
X-Gm-Message-State: AOJu0YzyQYSxts+9aR6I6tY7cuOXCt9sftNvBREg7N7ZwAn61HvdLFDz
 V+Rph+lpKbpoVwAAA8p7qMQlbt21Q+pBmCUIfHJSuA==
X-Google-Smtp-Source: AGHT+IEjPLop3zR06IuTV0pDa3bHnz2lypM0G/E0io2iI6+NeRoXwqNOJwwB3tHt7QXJsSGJOCChAESAiKvKyjUFjuI=
X-Received: by 2002:a05:6a20:e102:b0:187:6880:b025 with SMTP id
 kr2-20020a056a20e10200b001876880b025mr9766647pzb.49.1700560964449; Tue, 21
 Nov 2023 02:02:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 <87v89vleqp.fsf@pond.sub.org>
In-Reply-To: <87v89vleqp.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 21 Nov 2023 18:02:28 +0800
Message-ID: <CAK9dgmaGb6-fH9+r=Qczw86LQWTMLhg4iSHMEX_OG1fBan-D-A@mail.gmail.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000348fc0060aa6b450"
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000348fc0060aa6b450
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:58=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Laurent, there's a question for you at the end.
>
> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
> > wrote:
> >
> >> Hyman Huang <yong.huang@smartx.com> writes:
> >>
> >> > This patch allows to display feature and status bits in virtio-statu=
s.
> >> >
> >> > An optional argument is introduced: show-bits. For example:
> >> > {"execute": "x-query-virtio-status",
> >> >  "arguments": {"path":
> "/machine/peripheral-anon/device[1]/virtio-backend",
> >> >                "show-bits": true}
> >> >
> >> > Features and status bits could be helpful for applications to compar=
e
> >> > directly. For instance, when an upper application aims to ensure the
> >> > virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it
> use
> >> > the "ovs-vsctl list interface" command to retrieve interface feature=
s
> >> > (in number format) and the QMP command x-query-virtio-status to
> retrieve
> >> > vhost-user net device features. If "show-bits" is added, the
> application
> >> > can compare the two features directly; No need to encoding the
> features
> >> > returned by the QMP command.
> >> >
> >> > This patch also serves as a preparation for the next one, which
> implements
> >> > a vhost-user test case about acked features of vhost-user protocol.
> >> >
> >> > Note that since the matching HMP command is typically used for human=
,
> >> > leave it unchanged.
> >> >
> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >> > ---
> >> >  hw/virtio/virtio-hmp-cmds.c |  2 +-
> >> >  hw/virtio/virtio-qmp.c      | 21 +++++++++++++++-
> >> >  qapi/virtio.json            | 49
> ++++++++++++++++++++++++++++++++++---
> >> >  3 files changed, 67 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds=
.c
> >> > index 477c97dea2..3774f3d4bf 100644
> >> > --- a/hw/virtio/virtio-hmp-cmds.c
> >> > +++ b/hw/virtio/virtio-hmp-cmds.c
> >> > @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >> >  {
> >> >      Error *err =3D NULL;
> >> >      const char *path =3D qdict_get_try_str(qdict, "path");
> >> > -    VirtioStatus *s =3D qmp_x_query_virtio_status(path, &err);
> >> > +    VirtioStatus *s =3D qmp_x_query_virtio_status(path, false, fals=
e,
> &err);
> >> >
> >> >      if (err !=3D NULL) {
> >> >          hmp_handle_error(mon, err);
> >> > diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> >> > index 1dd96ed20f..2e92bf28ac 100644
> >> > --- a/hw/virtio/virtio-qmp.c
> >> > +++ b/hw/virtio/virtio-qmp.c
> >> > @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const cha=
r
> *path)
> >> >      return VIRTIO_DEVICE(dev);
> >> >  }
> >> >
> >> > -VirtioStatus *qmp_x_query_virtio_status(const char *path, Error
> **errp)
> >> > +VirtioStatus *qmp_x_query_virtio_status(const char *path,
> >> > +                                        bool has_show_bits,
> >> > +                                        bool show_bits,
> >> > +                                        Error **errp)
> >> >  {
> >> >      VirtIODevice *vdev;
> >> >      VirtioStatus *status;
> >> > +    bool display_bits =3D
> >> > +        has_show_bits ? show_bits : false;
> >>
> >> Since !has_show_bits implies !show_bits, you can simply use
> >> if (show_bits).
> >>
> > Ok
> >
> >>
> >> >
> >> >      vdev =3D qmp_find_virtio_device(path);
> >> >      if (vdev =3D=3D NULL) {
> >> > @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const
> char *path, Error **errp)
> >> >      status->name =3D g_strdup(vdev->name);
> >> >      status->device_id =3D vdev->device_id;
> >> >      status->vhost_started =3D vdev->vhost_started;
> >> > +    if (display_bits) {
> >> > +        status->guest_features_bits =3D vdev->guest_features;
> >> > +        status->host_features_bits =3D vdev->host_features;
> >> > +        status->backend_features_bits =3D vdev->backend_features;
> >> > +    }
> >> >      status->guest_features =3D qmp_decode_features(vdev->device_id,
> >> >
>  vdev->guest_features);
> >> >      status->host_features =3D qmp_decode_features(vdev->device_id,
> >> > @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const
> char *path, Error **errp)
> >> >      }
> >> >
> >> >      status->num_vqs =3D virtio_get_num_queues(vdev);
> >> > +    if (display_bits) {
> >> > +        status->status_bits =3D vdev->status;
> >> > +    }
> >> >      status->status =3D qmp_decode_status(vdev->status);
> >> >      status->isr =3D vdev->isr;
> >> >      status->queue_sel =3D vdev->queue_sel;
> >> > @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const
> char *path, Error **errp)
> >> >          status->vhost_dev->n_tmp_sections =3D hdev->n_tmp_sections;
> >> >          status->vhost_dev->nvqs =3D hdev->nvqs;
> >> >          status->vhost_dev->vq_index =3D hdev->vq_index;
> >> > +        if (display_bits) {
> >> > +            status->vhost_dev->features_bits =3D hdev->features;
> >> > +            status->vhost_dev->acked_features_bits =3D
> hdev->acked_features;
> >> > +            status->vhost_dev->backend_features_bits =3D
> hdev->backend_features;
> >> > +            status->vhost_dev->protocol_features_bits =3D
> hdev->protocol_features;
> >> > +        }
> >> >          status->vhost_dev->features =3D
> >> >              qmp_decode_features(vdev->device_id, hdev->features);
> >> >          status->vhost_dev->acked_features =3D
> >> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> >> > index e6dcee7b83..608b841a89 100644
> >> > --- a/qapi/virtio.json
> >> > +++ b/qapi/virtio.json
> >> > @@ -79,12 +79,20 @@
> >> >  #
> >> >  # @vq-index: vhost_dev vq_index
> >> >  #
> >> > +# @features-bits: vhost_dev features in decimal format
> >>
> >> Say "encoded as a number".  The number is decimal just because the
> >> transport is JSON.  We could have another transport some day.  Or
> >> language bindings wrapping around the JSON transport.
> >>
> >> > +#
> >> >  # @features: vhost_dev features
> >>
> >> Double-checking...  @feature-bits provides the exact same information =
as
> >> @features, only in another encoding.  Correct?
> >
> >
> >> Same for all the other new -bits.  Correct?
> >
> > Yes, all the new fields are only about providing another encoding.
>
> Why do we want to return the same information in two different
> encodings?  I figure the commit message tries to answer this question:
>
>      Features and status bits could be helpful for applications to compar=
e
>      directly. For instance, when an upper application aims to ensure the
>      virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it
> use
>      the "ovs-vsctl list interface" command to retrieve interface feature=
s
>      (in number format) and the QMP command x-query-virtio-status to
> retrieve
>      vhost-user net device features. If "show-bits" is added, the
> application
>      can compare the two features directly; No need to encoding the
> features
>      returned by the QMP command.
>
>      This patch also serves as a preparation for the next one, which
> implements
>      a vhost-user test case about acked features of vhost-user protocol.
>
> I guess you're trying to simplify use cases where the QMP client wants
> to compare entire feature sets without caring for individual features.
>
> The comparison is easy if both sets are represented the same way,
> e.g. both are numbers, or both are lists of symbols.


Yes,  quite correct, this patch just aims to keep the unencoded bits for
easy comparison.

>


> With different representations, we first have to map to a common
> representation.  Unfortunately, the design of x-query-virtio-status
> makes this harder than it should be.
>
> We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,
> VirtioDeviceFeatures to represent feature sets.  They all work the same
> way: array of strings plus a number.  For each bit QEMU knows, there's a
> string in the array.  Any remaining bits go into the number.
>
> The format of the string is undocumented.  They look like
>
>     "WELL_KNOWN_SYMBOL: human readable explanation"
>
> Mapping from bit to this string in a client would require duplicating
> QEMU's code exactly.
>
> Mapping both bit and string to just "WELL_KNOWN_SYMBOL" could perhaps be
> done.
>
> The mapping between symbols and bits is not visible in QMP.  Mapping
> from string to bit requires exploiting the undocumented format: extract
> the well-known symbol and decode it.
>
> This encoding of feature sets goes back to commit f3034ad71fc (qmp:
> decode feature & status bits in virtio-status) v7.2.  Before that, the
> command returned the bits as a number.
>
> For example, return value "member "status":
>
>     Before f3034ad71fc:
>
>         "status": 15,
>
>     Since f3034ad71fc:
>
>         "status": {
>             "statuses": [
>                 "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
>                 "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device"=
,
>                 "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
>                 "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>             ]},
>
>     With your patch:
>
>         "status": {
>             "statuses": [
>                 "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
>                 "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device"=
,
>                 "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
>                 "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>             ]},
>         "status-bits": 15,
>
> Looks like commit f3034ad71fc improved one use case at the expense of
> another, and your patch tries to revert the damage.  Which one exactly
> it improved is unclear; the commit message doesn't tell.  Laurent?
>
> [...]
>
>

--=20
Best regards

--000000000000348fc0060aa6b450
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 21, 20=
23 at 3:58=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Laurent, t=
here&#39;s a question for you at the end.<br>
<br>
Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">y=
ong.huang@smartx.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt;<b=
r>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; This patch allows to display feature and status bits in virti=
o-status.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; An optional argument is introduced: show-bits. For example:<b=
r>
&gt;&gt; &gt; {&quot;execute&quot;: &quot;x-query-virtio-status&quot;,<br>
&gt;&gt; &gt;=C2=A0 &quot;arguments&quot;: {&quot;path&quot;: &quot;/machin=
e/peripheral-anon/device[1]/virtio-backend&quot;,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
show-bits&quot;: true}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Features and status bits could be helpful for applications to=
 compare<br>
&gt;&gt; &gt; directly. For instance, when an upper application aims to ens=
ure the<br>
&gt;&gt; &gt; virtio negotiation correctness between guest, QEMU, and OVS-D=
PDK, it use<br>
&gt;&gt; &gt; the &quot;ovs-vsctl list interface&quot; command to retrieve =
interface features<br>
&gt;&gt; &gt; (in number format) and the QMP command x-query-virtio-status =
to retrieve<br>
&gt;&gt; &gt; vhost-user net device features. If &quot;show-bits&quot; is a=
dded, the application<br>
&gt;&gt; &gt; can compare the two features directly; No need to encoding th=
e features<br>
&gt;&gt; &gt; returned by the QMP command.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This patch also serves as a preparation for the next one, whi=
ch implements<br>
&gt;&gt; &gt; a vhost-user test case about acked features of vhost-user pro=
tocol.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Note that since the matching HMP command is typically used fo=
r human,<br>
&gt;&gt; &gt; leave it unchanged.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@s=
martx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 hw/virtio/virtio-hmp-cmds.c |=C2=A0 2 +-<br>
&gt;&gt; &gt;=C2=A0 hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 | 21 +++++++=
++++++++-<br>
&gt;&gt; &gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 49 ++++++++++++++++++++++++++++++++++---<br>
&gt;&gt; &gt;=C2=A0 3 files changed, 67 insertions(+), 5 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-h=
mp-cmds.c<br>
&gt;&gt; &gt; index 477c97dea2..3774f3d4bf 100644<br>
&gt;&gt; &gt; --- a/hw/virtio/virtio-hmp-cmds.c<br>
&gt;&gt; &gt; +++ b/hw/virtio/virtio-hmp-cmds.c<br>
&gt;&gt; &gt; @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, cons=
t QDict *qdict)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 const char *path =3D qdict_get_try_str(qd=
ict, &quot;path&quot;);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 VirtioStatus *s =3D qmp_x_query_virtio_status(=
path, &amp;err);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VirtioStatus *s =3D qmp_x_query_virtio_status(=
path, false, false, &amp;err);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_handle_error(mon, err);=
<br>
&gt;&gt; &gt; diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c<=
br>
&gt;&gt; &gt; index 1dd96ed20f..2e92bf28ac 100644<br>
&gt;&gt; &gt; --- a/hw/virtio/virtio-qmp.c<br>
&gt;&gt; &gt; +++ b/hw/virtio/virtio-qmp.c<br>
&gt;&gt; &gt; @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(co=
nst char *path)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return VIRTIO_DEVICE(dev);<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -VirtioStatus *qmp_x_query_virtio_status(const char *path, Er=
ror **errp)<br>
&gt;&gt; &gt; +VirtioStatus *qmp_x_query_virtio_status(const char *path,<br=
>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool has_show_bits,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool show_bits,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Error **errp)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtioStatus *status;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 bool display_bits =3D<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_show_bits ? show_bits : fals=
e;<br>
&gt;&gt;<br>
&gt;&gt; Since !has_show_bits implies !show_bits, you can simply use<br>
&gt;&gt; if (show_bits).<br>
&gt;&gt;<br>
&gt; Ok<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 vdev =3D qmp_find_virtio_device(path);<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (vdev =3D=3D NULL) {<br>
&gt;&gt; &gt; @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(=
const char *path, Error **errp)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;name =3D g_strdup(vdev-&gt;nam=
e);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;device_id =3D vdev-&gt;device_=
id;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_started =3D vdev-&gt;vho=
st_started;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (display_bits) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;guest_features_bits =
=3D vdev-&gt;guest_features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;host_features_bits =
=3D vdev-&gt;host_features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;backend_features_bits=
 =3D vdev-&gt;backend_features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;guest_features =3D qmp_decode_=
features(vdev-&gt;device_id,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;guest_features);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;host_features =3D qmp_decode_f=
eatures(vdev-&gt;device_id,<br>
&gt;&gt; &gt; @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(c=
onst char *path, Error **errp)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;num_vqs =3D virtio_get_num_que=
ues(vdev);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (display_bits) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;status_bits =3D vdev-=
&gt;status;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;status =3D qmp_decode_status(v=
dev-&gt;status);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;isr =3D vdev-&gt;isr;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;queue_sel =3D vdev-&gt;queue_s=
el;<br>
&gt;&gt; &gt; @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(=
const char *path, Error **errp)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;n_=
tmp_sections =3D hdev-&gt;n_tmp_sections;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;nv=
qs =3D hdev-&gt;nvqs;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;vq=
_index =3D hdev-&gt;vq_index;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (display_bits) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_d=
ev-&gt;features_bits =3D hdev-&gt;features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_d=
ev-&gt;acked_features_bits =3D hdev-&gt;acked_features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_d=
ev-&gt;backend_features_bits =3D hdev-&gt;backend_features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_d=
ev-&gt;protocol_features_bits =3D hdev-&gt;protocol_features;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;fe=
atures =3D<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_fe=
atures(vdev-&gt;device_id, hdev-&gt;features);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;ac=
ked_features =3D<br>
&gt;&gt; &gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt;&gt; &gt; index e6dcee7b83..608b841a89 100644<br>
&gt;&gt; &gt; --- a/qapi/virtio.json<br>
&gt;&gt; &gt; +++ b/qapi/virtio.json<br>
&gt;&gt; &gt; @@ -79,12 +79,20 @@<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 # @vq-index: vhost_dev vq_index<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; +# @features-bits: vhost_dev features in decimal format<br>
&gt;&gt;<br>
&gt;&gt; Say &quot;encoded as a number&quot;.=C2=A0 The number is decimal j=
ust because the<br>
&gt;&gt; transport is JSON.=C2=A0 We could have another transport some day.=
=C2=A0 Or<br>
&gt;&gt; language bindings wrapping around the JSON transport.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +#<br>
&gt;&gt; &gt;=C2=A0 # @features: vhost_dev features<br>
&gt;&gt;<br>
&gt;&gt; Double-checking...=C2=A0 @feature-bits provides the exact same inf=
ormation as<br>
&gt;&gt; @features, only in another encoding.=C2=A0 Correct?<br>
&gt;<br>
&gt;<br>
&gt;&gt; Same for all the other new -bits.=C2=A0 Correct?<br>
&gt;<br>
&gt; Yes, all the new fields are only about providing another encoding.<br>
<br>
Why do we want to return the same information in two different<br>
encodings?=C2=A0 I figure the commit message tries to answer this question:=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0Features and status bits could be helpful for applicati=
ons to compare<br>
=C2=A0 =C2=A0 =C2=A0directly. For instance, when an upper application aims =
to ensure the<br>
=C2=A0 =C2=A0 =C2=A0virtio negotiation correctness between guest, QEMU, and=
 OVS-DPDK, it use<br>
=C2=A0 =C2=A0 =C2=A0the &quot;ovs-vsctl list interface&quot; command to ret=
rieve interface features<br>
=C2=A0 =C2=A0 =C2=A0(in number format) and the QMP command x-query-virtio-s=
tatus to retrieve<br>
=C2=A0 =C2=A0 =C2=A0vhost-user net device features. If &quot;show-bits&quot=
; is added, the application<br>
=C2=A0 =C2=A0 =C2=A0can compare the two features directly; No need to encod=
ing the features<br>
=C2=A0 =C2=A0 =C2=A0returned by the QMP command.<br>
<br>
=C2=A0 =C2=A0 =C2=A0This patch also serves as a preparation for the next on=
e, which implements<br>
=C2=A0 =C2=A0 =C2=A0a vhost-user test case about acked features of vhost-us=
er protocol.<br>
<br>
I guess you&#39;re trying to simplify use cases where the QMP client wants<=
br>
to compare entire feature sets without caring for individual features.<br>
<br>
The comparison is easy if both sets are represented the same way,<br>
e.g. both are numbers, or both are lists of symbols.</blockquote><div><br><=
/div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif">Yes, =C2=A0quite correct, this patch just aims to keep th=
e unencoded bits for</div><div class=3D"gmail_default" style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif">easy comparison.</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-co=
lor:rgb(204,204,204);padding-left:1ex">
<br>
With different representations, we first have to map to a common<br>
representation.=C2=A0 Unfortunately, the design of x-query-virtio-status<br=
>
makes this harder than it should be.<br>
<br>
We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,<br>
VirtioDeviceFeatures to represent feature sets.=C2=A0 They all work the sam=
e<br>
way: array of strings plus a number.=C2=A0 For each bit QEMU knows, there&#=
39;s a<br>
string in the array.=C2=A0 Any remaining bits go into the number.<br>
<br>
The format of the string is undocumented.=C2=A0 They look like<br>
<br>
=C2=A0 =C2=A0 &quot;WELL_KNOWN_SYMBOL: human readable explanation&quot;<br>
<br>
Mapping from bit to this string in a client would require duplicating<br>
QEMU&#39;s code exactly.<br>
<br>
Mapping both bit and string to just &quot;WELL_KNOWN_SYMBOL&quot; could per=
haps be<br>
done.<br>
<br>
The mapping between symbols and bits is not visible in QMP.=C2=A0 Mapping<b=
r>
from string to bit requires exploiting the undocumented format: extract<br>
the well-known symbol and decode it.<br>
<br>
This encoding of feature sets goes back to commit f3034ad71fc (qmp:<br>
decode feature &amp; status bits in virtio-status) v7.2.=C2=A0 Before that,=
 the<br>
command returned the bits as a number.<br>
<br>
For example, return value &quot;member &quot;status&quot;:<br>
<br>
=C2=A0 =C2=A0 Before f3034ad71fc:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: 15,<br>
<br>
=C2=A0 =C2=A0 Since f3034ad71fc:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;statuses&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_ACKNOWLEDGE: Valid virtio device found&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_DRIVER: Guest OS compatible with device&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_FEATURES_OK: Feature negotiation complete&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_DRIVER_OK: Driver setup and ready&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]},<br>
<br>
=C2=A0 =C2=A0 With your patch:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;statuses&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_ACKNOWLEDGE: Valid virtio device found&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_DRIVER: Guest OS compatible with device&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_FEATURES_OK: Feature negotiation complete&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VIRTIO_CONFIG=
_S_DRIVER_OK: Driver setup and ready&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status-bits&quot;: 15,<br>
<br>
Looks like commit f3034ad71fc improved one use case at the expense of<br>
another, and your patch tries to revert the damage.=C2=A0 Which one exactly=
<br>
it improved is unclear; the commit message doesn&#39;t tell.=C2=A0 Laurent?=
<br>
<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000348fc0060aa6b450--

