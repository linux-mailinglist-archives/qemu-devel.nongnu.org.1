Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B3735178
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:06:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBBld-0005B3-U5; Mon, 19 Jun 2023 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBBlM-0004pz-3L
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBBlH-00040I-0s
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687169121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owkVPtMWhrnuf7TboX+Z+H1wfjueQMR45stD/qpzSOQ=;
 b=hgIOltYdbby/B6R4lbmT/xyIcLBay5I3RSxQ23Zf3dNlpmkmhyb3hq557Fq0STRsYF3mcA
 VqqdyqYE974BX8gbhzjjBOA/I8NmO7/7+Sr8vBuQX/7OUhQuOqGFnrb6horhyphggLZBDf
 acejV7LVvF9RfXZK7NAmR0sDQlYJlqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-27vZbXEjP7ynCOwc3mLuzg-1; Mon, 19 Jun 2023 06:05:18 -0400
X-MC-Unique: 27vZbXEjP7ynCOwc3mLuzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A380A805F30;
 Mon, 19 Jun 2023 10:05:17 +0000 (UTC)
Received: from localhost (unknown [10.39.195.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 786772166B27;
 Mon, 19 Jun 2023 10:05:15 +0000 (UTC)
Date: Mon, 19 Jun 2023 10:23:25 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>, eblake@redhat.com
Subject: Re: [PATCH v2 3/3] hw/ufs: Support for UFS logical unit
Message-ID: <20230619082325.GB2497337@fedora>
References: <CGME20230616065827epcms2p2ad3eefa7762feafe673ff9c0a54ba007@epcms2p2>
 <20230616065827epcms2p2ad3eefa7762feafe673ff9c0a54ba007@epcms2p2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FW8QP7VyUvLBJn7s"
Content-Disposition: inline
In-Reply-To: <20230616065827epcms2p2ad3eefa7762feafe673ff9c0a54ba007@epcms2p2>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--FW8QP7VyUvLBJn7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 03:58:27PM +0900, Jeuk Kim wrote:
> This commit adds support for ufs logical unit.
> The LU handles processing for the SCSI command,
> unit descriptor query request.
>=20
> This commit enables the UFS device to process
> IO requests.

Is UFS a SCSI Host Bus Adapter capable of exposing any SCSI device? The
code is written as if UFS was a special-purpose SCSI bus that cannot
handle regular SCSI devices already emulated by QEMU (like scsi-hd). As
a result, it duplicates a lot of SCSI device code instead of just
focussing on unwrapping/wrapping the SCSI commands and responses from
the UFS interface.

Would it be possible to have:

  --device ufs,id=3D<bus-name>
  --device scsi-hd,bus=3D<bus-name>

?

I think that would involve less code and be more flexible.

>=20
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>  hw/ufs/lu.c              | 1441 ++++++++++++++++++++++++++++++++++++++
>  hw/ufs/meson.build       |    2 +-
>  hw/ufs/trace-events      |   25 +
>  hw/ufs/ufs.c             |  252 ++++++-
>  hw/ufs/ufs.h             |   43 ++
>  include/scsi/constants.h |    1 +
>  6 files changed, 1757 insertions(+), 7 deletions(-)
>  create mode 100644 hw/ufs/lu.c
>=20
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> new file mode 100644
> index 0000000000..ef69de61a5
> --- /dev/null
> +++ b/hw/ufs/lu.c
> @@ -0,0 +1,1441 @@
> +/*
> + * QEMU UFS Logical Unit
> + *
> + * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
> + *
> + * Written by Jeuk Kim <jeuk20.kim@samsung.com>
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "qemu/memalign.h"
> +#include "hw/scsi/scsi.h"
> +#include "scsi/constants.h"
> +#include "sysemu/block-backend.h"
> +#include "qemu/cutils.h"
> +#include "trace.h"
> +#include "ufs.h"
> +
> +/*
> + * The code below handling SCSI commands is copied from hw/scsi/scsi-dis=
k.c,
> + * with minor adjustments to make it work for UFS.
> + */
> +
> +#define SCSI_DMA_BUF_SIZE (128 * KiB)
> +#define SCSI_MAX_INQUIRY_LEN 256
> +#define SCSI_INQUIRY_DATA_SIZE 36
> +#define SCSI_MAX_MODE_LEN 256
> +
> +typedef struct UfsSCSIReq {
> +    SCSIRequest req;
> +    /* Both sector and sector_count are in terms of BDRV_SECTOR_SIZE byt=
es.  */
> +    uint64_t sector;
> +    uint32_t sector_count;
> +    uint32_t buflen;
> +    bool started;
> +    bool need_fua_emulation;
> +    struct iovec iov;
> +    QEMUIOVector qiov;
> +    BlockAcctCookie acct;
> +} UfsSCSIReq;
> +
> +static void ufs_scsi_free_request(SCSIRequest *req)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +
> +    qemu_vfree(r->iov.iov_base);
> +}
> +
> +static void scsi_check_condition(UfsSCSIReq *r, SCSISense sense)
> +{
> +    trace_ufs_scsi_check_condition(r->req.tag, sense.key, sense.asc,
> +                                   sense.ascq);
> +    scsi_req_build_sense(&r->req, sense);
> +    scsi_req_complete(&r->req, CHECK_CONDITION);
> +}
> +
> +static int ufs_scsi_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf,
> +                                     uint32_t outbuf_len)
> +{
> +    UfsHc *u =3D UFS(req->bus->qbus.parent);
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, req->dev);
> +    uint8_t page_code =3D req->cmd.buf[2];
> +    int start, buflen =3D 0;
> +
> +    if (outbuf_len < SCSI_INQUIRY_DATA_SIZE) {
> +        return -1;
> +    }
> +
> +    outbuf[buflen++] =3D lu->qdev.type & 0x1f;
> +    outbuf[buflen++] =3D page_code;
> +    outbuf[buflen++] =3D 0x00;
> +    outbuf[buflen++] =3D 0x00;
> +    start =3D buflen;
> +
> +    switch (page_code) {
> +    case 0x00: /* Supported page codes, mandatory */
> +    {
> +        trace_ufs_scsi_emulate_vpd_page_00(req->cmd.xfer);
> +        outbuf[buflen++] =3D 0x00; /* list of supported pages (this page=
) */
> +        if (u->params.serial) {
> +            outbuf[buflen++] =3D 0x80; /* unit serial number */
> +        }
> +        outbuf[buflen++] =3D 0x87; /* mode page policy */
> +        break;
> +    }
> +    case 0x80: /* Device serial number, optional */
> +    {
> +        int l;
> +
> +        if (!u->params.serial) {
> +            trace_ufs_scsi_emulate_vpd_page_80_not_supported();
> +            return -1;
> +        }
> +
> +        l =3D strlen(u->params.serial);
> +        if (l > SCSI_INQUIRY_DATA_SIZE) {
> +            l =3D SCSI_INQUIRY_DATA_SIZE;
> +        }
> +
> +        trace_ufs_scsi_emulate_vpd_page_80(req->cmd.xfer);
> +        memcpy(outbuf + buflen, u->params.serial, l);
> +        buflen +=3D l;
> +        break;
> +    }
> +    case 0x87: /* Mode Page Policy, mandatory */
> +    {
> +        trace_ufs_scsi_emulate_vpd_page_87(req->cmd.xfer);
> +        outbuf[buflen++] =3D 0x3f; /* apply to all mode pages and subpag=
es */
> +        outbuf[buflen++] =3D 0xff;
> +        outbuf[buflen++] =3D 0; /* shared */
> +        outbuf[buflen++] =3D 0;
> +        break;
> +    }
> +    default:
> +        return -1;
> +    }
> +    /* done with EVPD */
> +    assert(buflen - start <=3D 255);
> +    outbuf[start - 1] =3D buflen - start;
> +    return buflen;
> +}
> +
> +static int ufs_scsi_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf,
> +                                    uint32_t outbuf_len)
> +{
> +    int buflen =3D 0;
> +
> +    if (outbuf_len < SCSI_INQUIRY_DATA_SIZE) {
> +        return -1;
> +    }
> +
> +    if (req->cmd.buf[1] & 0x1) {
> +        /* Vital product data */
> +        return ufs_scsi_emulate_vpd_page(req, outbuf, outbuf_len);
> +    }
> +
> +    /* Standard INQUIRY data */
> +    if (req->cmd.buf[2] !=3D 0) {
> +        return -1;
> +    }
> +
> +    /* PAGE CODE =3D=3D 0 */
> +    buflen =3D req->cmd.xfer;
> +    if (buflen > SCSI_MAX_INQUIRY_LEN) {
> +        buflen =3D SCSI_MAX_INQUIRY_LEN;
> +    }
> +
> +    if (is_wlun(req->lun)) {
> +        outbuf[0] =3D TYPE_WLUN;
> +    } else {
> +        outbuf[0] =3D 0;
> +    }
> +    outbuf[1] =3D 0;
> +
> +    strpadcpy((char *)&outbuf[16], 16, "QEMU UFS", ' ');
> +    strpadcpy((char *)&outbuf[8], 8, "QEMU", ' ');
> +
> +    memset(&outbuf[32], 0, 4);
> +
> +    outbuf[2] =3D 0x06; /* SPC-4 */
> +    outbuf[3] =3D 0x2;
> +
> +    if (buflen > SCSI_INQUIRY_DATA_SIZE) {
> +        outbuf[4] =3D buflen - 5; /* Additional Length =3D (Len - 1) - 4=
 */
> +    } else {
> +        /*
> +         * If the allocation length of CDB is too small, the additional
> +         * length is not adjusted
> +         */
> +        outbuf[4] =3D SCSI_INQUIRY_DATA_SIZE - 5;
> +    }
> +
> +    /* Support TCQ.  */
> +    outbuf[7] =3D req->bus->info->tcq ? 0x02 : 0;
> +    return buflen;
> +}
> +
> +static int mode_sense_page(UfsLu *lu, int page, uint8_t **p_outbuf,
> +                           int page_control)
> +{
> +    static const int mode_sense_valid[0x3f] =3D {
> +        [MODE_PAGE_CACHING] =3D 1,
> +        [MODE_PAGE_R_W_ERROR] =3D 1,
> +        [MODE_PAGE_CONTROL] =3D 1,
> +    };
> +
> +    uint8_t *p =3D *p_outbuf + 2;
> +    int length;
> +
> +    assert(page < ARRAY_SIZE(mode_sense_valid));
> +    if ((mode_sense_valid[page]) =3D=3D 0) {
> +        return -1;
> +    }
> +
> +    /*
> +     * If Changeable Values are requested, a mask denoting those mode pa=
rameters
> +     * that are changeable shall be returned. As we currently don't supp=
ort
> +     * parameter changes via MODE_SELECT all bits are returned set to ze=
ro.
> +     * The buffer was already memset to zero by the caller of this funct=
ion.
> +     */
> +    switch (page) {
> +    case MODE_PAGE_CACHING:
> +        length =3D 0x12;
> +        if (page_control =3D=3D 1 || /* Changeable Values */
> +            blk_enable_write_cache(lu->qdev.conf.blk)) {
> +            p[0] =3D 4; /* WCE */
> +        }
> +        break;
> +
> +    case MODE_PAGE_R_W_ERROR:
> +        length =3D 10;
> +        if (page_control =3D=3D 1) { /* Changeable Values */
> +            break;
> +        }
> +        p[0] =3D 0x80; /* Automatic Write Reallocation Enabled */
> +        break;
> +
> +    case MODE_PAGE_CONTROL:
> +        length =3D 10;
> +        if (page_control =3D=3D 1) { /* Changeable Values */
> +            break;
> +        }
> +        p[1] =3D 0x10; /* Queue Algorithm modifier */
> +        p[8] =3D 0xff; /* Busy Timeout Period */
> +        p[9] =3D 0xff;
> +        break;
> +
> +    default:
> +        return -1;
> +    }
> +
> +    assert(length < 256);
> +    (*p_outbuf)[0] =3D page;
> +    (*p_outbuf)[1] =3D length;
> +    *p_outbuf +=3D length + 2;
> +    return length + 2;
> +}
> +
> +static int ufs_scsi_emulate_mode_sense(UfsSCSIReq *r, uint8_t *outbuf)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +    bool dbd;
> +    int page, buflen, ret, page_control;
> +    uint8_t *p;
> +    uint8_t dev_specific_param =3D 0;
> +
> +    dbd =3D (r->req.cmd.buf[1] & 0x8) !=3D 0;
> +    if (!dbd) {
> +        return -1;
> +    }
> +
> +    page =3D r->req.cmd.buf[2] & 0x3f;
> +    page_control =3D (r->req.cmd.buf[2] & 0xc0) >> 6;
> +
> +    trace_ufs_scsi_emulate_mode_sense((r->req.cmd.buf[0] =3D=3D MODE_SEN=
SE) ? 6 :
> +                                                                        =
  10,
> +                                      page, r->req.cmd.xfer, page_contro=
l);
> +    memset(outbuf, 0, r->req.cmd.xfer);
> +    p =3D outbuf;
> +
> +    if (!blk_is_writable(lu->qdev.conf.blk)) {
> +        dev_specific_param |=3D 0x80; /* Readonly.  */
> +    }
> +
> +    p[2] =3D 0; /* Medium type.  */
> +    p[3] =3D dev_specific_param;
> +    p[6] =3D p[7] =3D 0; /* Block descriptor length.  */
> +    p +=3D 8;
> +
> +    if (page_control =3D=3D 3) {
> +        /* Saved Values */
> +        scsi_check_condition(r, SENSE_CODE(SAVING_PARAMS_NOT_SUPPORTED));
> +        return -1;
> +    }
> +
> +    if (page =3D=3D 0x3f) {
> +        for (page =3D 0; page <=3D 0x3e; page++) {
> +            mode_sense_page(lu, page, &p, page_control);
> +        }
> +    } else {
> +        ret =3D mode_sense_page(lu, page, &p, page_control);
> +        if (ret =3D=3D -1) {
> +            return -1;
> +        }
> +    }
> +
> +    buflen =3D p - outbuf;
> +    /*
> +     * The mode data length field specifies the length in bytes of the
> +     * following data that is available to be transferred. The mode data
> +     * length does not include itself.
> +     */
> +    outbuf[0] =3D ((buflen - 2) >> 8) & 0xff;
> +    outbuf[1] =3D (buflen - 2) & 0xff;
> +    return buflen;
> +}
> +
> +/*
> + * scsi_handle_rw_error has two return values.  False means that the err=
or
> + * must be ignored, true means that the error has been processed and the
> + * caller should not do anything else for this request.  Note that
> + * scsi_handle_rw_error always manages its reference counts, independent
> + * of the return value.
> + */
> +static bool scsi_handle_rw_error(UfsSCSIReq *r, int ret, bool acct_faile=
d)
> +{
> +    bool is_read =3D (r->req.cmd.mode =3D=3D SCSI_XFER_FROM_DEV);
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +    SCSISense sense =3D SENSE_CODE(NO_SENSE);
> +    int error =3D 0;
> +    bool req_has_sense =3D false;
> +    BlockErrorAction action;
> +    int status;
> +
> +    if (ret < 0) {
> +        status =3D scsi_sense_from_errno(-ret, &sense);
> +        error =3D -ret;
> +    } else {
> +        /* A passthrough command has completed with nonzero status.  */
> +        status =3D ret;
> +        if (status =3D=3D CHECK_CONDITION) {
> +            req_has_sense =3D true;
> +            error =3D scsi_sense_buf_to_errno(r->req.sense, sizeof(r->re=
q.sense));
> +        } else {
> +            error =3D EINVAL;
> +        }
> +    }
> +
> +    /*
> +     * Check whether the error has to be handled by the guest or should
> +     * rather follow the rerror=3D/werror=3D settings.  Guest-handled er=
rors
> +     * are usually retried immediately, so do not post them to QMP and
> +     * do not account them as failed I/O.
> +     */
> +    if (req_has_sense && scsi_sense_buf_is_guest_recoverable(
> +                             r->req.sense, sizeof(r->req.sense))) {
> +        action =3D BLOCK_ERROR_ACTION_REPORT;
> +        acct_failed =3D false;
> +    } else {
> +        action =3D blk_get_error_action(lu->qdev.conf.blk, is_read, erro=
r);
> +        blk_error_action(lu->qdev.conf.blk, action, is_read, error);
> +    }
> +
> +    switch (action) {
> +    case BLOCK_ERROR_ACTION_REPORT:
> +        if (acct_failed) {
> +            block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct=
);
> +        }
> +        if (!req_has_sense && status =3D=3D CHECK_CONDITION) {
> +            scsi_req_build_sense(&r->req, sense);
> +        }
> +        scsi_req_complete(&r->req, status);
> +        return true;
> +
> +    case BLOCK_ERROR_ACTION_IGNORE:
> +        return false;
> +
> +    case BLOCK_ERROR_ACTION_STOP:
> +        scsi_req_retry(&r->req);
> +        return true;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static bool ufs_scsi_req_check_error(UfsSCSIReq *r, int ret, bool acct_f=
ailed)
> +{
> +    if (r->req.io_canceled) {
> +        scsi_req_cancel_complete(&r->req);
> +        return true;
> +    }
> +
> +    if (ret < 0) {
> +        return scsi_handle_rw_error(r, ret, acct_failed);
> +    }
> +
> +    return false;
> +}
> +
> +static void scsi_aio_complete(void *opaque, int ret)
> +{
> +    UfsSCSIReq *r =3D (UfsSCSIReq *)opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
> +    if (ufs_scsi_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    scsi_req_complete(&r->req, GOOD);
> +
> +done:
> +    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
> +    scsi_req_unref(&r->req);
> +}
> +
> +static int32_t ufs_scsi_emulate_command(SCSIRequest *req, uint8_t *buf)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, req->dev);
> +    uint8_t *outbuf;
> +    int buflen;
> +
> +    switch (req->cmd.buf[0]) {
> +    case INQUIRY:
> +    case MODE_SENSE_10:
> +    case START_STOP:
> +    case REQUEST_SENSE:
> +        break;
> +
> +    default:
> +        if (!blk_is_available(lu->qdev.conf.blk)) {
> +            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
> +            return 0;
> +        }
> +        break;
> +    }
> +
> +    /*
> +     * FIXME: we shouldn't return anything bigger than 4k, but the code
> +     * requires the buffer to be as big as req->cmd.xfer in several
> +     * places.  So, do not allow CDBs with a very large ALLOCATION
> +     * LENGTH.  The real fix would be to modify scsi_read_data and
> +     * dma_buf_read, so that they return data beyond the buflen
> +     * as all zeros.
> +     */
> +    if (req->cmd.xfer > 65536) {
> +        goto illegal_request;
> +    }
> +    r->buflen =3D MAX(4096, req->cmd.xfer);
> +
> +    if (!r->iov.iov_base) {
> +        r->iov.iov_base =3D blk_blockalign(lu->qdev.conf.blk, r->buflen);
> +    }
> +
> +    outbuf =3D r->iov.iov_base;
> +    memset(outbuf, 0, r->buflen);
> +    switch (req->cmd.buf[0]) {
> +    case TEST_UNIT_READY:
> +        assert(blk_is_available(lu->qdev.conf.blk));
> +        break;
> +    case INQUIRY:
> +        buflen =3D ufs_scsi_emulate_inquiry(req, outbuf, r->buflen);
> +        if (buflen < 0) {
> +            goto illegal_request;
> +        }
> +        break;
> +    case MODE_SENSE_10:
> +        buflen =3D ufs_scsi_emulate_mode_sense(r, outbuf);
> +        if (buflen < 0) {
> +            goto illegal_request;
> +        }
> +        break;
> +    case READ_CAPACITY_10:
> +        /* The normal LEN field for this command is zero.  */
> +        memset(outbuf, 0, 8);
> +
> +        outbuf[0] =3D (lu->qdev.max_lba >> 24) & 0xff;
> +        outbuf[1] =3D (lu->qdev.max_lba >> 16) & 0xff;
> +        outbuf[2] =3D (lu->qdev.max_lba >> 8) & 0xff;
> +        outbuf[3] =3D lu->qdev.max_lba & 0xff;
> +        outbuf[4] =3D (lu->qdev.blocksize >> 24) & 0xff;
> +        outbuf[5] =3D (lu->qdev.blocksize >> 16) & 0xff;
> +        outbuf[6] =3D (lu->qdev.blocksize >> 8) & 0xff;
> +        outbuf[7] =3D lu->qdev.blocksize & 0xff;
> +        break;
> +    case REQUEST_SENSE:
> +        /* Just return "NO SENSE".  */
> +        buflen =3D scsi_convert_sense(NULL, 0, outbuf, r->buflen,
> +                                    (req->cmd.buf[1] & 1) =3D=3D 0);
> +        if (buflen < 0) {
> +            goto illegal_request;
> +        }
> +        break;
> +    case SYNCHRONIZE_CACHE:
> +        /* The request is used as the AIO opaque value, so add a ref.  */
> +        scsi_req_ref(&r->req);
> +        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
> +                         BLOCK_ACCT_FLUSH);
> +        r->req.aiocb =3D blk_aio_flush(lu->qdev.conf.blk, scsi_aio_compl=
ete, r);
> +        return 0;
> +    case VERIFY_10:
> +        trace_ufs_scsi_emulate_command_VERIFY((req->cmd.buf[1] >> 1) & 3=
);
> +        if (req->cmd.buf[1] & 6) {
> +            goto illegal_request;
> +        }
> +        break;
> +    case SERVICE_ACTION_IN_16:
> +        /* Service Action In subcommands. */
> +        if ((req->cmd.buf[1] & 31) =3D=3D SAI_READ_CAPACITY_16) {
> +            trace_ufs_scsi_emulate_command_SAI_16();
> +            memset(outbuf, 0, req->cmd.xfer);
> +
> +            outbuf[0] =3D (lu->qdev.max_lba >> 56) & 0xff;
> +            outbuf[1] =3D (lu->qdev.max_lba >> 48) & 0xff;
> +            outbuf[2] =3D (lu->qdev.max_lba >> 40) & 0xff;
> +            outbuf[3] =3D (lu->qdev.max_lba >> 32) & 0xff;
> +            outbuf[4] =3D (lu->qdev.max_lba >> 24) & 0xff;
> +            outbuf[5] =3D (lu->qdev.max_lba >> 16) & 0xff;
> +            outbuf[6] =3D (lu->qdev.max_lba >> 8) & 0xff;
> +            outbuf[7] =3D lu->qdev.max_lba & 0xff;
> +            outbuf[8] =3D (lu->qdev.blocksize >> 24) & 0xff;
> +            outbuf[9] =3D (lu->qdev.blocksize >> 16) & 0xff;
> +            outbuf[10] =3D (lu->qdev.blocksize >> 8) & 0xff;
> +            outbuf[11] =3D lu->qdev.blocksize & 0xff;
> +            outbuf[12] =3D 0;
> +            outbuf[13] =3D get_physical_block_exp(&lu->qdev.conf);
> +
> +            if (lu->unit_desc.provisioning_type =3D=3D 2 ||
> +                lu->unit_desc.provisioning_type =3D=3D 3) {
> +                outbuf[14] =3D 0x80;
> +            }
> +            /* Protection, exponent and lowest lba field left blank. */
> +            break;
> +        }
> +        trace_ufs_scsi_emulate_command_SAI_unsupported();
> +        goto illegal_request;
> +    case MODE_SELECT_10:
> +        trace_ufs_scsi_emulate_command_MODE_SELECT_10(r->req.cmd.xfer);
> +        break;
> +    case START_STOP:
> +        /*
> +         * TODO: START_STOP is not yet implemented. It always returns su=
ccess.
> +         * Revisit it when ufs power management is implemented.
> +         */
> +        trace_ufs_scsi_emulate_command_START_STOP();
> +        break;
> +    case FORMAT_UNIT:
> +        trace_ufs_scsi_emulate_command_FORMAT_UNIT();
> +        break;
> +    case SEND_DIAGNOSTIC:
> +        trace_ufs_scsi_emulate_command_SEND_DIAGNOSTIC();
> +        break;
> +    default:
> +        trace_ufs_scsi_emulate_command_UNKNOWN(buf[0],
> +                                               scsi_command_name(buf[0])=
);
> +        scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
> +        return 0;
> +    }
> +    assert(!r->req.aiocb);
> +    r->iov.iov_len =3D MIN(r->buflen, req->cmd.xfer);
> +    if (r->iov.iov_len =3D=3D 0) {
> +        scsi_req_complete(&r->req, GOOD);
> +    }
> +    if (r->req.cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
> +        assert(r->iov.iov_len =3D=3D req->cmd.xfer);
> +        return -r->iov.iov_len;
> +    } else {
> +        return r->iov.iov_len;
> +    }
> +
> +illegal_request:
> +    if (r->req.status =3D=3D -1) {
> +        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> +    }
> +    return 0;
> +}
> +
> +static void ufs_scsi_emulate_read_data(SCSIRequest *req)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +    int buflen =3D r->iov.iov_len;
> +
> +    if (buflen) {
> +        trace_ufs_scsi_emulate_read_data(buflen);
> +        r->iov.iov_len =3D 0;
> +        r->started =3D true;
> +        scsi_req_data(&r->req, buflen);
> +        return;
> +    }
> +
> +    /* This also clears the sense buffer for REQUEST SENSE.  */
> +    scsi_req_complete(&r->req, GOOD);
> +}
> +
> +static int ufs_scsi_check_mode_select(UfsLu *lu, int page, uint8_t *inbu=
f,
> +                                      int inlen)
> +{
> +    uint8_t mode_current[SCSI_MAX_MODE_LEN];
> +    uint8_t mode_changeable[SCSI_MAX_MODE_LEN];
> +    uint8_t *p;
> +    int len, expected_len, changeable_len, i;
> +
> +    /*
> +     * The input buffer does not include the page header, so it is
> +     * off by 2 bytes.
> +     */
> +    expected_len =3D inlen + 2;
> +    if (expected_len > SCSI_MAX_MODE_LEN) {
> +        return -1;
> +    }
> +
> +    /* MODE_PAGE_ALLS is only valid for MODE SENSE commands */
> +    if (page =3D=3D MODE_PAGE_ALLS) {
> +        return -1;
> +    }
> +
> +    p =3D mode_current;
> +    memset(mode_current, 0, inlen + 2);
> +    len =3D mode_sense_page(lu, page, &p, 0);
> +    if (len < 0 || len !=3D expected_len) {
> +        return -1;
> +    }
> +
> +    p =3D mode_changeable;
> +    memset(mode_changeable, 0, inlen + 2);
> +    changeable_len =3D mode_sense_page(lu, page, &p, 1);
> +    assert(changeable_len =3D=3D len);
> +
> +    /*
> +     * Check that unchangeable bits are the same as what MODE SENSE
> +     * would return.
> +     */
> +    for (i =3D 2; i < len; i++) {
> +        if (((mode_current[i] ^ inbuf[i - 2]) & ~mode_changeable[i]) !=
=3D 0) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static void ufs_scsi_apply_mode_select(UfsLu *lu, int page, uint8_t *p)
> +{
> +    switch (page) {
> +    case MODE_PAGE_CACHING:
> +        blk_set_enable_write_cache(lu->qdev.conf.blk, (p[0] & 4) !=3D 0);
> +        break;
> +
> +    default:
> +        break;
> +    }
> +}
> +
> +static int mode_select_pages(UfsSCSIReq *r, uint8_t *p, int len, bool ch=
ange)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    while (len > 0) {
> +        int page, page_len;
> +
> +        page =3D p[0] & 0x3f;
> +        if (p[0] & 0x40) {
> +            goto invalid_param;
> +        } else {
> +            if (len < 2) {
> +                goto invalid_param_len;
> +            }
> +            page_len =3D p[1];
> +            p +=3D 2;
> +            len -=3D 2;
> +        }
> +
> +        if (page_len > len) {
> +            goto invalid_param_len;
> +        }
> +
> +        if (!change) {
> +            if (ufs_scsi_check_mode_select(lu, page, p, page_len) < 0) {
> +                goto invalid_param;
> +            }
> +        } else {
> +            ufs_scsi_apply_mode_select(lu, page, p);
> +        }
> +
> +        p +=3D page_len;
> +        len -=3D page_len;
> +    }
> +    return 0;
> +
> +invalid_param:
> +    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM));
> +    return -1;
> +
> +invalid_param_len:
> +    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
> +    return -1;
> +}
> +
> +static void ufs_scsi_emulate_mode_select(UfsSCSIReq *r, uint8_t *inbuf)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +    uint8_t *p =3D inbuf;
> +    int len =3D r->req.cmd.xfer;
> +    int hdr_len =3D 8;
> +    int bd_len;
> +    int pass;
> +
> +    /* We only support PF=3D1, SP=3D0.  */
> +    if ((r->req.cmd.buf[1] & 0x11) !=3D 0x10) {
> +        goto invalid_field;
> +    }
> +
> +    if (len < hdr_len) {
> +        goto invalid_param_len;
> +    }
> +
> +    bd_len =3D lduw_be_p(&p[6]);
> +    if (bd_len !=3D 0) {
> +        goto invalid_param;
> +    }
> +
> +    len -=3D hdr_len;
> +    p +=3D hdr_len;
> +
> +    /* Ensure no change is made if there is an error!  */
> +    for (pass =3D 0; pass < 2; pass++) {
> +        if (mode_select_pages(r, p, len, pass =3D=3D 1) < 0) {
> +            assert(pass =3D=3D 0);
> +            return;
> +        }
> +    }
> +
> +    if (!blk_enable_write_cache(lu->qdev.conf.blk)) {
> +        /* The request is used as the AIO opaque value, so add a ref.  */
> +        scsi_req_ref(&r->req);
> +        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
> +                         BLOCK_ACCT_FLUSH);
> +        r->req.aiocb =3D blk_aio_flush(lu->qdev.conf.blk, scsi_aio_compl=
ete, r);
> +        return;
> +    }
> +
> +    scsi_req_complete(&r->req, GOOD);
> +    return;
> +
> +invalid_param:
> +    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM));
> +    return;
> +
> +invalid_param_len:
> +    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
> +    return;
> +
> +invalid_field:
> +    scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> +}
> +
> +/* sector_num and nb_sectors expected to be in qdev blocksize */
> +static inline bool check_lba_range(UfsLu *lu, uint64_t sector_num,
> +                                   uint32_t nb_sectors)
> +{
> +    /*
> +     * The first line tests that no overflow happens when computing the =
last
> +     * sector.  The second line tests that the last accessed sector is in
> +     * range.
> +     *
> +     * Careful, the computations should not underflow for nb_sectors =3D=
=3D 0,
> +     * and a 0-block read to the first LBA beyond the end of device is
> +     * valid.
> +     */
> +    return (sector_num <=3D sector_num + nb_sectors &&
> +            sector_num + nb_sectors <=3D lu->qdev.max_lba + 1);
> +}
> +
> +static void ufs_scsi_emulate_write_data(SCSIRequest *req)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +
> +    if (r->iov.iov_len) {
> +        int buflen =3D r->iov.iov_len;
> +        trace_ufs_scsi_emulate_write_data(buflen);
> +        r->iov.iov_len =3D 0;
> +        scsi_req_data(&r->req, buflen);
> +        return;
> +    }
> +
> +    switch (req->cmd.buf[0]) {
> +    case MODE_SELECT_10:
> +        /* This also clears the sense buffer for REQUEST SENSE.  */
> +        ufs_scsi_emulate_mode_select(r, r->iov.iov_base);
> +        break;
> +    default:
> +        abort();
> +    }
> +}
> +
> +/* Return a pointer to the data buffer.  */
> +static uint8_t *ufs_scsi_get_buf(SCSIRequest *req)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +
> +    return (uint8_t *)r->iov.iov_base;
> +}
> +
> +static int32_t ufs_scsi_dma_command(SCSIRequest *req, uint8_t *buf)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, req->dev);
> +    uint32_t len;
> +    uint8_t command;
> +
> +    command =3D buf[0];
> +
> +    if (!blk_is_available(lu->qdev.conf.blk)) {
> +        scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
> +        return 0;
> +    }
> +
> +    len =3D scsi_data_cdb_xfer(r->req.cmd.buf);
> +    switch (command) {
> +    case READ_6:
> +    case READ_10:
> +        trace_ufs_scsi_dma_command_READ(r->req.cmd.lba, len);
> +        if (r->req.cmd.buf[1] & 0xe0) {
> +            goto illegal_request;
> +        }
> +        if (!check_lba_range(lu, r->req.cmd.lba, len)) {
> +            goto illegal_lba;
> +        }
> +        r->sector =3D r->req.cmd.lba * (lu->qdev.blocksize / BDRV_SECTOR=
_SIZE);
> +        r->sector_count =3D len * (lu->qdev.blocksize / BDRV_SECTOR_SIZE=
);
> +        break;
> +    case WRITE_6:
> +    case WRITE_10:
> +        trace_ufs_scsi_dma_command_WRITE(r->req.cmd.lba, len);
> +        if (!blk_is_writable(lu->qdev.conf.blk)) {
> +            scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
> +            return 0;
> +        }
> +        if (r->req.cmd.buf[1] & 0xe0) {
> +            goto illegal_request;
> +        }
> +        if (!check_lba_range(lu, r->req.cmd.lba, len)) {
> +            goto illegal_lba;
> +        }
> +        r->sector =3D r->req.cmd.lba * (lu->qdev.blocksize / BDRV_SECTOR=
_SIZE);
> +        r->sector_count =3D len * (lu->qdev.blocksize / BDRV_SECTOR_SIZE=
);
> +        break;
> +    default:
> +        abort();
> +    illegal_request:
> +        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> +        return 0;
> +    illegal_lba:
> +        scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
> +        return 0;
> +    }
> +    r->need_fua_emulation =3D ((r->req.cmd.buf[1] & 8) !=3D 0);
> +    if (r->sector_count =3D=3D 0) {
> +        scsi_req_complete(&r->req, GOOD);
> +    }
> +    assert(r->iov.iov_len =3D=3D 0);
> +    if (r->req.cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
> +        return -r->sector_count * BDRV_SECTOR_SIZE;
> +    } else {
> +        return r->sector_count * BDRV_SECTOR_SIZE;
> +    }
> +}
> +
> +static void scsi_write_do_fua(UfsSCSIReq *r)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb =3D=3D NULL);
> +    assert(!r->req.io_canceled);
> +
> +    if (r->need_fua_emulation) {
> +        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
> +                         BLOCK_ACCT_FLUSH);
> +        r->req.aiocb =3D blk_aio_flush(lu->qdev.conf.blk, scsi_aio_compl=
ete, r);
> +        return;
> +    }
> +
> +    scsi_req_complete(&r->req, GOOD);
> +    scsi_req_unref(&r->req);
> +}
> +
> +static void scsi_dma_complete_noio(UfsSCSIReq *r, int ret)
> +{
> +    assert(r->req.aiocb =3D=3D NULL);
> +    if (ufs_scsi_req_check_error(r, ret, false)) {
> +        goto done;
> +    }
> +
> +    r->sector +=3D r->sector_count;
> +    r->sector_count =3D 0;
> +    if (r->req.cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
> +        scsi_write_do_fua(r);
> +        return;
> +    } else {
> +        scsi_req_complete(&r->req, GOOD);
> +    }
> +
> +done:
> +    scsi_req_unref(&r->req);
> +}
> +
> +static void scsi_dma_complete(void *opaque, int ret)
> +{
> +    UfsSCSIReq *r =3D (UfsSCSIReq *)opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
> +    if (ret < 0) {
> +        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    } else {
> +        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    }
> +    scsi_dma_complete_noio(r, ret);
> +    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
> +}
> +
> +static BlockAIOCB *scsi_dma_readv(int64_t offset, QEMUIOVector *iov,
> +                                  BlockCompletionFunc *cb, void *cb_opaq=
ue,
> +                                  void *opaque)
> +{
> +    UfsSCSIReq *r =3D opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +    return blk_aio_preadv(lu->qdev.conf.blk, offset, iov, 0, cb, cb_opaq=
ue);
> +}
> +
> +static void scsi_init_iovec(UfsSCSIReq *r, size_t size)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    if (!r->iov.iov_base) {
> +        r->buflen =3D size;
> +        r->iov.iov_base =3D blk_blockalign(lu->qdev.conf.blk, r->buflen);
> +    }
> +    r->iov.iov_len =3D MIN(r->sector_count * BDRV_SECTOR_SIZE, r->buflen=
);
> +    qemu_iovec_init_external(&r->qiov, &r->iov, 1);
> +}
> +
> +static void scsi_read_complete_noio(UfsSCSIReq *r, int ret)
> +{
> +    uint32_t n;
> +
> +    assert(r->req.aiocb =3D=3D NULL);
> +    if (ufs_scsi_req_check_error(r, ret, false)) {
> +        goto done;
> +    }
> +
> +    n =3D r->qiov.size / BDRV_SECTOR_SIZE;
> +    r->sector +=3D n;
> +    r->sector_count -=3D n;
> +    scsi_req_data(&r->req, r->qiov.size);
> +
> +done:
> +    scsi_req_unref(&r->req);
> +}
> +
> +static void scsi_read_complete(void *opaque, int ret)
> +{
> +    UfsSCSIReq *r =3D (UfsSCSIReq *)opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +    trace_ufs_scsi_read_data_count(r->sector_count);
> +    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
> +    if (ret < 0) {
> +        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    } else {
> +        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +        trace_ufs_scsi_read_complete(r->req.tag, r->qiov.size);
> +    }
> +    scsi_read_complete_noio(r, ret);
> +    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
> +}
> +
> +/* Actually issue a read to the block device.  */
> +static void scsi_do_read(UfsSCSIReq *r, int ret)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb =3D=3D NULL);
> +    if (ufs_scsi_req_check_error(r, ret, false)) {
> +        goto done;
> +    }
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +
> +    if (r->req.sg) {
> +        dma_acct_start(lu->qdev.conf.blk, &r->acct, r->req.sg, BLOCK_ACC=
T_READ);
> +        r->req.residual -=3D r->req.sg->size;
> +        r->req.aiocb =3D dma_blk_io(
> +            blk_get_aio_context(lu->qdev.conf.blk), r->req.sg,
> +            r->sector << BDRV_SECTOR_BITS, BDRV_SECTOR_SIZE, scsi_dma_re=
adv, r,
> +            scsi_dma_complete, r, DMA_DIRECTION_FROM_DEVICE);
> +    } else {
> +        scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
> +        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct,
> +                         r->qiov.size, BLOCK_ACCT_READ);
> +        r->req.aiocb =3D scsi_dma_readv(r->sector << BDRV_SECTOR_BITS, &=
r->qiov,
> +                                      scsi_read_complete, r, r);
> +    }
> +
> +done:
> +    scsi_req_unref(&r->req);
> +}
> +
> +static void scsi_do_read_cb(void *opaque, int ret)
> +{
> +    UfsSCSIReq *r =3D (UfsSCSIReq *)opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
> +    if (ret < 0) {
> +        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    } else {
> +        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    }
> +    scsi_do_read(opaque, ret);
> +    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
> +}
> +
> +/* Read more data from scsi device into buffer.  */
> +static void scsi_read_data(SCSIRequest *req)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +    bool first;
> +
> +    trace_ufs_scsi_read_data_count(r->sector_count);
> +    if (r->sector_count =3D=3D 0) {
> +        /* This also clears the sense buffer for REQUEST SENSE.  */
> +        scsi_req_complete(&r->req, GOOD);
> +        return;
> +    }
> +
> +    /* No data transfer may already be in progress */
> +    assert(r->req.aiocb =3D=3D NULL);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    if (r->req.cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
> +        trace_ufs_scsi_read_data_invalid();
> +        scsi_read_complete_noio(r, -EINVAL);
> +        return;
> +    }
> +
> +    if (!blk_is_available(req->dev->conf.blk)) {
> +        scsi_read_complete_noio(r, -ENOMEDIUM);
> +        return;
> +    }
> +
> +    first =3D !r->started;
> +    r->started =3D true;
> +    if (first && r->need_fua_emulation) {
> +        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
> +                         BLOCK_ACCT_FLUSH);
> +        r->req.aiocb =3D blk_aio_flush(lu->qdev.conf.blk, scsi_do_read_c=
b, r);
> +    } else {
> +        scsi_do_read(r, 0);
> +    }
> +}
> +
> +static void scsi_write_complete_noio(UfsSCSIReq *r, int ret)
> +{
> +    uint32_t n;
> +
> +    assert(r->req.aiocb =3D=3D NULL);
> +    if (ufs_scsi_req_check_error(r, ret, false)) {
> +        goto done;
> +    }
> +
> +    n =3D r->qiov.size / BDRV_SECTOR_SIZE;
> +    r->sector +=3D n;
> +    r->sector_count -=3D n;
> +    if (r->sector_count =3D=3D 0) {
> +        scsi_write_do_fua(r);
> +        return;
> +    } else {
> +        scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
> +        trace_ufs_scsi_write_complete_noio(r->req.tag, r->qiov.size);
> +        scsi_req_data(&r->req, r->qiov.size);
> +    }
> +
> +done:
> +    scsi_req_unref(&r->req);
> +}
> +
> +static void scsi_write_complete(void *opaque, int ret)
> +{
> +    UfsSCSIReq *r =3D (UfsSCSIReq *)opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
> +    if (ret < 0) {
> +        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    } else {
> +        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
> +    }
> +    scsi_write_complete_noio(r, ret);
> +    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
> +}
> +
> +static BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
> +                                   BlockCompletionFunc *cb, void *cb_opa=
que,
> +                                   void *opaque)
> +{
> +    UfsSCSIReq *r =3D opaque;
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +    return blk_aio_pwritev(lu->qdev.conf.blk, offset, iov, 0, cb, cb_opa=
que);
> +}
> +
> +static void scsi_write_data(SCSIRequest *req)
> +{
> +    UfsSCSIReq *r =3D DO_UPCAST(UfsSCSIReq, req, req);
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, r->req.dev);
> +
> +    /* No data transfer may already be in progress */
> +    assert(r->req.aiocb =3D=3D NULL);
> +
> +    /* The request is used as the AIO opaque value, so add a ref.  */
> +    scsi_req_ref(&r->req);
> +    if (r->req.cmd.mode !=3D SCSI_XFER_TO_DEV) {
> +        trace_ufs_scsi_write_data_invalid();
> +        scsi_write_complete_noio(r, -EINVAL);
> +        return;
> +    }
> +
> +    if (!r->req.sg && !r->qiov.size) {
> +        /* Called for the first time.  Ask the driver to send us more da=
ta.  */
> +        r->started =3D true;
> +        scsi_write_complete_noio(r, 0);
> +        return;
> +    }
> +    if (!blk_is_available(req->dev->conf.blk)) {
> +        scsi_write_complete_noio(r, -ENOMEDIUM);
> +        return;
> +    }
> +
> +    if (r->req.sg) {
> +        dma_acct_start(lu->qdev.conf.blk, &r->acct, r->req.sg,
> +                       BLOCK_ACCT_WRITE);
> +        r->req.residual -=3D r->req.sg->size;
> +        r->req.aiocb =3D dma_blk_io(
> +            blk_get_aio_context(lu->qdev.conf.blk), r->req.sg,
> +            r->sector << BDRV_SECTOR_BITS, BDRV_SECTOR_SIZE, scsi_dma_wr=
itev, r,
> +            scsi_dma_complete, r, DMA_DIRECTION_TO_DEVICE);
> +    } else {
> +        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct,
> +                         r->qiov.size, BLOCK_ACCT_WRITE);
> +        r->req.aiocb =3D scsi_dma_writev(r->sector << BDRV_SECTOR_BITS, =
&r->qiov,
> +                                       scsi_write_complete, r, r);
> +    }
> +}
> +
> +static const SCSIReqOps ufs_scsi_emulate_reqops =3D {
> +    .size =3D sizeof(UfsSCSIReq),
> +    .free_req =3D ufs_scsi_free_request,
> +    .send_command =3D ufs_scsi_emulate_command,
> +    .read_data =3D ufs_scsi_emulate_read_data,
> +    .write_data =3D ufs_scsi_emulate_write_data,
> +    .get_buf =3D ufs_scsi_get_buf,
> +};
> +
> +static const SCSIReqOps ufs_scsi_dma_reqops =3D {
> +    .size =3D sizeof(UfsSCSIReq),
> +    .free_req =3D ufs_scsi_free_request,
> +    .send_command =3D ufs_scsi_dma_command,
> +    .read_data =3D scsi_read_data,
> +    .write_data =3D scsi_write_data,
> +    .get_buf =3D ufs_scsi_get_buf,
> +};
> +
> +/*
> + * Following commands are not yet supported
> + * PRE_FETCH(10),
> + * UNMAP,
> + * WRITE_BUFFER, READ_BUFFER,
> + * SECURITY_PROTOCOL_IN, SECURITY_PROTOCOL_OUT
> + */
> +static const SCSIReqOps *const ufs_scsi_reqops_dispatch[256] =3D {
> +    [TEST_UNIT_READY] =3D &ufs_scsi_emulate_reqops,
> +    [INQUIRY] =3D &ufs_scsi_emulate_reqops,
> +    [MODE_SENSE_10] =3D &ufs_scsi_emulate_reqops,
> +    [START_STOP] =3D &ufs_scsi_emulate_reqops,
> +    [READ_CAPACITY_10] =3D &ufs_scsi_emulate_reqops,
> +    [REQUEST_SENSE] =3D &ufs_scsi_emulate_reqops,
> +    [SYNCHRONIZE_CACHE] =3D &ufs_scsi_emulate_reqops,
> +    [MODE_SELECT_10] =3D &ufs_scsi_emulate_reqops,
> +    [VERIFY_10] =3D &ufs_scsi_emulate_reqops,
> +    [FORMAT_UNIT] =3D &ufs_scsi_emulate_reqops,
> +    [SERVICE_ACTION_IN_16] =3D &ufs_scsi_emulate_reqops,
> +    [SEND_DIAGNOSTIC] =3D &ufs_scsi_emulate_reqops,
> +
> +    [READ_6] =3D &ufs_scsi_dma_reqops,
> +    [READ_10] =3D &ufs_scsi_dma_reqops,
> +    [WRITE_6] =3D &ufs_scsi_dma_reqops,
> +    [WRITE_10] =3D &ufs_scsi_dma_reqops,
> +};
> +
> +static SCSIRequest *scsi_new_request(SCSIDevice *dev, uint32_t tag,
> +                                     uint32_t lun, uint8_t *buf,
> +                                     void *hba_private)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, dev);
> +    SCSIRequest *req;
> +    const SCSIReqOps *ops;
> +    uint8_t command;
> +
> +    command =3D buf[0];
> +    ops =3D ufs_scsi_reqops_dispatch[command];
> +    if (!ops) {
> +        ops =3D &ufs_scsi_emulate_reqops;
> +    }
> +    req =3D scsi_req_alloc(ops, &lu->qdev, tag, lun, hba_private);
> +
> +    return req;
> +}
> +
> +static Property ufs_lu_props[] =3D {
> +    DEFINE_PROP_DRIVE_IOTHREAD("drive", UfsLu, qdev.conf.blk),
> +    DEFINE_BLOCK_PROPERTIES_BASE(UfsLu, qdev.conf),
> +    DEFINE_BLOCK_ERROR_PROPERTIES(UfsLu, qdev.conf),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static bool ufs_lu_brdv_init(UfsLu *lu, Error **errp)
> +{
> +    SCSIDevice *dev =3D &lu->qdev;
> +    bool read_only;
> +
> +    if (!lu->qdev.conf.blk) {
> +        error_setg(errp, "drive property not set");
> +        return false;
> +    }
> +
> +    if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
> +        return false;
> +    }
> +
> +    if (blk_get_aio_context(lu->qdev.conf.blk) !=3D qemu_get_aio_context=
() &&
> +        !lu->qdev.hba_supports_iothread) {
> +        error_setg(errp, "HBA does not support iothreads");
> +        return false;
> +    }
> +
> +    read_only =3D !blk_supports_write_perm(lu->qdev.conf.blk);
> +
> +    if (!blkconf_apply_backend_options(&dev->conf, read_only,
> +                                       dev->type =3D=3D TYPE_DISK, errp)=
) {
> +        return false;
> +    }
> +
> +    if (blk_is_sg(lu->qdev.conf.blk)) {
> +        error_setg(errp, "unwanted /dev/sg*");
> +        return false;
> +    }
> +
> +    blk_iostatus_enable(lu->qdev.conf.blk);
> +    return true;
> +}
> +
> +static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
> +{
> +    BlockBackend *blk =3D lu->qdev.conf.blk;
> +    int64_t brdv_len =3D blk_getlength(blk);
> +    uint64_t raw_dev_cap =3D
> +        be64_to_cpu(u->geometry_desc.total_raw_device_capacity);
> +
> +    if (u->device_desc.number_lu >=3D UFS_MAX_LUS) {
> +        error_setg(errp, "ufs host controller has too many logical units=
=2E");
> +        return false;
> +    }
> +
> +    if (u->lus[lu->lun] !=3D NULL) {
> +        error_setg(errp, "ufs logical unit %d already exists.", lu->lun);
> +        return false;
> +    }
> +
> +    u->lus[lu->lun] =3D lu;
> +    u->device_desc.number_lu++;
> +    raw_dev_cap +=3D (brdv_len >> UFS_GEOMETRY_CAPACITY_SHIFT);
> +    u->geometry_desc.total_raw_device_capacity =3D cpu_to_be64(raw_dev_c=
ap);
> +    return true;
> +}
> +
> +static inline uint8_t ufs_log2(uint64_t input)
> +{
> +    int log =3D 1;
> +    while (input >> log) {
> +        log++;
> +    }
> +    return log;
> +}
> +
> +static void ufs_init_lu(UfsLu *lu)
> +{
> +    BlockBackend *blk =3D lu->qdev.conf.blk;
> +    int64_t brdv_len =3D blk_getlength(blk);
> +
> +    lu->lun =3D lu->qdev.lun;
> +    memset(&lu->unit_desc, 0, sizeof(lu->unit_desc));
> +    lu->unit_desc.length =3D sizeof(UnitDescriptor);
> +    lu->unit_desc.descriptor_idn =3D QUERY_DESC_IDN_UNIT;
> +    lu->unit_desc.lu_enable =3D 0x01;
> +    lu->unit_desc.logical_block_size =3D ufs_log2(lu->qdev.blocksize);
> +    lu->unit_desc.unit_index =3D lu->qdev.lun;
> +    lu->unit_desc.logical_block_count =3D
> +        cpu_to_be64(brdv_len / (1 << lu->unit_desc.logical_block_size));
> +}
> +
> +static bool ufs_lu_check_constraints(UfsLu *lu, Error **errp)
> +{
> +    if (!blk_is_available(lu->qdev.conf.blk)) {
> +        error_setg(errp, "block backend not configured");
> +        return false;
> +    }
> +
> +    if (lu->qdev.channel !=3D 0) {
> +        error_setg(errp, "ufs logical unit does not support channel");
> +        return false;
> +    }
> +
> +    if (lu->qdev.lun >=3D UFS_MAX_LUS) {
> +        error_setg(errp, "lun must be between 1 and %d", UFS_MAX_LUS - 1=
);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void ufs_lu_realize(SCSIDevice *dev, Error **errp)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, dev);
> +    BusState *s =3D qdev_get_parent_bus(&dev->qdev);
> +    UfsHc *u =3D UFS(s->parent);
> +    AioContext *ctx =3D NULL;
> +    uint64_t nb_sectors, nb_blocks;
> +
> +    if (!ufs_lu_check_constraints(lu, errp)) {
> +        return;
> +    }
> +
> +    if (lu->qdev.conf.blk) {
> +        ctx =3D blk_get_aio_context(lu->qdev.conf.blk);
> +        aio_context_acquire(ctx);
> +        if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
> +            goto out;
> +        }
> +    }
> +    lu->qdev.blocksize =3D lu->qdev.conf.logical_block_size;
> +    blk_get_geometry(lu->qdev.conf.blk, &nb_sectors);
> +    nb_blocks =3D nb_sectors / (lu->qdev.blocksize / BDRV_SECTOR_SIZE) -=
 1;
> +    if (nb_blocks > UINT32_MAX) {
> +        nb_blocks =3D UINT32_MAX;
> +    }
> +    lu->qdev.max_lba =3D nb_blocks;
> +    lu->qdev.type =3D TYPE_DISK;
> +
> +    ufs_init_lu(lu);
> +    if (!ufs_add_lu(u, lu, errp)) {
> +        goto out;
> +    }
> +
> +    ufs_lu_brdv_init(lu, errp);
> +out:
> +    if (ctx) {
> +        aio_context_release(ctx);
> +    }
> +}
> +
> +static void ufs_lu_unrealize(SCSIDevice *dev)
> +{
> +    UfsLu *lu =3D DO_UPCAST(UfsLu, qdev, dev);
> +
> +    blk_drain(lu->qdev.conf.blk);
> +}
> +
> +static void ufs_wlu_realize(DeviceState *qdev, Error **errp)
> +{
> +    UfsWLu *wlu =3D UFSWLU(qdev);
> +    SCSIDevice *dev =3D &wlu->qdev;
> +
> +    if (!is_wlun(dev->lun)) {
> +        error_setg(errp, "not well-known logical unit number");
> +        return;
> +    }
> +
> +    QTAILQ_INIT(&dev->requests);
> +}
> +
> +static void ufs_lu_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(oc);
> +
> +    sc->realize =3D ufs_lu_realize;
> +    sc->unrealize =3D ufs_lu_unrealize;
> +    sc->alloc_req =3D scsi_new_request;
> +    dc->bus_type =3D TYPE_UFS_BUS;
> +    device_class_set_props(dc, ufs_lu_props);
> +    dc->desc =3D "Virtual UFS logical unit";
> +}
> +
> +static void ufs_wlu_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(oc);
> +
> +    /*
> +     * The realize() function of TYPE_SCSI_DEVICE causes a segmentation =
fault
> +     * if a block drive does not exist. Define a new realize function for
> +     * well-known LUs that do not have a block drive.
> +     */
> +    dc->realize =3D ufs_wlu_realize;
> +    sc->alloc_req =3D scsi_new_request;
> +    dc->bus_type =3D TYPE_UFS_BUS;
> +    dc->desc =3D "Virtual UFS well-known logical unit";
> +}
> +
> +static const TypeInfo ufs_lu_info =3D {
> +    .name =3D TYPE_UFS_LU,
> +    .parent =3D TYPE_SCSI_DEVICE,
> +    .class_init =3D ufs_lu_class_init,
> +    .instance_size =3D sizeof(UfsLu),
> +};
> +
> +static const TypeInfo ufs_wlu_info =3D {
> +    .name =3D TYPE_UFS_WLU,
> +    .parent =3D TYPE_SCSI_DEVICE,
> +    .class_init =3D ufs_wlu_class_init,
> +    .instance_size =3D sizeof(UfsWLu),
> +};
> +
> +static void ufs_lu_register_types(void)
> +{
> +    type_register_static(&ufs_lu_info);
> +    type_register_static(&ufs_wlu_info);
> +}
> +
> +type_init(ufs_lu_register_types)
> diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
> index c1d90eeea6..9953b4fd9b 100644
> --- a/hw/ufs/meson.build
> +++ b/hw/ufs/meson.build
> @@ -1 +1 @@
> -softmmu_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c'))
> +softmmu_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c', 'lu.c'))
> diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
> index 17793929b1..644a4c60bc 100644
> --- a/hw/ufs/trace-events
> +++ b/hw/ufs/trace-events
> @@ -12,6 +12,31 @@ ufs_exec_scsi_cmd(uint32_t slot, uint8_t lun, uint8_t =
opcode) "slot %"PRIu32", l
>  ufs_exec_query_cmd(uint32_t slot, uint8_t opcode) "slot %"PRIu32", opcod=
e 0x%"PRIx8""
>  ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2=
, uint32_t ucmdarg3) "uiccmd 0x%"PRIx32", ucmdarg1 0x%"PRIx32", ucmdarg2 0x=
%"PRIx32", ucmdarg3 0x%"PRIx32""
> =20
> +# lu.c
> +ufs_scsi_check_condition(uint32_t tag, uint8_t key, uint8_t asc, uint8_t=
 ascq) "Command complete tag=3D0x%x sense=3D%d/%d/%d"
> +ufs_scsi_read_complete(uint32_t tag, size_t size) "Data ready tag=3D0x%x=
 len=3D%zd"
> +ufs_scsi_read_data_count(uint32_t sector_count) "Read sector_count=3D%d"
> +ufs_scsi_read_data_invalid(void) "Data transfer direction invalid"
> +ufs_scsi_write_complete_noio(uint32_t tag, size_t size) "Write complete =
tag=3D0x%x more=3D%zd"
> +ufs_scsi_write_data_invalid(void) "Data transfer direction invalid"
> +ufs_scsi_emulate_vpd_page_00(size_t xfer) "Inquiry EVPD[Supported pages]=
 buffer size %zd"
> +ufs_scsi_emulate_vpd_page_80_not_supported(void) "Inquiry EVPD[Serial nu=
mber] not supported"
> +ufs_scsi_emulate_vpd_page_80(size_t xfer) "Inquiry EVPD[Serial number] b=
uffer size %zd"
> +ufs_scsi_emulate_vpd_page_87(size_t xfer) "Inquiry EVPD[Mode Page Policy=
] buffer size %zd"
> +ufs_scsi_emulate_mode_sense(int cmd, int page, size_t xfer, int control)=
 "Mode Sense(%d) (page %d, xfer %zd, page_control %d)"
> +ufs_scsi_emulate_read_data(int buflen) "Read buf_len=3D%d"
> +ufs_scsi_emulate_write_data(int buflen) "Write buf_len=3D%d"
> +ufs_scsi_emulate_command_START_STOP(void) "START STOP UNIT"
> +ufs_scsi_emulate_command_FORMAT_UNIT(void) "FORMAT UNIT"
> +ufs_scsi_emulate_command_SEND_DIAGNOSTIC(void) "SEND DIAGNOSTIC"
> +ufs_scsi_emulate_command_SAI_16(void) "SAI READ CAPACITY(16)"
> +ufs_scsi_emulate_command_SAI_unsupported(void) "Unsupported Service Acti=
on In"
> +ufs_scsi_emulate_command_MODE_SELECT_10(size_t xfer) "Mode Select(10) (l=
en %zd)"
> +ufs_scsi_emulate_command_VERIFY(int bytchk) "Verify (bytchk %d)"
> +ufs_scsi_emulate_command_UNKNOWN(int cmd, const char *name) "Unknown SCS=
I command (0x%2.2x=3D%s)"
> +ufs_scsi_dma_command_READ(uint64_t lba, uint32_t len) "Read (block %" PR=
Iu64 ", count %u)"
> +ufs_scsi_dma_command_WRITE(uint64_t lba, int len) "Write (block %" PRIu6=
4 ", count %u)"
> +
>  # error condition
>  ufs_err_memory_allocation(void) "failed to allocate memory"
>  ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd=
=2E UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 10ecc8cd7b..d17f75446a 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -8,6 +8,19 @@
>   * This code is licensed under the GNU GPL v2 or later.
>   */
> =20
> +/**
> + * Reference Specs: https://www.jedec.org/, 3.1
> + *
> + * Usage
> + * -----
> + *
> + * Add options:
> + *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
> + *      -device ufs,serial=3D<serial>,id=3D<bus_name>, \
> + *              nutrs=3D<N[optional]>,nutmrs=3D<N[optional]>
> + *      -device ufs-lu,drive=3D<drive_id>,bus=3D<bus_name>
> + */
> +
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
> @@ -459,6 +472,19 @@ static const MemoryRegionOps ufs_mmio_ops =3D {
>      },
>  };
> =20
> +static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
> +{
> +    UfsRequest *req =3D scsi_req->hba_private;
> +    return req->sg;
> +}
> +
> +static void ufs_build_upiu_sense_data(UfsRequest *req, SCSIRequest *scsi=
_req)
> +{
> +    req->rsp_upiu.sr.sense_data_len =3D cpu_to_be16(scsi_req->sense_len);
> +    assert(scsi_req->sense_len <=3D SCSI_SENSE_LEN);
> +    memcpy(req->rsp_upiu.sr.sense_data, scsi_req->sense, scsi_req->sense=
_len);
> +}
> +
>  static void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type,
>                                    uint8_t flags, uint8_t response,
>                                    uint8_t scsi_status,
> @@ -472,6 +498,98 @@ static void ufs_build_upiu_header(UfsRequest *req, u=
int8_t trans_type,
>      req->rsp_upiu.header.data_segment_length =3D cpu_to_be16(data_segmen=
t_length);
>  }
> =20
> +static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resi=
d)
> +{
> +    UfsRequest *req =3D scsi_req->hba_private;
> +    int16_t status =3D scsi_req->status;
> +    uint32_t expected_len =3D be32_to_cpu(req->req_upiu.sc.exp_data_tran=
sfer_len);
> +    uint32_t transfered_len =3D scsi_req->cmd.xfer - resid;
> +    uint8_t flags =3D 0, response =3D COMMAND_RESULT_SUCESS;
> +    uint16_t data_segment_length;
> +
> +    if (expected_len > transfered_len) {
> +        req->rsp_upiu.sr.residual_transfer_count =3D
> +            cpu_to_be32(expected_len - transfered_len);
> +        flags |=3D UFS_UPIU_FLAG_UNDERFLOW;
> +    } else if (expected_len < transfered_len) {
> +        req->rsp_upiu.sr.residual_transfer_count =3D
> +            cpu_to_be32(transfered_len - expected_len);
> +        flags |=3D UFS_UPIU_FLAG_OVERFLOW;
> +    }
> +
> +    if (status !=3D 0) {
> +        ufs_build_upiu_sense_data(req, scsi_req);
> +        response =3D COMMAND_RESULT_FAIL;
> +    }
> +
> +    data_segment_length =3D cpu_to_be16(scsi_req->sense_len +
> +                                      sizeof(req->rsp_upiu.sr.sense_data=
_len));
> +    ufs_build_upiu_header(req, UPIU_TRANSACTION_RESPONSE, flags, respons=
e,
> +                          status, data_segment_length);
> +
> +    ufs_complete_req(req, UFS_REQUEST_SUCCESS);
> +
> +    scsi_req->hba_private =3D NULL;
> +    scsi_req_unref(scsi_req);
> +}
> +
> +static const struct SCSIBusInfo ufs_scsi_info =3D {
> +    .tcq =3D true,
> +    .max_target =3D 0,
> +    .max_lun =3D UFS_MAX_LUS,
> +    .max_channel =3D 0,
> +
> +    .get_sg_list =3D ufs_get_sg_list,
> +    .complete =3D ufs_scsi_command_complete,
> +};
> +
> +static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    uint8_t lun =3D req->req_upiu.header.lun;
> +    uint8_t task_tag =3D req->req_upiu.header.task_tag;
> +    SCSIDevice *dev =3D NULL;
> +
> +    trace_ufs_exec_scsi_cmd(req->slot, lun, req->req_upiu.sc.cdb[0]);
> +
> +    if (!is_wlun(lun)) {
> +        if (lun >=3D u->device_desc.number_lu) {
> +            trace_ufs_err_scsi_cmd_invalid_lun(lun);
> +            return UFS_REQUEST_ERROR;
> +        } else if (u->lus[lun] =3D=3D NULL) {
> +            trace_ufs_err_scsi_cmd_invalid_lun(lun);
> +            return UFS_REQUEST_ERROR;
> +        }
> +    }
> +
> +    switch (lun) {
> +    case UFS_UPIU_REPORT_LUNS_WLUN:
> +        dev =3D &u->report_wlu->qdev;
> +        break;
> +    case UFS_UPIU_UFS_DEVICE_WLUN:
> +        dev =3D &u->dev_wlu->qdev;
> +        break;
> +    case UFS_UPIU_BOOT_WLUN:
> +        dev =3D &u->boot_wlu->qdev;
> +        break;
> +    case UFS_UPIU_RPMB_WLUN:
> +        dev =3D &u->rpmb_wlu->qdev;
> +        break;
> +    default:
> +        dev =3D &u->lus[lun]->qdev;
> +    }
> +
> +    SCSIRequest *scsi_req =3D scsi_req_new(
> +        dev, task_tag, lun, req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
> +
> +    uint32_t len =3D scsi_req_enqueue(scsi_req);
> +    if (len) {
> +        scsi_req_continue(scsi_req);
> +    }
> +
> +    return UFS_REQUEST_NO_COMPLETE;
> +}
> +
>  static UfsReqResult ufs_exec_nop_cmd(UfsRequest *req)
>  {
>      trace_ufs_exec_nop_cmd(req->slot);
> @@ -749,9 +867,11 @@ static const RpmbUnitDescriptor rpmb_unit_desc =3D {
> =20
>  static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
>  {
> +    UfsHc *u =3D req->hc;
>      uint8_t lun =3D req->req_upiu.qr.index;
> =20
> -    if (lun !=3D UFS_UPIU_RPMB_WLUN && lun > UFS_MAX_LUS) {
> +    if (lun !=3D UFS_UPIU_RPMB_WLUN &&
> +        (lun > UFS_MAX_LUS || u->lus[lun] =3D=3D NULL)) {
>          trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, lun);
>          return QUERY_RESULT_INVALID_INDEX;
>      }
> @@ -759,8 +879,8 @@ static QueryRespCode ufs_read_unit_desc(UfsRequest *r=
eq)
>      if (lun =3D=3D UFS_UPIU_RPMB_WLUN) {
>          memcpy(&req->rsp_upiu.qr.data, &rpmb_unit_desc, rpmb_unit_desc.l=
ength);
>      } else {
> -        /* unit descriptor is not yet supported */
> -        return QUERY_RESULT_INVALID_INDEX;
> +        memcpy(&req->rsp_upiu.qr.data, &u->lus[lun]->unit_desc,
> +               sizeof(u->lus[lun]->unit_desc));
>      }
> =20
>      return QUERY_RESULT_SUCCESS;
> @@ -976,8 +1096,7 @@ static void ufs_exec_req(UfsRequest *req)
>          req_result =3D ufs_exec_nop_cmd(req);
>          break;
>      case UPIU_TRANSACTION_COMMAND:
> -        /* Not yet implemented */
> -        req_result =3D UFS_REQUEST_ERROR;
> +        req_result =3D ufs_exec_scsi_cmd(req);
>          break;
>      case UPIU_TRANSACTION_QUERY_REQ:
>          req_result =3D ufs_exec_query_cmd(req);
> @@ -988,7 +1107,14 @@ static void ufs_exec_req(UfsRequest *req)
>          req_result =3D UFS_REQUEST_ERROR;
>      }
> =20
> -    ufs_complete_req(req, req_result);
> +    /*
> +     * The ufs_complete_req for scsi commands is handled by the
> +     * ufs_scsi_command_complete() callback function. Therefore, to avoid
> +     * duplicate processing, ufs_complete_req() is not called for scsi c=
ommands.
> +     */
> +    if (req_result !=3D UFS_REQUEST_NO_COMPLETE) {
> +        ufs_complete_req(req, req_result);
> +    }
>  }
> =20
>  static void ufs_process_req(void *opaque)
> @@ -1202,6 +1328,28 @@ static void ufs_init_hc(UfsHc *u)
>      u->flags.permanently_disable_fw_update =3D 1;
>  }
> =20
> +static bool ufs_init_wlu(UfsHc *u, UfsWLu **wlu, uint8_t wlun, Error **e=
rrp)
> +{
> +    UfsWLu *new_wlu =3D UFSWLU(qdev_new(TYPE_UFS_WLU));
> +
> +    qdev_prop_set_uint32(DEVICE(new_wlu), "lun", wlun);
> +
> +    /*
> +     * The well-known lu shares the same bus as the normal lu. If the we=
ll-known
> +     * lu writes the same channel value as the normal lu, the report wil=
l be
> +     * made not only for the normal lu but also for the well-known lu at
> +     * REPORT_LUN time. To prevent this, the channel value of normal lu =
is fixed
> +     * to 0 and the channel value of well-known lu is fixed to 1.
> +     */
> +    qdev_prop_set_uint32(DEVICE(new_wlu), "channel", 1);
> +    if (!qdev_realize_and_unref(DEVICE(new_wlu), BUS(&u->bus), errp)) {
> +        return false;
> +    }
> +
> +    *wlu =3D new_wlu;
> +    return true;
> +}
> +
>  static void ufs_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      UfsHc *u =3D UFS(pci_dev);
> @@ -1210,15 +1358,55 @@ static void ufs_realize(PCIDevice *pci_dev, Error=
 **errp)
>          return;
>      }
> =20
> +    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, &pci_dev->qdev,
> +              u->parent_obj.qdev.id);
> +    u->bus.parent_bus.info =3D &ufs_scsi_info;
> +
>      ufs_init_state(u);
>      ufs_init_hc(u);
>      ufs_init_pci(u, pci_dev);
> +
> +    if (!ufs_init_wlu(u, &u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN, errp=
)) {
> +        return;
> +    }
> +
> +    if (!ufs_init_wlu(u, &u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN, errp)) {
> +        return;
> +    }
> +
> +    if (!ufs_init_wlu(u, &u->boot_wlu, UFS_UPIU_BOOT_WLUN, errp)) {
> +        return;
> +    }
> +
> +    if (!ufs_init_wlu(u, &u->rpmb_wlu, UFS_UPIU_RPMB_WLUN, errp)) {
> +        return;
> +    }
>  }
> =20
>  static void ufs_exit(PCIDevice *pci_dev)
>  {
>      UfsHc *u =3D UFS(pci_dev);
> =20
> +    if (u->dev_wlu) {
> +        object_unref(OBJECT(u->dev_wlu));
> +        u->dev_wlu =3D NULL;
> +    }
> +
> +    if (u->report_wlu) {
> +        object_unref(OBJECT(u->report_wlu));
> +        u->report_wlu =3D NULL;
> +    }
> +
> +    if (u->rpmb_wlu) {
> +        object_unref(OBJECT(u->rpmb_wlu));
> +        u->rpmb_wlu =3D NULL;
> +    }
> +
> +    if (u->boot_wlu) {
> +        object_unref(OBJECT(u->boot_wlu));
> +        u->boot_wlu =3D NULL;
> +    }
> +
>      qemu_bh_delete(u->doorbell_bh);
>      qemu_bh_delete(u->complete_bh);
> =20
> @@ -1255,6 +1443,49 @@ static void ufs_class_init(ObjectClass *oc, void *=
data)
>      dc->vmsd =3D &ufs_vmstate;
>  }
> =20
> +static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
> +                                  Error **errp)
> +{
> +    SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> +    UfsBusClass *ubc =3D UFS_BUS_GET_CLASS(qbus);
> +    UfsHc *u =3D UFS(qbus->parent);
> +
> +    if (strcmp(object_get_typename(OBJECT(dev)), TYPE_UFS_WLU) =3D=3D 0)=
 {
> +        if (dev->lun !=3D UFS_UPIU_REPORT_LUNS_WLUN &&
> +            dev->lun !=3D UFS_UPIU_UFS_DEVICE_WLUN &&
> +            dev->lun !=3D UFS_UPIU_BOOT_WLUN && dev->lun !=3D UFS_UPIU_R=
PMB_WLUN) {
> +            error_setg(errp, "bad well-known lun: %d", dev->lun);
> +            return false;
> +        }
> +
> +        if ((dev->lun =3D=3D UFS_UPIU_REPORT_LUNS_WLUN && u->report_wlu =
!=3D NULL) ||
> +            (dev->lun =3D=3D UFS_UPIU_UFS_DEVICE_WLUN && u->dev_wlu !=3D=
 NULL) ||
> +            (dev->lun =3D=3D UFS_UPIU_BOOT_WLUN && u->boot_wlu !=3D NULL=
) ||
> +            (dev->lun =3D=3D UFS_UPIU_RPMB_WLUN && u->rpmb_wlu !=3D NULL=
)) {
> +            error_setg(errp, "well-known lun %d already exists", dev->lu=
n);
> +            return false;
> +        }
> +
> +        return true;
> +    }
> +
> +    if (strcmp(object_get_typename(OBJECT(dev)), TYPE_UFS_LU) !=3D 0) {
> +        error_setg(errp, "%s cannot be connected to ufs-bus",
> +                   object_get_typename(OBJECT(dev)));
> +        return false;
> +    }
> +
> +    return ubc->parent_check_address(qbus, qdev, errp);
> +}
> +
> +static void ufs_bus_class_init(ObjectClass *class, void *data)
> +{
> +    BusClass *bc =3D BUS_CLASS(class);
> +    UfsBusClass *ubc =3D UFS_BUS_CLASS(class);
> +    ubc->parent_check_address =3D bc->check_address;
> +    bc->check_address =3D ufs_bus_check_address;
> +}
> +
>  static const TypeInfo ufs_info =3D {
>      .name =3D TYPE_UFS,
>      .parent =3D TYPE_PCI_DEVICE,
> @@ -1263,9 +1494,18 @@ static const TypeInfo ufs_info =3D {
>      .interfaces =3D (InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
>  };
> =20
> +static const TypeInfo ufs_bus_info =3D {
> +    .name =3D TYPE_UFS_BUS,
> +    .parent =3D TYPE_SCSI_BUS,
> +    .class_init =3D ufs_bus_class_init,
> +    .class_size =3D sizeof(UfsBusClass),
> +    .instance_size =3D sizeof(UfsBus),
> +};
> +
>  static void ufs_register_types(void)
>  {
>      type_register_static(&ufs_info);
> +    type_register_static(&ufs_bus_info);
>  }
> =20
>  type_init(ufs_register_types)
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index 5d4fd818f9..6d2dc000e9 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -18,6 +18,18 @@
>  #define UFS_MAX_LUS 32
>  #define UFS_LOGICAL_BLK_SIZE 4096
> =20
> +typedef struct UfsBusClass {
> +    BusClass parent_class;
> +    bool (*parent_check_address)(BusState *bus, DeviceState *dev, Error =
**errp);
> +} UfsBusClass;
> +
> +typedef struct UfsBus {
> +    SCSIBus parent_bus;
> +} UfsBus;
> +
> +#define TYPE_UFS_BUS "ufs-bus"
> +DECLARE_OBJ_CHECKERS(UfsBus, UfsBusClass, UFS_BUS, TYPE_UFS_BUS)
> +
>  typedef enum UfsRequestState {
>      UFS_REQUEST_IDLE =3D 0,
>      UFS_REQUEST_READY =3D 1,
> @@ -28,6 +40,7 @@ typedef enum UfsRequestState {
>  typedef enum UfsReqResult {
>      UFS_REQUEST_SUCCESS =3D 0,
>      UFS_REQUEST_ERROR =3D 1,
> +    UFS_REQUEST_NO_COMPLETE =3D 2,
>  } UfsReqResult;
> =20
>  typedef struct UfsRequest {
> @@ -43,6 +56,17 @@ typedef struct UfsRequest {
>      QEMUSGList *sg;
>  } UfsRequest;
> =20
> +typedef struct UfsLu {
> +    SCSIDevice qdev;
> +    uint8_t lun;
> +    UnitDescriptor unit_desc;
> +} UfsLu;
> +
> +typedef struct UfsWLu {
> +    SCSIDevice qdev;
> +    uint8_t lun;
> +} UfsWLu;
> +
>  typedef struct UfsParams {
>      char *serial;
>      uint8_t nutrs; /* Number of UTP Transfer Request Slots */
> @@ -51,12 +75,18 @@ typedef struct UfsParams {
> =20
>  typedef struct UfsHc {
>      PCIDevice parent_obj;
> +    UfsBus bus;
>      MemoryRegion iomem;
>      UfsReg reg;
>      UfsParams params;
>      uint32_t reg_size;
>      UfsRequest *req_list;
> =20
> +    UfsLu *lus[UFS_MAX_LUS];
> +    UfsWLu *report_wlu;
> +    UfsWLu *dev_wlu;
> +    UfsWLu *boot_wlu;
> +    UfsWLu *rpmb_wlu;
>      DeviceDescriptor device_desc;
>      GeometryDescriptor geometry_desc;
>      Attributes attributes;
> @@ -70,6 +100,12 @@ typedef struct UfsHc {
>  #define TYPE_UFS "ufs"
>  #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
> =20
> +#define TYPE_UFS_LU "ufs-lu"
> +#define UFSLU(obj) OBJECT_CHECK(UfsLu, (obj), TYPE_UFS_LU)
> +
> +#define TYPE_UFS_WLU "ufs-wlu"
> +#define UFSWLU(obj) OBJECT_CHECK(UfsWLu, (obj), TYPE_UFS_WLU)
> +
>  typedef enum UfsQueryFlagPerm {
>      UFS_QUERY_FLAG_NONE =3D 0x0,
>      UFS_QUERY_FLAG_READ =3D 0x1,
> @@ -84,4 +120,11 @@ typedef enum UfsQueryAttrPerm {
>      UFS_QUERY_ATTR_WRITE =3D 0x2,
>  } UfsQueryAttrPerm;
> =20
> +static inline bool is_wlun(uint8_t lun)
> +{
> +    return (lun =3D=3D UFS_UPIU_REPORT_LUNS_WLUN ||
> +            lun =3D=3D UFS_UPIU_UFS_DEVICE_WLUN || lun =3D=3D UFS_UPIU_B=
OOT_WLUN ||
> +            lun =3D=3D UFS_UPIU_RPMB_WLUN);
> +}
> +
>  #endif /* HW_UFS_UFS_H */
> diff --git a/include/scsi/constants.h b/include/scsi/constants.h
> index 6a8bad556a..9b98451912 100644
> --- a/include/scsi/constants.h
> +++ b/include/scsi/constants.h
> @@ -231,6 +231,7 @@
>  #define MODE_PAGE_FLEXIBLE_DISK_GEOMETRY      0x05
>  #define MODE_PAGE_CACHING                     0x08
>  #define MODE_PAGE_AUDIO_CTL                   0x0e
> +#define MODE_PAGE_CONTROL                     0x0a
>  #define MODE_PAGE_POWER                       0x1a
>  #define MODE_PAGE_FAULT_FAIL                  0x1c
>  #define MODE_PAGE_TO_PROTECT                  0x1d
> --=20
> 2.34.1
>=20

--FW8QP7VyUvLBJn7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQEH0ACgkQnKSrs4Gr
c8jeTgf+JP7H4/n8ePtqren7MesGl7jqhMtmAkvSKh9Q7fC8IjPKvKK5N4nwWtTy
Hmj9CFkm+WrH0je3fwAL0ul3NM+83rVdK9JBYTMg7GIiph7DKlGuaocNl9VFLPXz
9fu22ZxcwnMi1TuEOhO03bMwZEPWpTOwOMcUs4Z/2eqmw8gDm73qa9JalrQbHSXo
os4yFY47ttchlkMp3uOxTPdxytieSRntKg8IeCZed25FT8Ri/UrPntcurj62OVoW
Z6lo3KQUgXzv13vkuOLXAkaoi274yqMWxQ0KT20vJFmHupoeiCpEoOc1a/k2xvEO
A9RqK+cgBaVEQfN/wKfWeti1cbNxzA==
=tJtf
-----END PGP SIGNATURE-----

--FW8QP7VyUvLBJn7s--


