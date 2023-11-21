Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C97F26CB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:58:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LeT-00067F-SC; Tue, 21 Nov 2023 02:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5LeS-00066x-RN
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5LeQ-0005or-FQ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700553509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6sivWt/sGy+Lp5GgAQY5M/UkBQ1tWiTSmPqlcV5Q3s=;
 b=i1sWX/o+Z73kkzhhG0QhcocLf+svqHukyLEUbLy95axBR96FSK+IjHkcZ8rvaG+hv+rL2O
 rsAE4/ge+XW51Dybeiay+lOSlk3NsQgtMRyHGfJa633qA/oJ/qek7tcFUP9nWYQuciSLdW
 bDVtZAkVV75V3B4UG35CuMI/PkzJH1Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-roYtmZQ6Pnuk6BICHUbjxQ-1; Tue,
 21 Nov 2023 02:58:24 -0500
X-MC-Unique: roYtmZQ6Pnuk6BICHUbjxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB4E38143B5;
 Tue, 21 Nov 2023 07:58:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D26F492BFA;
 Tue, 21 Nov 2023 07:58:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86E7521E6A1F; Tue, 21 Nov 2023 08:58:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
Date: Tue, 21 Nov 2023 08:58:22 +0100
In-Reply-To: <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 (Yong Huang's message of "Sat, 18 Nov 2023 00:12:52 +0800")
Message-ID: <87v89vleqp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Laurent, there's a question for you at the end.

Yong Huang <yong.huang@smartx.com> writes:

> On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com>
> wrote:
>
>> Hyman Huang <yong.huang@smartx.com> writes:
>>
>> > This patch allows to display feature and status bits in virtio-status.
>> >
>> > An optional argument is introduced: show-bits. For example:
>> > {"execute": "x-query-virtio-status",
>> >  "arguments": {"path": "/machine/peripheral-anon/device[1]/virtio-back=
end",
>> >                "show-bits": true}
>> >
>> > Features and status bits could be helpful for applications to compare
>> > directly. For instance, when an upper application aims to ensure the
>> > virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it u=
se
>> > the "ovs-vsctl list interface" command to retrieve interface features
>> > (in number format) and the QMP command x-query-virtio-status to retrie=
ve
>> > vhost-user net device features. If "show-bits" is added, the applicati=
on
>> > can compare the two features directly; No need to encoding the features
>> > returned by the QMP command.
>> >
>> > This patch also serves as a preparation for the next one, which implem=
ents
>> > a vhost-user test case about acked features of vhost-user protocol.
>> >
>> > Note that since the matching HMP command is typically used for human,
>> > leave it unchanged.
>> >
>> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> > ---
>> >  hw/virtio/virtio-hmp-cmds.c |  2 +-
>> >  hw/virtio/virtio-qmp.c      | 21 +++++++++++++++-
>> >  qapi/virtio.json            | 49 ++++++++++++++++++++++++++++++++++---
>> >  3 files changed, 67 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
>> > index 477c97dea2..3774f3d4bf 100644
>> > --- a/hw/virtio/virtio-hmp-cmds.c
>> > +++ b/hw/virtio/virtio-hmp-cmds.c
>> > @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict *=
qdict)
>> >  {
>> >      Error *err =3D NULL;
>> >      const char *path =3D qdict_get_try_str(qdict, "path");
>> > -    VirtioStatus *s =3D qmp_x_query_virtio_status(path, &err);
>> > +    VirtioStatus *s =3D qmp_x_query_virtio_status(path, false, false,=
 &err);
>> >
>> >      if (err !=3D NULL) {
>> >          hmp_handle_error(mon, err);
>> > diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> > index 1dd96ed20f..2e92bf28ac 100644
>> > --- a/hw/virtio/virtio-qmp.c
>> > +++ b/hw/virtio/virtio-qmp.c
>> > @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const char =
*path)
>> >      return VIRTIO_DEVICE(dev);
>> >  }
>> >
>> > -VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **err=
p)
>> > +VirtioStatus *qmp_x_query_virtio_status(const char *path,
>> > +                                        bool has_show_bits,
>> > +                                        bool show_bits,
>> > +                                        Error **errp)
>> >  {
>> >      VirtIODevice *vdev;
>> >      VirtioStatus *status;
>> > +    bool display_bits =3D
>> > +        has_show_bits ? show_bits : false;
>>
>> Since !has_show_bits implies !show_bits, you can simply use
>> if (show_bits).
>>
> Ok
>
>>
>> >
>> >      vdev =3D qmp_find_virtio_device(path);
>> >      if (vdev =3D=3D NULL) {
>> > @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r *path, Error **errp)
>> >      status->name =3D g_strdup(vdev->name);
>> >      status->device_id =3D vdev->device_id;
>> >      status->vhost_started =3D vdev->vhost_started;
>> > +    if (display_bits) {
>> > +        status->guest_features_bits =3D vdev->guest_features;
>> > +        status->host_features_bits =3D vdev->host_features;
>> > +        status->backend_features_bits =3D vdev->backend_features;
>> > +    }
>> >      status->guest_features =3D qmp_decode_features(vdev->device_id,
>> >                                                   vdev->guest_features=
);
>> >      status->host_features =3D qmp_decode_features(vdev->device_id,
>> > @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char=
 *path, Error **errp)
>> >      }
>> >
>> >      status->num_vqs =3D virtio_get_num_queues(vdev);
>> > +    if (display_bits) {
>> > +        status->status_bits =3D vdev->status;
>> > +    }
>> >      status->status =3D qmp_decode_status(vdev->status);
>> >      status->isr =3D vdev->isr;
>> >      status->queue_sel =3D vdev->queue_sel;
>> > @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r *path, Error **errp)
>> >          status->vhost_dev->n_tmp_sections =3D hdev->n_tmp_sections;
>> >          status->vhost_dev->nvqs =3D hdev->nvqs;
>> >          status->vhost_dev->vq_index =3D hdev->vq_index;
>> > +        if (display_bits) {
>> > +            status->vhost_dev->features_bits =3D hdev->features;
>> > +            status->vhost_dev->acked_features_bits =3D hdev->acked_fe=
atures;
>> > +            status->vhost_dev->backend_features_bits =3D hdev->backen=
d_features;
>> > +            status->vhost_dev->protocol_features_bits =3D hdev->proto=
col_features;
>> > +        }
>> >          status->vhost_dev->features =3D
>> >              qmp_decode_features(vdev->device_id, hdev->features);
>> >          status->vhost_dev->acked_features =3D
>> > diff --git a/qapi/virtio.json b/qapi/virtio.json
>> > index e6dcee7b83..608b841a89 100644
>> > --- a/qapi/virtio.json
>> > +++ b/qapi/virtio.json
>> > @@ -79,12 +79,20 @@
>> >  #
>> >  # @vq-index: vhost_dev vq_index
>> >  #
>> > +# @features-bits: vhost_dev features in decimal format
>>
>> Say "encoded as a number".  The number is decimal just because the
>> transport is JSON.  We could have another transport some day.  Or
>> language bindings wrapping around the JSON transport.
>>
>> > +#
>> >  # @features: vhost_dev features
>>
>> Double-checking...  @feature-bits provides the exact same information as
>> @features, only in another encoding.  Correct?
>
>
>> Same for all the other new -bits.  Correct?
>
> Yes, all the new fields are only about providing another encoding.

Why do we want to return the same information in two different
encodings?  I figure the commit message tries to answer this question:

     Features and status bits could be helpful for applications to compare
     directly. For instance, when an upper application aims to ensure the
     virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it u=
se
     the "ovs-vsctl list interface" command to retrieve interface features
     (in number format) and the QMP command x-query-virtio-status to retrie=
ve
     vhost-user net device features. If "show-bits" is added, the applicati=
on
     can compare the two features directly; No need to encoding the features
     returned by the QMP command.

     This patch also serves as a preparation for the next one, which implem=
ents
     a vhost-user test case about acked features of vhost-user protocol.

I guess you're trying to simplify use cases where the QMP client wants
to compare entire feature sets without caring for individual features.

The comparison is easy if both sets are represented the same way,
e.g. both are numbers, or both are lists of symbols.

With different representations, we first have to map to a common
representation.  Unfortunately, the design of x-query-virtio-status
makes this harder than it should be.

We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,
VirtioDeviceFeatures to represent feature sets.  They all work the same
way: array of strings plus a number.  For each bit QEMU knows, there's a
string in the array.  Any remaining bits go into the number.

The format of the string is undocumented.  They look like

    "WELL_KNOWN_SYMBOL: human readable explanation"

Mapping from bit to this string in a client would require duplicating
QEMU's code exactly.

Mapping both bit and string to just "WELL_KNOWN_SYMBOL" could perhaps be
done.

The mapping between symbols and bits is not visible in QMP.  Mapping
from string to bit requires exploiting the undocumented format: extract
the well-known symbol and decode it.

This encoding of feature sets goes back to commit f3034ad71fc (qmp:
decode feature & status bits in virtio-status) v7.2.  Before that, the
command returned the bits as a number.

For example, return value "member "status":

    Before f3034ad71fc:

        "status": 15,

    Since f3034ad71fc:

        "status": {
            "statuses": [
                "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
                "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
                "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
                "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
            ]},

    With your patch:

        "status": {
            "statuses": [
                "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
                "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
                "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
                "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
            ]},
        "status-bits": 15,

Looks like commit f3034ad71fc improved one use case at the expense of
another, and your patch tries to revert the damage.  Which one exactly
it improved is unclear; the commit message doesn't tell.  Laurent?

[...]


