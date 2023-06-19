Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCB734C3C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB98I-0007wx-UC; Mon, 19 Jun 2023 03:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qB985-0007wC-0r
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qB97x-0007bu-6M
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687159000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibhaHwzEUps+9d/30cMuiA8AmaF625qCdmgPH1lItoc=;
 b=da8NAtK27RsvtCrHciIVwTgqXnA3E3+IU9kEXAcTTfVt5oRDLCMaDBDeMvIjr/LwBW9XdU
 LzIrlj7E+bhFCWmnY3xGHIDm8q3D2Mb8GK6T9oKfG6WP7qCMnq6LQAQLFBUTHoPiAUoiPU
 60waX9mlKSv7i2iROzAv7OG7eu3hJYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-TZhDEe9SN3WXByhmVebquQ-1; Mon, 19 Jun 2023 03:16:36 -0400
X-MC-Unique: TZhDEe9SN3WXByhmVebquQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E32580013A;
 Mon, 19 Jun 2023 07:16:36 +0000 (UTC)
Received: from localhost (unknown [10.39.193.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ACC8C1603B;
 Mon, 19 Jun 2023 07:16:34 +0000 (UTC)
Date: Mon, 19 Jun 2023 09:16:33 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 2/3] hw/ufs: Support for Query Transfer Requests
Message-ID: <20230619071633.GA2497337@fedora>
References: <CGME20230616065825epcms2p5682ea0edcd1fb0366a344708bea875cb@epcms2p5>
 <20230616065825epcms2p5682ea0edcd1fb0366a344708bea875cb@epcms2p5>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iGIX2l0JKczoxyCA"
Content-Disposition: inline
In-Reply-To: <20230616065825epcms2p5682ea0edcd1fb0366a344708bea875cb@epcms2p5>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--iGIX2l0JKczoxyCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 03:58:25PM +0900, Jeuk Kim wrote:
> This commit makes the UFS device support query
> and nop out transfer requests.
>=20
> The next patch would be support for UFS logical
> unit and scsi command transfer request.
>=20
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>  hw/ufs/ufs.c | 968 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/ufs/ufs.h |  45 +++
>  2 files changed, 1012 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 9dba1073a8..10ecc8cd7b 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -19,6 +19,233 @@
>  #define UFS_MAX_NUTRS 32
>  #define UFS_MAX_NUTMRS 8
> =20
> +static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int s=
ize)
> +{
> +    uint32_t cap =3D ldl_le_p(&u->reg.cap);
> +    hwaddr hi =3D addr + size - 1;
> +
> +    if (hi < addr) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    if (!FIELD_EX32(cap, CAP, 64AS) && (hi >> 32)) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
> +}
> +
> +static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
> +                                  int size)
> +{
> +    uint32_t cap =3D ldl_le_p(&u->reg.cap);
> +    hwaddr hi =3D addr + size - 1;
> +    if (hi < addr) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    if (!FIELD_EX32(cap, CAP, 64AS) && (hi >> 32)) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
> +}
> +
> +static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
> +
> +static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
> +{
> +    uint32_t utrlba =3D ldl_le_p(&u->reg.utrlba);
> +    uint32_t utrlbau =3D ldl_le_p(&u->reg.utrlbau);
> +    hwaddr utrl_base_addr =3D (((hwaddr)utrlbau) << 32) + utrlba;
> +    hwaddr utrd_addr =3D utrl_base_addr + slot * sizeof(UtpTransferReqDe=
sc);
> +
> +    return utrd_addr;
> +}
> +
> +static inline hwaddr ufs_get_req_upiu_base_addr(const UtpTransferReqDesc=
 *utrd)
> +{
> +    uint32_t cmd_desc_base_addr_lo =3D
> +        le32_to_cpu(utrd->command_desc_base_addr_lo);
> +    uint32_t cmd_desc_base_addr_hi =3D
> +        le32_to_cpu(utrd->command_desc_base_addr_hi);
> +
> +    return (((hwaddr)cmd_desc_base_addr_hi) << 32) + cmd_desc_base_addr_=
lo;
> +}
> +
> +static inline hwaddr ufs_get_rsp_upiu_base_addr(const UtpTransferReqDesc=
 *utrd)
> +{
> +    hwaddr req_upiu_base_addr =3D ufs_get_req_upiu_base_addr(utrd);
> +    uint32_t rsp_upiu_byte_off =3D
> +        le16_to_cpu(utrd->response_upiu_offset) * sizeof(uint32_t);
> +    return req_upiu_base_addr + rsp_upiu_byte_off;
> +}
> +
> +static MemTxResult ufs_dma_read_utrd(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    hwaddr utrd_addr =3D ufs_get_utrd_addr(u, req->slot);
> +    MemTxResult ret;
> +
> +    ret =3D ufs_addr_read(u, utrd_addr, &req->utrd, sizeof(req->utrd));
> +    if (ret) {
> +        trace_ufs_err_dma_read_utrd(req->slot, utrd_addr);
> +    }
> +    return ret;
> +}
> +
> +static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    hwaddr req_upiu_base_addr =3D ufs_get_req_upiu_base_addr(&req->utrd);
> +    UtpUpiuReq *req_upiu =3D &req->req_upiu;
> +    uint32_t copy_size;
> +    uint16_t data_segment_length;
> +    MemTxResult ret;
> +
> +    /*
> +     * To know the size of the req_upiu, we need to read the
> +     * data_segment_length in the header first.
> +     */
> +    ret =3D ufs_addr_read(u, req_upiu_base_addr, &req_upiu->header,
> +                        sizeof(UtpUpiuHeader));
> +    if (ret) {
> +        trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
> +        return ret;
> +    }
> +    data_segment_length =3D be16_to_cpu(req_upiu->header.data_segment_le=
ngth);
> +
> +    copy_size =3D sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD=
_SIZE +
> +                data_segment_length;
> +
> +    ret =3D ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_si=
ze);
> +    if (ret) {
> +        trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
> +    }
> +    return ret;
> +}
> +
> +static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    uint16_t prdt_len =3D le16_to_cpu(req->utrd.prd_table_length);
> +    uint16_t prdt_byte_off =3D
> +        le16_to_cpu(req->utrd.prd_table_offset) * sizeof(uint32_t);
> +    uint32_t prdt_size =3D prdt_len * sizeof(UfshcdSgEntry);
> +    UfshcdSgEntry *prd_entries;
> +    hwaddr req_upiu_base_addr, prdt_base_addr;
> +    int err;
> +
> +    assert(!req->sg);
> +
> +    if (prdt_len =3D=3D 0) {
> +        return MEMTX_OK;
> +    }
> +
> +    prd_entries =3D g_new(UfshcdSgEntry, prdt_size);
> +    if (!prd_entries) {
> +        trace_ufs_err_memory_allocation();
> +        return MEMTX_ERROR;
> +    }
> +
> +    req_upiu_base_addr =3D ufs_get_req_upiu_base_addr(&req->utrd);
> +    prdt_base_addr =3D req_upiu_base_addr + prdt_byte_off;
> +
> +    err =3D ufs_addr_read(u, prdt_base_addr, prd_entries, prdt_size);
> +    if (err) {
> +        trace_ufs_err_dma_read_prdt(req->slot, prdt_base_addr);
> +        return err;

prd_entries is leaked. I suggest using g_autofree to avoid manual
g_free() calls in return paths.

> +    }
> +
> +    req->sg =3D g_malloc0(sizeof(QEMUSGList));
> +    if (!req->sg) {
> +        trace_ufs_err_memory_allocation();
> +        g_free(prd_entries);
> +        return MEMTX_ERROR;
> +    }
> +    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
> +
> +    for (uint16_t i =3D 0; i < prdt_len; ++i) {
> +        hwaddr data_dma_addr =3D le64_to_cpu(prd_entries[i].addr);
> +        int32_t data_byte_count =3D le32_to_cpu(prd_entries[i].size) + 1;
> +        qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
> +    }
> +    g_free(prd_entries);
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult ufs_dma_read_upiu(UfsRequest *req)
> +{
> +    MemTxResult ret;
> +
> +    ret =3D ufs_dma_read_utrd(req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret =3D ufs_dma_read_req_upiu(req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret =3D ufs_dma_read_prdt(req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static MemTxResult ufs_dma_write_utrd(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    hwaddr utrd_addr =3D ufs_get_utrd_addr(u, req->slot);
> +    MemTxResult ret;
> +
> +    ret =3D ufs_addr_write(u, utrd_addr, &req->utrd, sizeof(req->utrd));
> +    if (ret) {
> +        trace_ufs_err_dma_write_utrd(req->slot, utrd_addr);
> +    }
> +    return ret;
> +}
> +
> +static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    hwaddr rsp_upiu_base_addr =3D ufs_get_rsp_upiu_base_addr(&req->utrd);
> +    uint32_t rsp_upiu_byte_len =3D
> +        le16_to_cpu(req->utrd.response_upiu_length) * sizeof(uint32_t);
> +    uint16_t data_segment_length =3D
> +        be16_to_cpu(req->rsp_upiu.header.data_segment_length);
> +    uint32_t copy_size =3D sizeof(UtpUpiuHeader) +
> +                         UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
> +                         data_segment_length;
> +    MemTxResult ret;
> +
> +    if (copy_size > rsp_upiu_byte_len) {
> +        copy_size =3D rsp_upiu_byte_len;
> +    }
> +
> +    ret =3D ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_s=
ize);
> +    if (ret) {
> +        trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
> +    }
> +    return ret;
> +}
> +
> +static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
> +{
> +    MemTxResult ret;
> +
> +    ret =3D ufs_dma_write_rsp_upiu(req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return ufs_dma_write_utrd(req);
> +}
> +
>  static void ufs_irq_check(UfsHc *u)
>  {
>      PCIDevice *pci =3D PCI_DEVICE(u);
> @@ -34,6 +261,36 @@ static void ufs_irq_check(UfsHc *u)
>      }
>  }
> =20
> +static void ufs_process_db(UfsHc *u, uint64_t val)
> +{
> +    uint32_t slot;
> +    uint32_t nutrs =3D u->params.nutrs;
> +    uint32_t utrldbr =3D ldl_le_p(&u->reg.utrldbr);
> +    UfsRequest *req;
> +
> +    val &=3D ~utrldbr;
> +    if (!val) {
> +        return;
> +    }
> +    stl_le_p(&u->reg.utrldbr, utrldbr | val);
> +
> +    slot =3D find_first_bit(&val, nutrs);
> +
> +    while (slot < nutrs) {
> +        req =3D &u->req_list[slot];
> +        if (req->state !=3D UFS_REQUEST_IDLE) {
> +            trace_ufs_err_utrl_slot_busy(req->slot);
> +            return;
> +        }
> +
> +        trace_ufs_process_db(slot);
> +        req->state =3D UFS_REQUEST_READY;
> +        slot =3D find_next_bit(&val, nutrs, slot + 1);
> +    }
> +
> +    qemu_bh_schedule(u->doorbell_bh);
> +}
> +
>  static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
>  {
>      uint32_t is =3D ldl_le_p(&u->reg.is);
> @@ -85,6 +342,7 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uin=
t32_t data, unsigned size)
>      uint32_t is =3D ldl_le_p(&u->reg.is);
>      uint32_t hcs =3D ldl_le_p(&u->reg.hcs);
>      uint32_t hce =3D ldl_le_p(&u->reg.hce);
> +    uint32_t utrldbr =3D ldl_le_p(&u->reg.utrldbr);
>      uint32_t utrlcnr =3D ldl_le_p(&u->reg.utrlcnr);
>      uint32_t utrlba, utmrlba;
> =20
> @@ -119,7 +377,9 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, ui=
nt32_t data, unsigned size)
>          stl_le_p(&u->reg.utrlbau, data);
>          break;
>      case A_UTRLDBR:
> -        /* Not yet supported */
> +        ufs_process_db(u, data);
> +        utrldbr |=3D data;
> +        stl_le_p(&u->reg.utrldbr, utrldbr);
>          break;
>      case A_UTRLRSR:
>          stl_le_p(&u->reg.utrlrsr, data);
> @@ -199,6 +459,632 @@ static const MemoryRegionOps ufs_mmio_ops =3D {
>      },
>  };
> =20
> +static void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type,
> +                                  uint8_t flags, uint8_t response,
> +                                  uint8_t scsi_status,
> +                                  uint16_t data_segment_length)
> +{
> +    memcpy(&req->rsp_upiu.header, &req->req_upiu.header, sizeof(UtpUpiuH=
eader));
> +    req->rsp_upiu.header.trans_type =3D trans_type;
> +    req->rsp_upiu.header.flags =3D flags;
> +    req->rsp_upiu.header.response =3D response;
> +    req->rsp_upiu.header.scsi_status =3D scsi_status;
> +    req->rsp_upiu.header.data_segment_length =3D cpu_to_be16(data_segmen=
t_length);
> +}
> +
> +static UfsReqResult ufs_exec_nop_cmd(UfsRequest *req)
> +{
> +    trace_ufs_exec_nop_cmd(req->slot);
> +    ufs_build_upiu_header(req, UPIU_TRANSACTION_NOP_IN, 0, 0, 0, 0);
> +    return UFS_REQUEST_SUCCESS;
> +}
> +
> +/*
> + * This defines the permission of flags based on their IDN. There are so=
me
> + * things that are declared read-only, which is inconsistent with the uf=
s spec,
> + * because we want to return an error for features that are not yet supp=
orted.
> + */
> +static const int flag_permission[QUERY_FLAG_IDN_COUNT] =3D {
> +    [QUERY_FLAG_IDN_FDEVICEINIT] =3D UFS_QUERY_FLAG_READ | UFS_QUERY_FLA=
G_SET,
> +    /* Write protection is not supported */
> +    [QUERY_FLAG_IDN_PERMANENT_WPE] =3D UFS_QUERY_FLAG_READ,
> +    [QUERY_FLAG_IDN_PWR_ON_WPE] =3D UFS_QUERY_FLAG_READ,
> +    [QUERY_FLAG_IDN_BKOPS_EN] =3D UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_S=
ET |
> +                                UFS_QUERY_FLAG_CLEAR | UFS_QUERY_FLAG_TO=
GGLE,
> +    [QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE] =3D
> +        UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET | UFS_QUERY_FLAG_CLEAR |
> +        UFS_QUERY_FLAG_TOGGLE,
> +    /* Purge Operation is not supported */
> +    [QUERY_FLAG_IDN_PURGE_ENABLE] =3D UFS_QUERY_FLAG_NONE,
> +    /* Refresh Operation is not supported */
> +    [QUERY_FLAG_IDN_REFRESH_ENABLE] =3D UFS_QUERY_FLAG_NONE,
> +    /* Physical Resource Removal is not supported */
> +    [QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL] =3D UFS_QUERY_FLAG_READ,
> +    [QUERY_FLAG_IDN_BUSY_RTC] =3D UFS_QUERY_FLAG_READ,
> +    [QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE] =3D UFS_QUERY_FLAG_RE=
AD,
> +    /* Write Booster is not supported */
> +    [QUERY_FLAG_IDN_WB_EN] =3D UFS_QUERY_FLAG_READ,
> +    [QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN] =3D UFS_QUERY_FLAG_READ,
> +    [QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8] =3D UFS_QUERY_FLAG_REA=
D,
> +};
> +
> +static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
> +{
> +    if (idn >=3D QUERY_FLAG_IDN_COUNT) {
> +        return QUERY_RESULT_INVALID_IDN;
> +    }
> +
> +    if (!(flag_permission[idn] & op)) {
> +        if (op =3D=3D UFS_QUERY_FLAG_READ) {
> +            trace_ufs_err_query_flag_not_readable(idn);
> +            return QUERY_RESULT_NOT_READABLE;
> +        }
> +        trace_ufs_err_query_flag_not_writable(idn);
> +        return QUERY_RESULT_NOT_WRITEABLE;
> +    }
> +
> +    return QUERY_RESULT_SUCCESS;
> +}
> +
> +static const int attr_permission[QUERY_ATTR_IDN_COUNT] =3D {
> +    /* booting is not supported */
> +    [QUERY_ATTR_IDN_BOOT_LU_EN] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_POWER_MODE] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_ACTIVE_ICC_LVL] =3D
> +        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
> +    [QUERY_ATTR_IDN_OOO_DATA_EN] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_BKOPS_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_PURGE_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_MAX_DATA_IN] =3D UFS_QUERY_ATTR_READ | UFS_QUERY_ATT=
R_WRITE,
> +    [QUERY_ATTR_IDN_MAX_DATA_OUT] =3D UFS_QUERY_ATTR_READ | UFS_QUERY_AT=
TR_WRITE,
> +    [QUERY_ATTR_IDN_DYN_CAP_NEEDED] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_REF_CLK_FREQ] =3D UFS_QUERY_ATTR_READ | UFS_QUERY_AT=
TR_WRITE,
> +    [QUERY_ATTR_IDN_CONF_DESC_LOCK] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_MAX_NUM_OF_RTT] =3D
> +        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
> +    [QUERY_ATTR_IDN_EE_CONTROL] =3D UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR=
_WRITE,
> +    [QUERY_ATTR_IDN_EE_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_SECONDS_PASSED] =3D UFS_QUERY_ATTR_WRITE,
> +    [QUERY_ATTR_IDN_CNTX_CONF] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_FFU_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_PSA_STATE] =3D UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_=
WRITE,
> +    [QUERY_ATTR_IDN_PSA_DATA_SIZE] =3D UFS_QUERY_ATTR_READ | UFS_QUERY_A=
TTR_WRITE,
> +    [QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_CASE_ROUGH_TEMP] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_HIGH_TEMP_BOUND] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_LOW_TEMP_BOUND] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_THROTTLING_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_WB_FLUSH_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE] =3D UFS_QUERY_ATTR_READ,
> +    /* refresh operation is not supported */
> +    [QUERY_ATTR_IDN_REFRESH_STATUS] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_REFRESH_FREQ] =3D UFS_QUERY_ATTR_READ,
> +    [QUERY_ATTR_IDN_REFRESH_UNIT] =3D UFS_QUERY_ATTR_READ,
> +};
> +
> +static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
> +{
> +    if (idn >=3D QUERY_ATTR_IDN_COUNT) {
> +        return QUERY_RESULT_INVALID_IDN;
> +    }
> +
> +    if (!(attr_permission[idn] & op)) {
> +        if (op =3D=3D UFS_QUERY_ATTR_READ) {
> +            trace_ufs_err_query_attr_not_readable(idn);
> +            return QUERY_RESULT_NOT_READABLE;
> +        }
> +        trace_ufs_err_query_attr_not_writable(idn);
> +        return QUERY_RESULT_NOT_WRITEABLE;
> +    }
> +
> +    return QUERY_RESULT_SUCCESS;
> +}
> +
> +static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
> +{
> +    UfsHc *u =3D req->hc;
> +    uint8_t idn =3D req->req_upiu.qr.idn;
> +    uint32_t value;
> +    QueryRespCode ret;
> +
> +    ret =3D ufs_flag_check_idn_valid(idn, op);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    value =3D *(((uint8_t *)&u->flags) + idn);
> +    if (idn =3D=3D QUERY_FLAG_IDN_FDEVICEINIT) {
> +        value =3D 0;
> +    } else if (op =3D=3D UFS_QUERY_FLAG_READ) {
> +        value =3D *(((uint8_t *)&u->flags) + idn);

This value was already loaded a few lines above.

> +    } else if (op =3D=3D UFS_QUERY_FLAG_SET) {
> +        value =3D 1;
> +    } else if (op =3D=3D UFS_QUERY_FLAG_CLEAR) {
> +        value =3D 0;
> +    } else if (op =3D=3D UFS_QUERY_FLAG_TOGGLE) {
> +        value =3D !value;
> +    } else {
> +        trace_ufs_err_query_invalid_opcode(op);
> +        return QUERY_RESULT_INVALID_OPCODE;
> +    }
> +
> +    *(((uint8_t *)&u->flags) + idn) =3D value;
> +    req->rsp_upiu.qr.value =3D cpu_to_be32(value);
> +    return QUERY_RESULT_SUCCESS;
> +}
> +
> +static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
> +{
> +    switch (idn) {
> +    case QUERY_ATTR_IDN_BOOT_LU_EN:
> +        return u->attributes.boot_lun_en;
> +    case QUERY_ATTR_IDN_POWER_MODE:
> +        return u->attributes.current_power_mode;
> +    case QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
> +        return u->attributes.active_icc_level;
> +    case QUERY_ATTR_IDN_OOO_DATA_EN:
> +        return u->attributes.out_of_order_data_en;
> +    case QUERY_ATTR_IDN_BKOPS_STATUS:
> +        return u->attributes.background_op_status;
> +    case QUERY_ATTR_IDN_PURGE_STATUS:
> +        return u->attributes.purge_status;
> +    case QUERY_ATTR_IDN_MAX_DATA_IN:
> +        return u->attributes.max_data_in_size;
> +    case QUERY_ATTR_IDN_MAX_DATA_OUT:
> +        return u->attributes.max_data_out_size;
> +    case QUERY_ATTR_IDN_DYN_CAP_NEEDED:
> +        return be32_to_cpu(u->attributes.dyn_cap_needed);
> +    case QUERY_ATTR_IDN_REF_CLK_FREQ:
> +        return u->attributes.ref_clk_freq;
> +    case QUERY_ATTR_IDN_CONF_DESC_LOCK:
> +        return u->attributes.config_descr_lock;
> +    case QUERY_ATTR_IDN_MAX_NUM_OF_RTT:
> +        return u->attributes.max_num_of_rtt;
> +    case QUERY_ATTR_IDN_EE_CONTROL:
> +        return be16_to_cpu(u->attributes.exception_event_control);
> +    case QUERY_ATTR_IDN_EE_STATUS:
> +        return be16_to_cpu(u->attributes.exception_event_status);
> +    case QUERY_ATTR_IDN_SECONDS_PASSED:
> +        return be32_to_cpu(u->attributes.seconds_passed);
> +    case QUERY_ATTR_IDN_CNTX_CONF:
> +        return be16_to_cpu(u->attributes.context_conf);
> +    case QUERY_ATTR_IDN_FFU_STATUS:
> +        return u->attributes.device_ffu_status;
> +    case QUERY_ATTR_IDN_PSA_STATE:
> +        return be32_to_cpu(u->attributes.psa_state);
> +    case QUERY_ATTR_IDN_PSA_DATA_SIZE:
> +        return u->attributes.psa_data_size;
> +    case QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME:
> +        return u->attributes.ref_clk_gating_wait_time;
> +    case QUERY_ATTR_IDN_CASE_ROUGH_TEMP:
> +        return u->attributes.device_case_rough_temperaure;
> +    case QUERY_ATTR_IDN_HIGH_TEMP_BOUND:
> +        return u->attributes.device_too_high_temp_boundary;
> +    case QUERY_ATTR_IDN_LOW_TEMP_BOUND:
> +        return u->attributes.device_too_low_temp_boundary;
> +    case QUERY_ATTR_IDN_THROTTLING_STATUS:
> +        return u->attributes.throttling_status;
> +    case QUERY_ATTR_IDN_WB_FLUSH_STATUS:
> +        return u->attributes.wb_buffer_flush_status;
> +    case QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE:
> +        return u->attributes.available_wb_buffer_size;
> +    case QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST:
> +        return u->attributes.wb_buffer_life_time_est;
> +    case QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE:
> +        return be32_to_cpu(u->attributes.current_wb_buffer_size);
> +    case QUERY_ATTR_IDN_REFRESH_STATUS:
> +        return u->attributes.refresh_status;
> +    case QUERY_ATTR_IDN_REFRESH_FREQ:
> +        return u->attributes.refresh_freq;
> +    case QUERY_ATTR_IDN_REFRESH_UNIT:
> +        return u->attributes.refresh_unit;
> +    }
> +    return 0;
> +}
> +
> +static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
> +{
> +    switch (idn) {
> +    case QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
> +        u->attributes.active_icc_level =3D value;
> +        break;
> +    case QUERY_ATTR_IDN_MAX_DATA_IN:
> +        u->attributes.max_data_in_size =3D value;
> +        break;
> +    case QUERY_ATTR_IDN_MAX_DATA_OUT:
> +        u->attributes.max_data_out_size =3D value;
> +        break;
> +    case QUERY_ATTR_IDN_REF_CLK_FREQ:
> +        u->attributes.ref_clk_freq =3D value;
> +        break;
> +    case QUERY_ATTR_IDN_MAX_NUM_OF_RTT:
> +        u->attributes.max_num_of_rtt =3D value;
> +        break;
> +    case QUERY_ATTR_IDN_EE_CONTROL:
> +        u->attributes.exception_event_control =3D cpu_to_be16(value);
> +        break;
> +    case QUERY_ATTR_IDN_SECONDS_PASSED:
> +        u->attributes.seconds_passed =3D cpu_to_be32(value);
> +        break;
> +    case QUERY_ATTR_IDN_PSA_STATE:
> +        u->attributes.psa_state =3D value;
> +        break;
> +    case QUERY_ATTR_IDN_PSA_DATA_SIZE:
> +        u->attributes.psa_data_size =3D cpu_to_be32(value);
> +        break;
> +    }
> +}
> +
> +static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
> +{
> +    UfsHc *u =3D req->hc;
> +    uint8_t idn =3D req->req_upiu.qr.idn;
> +    uint32_t value;
> +    QueryRespCode ret;
> +
> +    ret =3D ufs_attr_check_idn_valid(idn, op);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (op =3D=3D UFS_QUERY_ATTR_READ) {
> +        value =3D ufs_read_attr_value(u, idn);
> +    } else {
> +        value =3D be32_to_cpu(req->req_upiu.qr.value);
> +        ufs_write_attr_value(u, idn, value);
> +    }
> +
> +    req->rsp_upiu.qr.value =3D cpu_to_be32(value);
> +    return QUERY_RESULT_SUCCESS;
> +}
> +
> +static const RpmbUnitDescriptor rpmb_unit_desc =3D {
> +    .length =3D sizeof(RpmbUnitDescriptor),
> +    .descriptor_idn =3D 2,
> +    .unit_index =3D UFS_UPIU_RPMB_WLUN,
> +    .lu_enable =3D 0,
> +};
> +
> +static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
> +{
> +    uint8_t lun =3D req->req_upiu.qr.index;
> +
> +    if (lun !=3D UFS_UPIU_RPMB_WLUN && lun > UFS_MAX_LUS) {
> +        trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, lun);
> +        return QUERY_RESULT_INVALID_INDEX;
> +    }
> +
> +    if (lun =3D=3D UFS_UPIU_RPMB_WLUN) {
> +        memcpy(&req->rsp_upiu.qr.data, &rpmb_unit_desc, rpmb_unit_desc.l=
ength);
> +    } else {
> +        /* unit descriptor is not yet supported */
> +        return QUERY_RESULT_INVALID_INDEX;
> +    }
> +
> +    return QUERY_RESULT_SUCCESS;
> +}
> +
> +static const StringDescriptor manufacturer_str_desc =3D {
> +    .length =3D 0x12,
> +    .descriptor_idn =3D QUERY_DESC_IDN_STRING,
> +    .UC =3D { 'S', 'A', 'M', 'S', 'U', 'N', 'G' },

What is the endianness of these 16-bit characters? I noticed endianness
issues in several other places but will not audit the patch
exhaustively. Please review all guest-visible fields carefully and add
cpu_to_leXX()/cpu_to_beXX() where necessary.

> +};
> +
> +static const StringDescriptor product_name_str_desc =3D {
> +    .length =3D 0x22,
> +    .descriptor_idn =3D QUERY_DESC_IDN_STRING,
> +    .UC =3D { 'Q', 'E', 'M', 'U', '-', 'U', 'F', 'S' },
> +};
> +
> +static const StringDescriptor product_rev_level_str_desc =3D {
> +    .length =3D 0x0a,
> +    .descriptor_idn =3D QUERY_DESC_IDN_STRING,
> +    .UC =3D { '0', '0', '0', '1' },
> +};
> +
> +static const StringDescriptor null_str_desc =3D {
> +    .length =3D 0x02,
> +    .descriptor_idn =3D QUERY_DESC_IDN_STRING,
> +};
> +
> +static QueryRespCode ufs_read_string_desc(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    uint8_t index =3D req->req_upiu.qr.index;
> +    if (index =3D=3D u->device_desc.manufacturer_name) {
> +        memcpy(&req->rsp_upiu.qr.data, &manufacturer_str_desc,
> +               manufacturer_str_desc.length);
> +    } else if (index =3D=3D u->device_desc.product_name) {
> +        memcpy(&req->rsp_upiu.qr.data, &product_name_str_desc,
> +               product_name_str_desc.length);
> +    } else if (index =3D=3D u->device_desc.serial_number) {
> +        memcpy(&req->rsp_upiu.qr.data, &null_str_desc, null_str_desc.len=
gth);
> +    } else if (index =3D=3D u->device_desc.oem_id) {
> +        memcpy(&req->rsp_upiu.qr.data, &null_str_desc, null_str_desc.len=
gth);
> +    } else if (index =3D=3D u->device_desc.product_revision_level) {
> +        memcpy(&req->rsp_upiu.qr.data, &product_rev_level_str_desc,
> +               product_rev_level_str_desc.length);
> +    } else {
> +        trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, index=
);
> +        return QUERY_RESULT_INVALID_INDEX;
> +    }
> +    return QUERY_RESULT_SUCCESS;
> +}
> +
> +static const InterconnectDescriptor interconnect_desc =3D {
> +    .length =3D sizeof(InterconnectDescriptor),
> +    .descriptor_idn =3D QUERY_DESC_IDN_INTERCONNECT,
> +    .bcd_unipro_version =3D 0x180,
> +    .bcd_mphy_version =3D 0x410,

What is the endianness of these two 16-bit fields?

> +};
> +
> +static QueryRespCode ufs_read_desc(UfsRequest *req)
> +{
> +    UfsHc *u =3D req->hc;
> +    QueryRespCode status;
> +    uint8_t idn =3D req->req_upiu.qr.idn;
> +    uint16_t length =3D be16_to_cpu(req->req_upiu.qr.length);
> +
> +    switch (idn) {
> +    case QUERY_DESC_IDN_DEVICE:
> +        memcpy(&req->rsp_upiu.qr.data, &u->device_desc, sizeof(u->device=
_desc));
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    case QUERY_DESC_IDN_UNIT:
> +        status =3D ufs_read_unit_desc(req);
> +        break;
> +    case QUERY_DESC_IDN_GEOMETRY:
> +        memcpy(&req->rsp_upiu.qr.data, &u->geometry_desc,
> +               sizeof(u->geometry_desc));
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    case QUERY_DESC_IDN_INTERCONNECT: {
> +        memcpy(&req->rsp_upiu.qr.data, &interconnect_desc,
> +               sizeof(interconnect_desc));
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    }
> +    case QUERY_DESC_IDN_STRING:
> +        status =3D ufs_read_string_desc(req);
> +        break;
> +    case QUERY_DESC_IDN_POWER:
> +        /* mocking of power descriptor is not supported */
> +        memset(&req->rsp_upiu.qr.data, 0, sizeof(PowerParametersDescript=
or));
> +        req->rsp_upiu.qr.data[0] =3D sizeof(PowerParametersDescriptor);
> +        req->rsp_upiu.qr.data[1] =3D QUERY_DESC_IDN_POWER;
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    case QUERY_DESC_IDN_HEALTH:
> +        /* mocking of health descriptor is not supported */
> +        memset(&req->rsp_upiu.qr.data, 0, sizeof(DeviceHealthDescriptor)=
);
> +        req->rsp_upiu.qr.data[0] =3D sizeof(DeviceHealthDescriptor);
> +        req->rsp_upiu.qr.data[1] =3D QUERY_DESC_IDN_HEALTH;
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    default:
> +        length =3D 0;
> +        trace_ufs_err_query_invalid_idn(req->req_upiu.qr.opcode, idn);
> +        status =3D QUERY_RESULT_INVALID_IDN;
> +    }
> +
> +    if (length > req->rsp_upiu.qr.data[0]) {
> +        length =3D req->rsp_upiu.qr.data[0];
> +    }
> +    req->rsp_upiu.qr.opcode =3D req->req_upiu.qr.opcode;
> +    req->rsp_upiu.qr.idn =3D req->req_upiu.qr.idn;
> +    req->rsp_upiu.qr.index =3D req->req_upiu.qr.index;
> +    req->rsp_upiu.qr.selector =3D req->req_upiu.qr.selector;
> +    req->rsp_upiu.qr.length =3D cpu_to_be16(length);
> +
> +    return status;
> +}
> +
> +static QueryRespCode ufs_exec_query_read(UfsRequest *req)
> +{
> +    QueryRespCode status;
> +    switch (req->req_upiu.qr.opcode) {
> +    case UPIU_QUERY_OPCODE_NOP:
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    case UPIU_QUERY_OPCODE_READ_DESC:
> +        status =3D ufs_read_desc(req);
> +        break;
> +    case UPIU_QUERY_OPCODE_READ_ATTR:
> +        status =3D ufs_exec_query_attr(req, UFS_QUERY_ATTR_READ);
> +        break;
> +    case UPIU_QUERY_OPCODE_READ_FLAG:
> +        status =3D ufs_exec_query_flag(req, UFS_QUERY_FLAG_READ);
> +        break;
> +    default:
> +        trace_ufs_err_query_invalid_opcode(req->req_upiu.qr.opcode);
> +        status =3D QUERY_RESULT_INVALID_OPCODE;
> +        break;
> +    }
> +
> +    return status;
> +}
> +
> +static QueryRespCode ufs_exec_query_write(UfsRequest *req)
> +{
> +    QueryRespCode status;
> +    switch (req->req_upiu.qr.opcode) {
> +    case UPIU_QUERY_OPCODE_NOP:
> +        status =3D QUERY_RESULT_SUCCESS;
> +        break;
> +    case UPIU_QUERY_OPCODE_WRITE_DESC:
> +        /* write descriptor is not supported */
> +        status =3D QUERY_RESULT_NOT_WRITEABLE;
> +        break;
> +    case UPIU_QUERY_OPCODE_WRITE_ATTR:
> +        status =3D ufs_exec_query_attr(req, UFS_QUERY_ATTR_WRITE);
> +        break;
> +    case UPIU_QUERY_OPCODE_SET_FLAG:
> +        status =3D ufs_exec_query_flag(req, UFS_QUERY_FLAG_SET);
> +        break;
> +    case UPIU_QUERY_OPCODE_CLEAR_FLAG:
> +        status =3D ufs_exec_query_flag(req, UFS_QUERY_FLAG_CLEAR);
> +        break;
> +    case UPIU_QUERY_OPCODE_TOGGLE_FLAG:
> +        status =3D ufs_exec_query_flag(req, UFS_QUERY_FLAG_TOGGLE);
> +        break;
> +    default:
> +        trace_ufs_err_query_invalid_opcode(req->req_upiu.qr.opcode);
> +        status =3D QUERY_RESULT_INVALID_OPCODE;
> +        break;
> +    }
> +
> +    return status;
> +}
> +
> +static UfsReqResult ufs_exec_query_cmd(UfsRequest *req)
> +{
> +    uint8_t query_func =3D req->req_upiu.header.query_func;
> +    uint16_t data_segment_length;
> +    QueryRespCode status;
> +
> +    trace_ufs_exec_query_cmd(req->slot, req->req_upiu.qr.opcode);
> +    if (query_func =3D=3D UPIU_QUERY_FUNC_STANDARD_READ_REQUEST) {
> +        status =3D ufs_exec_query_read(req);
> +    } else if (query_func =3D=3D UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST)=
 {
> +        status =3D ufs_exec_query_write(req);
> +    } else {
> +        status =3D QUERY_RESULT_GENERAL_FAILURE;
> +    }
> +
> +    data_segment_length =3D be16_to_cpu(req->rsp_upiu.qr.length);
> +    ufs_build_upiu_header(req, UPIU_TRANSACTION_QUERY_RSP, 0, status, 0,
> +                          data_segment_length);
> +
> +    if (status !=3D QUERY_RESULT_SUCCESS) {
> +        return UFS_REQUEST_ERROR;
> +    }
> +    return UFS_REQUEST_SUCCESS;
> +}
> +
> +static void ufs_exec_req(UfsRequest *req)
> +{
> +    UfsReqResult req_result;
> +
> +    if (ufs_dma_read_upiu(req)) {
> +        return;
> +    }
> +
> +    switch (req->req_upiu.header.trans_type) {
> +    case UPIU_TRANSACTION_NOP_OUT:
> +        req_result =3D ufs_exec_nop_cmd(req);
> +        break;
> +    case UPIU_TRANSACTION_COMMAND:
> +        /* Not yet implemented */
> +        req_result =3D UFS_REQUEST_ERROR;
> +        break;
> +    case UPIU_TRANSACTION_QUERY_REQ:
> +        req_result =3D ufs_exec_query_cmd(req);
> +        break;
> +    default:
> +        trace_ufs_err_invalid_trans_code(req->slot,
> +                                         req->req_upiu.header.trans_type=
);
> +        req_result =3D UFS_REQUEST_ERROR;
> +    }
> +
> +    ufs_complete_req(req, req_result);
> +}
> +
> +static void ufs_process_req(void *opaque)
> +{
> +    UfsHc *u =3D opaque;
> +    UfsRequest *req;
> +    int slot;
> +
> +    for (slot =3D 0; slot < u->params.nutrs; slot++) {
> +        req =3D &u->req_list[slot];
> +
> +        if (req->state !=3D UFS_REQUEST_READY) {
> +            continue;
> +        }
> +        trace_ufs_process_req(slot);
> +        req->state =3D UFS_REQUEST_RUNNING;
> +
> +        ufs_exec_req(req);
> +    }
> +}
> +
> +static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
> +{
> +    UfsHc *u =3D req->hc;
> +    assert(req->state =3D=3D UFS_REQUEST_RUNNING);
> +
> +    if (req_result =3D=3D UFS_REQUEST_SUCCESS) {
> +        req->utrd.header.dword_2 =3D OCS_SUCCESS;
> +    } else {
> +        req->utrd.header.dword_2 =3D OCS_INVALID_CMD_TABLE_ATTR;
> +    }

How does byte-swapping work in your patch series? This looks like native
endian but it should be little-endian.

> +
> +    trace_ufs_complete_req(req->slot);
> +    req->state =3D UFS_REQUEST_COMPLETE;
> +    qemu_bh_schedule(u->complete_bh);
> +}
> +
> +static void ufs_clear_req(UfsRequest *req)
> +{
> +    if (req->sg !=3D NULL) {
> +        qemu_sglist_destroy(req->sg);
> +        g_free(req->sg);
> +        req->sg =3D NULL;
> +    }
> +
> +    memset(&req->utrd, 0, sizeof(req->utrd));
> +    memset(&req->req_upiu, 0, sizeof(req->req_upiu));
> +    memset(&req->rsp_upiu, 0, sizeof(req->rsp_upiu));
> +}
> +
> +static void ufs_sendback_req(void *opaque)
> +{
> +    UfsHc *u =3D opaque;
> +    UfsRequest *req;
> +    int slot;
> +
> +    for (slot =3D 0; slot < u->params.nutrs; slot++) {
> +        uint32_t is =3D ldl_le_p(&u->reg.is);
> +        uint32_t utrldbr =3D ldl_le_p(&u->reg.utrldbr);
> +        uint32_t utrlcnr =3D ldl_le_p(&u->reg.utrlcnr);
> +
> +        req =3D &u->req_list[slot];
> +
> +        if (req->state !=3D UFS_REQUEST_COMPLETE) {
> +            continue;
> +        }
> +
> +        if (ufs_dma_write_upiu(req)) {
> +            continue;

Does this error handling work? It looks to me like a failed DMA
transaction will repeat every time ufs_sendback_req() is called instead
of stopping the request (changing req->state).

> +        }
> +
> +        /*
> +         * TODO: UTP Transfer Request Interrupt Aggregation Control is n=
ot yet
> +         * supported
> +         */
> +        if (req->utrd.header.dword_2 !=3D OCS_SUCCESS ||
> +            req->utrd.header.dword_0 & UTP_REQ_DESC_INT_CMD) {
> +            is =3D FIELD_DP32(is, IS, UTRCS, 1);
> +        }
> +
> +        utrldbr &=3D ~(1 << slot);
> +        utrlcnr |=3D (1 << slot);
> +
> +        stl_le_p(&u->reg.is, is);
> +        stl_le_p(&u->reg.utrldbr, utrldbr);
> +        stl_le_p(&u->reg.utrlcnr, utrlcnr);
> +
> +        trace_ufs_sendback_req(req->slot);
> +
> +        ufs_clear_req(req);
> +        req->state =3D UFS_REQUEST_IDLE;
> +    }
> +
> +    ufs_irq_check(u);
> +}
> +
>  static bool ufs_check_constraints(UfsHc *u, Error **errp)
>  {
>      if (u->params.nutrs > UFS_MAX_NUTRS) {
> @@ -232,6 +1118,23 @@ static void ufs_init_pci(UfsHc *u, PCIDevice *pci_d=
ev)
>      u->irq =3D pci_allocate_irq(pci_dev);
>  }
> =20
> +static void ufs_init_state(UfsHc *u)
> +{
> +    u->req_list =3D g_new0(UfsRequest, u->params.nutrs);
> +
> +    for (int i =3D 0; i < u->params.nutrs; i++) {
> +        u->req_list[i].hc =3D u;
> +        u->req_list[i].slot =3D i;
> +        u->req_list[i].sg =3D NULL;
> +        u->req_list[i].state =3D UFS_REQUEST_IDLE;
> +    }
> +
> +    u->doorbell_bh =3D qemu_bh_new_guarded(ufs_process_req, u,
> +                                         &DEVICE(u)->mem_reentrancy_guar=
d);
> +    u->complete_bh =3D qemu_bh_new_guarded(ufs_sendback_req, u,
> +                                         &DEVICE(u)->mem_reentrancy_guar=
d);
> +}
> +
>  static void ufs_init_hc(UfsHc *u)
>  {
>      uint32_t cap =3D 0;
> @@ -249,6 +1152,54 @@ static void ufs_init_hc(UfsHc *u)
>      cap =3D FIELD_DP32(cap, CAP, CS, 0);
>      stl_le_p(&u->reg.cap, cap);
>      stl_le_p(&u->reg.ver, UFS_SPEC_VER);
> +
> +    memset(&u->device_desc, 0, sizeof(DeviceDescriptor));
> +    u->device_desc.length =3D sizeof(DeviceDescriptor);
> +    u->device_desc.descriptor_idn =3D QUERY_DESC_IDN_DEVICE;
> +    u->device_desc.device_sub_class =3D 0x01;
> +    u->device_desc.number_lu =3D 0x00;
> +    u->device_desc.number_wlu =3D 0x04;
> +    /* TODO: Revisit it when Power Management is implemented */
> +    u->device_desc.init_power_mode =3D 0x01; /* Active Mode */
> +    u->device_desc.high_priority_lun =3D 0x7F; /* Same Priority */
> +    u->device_desc.spec_version =3D cpu_to_be16(0x0310);

Can UFS_SPEC_VER be used here instead of hardcoding a magic number?

> +    u->device_desc.manufacturer_name =3D 0x00;
> +    u->device_desc.product_name =3D 0x01;
> +    u->device_desc.serial_number =3D 0x02;
> +    u->device_desc.oem_id =3D 0x03;
> +    u->device_desc.ud_0_base_offset =3D 0x16;
> +    u->device_desc.ud_config_p_length =3D 0x1A;
> +    u->device_desc.device_rtt_cap =3D 0x02;
> +    u->device_desc.queue_depth =3D u->params.nutrs;
> +    u->device_desc.product_revision_level =3D 0x04;
> +    u->device_desc.extended_ufs_features_support =3D 0x00;
> +
> +    memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
> +    u->geometry_desc.length =3D sizeof(GeometryDescriptor);
> +    u->geometry_desc.descriptor_idn =3D QUERY_DESC_IDN_GEOMETRY;
> +    u->geometry_desc.total_raw_device_capacity =3D 0;
> +    u->geometry_desc.max_number_lu =3D (UFS_MAX_LUS =3D=3D 32) ? 0x1 : 0=
x0;
> +    u->geometry_desc.segment_size =3D cpu_to_be32(0x2000); /* 4KB */
> +    u->geometry_desc.allocation_unit_size =3D 0x1; /* 4KB */
> +    u->geometry_desc.min_addr_block_size =3D 0x8; /* 4KB */
> +    u->geometry_desc.max_in_buffer_size =3D 0x8;
> +    u->geometry_desc.max_out_buffer_size =3D 0x8;
> +    u->geometry_desc.rpmb_read_write_size =3D 0x40;
> +    u->geometry_desc.data_ordering =3D
> +        0x0; /* out-of-order data transfer is not supported */
> +    u->geometry_desc.max_context_id_number =3D 0x5;
> +    u->geometry_desc.supported_memory_types =3D cpu_to_be16(0x8001);
> +
> +    memset(&u->attributes, 0, sizeof(u->attributes));
> +    u->attributes.max_data_in_size =3D 0x08;
> +    u->attributes.max_data_out_size =3D 0x08;
> +    u->attributes.ref_clk_freq =3D 0x01; /* 26 MHz */
> +    /* configure descriptor is not supported */
> +    u->attributes.config_descr_lock =3D 0x01;
> +    u->attributes.max_num_of_rtt =3D 0x02;
> +
> +    memset(&u->flags, 0, sizeof(u->flags));
> +    u->flags.permanently_disable_fw_update =3D 1;
>  }
> =20
>  static void ufs_realize(PCIDevice *pci_dev, Error **errp)
> @@ -259,10 +1210,24 @@ static void ufs_realize(PCIDevice *pci_dev, Error =
**errp)
>          return;
>      }
> =20
> +    ufs_init_state(u);
>      ufs_init_hc(u);
>      ufs_init_pci(u, pci_dev);
>  }
> =20
> +static void ufs_exit(PCIDevice *pci_dev)
> +{
> +    UfsHc *u =3D UFS(pci_dev);
> +
> +    qemu_bh_delete(u->doorbell_bh);
> +    qemu_bh_delete(u->complete_bh);
> +
> +    for (int i =3D 0; i < u->params.nutrs; i++) {
> +        ufs_clear_req(&u->req_list[i]);
> +    }
> +    g_free(u->req_list);
> +}
> +
>  static Property ufs_props[] =3D {
>      DEFINE_PROP_STRING("serial", UfsHc, params.serial),
>      DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
> @@ -281,6 +1246,7 @@ static void ufs_class_init(ObjectClass *oc, void *da=
ta)
>      PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(oc);
> =20
>      pc->realize =3D ufs_realize;
> +    pc->exit =3D ufs_exit;
>      pc->class_id =3D PCI_CLASS_STORAGE_UFS;
> =20
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index 3c28f4e62d..5d4fd818f9 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -18,6 +18,31 @@
>  #define UFS_MAX_LUS 32
>  #define UFS_LOGICAL_BLK_SIZE 4096
> =20
> +typedef enum UfsRequestState {
> +    UFS_REQUEST_IDLE =3D 0,
> +    UFS_REQUEST_READY =3D 1,
> +    UFS_REQUEST_RUNNING =3D 2,
> +    UFS_REQUEST_COMPLETE =3D 3,
> +} UfsRequestState;
> +
> +typedef enum UfsReqResult {
> +    UFS_REQUEST_SUCCESS =3D 0,
> +    UFS_REQUEST_ERROR =3D 1,
> +} UfsReqResult;
> +
> +typedef struct UfsRequest {
> +    struct UfsHc *hc;
> +    UfsRequestState state;
> +    int slot;
> +
> +    UtpTransferReqDesc utrd;
> +    UtpUpiuReq req_upiu;
> +    UtpUpiuRsp rsp_upiu;
> +
> +    /* for scsi command */
> +    QEMUSGList *sg;
> +} UfsRequest;
> +
>  typedef struct UfsParams {
>      char *serial;
>      uint8_t nutrs; /* Number of UTP Transfer Request Slots */
> @@ -30,6 +55,12 @@ typedef struct UfsHc {
>      UfsReg reg;
>      UfsParams params;
>      uint32_t reg_size;
> +    UfsRequest *req_list;
> +
> +    DeviceDescriptor device_desc;
> +    GeometryDescriptor geometry_desc;
> +    Attributes attributes;
> +    Flags flags;
> =20
>      qemu_irq irq;
>      QEMUBH *doorbell_bh;
> @@ -39,4 +70,18 @@ typedef struct UfsHc {
>  #define TYPE_UFS "ufs"
>  #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
> =20
> +typedef enum UfsQueryFlagPerm {
> +    UFS_QUERY_FLAG_NONE =3D 0x0,
> +    UFS_QUERY_FLAG_READ =3D 0x1,
> +    UFS_QUERY_FLAG_SET =3D 0x2,
> +    UFS_QUERY_FLAG_CLEAR =3D 0x4,
> +    UFS_QUERY_FLAG_TOGGLE =3D 0x8,
> +} UfsQueryFlagPerm;
> +
> +typedef enum UfsQueryAttrPerm {
> +    UFS_QUERY_ATTR_NONE =3D 0x0,
> +    UFS_QUERY_ATTR_READ =3D 0x1,
> +    UFS_QUERY_ATTR_WRITE =3D 0x2,
> +} UfsQueryAttrPerm;
> +
>  #endif /* HW_UFS_UFS_H */
> --=20
> 2.34.1
>=20

--iGIX2l0JKczoxyCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQANEACgkQnKSrs4Gr
c8gazwf/YQXHQ1ygG0cgJvU741hHj3ufC1SC1OL3xK69q45BjWIxTLZI5Ee33weN
HdHc9A+ApCuUsMn4A9XB6+SkqE2yU7G4nTGVaV3mJLkiXRSD7kGBUDS7ipuiKybR
q4yF+3LcbHeBghMn7993IP44p4+uaQK9R04LvLI6A1TbDr6+hsUInuqOGICAqzur
Bla+l30EcL2Bmqbi/jTfkiW8NHXHwlk5KfwauILSe9GDVe+unTF0zPS4j2r/hHzG
JMTUidhzUAdM9b2jkseG5akWxM5zv1C1H718Enteb3NzvizMy8toSUKBLIfG5b6H
f82LgzjcjmavmanDxnLBzLbf0KhKlQ==
=nNVK
-----END PGP SIGNATURE-----

--iGIX2l0JKczoxyCA--


