Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F327B0ACA
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 19:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlXwh-00029g-Un; Wed, 27 Sep 2023 13:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlXwe-00029U-K3
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlXwb-0008JC-Ed
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695834203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AsqTUAY9SVNtZKsF2zk72Q9LMtUoyOx+dMUV2Zi/WDs=;
 b=bm0O7gmBrN/uOpq+YJiqTvtbOJFYuZulY0Ad9yk0mtyFOZnLvnkaZYDr/mFS25wMw/Xcq3
 XHBLhlsASIgb9nCfK4OChTwk7gmz4WRoPA8k0diPr0qe9hySW7mJ14N7+ZQuT1g6uE6F6K
 O5hs9SSYXZUjntCyYwHbLJRXMgZLCCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-6qWLReELPwSf_9MCLPItqA-1; Wed, 27 Sep 2023 13:03:19 -0400
X-MC-Unique: 6qWLReELPwSf_9MCLPItqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38EFE811E7E;
 Wed, 27 Sep 2023 17:03:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D9F940C6EA8;
 Wed, 27 Sep 2023 17:03:18 +0000 (UTC)
Date: Wed, 27 Sep 2023 18:03:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] tpm: add backend for mssim
Message-ID: <ZRRgVAMbwXDsvdk/@redhat.com>
References: <20230927164908.12891-1-jejb@linux.ibm.com>
 <20230927164908.12891-3-jejb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927164908.12891-3-jejb@linux.ibm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Wed, Sep 27, 2023 at 12:49:08PM -0400, James Bottomley wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> The Microsoft Simulator (mssim) is the reference emulation platform
> for the TCG TPM 2.0 specification.
> 
> https://github.com/Microsoft/ms-tpm-20-ref.git
> 
> It exports a fairly simple network socket based protocol on two
> sockets, one for command (default 2321) and one for control (default
> 2322).  This patch adds a simple backend that can speak the mssim
> protocol over the network.  It also allows the two sockets to be
> specified on the command line.  The benefits are twofold: firstly it
> gives us a backend that actually speaks a standard TPM emulation
> protocol instead of the linux specific TPM driver format of the
> current emulated TPM backend and secondly, using the microsoft
> protocol, the end point of the emulator can be anywhere on the
> network, facilitating the cloud use case where a central TPM service
> can be used over a control network.
> 
> The implementation does basic control commands like power off/on, but
> doesn't implement cancellation or startup.  The former because
> cancellation is pretty much useless on a fast operating TPM emulator
> and the latter because this emulator is designed to be used with OVMF
> which itself does TPM startup and I wanted to validate that.
> 
> To run this, simply download an emulator based on the MS specification
> (package ibmswtpm2 on openSUSE) and run it, then add these two lines
> to the qemu command and it will use the emulator.
> 
>     -tpmdev mssim,id=tpm0 \
>     -device tpm-crb,tpmdev=tpm0 \
> 
> to use a remote emulator replace the first line with
> 
>     -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote','port':'2321'}}"
> 
> tpm-tis also works as the backend.
> 
> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> ---
> 
> v2: convert to SocketAddr json and use qio_channel_socket_connect_sync()
> v3: gate control power off by migration state keep control socket disconnected
>     to test outside influence and add docs.
>     v7: TPMmssim -> TPMMssim; doc and json fixes
> ---
>  MAINTAINERS              |   6 +
>  backends/tpm/Kconfig     |   5 +
>  backends/tpm/meson.build |   1 +
>  backends/tpm/tpm_mssim.c | 290 +++++++++++++++++++++++++++++++++++++++
>  backends/tpm/tpm_mssim.h |  44 ++++++
>  docs/specs/tpm.rst       |  39 ++++++
>  qapi/tpm.json            |  32 ++++-
>  softmmu/tpm-hmp-cmds.c   |   9 ++
>  8 files changed, 422 insertions(+), 4 deletions(-)
>  create mode 100644 backends/tpm/tpm_mssim.c
>  create mode 100644 backends/tpm/tpm_mssim.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf2366815b..939e0e65c3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3182,10 +3182,16 @@ F: include/hw/acpi/tpm.h
>  F: include/sysemu/tpm*
>  F: qapi/tpm.json
>  F: backends/tpm/
> +X: backends/tpm/tpm_mssim.*
>  F: tests/qtest/*tpm*
>  F: docs/specs/tpm.rst
>  T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>  
> +MSSIM TPM Backend
> +M: James Bottomley <jejb@linux.ibm.com>
> +S: Maintained
> +F: backends/tpm/tpm_mssim.*
> +
>  Checkpatch
>  S: Odd Fixes
>  F: scripts/checkpatch.pl
> diff --git a/backends/tpm/Kconfig b/backends/tpm/Kconfig
> index 5d91eb89c2..d6d6fa53e9 100644
> --- a/backends/tpm/Kconfig
> +++ b/backends/tpm/Kconfig
> @@ -12,3 +12,8 @@ config TPM_EMULATOR
>      bool
>      default y
>      depends on TPM_BACKEND
> +
> +config TPM_MSSIM
> +    bool
> +    default y
> +    depends on TPM_BACKEND
> diff --git a/backends/tpm/meson.build b/backends/tpm/meson.build
> index 0bfa6c422b..c6f7c24cb1 100644
> --- a/backends/tpm/meson.build
> +++ b/backends/tpm/meson.build
> @@ -3,4 +3,5 @@ if have_tpm
>    system_ss.add(files('tpm_util.c'))
>    system_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true: files('tpm_passthrough.c'))
>    system_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))
> +  system_ss.add(when: 'CONFIG_TPM_MSSIM', if_true: files('tpm_mssim.c'))
>  endif
> diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
> new file mode 100644
> index 0000000000..b8a12dce04
> --- /dev/null
> +++ b/backends/tpm/tpm_mssim.c
> @@ -0,0 +1,290 @@
> +/*
> + * Emulator TPM driver which connects over the mssim protocol
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2022
> + * Author: James Bottomley <jejb@linux.ibm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/sockets.h"
> +
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-tpm.h"
> +
> +#include "io/channel-socket.h"
> +
> +#include "sysemu/runstate.h"
> +#include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
> +
> +#include "qom/object.h"
> +
> +#include "tpm_int.h"
> +#include "tpm_mssim.h"
> +
> +#define ERROR_PREFIX "TPM mssim Emulator: "
> +
> +#define TYPE_TPM_MSSIM "tpm-mssim"
> +OBJECT_DECLARE_SIMPLE_TYPE(TPMMssim, TPM_MSSIM)
> +
> +struct TPMMssim {
> +    TPMBackend parent;
> +
> +    TPMMssimOptions opts;
> +
> +    QIOChannelSocket *cmd_qc, *ctrl_qc;
> +};
> +
> +static int tpm_send_ctrl(TPMMssim *t, uint32_t cmd, Error **errp)
> +{
> +    int ret;
> +
> +    qio_channel_socket_connect_sync(t->ctrl_qc, t->opts.control, errp);

Need to assign to 'ret' and check for failure here, otherwise the
next call to write_all will overwrite the useful message in 'errp'
with a less helpful one.

> +    cmd = htonl(cmd);
> +    ret = qio_channel_write_all(QIO_CHANNEL(t->ctrl_qc),
> +                                (char *)&cmd, sizeof(cmd), errp);
> +    if (ret != 0) {
> +        goto out;
> +    }
> +
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->ctrl_qc),
> +                               (char *)&cmd, sizeof(cmd), errp);
> +    if (ret != 0) {
> +        goto out;
> +    }
> +    if (cmd != 0) {
> +        error_setg(errp, ERROR_PREFIX
> +                   "Incorrect ACK recieved on control channel 0x%x", cmd);
> +        ret = -1;
> +    }
> + out:
> +    qio_channel_close(QIO_CHANNEL(t->ctrl_qc), errp);

Should check failure here, and if it fails set 'ret' to -1
too, so that in the success codepath, we catch any final
error.

> +    return ret;
> +}
> +
> +static void tpm_mssim_instance_init(Object *obj)
> +{
> +}
> +
> +static void tpm_mssim_instance_finalize(Object *obj)
> +{
> +    TPMMssim *t = TPM_MSSIM(obj);
> +
> +    if (t->cmd_qc && !runstate_check(RUN_STATE_POSTMIGRATE)) {
> +        tpm_send_ctrl(t, TPM_SIGNAL_POWER_OFF, NULL);

Finalize doesn't let us propagate the error, but it is probably
worth using error_report_err to print it.

> +    }
> +
> +    object_unref(OBJECT(t->ctrl_qc));
> +    object_unref(OBJECT(t->cmd_qc));
> +}
> +
> +static void tpm_mssim_cancel_cmd(TPMBackend *tb)
> +{
> +        return;
> +}
> +
> +static TPMVersion tpm_mssim_get_version(TPMBackend *tb)
> +{
> +    return TPM_VERSION_2_0;
> +}
> +
> +static size_t tpm_mssim_get_buffer_size(TPMBackend *tb)
> +{
> +    /* TCG standard profile max buffer size */
> +    return 4096;
> +}
> +
> +static TpmTypeOptions *tpm_mssim_get_opts(TPMBackend *tb)
> +{
> +    TPMMssim *t = TPM_MSSIM(tb);
> +    TpmTypeOptions *opts = g_new0(TpmTypeOptions, 1);
> +
> +    opts->type = TPM_TYPE_MSSIM;
> +    QAPI_CLONE_MEMBERS(TPMMssimOptions, &opts->u.mssim, &t->opts);
> +
> +    return opts;
> +}
> +
> +static void tpm_mssim_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
> +                                     Error **errp)
> +{
> +    TPMMssim *t = TPM_MSSIM(tb);
> +    uint32_t header, len;
> +    uint8_t locality = cmd->locty;
> +    struct iovec iov[4];
> +    int ret;
> +
> +    header = htonl(TPM_SEND_COMMAND);
> +    len = htonl(cmd->in_len);
> +
> +    iov[0].iov_base = &header;
> +    iov[0].iov_len = sizeof(header);
> +    iov[1].iov_base = &locality;
> +    iov[1].iov_len = sizeof(locality);
> +    iov[2].iov_base = &len;
> +    iov[2].iov_len = sizeof(len);
> +    iov[3].iov_base = (void *)cmd->in;
> +    iov[3].iov_len = cmd->in_len;
> +
> +    ret = qio_channel_writev_all(QIO_CHANNEL(t->cmd_qc), iov, 4, errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->cmd_qc),
> +                               (char *)&len, sizeof(len), errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +
> +    len = ntohl(len);
> +    if (len > cmd->out_len) {
> +        error_setg(errp, "receive size is too large");
> +        goto fail;
> +    }
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->cmd_qc),
> +                               (char *)cmd->out, len, errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +
> +    /* ACK packet */
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->cmd_qc),
> +                               (char *)&header, sizeof(header), errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +    if (header != 0) {
> +        error_setg(errp, "incorrect ACK received on command channel 0x%x", len);
> +        goto fail;
> +    }
> +
> +    return;
> +
> + fail:
> +    error_prepend(errp, ERROR_PREFIX);
> +    tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
> +}
> +
> +static TPMBackend *tpm_mssim_create(TpmCreateOptions *opts)
> +{
> +    TPMBackend *be = TPM_BACKEND(object_new(TYPE_TPM_MSSIM));
> +    TPMMssim *t = TPM_MSSIM(be);
> +    int sock;
> +    Error *errp = NULL;
> +    TPMMssimOptions *mo = &opts->u.mssim;
> +
> +    if (!mo->command) {
> +            mo->command = g_new0(SocketAddress, 1);
> +            mo->command->type = SOCKET_ADDRESS_TYPE_INET;
> +            mo->command->u.inet.host = g_strdup("localhost");
> +            mo->command->u.inet.port = g_strdup("2321");
> +    }
> +    if (!mo->control) {
> +            int port;
> +
> +            mo->control = g_new0(SocketAddress, 1);
> +            mo->control->type = SOCKET_ADDRESS_TYPE_INET;
> +            mo->control->u.inet.host = g_strdup(mo->command->u.inet.host);
> +            /*
> +             * in the reference implementation, the control port is
> +             * always one above the command port
> +             */
> +            port = atoi(mo->command->u.inet.port) + 1;
> +            mo->control->u.inet.port = g_strdup_printf("%d", port);
> +    }
> +
> +    QAPI_CLONE_MEMBERS(TPMMssimOptions, &t->opts, &opts->u.mssim);
> +    t->cmd_qc = qio_channel_socket_new();
> +    t->ctrl_qc = qio_channel_socket_new();
> +
> +    if (qio_channel_socket_connect_sync(t->cmd_qc, mo->command, &errp) < 0) {
> +        goto fail;
> +    }
> +
> +    if (qio_channel_socket_connect_sync(t->ctrl_qc, mo->control, &errp) < 0) {
> +        goto fail;
> +    }
> +    qio_channel_close(QIO_CHANNEL(t->ctrl_qc), &errp);
> +
> +    if (!runstate_check(RUN_STATE_INMIGRATE)) {
> +        /*
> +         * reset the TPM using a power cycle sequence, in case someone
> +         * has previously powered it up
> +         */
> +        sock = tpm_send_ctrl(t, TPM_SIGNAL_POWER_OFF, &errp);
> +        if (sock != 0) {
> +            goto fail;
> +        }

s/sock/ret/ would be less confusing, as its returning a plain
status code, rather than a socket.

> +
> +        sock = tpm_send_ctrl(t, TPM_SIGNAL_POWER_ON, &errp);
> +        if (sock != 0) {
> +            goto fail;
> +        }
> +
> +        sock = tpm_send_ctrl(t, TPM_SIGNAL_NV_ON, &errp);
> +        if (sock != 0) {
> +            goto fail;
> +        }
> +    }
> +
> +    return be;
> +
> + fail:
> +    object_unref(OBJECT(t->ctrl_qc));
> +    object_unref(OBJECT(t->cmd_qc));
> +    t->ctrl_qc = NULL;
> +    t->cmd_qc = NULL;
> +    error_prepend(&errp, ERROR_PREFIX);
> +    error_report_err(errp);
> +    object_unref(OBJECT(be));
> +
> +    return NULL;
> +}
> +



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


