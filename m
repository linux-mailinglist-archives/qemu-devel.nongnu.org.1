Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725B7828A2
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3jU-0003L2-MD; Mon, 21 Aug 2023 08:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY3jT-0003Ks-0s
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY3jQ-0006yf-B1
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692619803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO31bi0ZuPQP+XnpN2Zysz6pkwQzGmlq9m7BA5u8cAU=;
 b=i96LltGsDBSh57c8nIosDXJoHdOfPcRkZzVab+CsIUpDG1gqlqoCTCfHb4xT8Q0blnAmXV
 b1JxXLDPqVGrLhlvHHOc6hddK9ClFB0G0Wt5nlZe6y8RKu6UmvfwfCUAZyO2tL2DjkDF56
 yafb2Gwu97MC/EYx5Fmoq5XPUM5niMQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-USH_LyqvO52U1sFm9YDp4A-1; Mon, 21 Aug 2023 08:09:59 -0400
X-MC-Unique: USH_LyqvO52U1sFm9YDp4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AAB92A5957F;
 Mon, 21 Aug 2023 12:09:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC7BB40D2843;
 Mon, 21 Aug 2023 12:09:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C834A21E690D; Mon, 21 Aug 2023 14:09:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-3-fengli@smartx.com>
 <C026BA6F-63E7-4BE8-8FC0-69372A14FFAB@nutanix.com>
 <844CBDD0-E0A9-4097-904E-5CD74C2884AD@smartx.com>
Date: Mon, 21 Aug 2023 14:09:57 +0200
In-Reply-To: <844CBDD0-E0A9-4097-904E-5CD74C2884AD@smartx.com> (Li Feng's
 message of "Thu, 17 Aug 2023 14:49:53 +0800")
Message-ID: <87o7j0egve.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Li Feng <fengli@smartx.com> writes:

>> 2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphae=
l Norwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Thanks for the cleanup! A few comments.
>>=20
>>> On Aug 4, 2023, at 1:29 AM, Li Feng <fengli@smartx.com> wrote:
>>>=20
>>> Add a Error parameter to report the real error, like vhost-user-blk.
>>>=20
>>> Signed-off-by: Li Feng <fengli@smartx.com>
>>> ---
>>> hw/scsi/vhost-scsi-common.c           | 17 ++++++++++-------
>>> hw/scsi/vhost-scsi.c                  |  5 +++--
>>> hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
>>> include/hw/virtio/vhost-scsi-common.h |  2 +-
>>> 4 files changed, 22 insertions(+), 16 deletions(-)
>>>=20
>>> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
>>> index a61cd0e907..392587dfb5 100644
>>> --- a/hw/scsi/vhost-scsi-common.c
>>> +++ b/hw/scsi/vhost-scsi-common.c
>>> @@ -16,6 +16,7 @@
>>> */
>>>=20
>>> #include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> #include "qemu/error-report.h"
>>> #include "qemu/module.h"
>>> #include "hw/virtio/vhost.h"
>>> @@ -25,7 +26,7 @@
>>> #include "hw/virtio/virtio-access.h"
>>> #include "hw/fw-path-provider.h"
>>>=20
>>> -int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
>>> {
>>>    int ret, i;
>>>    VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>>> @@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>>    VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;
>>>=20
>>>    if (!k->set_guest_notifiers) {
>>> -        error_report("binding does not support guest notifiers");
>>> +        error_setg(errp, "binding does not support guest notifiers");
>>>        return -ENOSYS;
>>>    }
>>>=20
>>>    ret =3D vhost_dev_enable_notifiers(&vsc->dev, vdev);
>>>    if (ret < 0) {
>>> +        error_setg_errno(errp, -ret, "Error enabling host notifiers");
>>>        return ret;
>>>    }
>>>=20
>>>    ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
>>>    if (ret < 0) {
>>> -        error_report("Error binding guest notifier");
>>> +        error_setg_errno(errp, -ret, "Error binding guest notifier");
>>>        goto err_host_notifiers;
>>>    }
>>>=20
>>> @@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>>=20
>>>    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>>>    if (ret < 0) {
>>> -        error_report("Error setting inflight format: %d", -ret);
>>=20
>> Curious why you=E2=80=99re adding the error value to the string. Isn=E2=
=80=99t it redundant since we pass it in as the second param?
>>=20
>>> +        error_setg_errno(errp, -ret, "Error setting inflight format: %=
d", -ret);
>
> I don=E2=80=99t understand. Here I put the error message in errp, where i=
s redundant?

The error message will come out like

    Error setting inflight format: 22: Invalid argument

You need to drop ": %d".

Two remarks:

1. The #1 reason for bad error messages is neglecting to *test* them.

2. Printing errno as a number is needlessly unfriendly to users.

[...]


