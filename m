Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A4927DC4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 21:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPS7V-0005Yf-4p; Thu, 04 Jul 2024 15:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7C-0005N8-Nd
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS79-0005xS-5A
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720121248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+v5S3B7tO5S0dKmKXJ2GiDGO1xql+XwZ4g/2+ONMZo=;
 b=BvM5Y7rbINrCDRgEhKoZ/cgzJk/8QQ1egNHgs+oNyYU0Xg8+vIJTxI8usS3S6Nhz+zaWsg
 E2UkCcTb4HbrmOfpt1MRQYauCNhGjU+bEeOXQsi6KpygpMUIVWKO0Kh/dvLQIW4yfh/Mdf
 j8VvNHyoBcTU+zSS60OfaYJBp3ziIl4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-uck59CCfPuCavyjTzalcOw-1; Thu,
 04 Jul 2024 15:27:22 -0400
X-MC-Unique: uck59CCfPuCavyjTzalcOw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D42119560B4; Thu,  4 Jul 2024 19:27:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E51D3000181; Thu,  4 Jul 2024 19:27:17 +0000 (UTC)
Date: Thu, 4 Jul 2024 18:46:07 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 05/10] hw/scsi: add persistent reservation in/out api
 for scsi device
Message-ID: <20240704164607.GE2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-6-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZzRWT+lLmflzAzYN"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-6-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--ZzRWT+lLmflzAzYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:22PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations in the
> SCSI device layer. By introducing the persistent
> reservation in/out api, this enables the SCSI device
> to perform reservation-related tasks, including querying
> keys, querying reservation status, registering reservation
> keys, initiating and releasing reservations, as well as
> clearing and preempting reservations held by other keys.
>=20
> These operations are crucial for management and control of
> shared storage resources in a persistent manner.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

As mentioned in my reply to a previous version, I don't understand the
buffer allocation/sizing in hw/scsi/ so I haven't been able to fully
review this code for buffer overflows and input validation. cmd.xfer
isn't consistently used for size checks in the new functions. Maybe some
checks are missing?

> ---
>  hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 352 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 4bd7af9d0c..0e964dbd87 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,6 +32,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/scsi/emulation.h"
>  #include "scsi/constants.h"
> +#include "scsi/utils.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/block/block.h"
> @@ -42,6 +43,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "qom/object.h"
> +#include "block/block_int.h"
> =20
>  #ifdef __linux
>  #include <scsi/sg.h>
> @@ -1474,6 +1476,346 @@ static void scsi_disk_emulate_read_data(SCSIReque=
st *req)
>      scsi_req_complete(&r->req, GOOD);
>  }
> =20
> +typedef struct SCSIPrReadKeys {
> +    uint32_t generation;
> +    uint32_t num_keys;
> +    uint64_t *keys;
> +    void     *req;

Why is this field void * instead of SCSIDiskReq *?

> +} SCSIPrReadKeys;
> +
> +typedef struct SCSIPrReadReservation {
> +    uint32_t generation;
> +    uint64_t key;
> +    BlockPrType type;
> +    void *req;

Same here.

> +} SCSIPrReadReservation;
> +
> +static void scsi_pr_read_keys_complete(void *opaque, int ret)
> +{
> +    int num_keys;
> +    uint8_t *buf;
> +    SCSIPrReadKeys *blk_keys =3D (SCSIPrReadKeys *)opaque;
> +    SCSIDiskReq *r =3D (SCSIDiskReq *)blk_keys->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +            qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    buf =3D scsi_req_get_buf(&r->req);
> +    num_keys =3D MIN(blk_keys->num_keys, ret);
> +    blk_keys->generation =3D cpu_to_be32(blk_keys->generation);
> +    memcpy(&buf[0], &blk_keys->generation, 4);
> +    for (int i =3D 0; i < num_keys; i++) {
> +        blk_keys->keys[i] =3D cpu_to_be64(blk_keys->keys[i]);
> +        memcpy(&buf[8 + i * 8], &blk_keys->keys[i], 8);
> +    }
> +    num_keys =3D cpu_to_be32(num_keys * 8);
> +    memcpy(&buf[4], &num_keys, 4);
> +
> +    scsi_req_data(&r->req, r->buflen);
> +done:
> +    scsi_req_unref(&r->req);
> +    g_free(blk_keys->keys);
> +    g_free(blk_keys);
> +}
> +
> +static int scsi_disk_emulate_pr_read_keys(SCSIRequest *req)
> +{
> +    SCSIPrReadKeys *blk_keys;
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +    int buflen =3D MIN(r->req.cmd.xfer, r->buflen);
> +    int num_keys =3D (buflen - sizeof(uint32_t) * 2) / sizeof(uint64_t);

If buflen is an untrusted input then num_keys < 0 and maybe num_keys =3D=3D
0 need to be rejected with an error.

> +
> +    blk_keys =3D g_new0(SCSIPrReadKeys, 1);
> +    blk_keys->generation =3D 0;
> +    /* num_keys is the maximum number of keys that can be transmitted */
> +    blk_keys->num_keys =3D num_keys;
> +    blk_keys->keys =3D g_malloc(sizeof(uint64_t) * num_keys);
> +    blk_keys->req =3D r;
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_read_keys(s->qdev.conf.blk, &blk_keys->g=
eneration,
> +                                        blk_keys->num_keys, blk_keys->ke=
ys,
> +                                        scsi_pr_read_keys_complete, blk_=
keys);
> +    return 0;
> +}
> +
> +static void scsi_pr_read_reservation_complete(void *opaque, int ret)
> +{
> +    uint8_t *buf;
> +    uint32_t additional_len =3D 0;
> +    SCSIPrReadReservation *blk_rsv =3D (SCSIPrReadReservation *)opaque;
> +    SCSIDiskReq *r =3D (SCSIDiskReq *)blk_rsv->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +            qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    buf =3D scsi_req_get_buf(&r->req);
> +    blk_rsv->generation =3D cpu_to_be32(blk_rsv->generation);
> +    memcpy(&buf[0], &blk_rsv->generation, 4);
> +    if (ret) {
> +        additional_len =3D cpu_to_be32(16);
> +        blk_rsv->key =3D cpu_to_be64(blk_rsv->key);
> +        memcpy(&buf[8], &blk_rsv->key, 8);
> +        buf[21] =3D block_pr_type_to_scsi(blk_rsv->type) & 0xf;
> +    } else {
> +        additional_len =3D cpu_to_be32(0);
> +    }
> +
> +    memcpy(&buf[4], &additional_len, 4);
> +    scsi_req_data(&r->req, r->buflen);
> +
> +done:
> +    scsi_req_unref(&r->req);
> +    g_free(blk_rsv);
> +}
> +
> +static int scsi_disk_emulate_pr_read_reservation(SCSIRequest *req)
> +{
> +    SCSIPrReadReservation *blk_rsv;
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);

There is a buflen check in scsi_disk_emulate_pr_report_capabilities()
but not here. Is a check needed here to make sure up to 22 bytes are
available?

> +
> +    blk_rsv =3D g_malloc(sizeof(*blk_rsv));
> +    blk_rsv->generation =3D 0;
> +    blk_rsv->key =3D 0;
> +    blk_rsv->type =3D 0;
> +    blk_rsv->req =3D r;
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_read_reservation(s->qdev.conf.blk,
> +                   &blk_rsv->generation, &blk_rsv->key, &blk_rsv->type,
> +                   scsi_pr_read_reservation_complete, blk_rsv);
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_report_capabilities(SCSIRequest *req)
> +{
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +    BlockDriverState *bs =3D blk_bs(s->qdev.conf.blk);
> +    uint8_t blk_pr_cap =3D bs->file->bs->bl.pr_cap;
> +    uint8_t *buf =3D scsi_req_get_buf(req);
> +    uint16_t pr_cap;
> +    /*
> +     * according to response of report_capabilities
> +     * command of chapter 6.13 of spc4
> +     */
> +    int len =3D sizeof(uint16_t) * 2 + sizeof(uint8_t) * 4;
> +
> +    if (len > r->buflen) {
> +        return -EINVAL;
> +    }
> +
> +    len =3D cpu_to_be16(len);
> +    memcpy(&buf[0], &len, 2);
> +    /* enable PTPL_C */
> +    buf[2] =3D 1;
> +    buf[3] =3D (blk_pr_cap & BLK_PR_CAP_PTPL) ? 1 : 0;
> +    /* enable TMV */
> +    buf[3] |=3D 1 << 7;
> +
> +    /* enable persistent reservation type */
> +    pr_cap =3D block_pr_cap_to_scsi(blk_pr_cap);
> +    buf[4] =3D pr_cap >> 8 & 0xff;
> +    buf[5] =3D pr_cap & 0xff;
> +
> +    scsi_req_data(&r->req, len);
> +    return 0;
> +}
> +
> +static void scsi_aio_pr_complete(void *opaque, int ret)
> +{
> +    SCSIDiskReq *r =3D (SCSIDiskReq *)opaque;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    /* The request must only run in the BlockBackend's AioContext */
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +           qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    scsi_req_complete(&r->req, GOOD);
> +
> +done:
> +    scsi_req_unref(&r->req);
> +}
> +
> +static int scsi_disk_emulate_pr_register(SCSIDiskReq *r, uint64_t r_key,
> +                                         uint64_t sa_key, SCSIPrType typ=
e,
> +                                         uint8_t aptpl, bool ignore_key)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_register(s->qdev.conf.blk, r_key, sa_key,
> +                                       scsi_pr_type_to_block(type),
> +                                       aptpl ? true : false,
> +                                       ignore_key, scsi_aio_pr_complete,=
 r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_reserve(SCSIDiskReq *r, uint64_t r_key,
> +                                        SCSIPrType type)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_reserve(s->qdev.conf.blk, r_key,
> +                                      scsi_pr_type_to_block(type),
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_release(SCSIDiskReq *r, uint64_t r_key,
> +                                        SCSIPrType type)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_release(s->qdev.conf.blk, r_key,
> +                                      scsi_pr_type_to_block(type),
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_clear(SCSIDiskReq *r, uint64_t r_key)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_clear(s->qdev.conf.blk, r_key,
> +                                    scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_preempt(SCSIDiskReq *r, uint64_t r_key,
> +                                        uint64_t sa_key, SCSIPrType type,
> +                                        bool abort)
> +{
> +    SCSIRequest *req =3D &r->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, req->dev);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    r->req.aiocb =3D blk_aio_pr_preempt(s->qdev.conf.blk, r_key, sa_key,
> +                                      scsi_pr_type_to_block(type), abort,
> +                                      scsi_aio_pr_complete, r);
> +
> +    return 0;
> +}
> +
> +static int scsi_disk_emulate_pr_in(SCSIRequest *req)
> +{
> +    int rc;
> +    SCSIPrInAction action =3D req->cmd.buf[1] & 0x1f;
> +
> +    switch (action) {
> +    case SCSI_PR_IN_READ_KEYS:
> +        rc =3D scsi_disk_emulate_pr_read_keys(req);
> +        break;
> +    case SCSI_PR_IN_READ_RESERVATION:
> +        rc =3D scsi_disk_emulate_pr_read_reservation(req);
> +        break;
> +    case SCSI_PR_IN_REPORT_CAPABILITIES:
> +        rc =3D scsi_disk_emulate_pr_report_capabilities(req);
> +        break;
> +    default:
> +        return -ENOTSUP;
> +    }
> +
> +    return rc;
> +}
> +
> +static int scsi_disk_emulate_pr_out(SCSIDiskReq *r, uint8_t *inbuf)
> +{
> +    int rc;
> +    uint8_t aptpl;
> +    uint64_t r_key, sa_key;
> +    SCSIPrOutAction action;
> +    SCSIPrScope scope;
> +    SCSIPrType type;
> +    SCSIRequest *req =3D &r->req;
> +
> +    memcpy(&r_key, &inbuf[0], 8);
> +    r_key =3D be64_to_cpu(r_key);
> +    memcpy(&sa_key, &inbuf[8], 8);
> +    sa_key =3D be64_to_cpu(sa_key);
> +    memcpy(&aptpl, &inbuf[20], 1);
> +    aptpl =3D  aptpl & 0x01;
> +    action =3D req->cmd.buf[1] & 0x1f;
> +    scope =3D (req->cmd.buf[2] >> 4) & 0x0f;
> +    type =3D req->cmd.buf[2] & 0x0f;
> +
> +    if (scope !=3D SCSI_PR_LU_SCOPE) {
> +        return -ENOTSUP;
> +    }
> +
> +    switch (action) {
> +    case SCSI_PR_OUT_REGISTER:
> +        rc =3D scsi_disk_emulate_pr_register(r, r_key, sa_key, type,
> +                                           aptpl, false);
> +        break;
> +    case SCSI_PR_OUT_REG_AND_IGNORE_KEY:
> +        rc =3D scsi_disk_emulate_pr_register(r, r_key, sa_key, type, apt=
pl, true);
> +        break;
> +    case SCSI_PR_OUT_RESERVE:
> +        rc =3D scsi_disk_emulate_pr_reserve(r, r_key, type);
> +        break;
> +    case SCSI_PR_OUT_RELEASE:
> +        rc =3D scsi_disk_emulate_pr_release(r, r_key, type);
> +        break;
> +    case SCSI_PR_OUT_CLEAR:
> +        rc =3D scsi_disk_emulate_pr_clear(r, r_key);
> +        break;
> +    case SCSI_PR_OUT_PREEMPT:
> +        rc =3D scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, fals=
e);
> +        break;
> +    case SCSI_PR_OUT_PREEMPT_AND_ABORT:
> +        rc =3D scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, true=
);
> +        break;
> +    default:
> +        return -ENOTSUP;
> +    }
> +
> +    return rc;
> +}
> +
>  static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
>                                         uint8_t *inbuf, int inlen)
>  {
> @@ -1957,6 +2299,9 @@ static void scsi_disk_emulate_write_data(SCSIReques=
t *req)
>          scsi_req_complete(&r->req, GOOD);
>          break;
> =20
> +    case PERSISTENT_RESERVE_OUT:
> +        scsi_disk_emulate_pr_out(r, r->iov.iov_base);
> +        break;
>      default:
>          abort();
>      }
> @@ -2213,6 +2558,11 @@ static int32_t scsi_disk_emulate_command(SCSIReque=
st *req, uint8_t *buf)
>      case FORMAT_UNIT:
>          trace_scsi_disk_emulate_command_FORMAT_UNIT(r->req.cmd.xfer);
>          break;
> +    case PERSISTENT_RESERVE_OUT:
> +        break;
> +    case PERSISTENT_RESERVE_IN:
> +        scsi_disk_emulate_pr_in(req);
> +        return 0;
>      default:
>          trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
>                                                  scsi_command_name(buf[0]=
));
> @@ -2632,6 +2982,8 @@ static const SCSIReqOps *const scsi_disk_reqops_dis=
patch[256] =3D {
>      [VERIFY_12]                       =3D &scsi_disk_emulate_reqops,
>      [VERIFY_16]                       =3D &scsi_disk_emulate_reqops,
>      [FORMAT_UNIT]                     =3D &scsi_disk_emulate_reqops,
> +    [PERSISTENT_RESERVE_IN]           =3D &scsi_disk_emulate_reqops,
> +    [PERSISTENT_RESERVE_OUT]          =3D &scsi_disk_emulate_reqops,
> =20
>      [READ_6]                          =3D &scsi_disk_dma_reqops,
>      [READ_10]                         =3D &scsi_disk_dma_reqops,
> --=20
> 2.20.1
>=20

--ZzRWT+lLmflzAzYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaG0c8ACgkQnKSrs4Gr
c8hdxwf+Pst99ZNKF3CmopAxrFDzXct5tHszyDTBS+0Ocu/S4RSnsqlrNRZeznCT
2dEWroWYKOPM2Qjz/V9squpXWRFphPa4cN2UMxSWwJuN0YwtVpcIetjtxBQQPY0O
M4tND2IBoH6DhB6kf08rrbnQKcFLU89VpC73LGdLZRQzfhGL8sGBwrdEwCZlObjF
8c8HxrGC1EPGzVU+HbDziZzyEDDM/6RKYgpI9PciSO/6dSGy7QTQfM4hgeq7lMTI
neS08hUhWVt1bvEr+/EPRbltRZBUQsbB4jGr+J90EOmHEGJbnGOHnkqdNPnxzMDS
h51c/nCrPrqLzcu4AO2+/Z9HKv1W2A==
=NdZ+
-----END PGP SIGNATURE-----

--ZzRWT+lLmflzAzYN--


