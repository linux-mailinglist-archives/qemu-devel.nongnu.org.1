Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A97B121A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 07:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qljal-0006qW-Pj; Thu, 28 Sep 2023 01:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qljaZ-0006pA-2V
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qljaX-00023H-Eq
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 01:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695878964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+d+yTZNDpTfGAJFZvXcA2LE0IIjzO8p6cSKSTTc4L4=;
 b=CF8MJecEmjaAOl2wlvMeORobGBSUX/TVwB4FgLrJWzJNZnTl4VJq9N+LAyaQfz0sCF9bp/
 SZ4hhGsvgU641kEaei738tAcz4YhW0JohZ4FMRc7EDlpeYpo59jd+d3n917KmhGh576xa/
 olzBWJnZl3Zk7vhzWl/IrN2Iu86kk3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-dCnKk8b4OYyuPo8wk76s3Q-1; Thu, 28 Sep 2023 01:29:21 -0400
X-MC-Unique: dCnKk8b4OYyuPo8wk76s3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3704101A529;
 Thu, 28 Sep 2023 05:29:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8545649BB9A;
 Thu, 28 Sep 2023 05:29:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A00FA21E6900; Thu, 28 Sep 2023 07:29:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>,  qemu-devel@nongnu.org,  Markus
 Armbruster <armbru@redhat.com>,  Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] tpm: add backend for mssim
References: <20230927164908.12891-1-jejb@linux.ibm.com>
 <20230927164908.12891-3-jejb@linux.ibm.com>
 <ZRRgVAMbwXDsvdk/@redhat.com>
Date: Thu, 28 Sep 2023 07:29:19 +0200
In-Reply-To: <ZRRgVAMbwXDsvdk/@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 27 Sep 2023 18:03:16 +0100")
Message-ID: <87bkdm6f2o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 27, 2023 at 12:49:08PM -0400, James Bottomley wrote:
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>>=20
>> The Microsoft Simulator (mssim) is the reference emulation platform
>> for the TCG TPM 2.0 specification.
>>=20
>> https://github.com/Microsoft/ms-tpm-20-ref.git
>>=20
>> It exports a fairly simple network socket based protocol on two
>> sockets, one for command (default 2321) and one for control (default
>> 2322).  This patch adds a simple backend that can speak the mssim
>> protocol over the network.  It also allows the two sockets to be
>> specified on the command line.  The benefits are twofold: firstly it
>> gives us a backend that actually speaks a standard TPM emulation
>> protocol instead of the linux specific TPM driver format of the
>> current emulated TPM backend and secondly, using the microsoft
>> protocol, the end point of the emulator can be anywhere on the
>> network, facilitating the cloud use case where a central TPM service
>> can be used over a control network.
>>=20
>> The implementation does basic control commands like power off/on, but
>> doesn't implement cancellation or startup.  The former because
>> cancellation is pretty much useless on a fast operating TPM emulator
>> and the latter because this emulator is designed to be used with OVMF
>> which itself does TPM startup and I wanted to validate that.
>>=20
>> To run this, simply download an emulator based on the MS specification
>> (package ibmswtpm2 on openSUSE) and run it, then add these two lines
>> to the qemu command and it will use the emulator.
>>=20
>>     -tpmdev mssim,id=3Dtpm0 \
>>     -device tpm-crb,tpmdev=3Dtpm0 \
>>=20
>> to use a remote emulator replace the first line with
>>=20
>>     -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'=
remote','port':'2321'}}"
>>=20
>> tpm-tis also works as the backend.
>>=20
>> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>

[...]

>> diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
>> new file mode 100644
>> index 0000000000..b8a12dce04
>> --- /dev/null
>> +++ b/backends/tpm/tpm_mssim.c
>> @@ -0,0 +1,290 @@
>> +/*
>> + * Emulator TPM driver which connects over the mssim protocol
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Copyright (c) 2022
>> + * Author: James Bottomley <jejb@linux.ibm.com>
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/sockets.h"
>> +
>> +#include "qapi/clone-visitor.h"
>> +#include "qapi/qapi-visit-tpm.h"
>> +
>> +#include "io/channel-socket.h"
>> +
>> +#include "sysemu/runstate.h"
>> +#include "sysemu/tpm_backend.h"
>> +#include "sysemu/tpm_util.h"
>> +
>> +#include "qom/object.h"
>> +
>> +#include "tpm_int.h"
>> +#include "tpm_mssim.h"
>> +
>> +#define ERROR_PREFIX "TPM mssim Emulator: "
>> +
>> +#define TYPE_TPM_MSSIM "tpm-mssim"
>> +OBJECT_DECLARE_SIMPLE_TYPE(TPMMssim, TPM_MSSIM)
>> +
>> +struct TPMMssim {
>> +    TPMBackend parent;
>> +
>> +    TPMMssimOptions opts;
>> +
>> +    QIOChannelSocket *cmd_qc, *ctrl_qc;
>> +};
>> +
>> +static int tpm_send_ctrl(TPMMssim *t, uint32_t cmd, Error **errp)
>> +{
>> +    int ret;
>> +
>> +    qio_channel_socket_connect_sync(t->ctrl_qc, t->opts.control, errp);
>
> Need to assign to 'ret' and check for failure here, otherwise the
> next call to write_all will overwrite the useful message in 'errp'
> with a less helpful one.

No, it'll crash :)

An @errp argument must point to a null pointer.  If it doesn't, setting
an error will trip error_setv()'s assertion.

> +    cmd =3D htonl(cmd);
> +    ret =3D qio_channel_write_all(QIO_CHANNEL(t->ctrl_qc),
> +                                (char *)&cmd, sizeof(cmd), errp);
> +    if (ret !=3D 0) {
> +        goto out;
> +    }

qapi/error.h's big comment advises:

 * Receive and accumulate multiple errors (first one wins):
 *     Error *err =3D NULL, *local_err =3D NULL;
 *     foo(arg, &err);
 *     bar(arg, &local_err);
 *     error_propagate(&err, local_err);
 *     if (err) {
 *         handle the error...
 *     }
 *
 * Do *not* "optimize" this to
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     bar(arg, &err); // WRONG!
 *     if (err) {
 *         handle the error...
 *     }
 * because this may pass a non-null err to bar().
 *
 * Likewise, do *not*
 *     Error *err =3D NULL;
 *     if (cond1) {
 *         error_setg(&err, ...);
 *     }
 *     if (cond2) {
 *         error_setg(&err, ...); // WRONG!
 *     }
 * because this may pass a non-null err to error_setg().

The quoted code is like the last example, except the error_setg() lurk
within the functions called.

[...]


