Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB66E73556A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 13:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCgo-0001kk-21; Mon, 19 Jun 2023 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qBCgM-0001jD-ME
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 07:04:28 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qBCgH-0000iI-Nx
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 07:04:26 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230619110418epoutp021f21cb29a3d1f69db62222366149412e~qCpfujcTV2683426834epoutp02r
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 11:04:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230619110418epoutp021f21cb29a3d1f69db62222366149412e~qCpfujcTV2683426834epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1687172658;
 bh=/SmOys3ND9c26Sg25ZTsO3CHo6G2saD7o+/jKy3nvo0=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=i4FJZnXpxRvY48I5jDUpjA3ypKw3K0TNzwf2a3n3IAADzbYMuNCeNsqFSZjlO0ekF
 448YOwLIRYIP67Zz3h6TedcwQ8bderFtdNelyjU84RjnFdoD8+MQeYTQmBa1gihPUs
 47EGoFcdOg6C/xN8yIGb6aZZdBXVHAF5ctBF8jUw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230619110417epcas2p3cc177166a16f6a0a5c2e09f725773c34~qCpfG--Fc0300203002epcas2p3X;
 Mon, 19 Jun 2023 11:04:17 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Ql6N04XGzz4x9Pp; Mon, 19 Jun
 2023 11:04:16 +0000 (GMT)
X-AuditID: b6c32a47-c2bfa70000007f5e-8e-649036307964
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.BC.32606.03630946; Mon, 19 Jun 2023 20:04:16 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 2/3] hw/ufs: Support for Query Transfer Requests
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Klaus
 Birkelund Jensen <k.jensen@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230619071633.GA2497337@fedora>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230619110416epcms2p2a0488024f5a2805407f58ae3f67fc966@epcms2p2>
Date: Mon, 19 Jun 2023 20:04:16 +0900
X-CMS-MailID: 20230619110416epcms2p2a0488024f5a2805407f58ae3f67fc966
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTXNfAbEKKwZy/MhYvD2laXNl/ntHi
 wd1+RouTjXtYLZZcTLXYv+0fq8Wsd+1sFsd7d7BYvJ70n9WB0+PHuXY2jyfXNjN5vN93lc2j
 b8sqxgCWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
 HKBTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYG
 RqZAhQnZGWsvbWQveHiRqeLNxSVMDYyNjUxdjJwcEgImEn0Pm1i6GLk4hAR2MErs3djG2sXI
 wcErICjxd4cwSI2wgLvEyp2XWEBsIQEFiTnbOtgh4poS09dPZAIpZxNQlzi90BzEFAEK3+gW
 BJnILLCbSaL1ynRGiFW8EjPan7JA2NIS25dvBYtzCuhJbJrwih0iriHxY1kvM4QtKnFz9Vt2
 GPv9sflQc0QkWu+dhaoRlHjwczdUXFLi1LfHrBD2dEaJBf9NQY6QEFjAKPGreTpUg77EtY6N
 YEfwCvhKPL78jQ3EZhFQlZiyuYkNosZF4sLaT2A2s4C8xPa3c5hBHmMGemz9Ln0QU0JAWeLI
 LRaICj6JjsN/2WFebNj4Gyt7x7wn0BBXkVjcfJh1AqPyLEQ4z0KyaxbCrgWMzKsYxVILinPT
 U4uNCozhkZucn7uJEZwqtdx3MM54+0HvECMTB+MhRgkOZiUR3qC9fSlCvCmJlVWpRfnxRaU5
 qcWHGE2BvpzILCWanA9M1nkl8YYmlgYmZmaG5kamBuZK4rzLHvamCAmkJ5akZqemFqQWwfQx
 cXBKNTA5Cui6TZVw2S8fsb5NxLE9QTnfsXp1mcvirHwNVhbvV2tL6iRm8/msjBeUOfePNXWH
 kPbttOt13dK5/n+Yb848Ozs/MO6JeN8516aWKktngXK+hM9Tpvw5OOumlIf669dRK9X0M/aE
 RNb+OtFSPKHsU+70DQznt5/fx9owsbsov1KoMNr49qpCFdt2liDVVxXLJV9d/97PqfvSVVPr
 rZH7jndN95bv2/6dV3UnT75azPHw++8evZXekXc839V8Uva91Gv9a2bueT1d6bj7nm0vvn9+
 mrPk99qwkyulNnt9ydue8MrF19PXY2G72Od3jP7XE5Za3ZVqtHwlry9f+O2J/8kdctt3ux3Y
 zrxn2WMlluKMREMt5qLiRAB77wcjHgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230616065825epcms2p5682ea0edcd1fb0366a344708bea875cb
References: <20230619071633.GA2497337@fedora>
 <20230616065825epcms2p5682ea0edcd1fb0366a344708bea875cb@epcms2p5>
 <CGME20230616065825epcms2p5682ea0edcd1fb0366a344708bea875cb@epcms2p2>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 19, 2023, Stefan Hajnoczi wrote:
>On Fri, Jun 16, 2023 at 03:58:25PM +0900, Jeuk Kim wrote:
>> This commit makes the UFS device support query
>> and nop out transfer requests.
>> 
>> The next patch would be support for UFS logical
>> unit and scsi command transfer request.
>> 
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>  hw/ufs/ufs.c | 968 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  hw/ufs/ufs.h |  45 +++
>>  2 files changed, 1012 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
>> index 9dba1073a8..10ecc8cd7b 100644
>> --- a/hw/ufs/ufs.c
>> +++ b/hw/ufs/ufs.c
>> @@ -19,6 +19,233 @@
>>  #define UFS_MAX_NUTRS 32
>>  #define UFS_MAX_NUTMRS 8
>>  
>> +static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
>> +{
>> +    uint32_t cap = ldl_le_p(&u->reg.cap);
>> +    hwaddr hi = addr + size - 1;
>> +
>> +    if (hi < addr) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }
>> +
>> +    if (!FIELD_EX32(cap, CAP, 64AS) && (hi >> 32)) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }
>> +
>> +    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
>> +}
>> +
>> +static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
>> +                                  int size)
>> +{
>> +    uint32_t cap = ldl_le_p(&u->reg.cap);
>> +    hwaddr hi = addr + size - 1;
>> +    if (hi < addr) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }
>> +
>> +    if (!FIELD_EX32(cap, CAP, 64AS) && (hi >> 32)) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }
>> +
>> +    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
>> +}
>> +
>> +static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
>> +
>> +static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
>> +{
>> +    uint32_t utrlba = ldl_le_p(&u->reg.utrlba);
>> +    uint32_t utrlbau = ldl_le_p(&u->reg.utrlbau);
>> +    hwaddr utrl_base_addr = (((hwaddr)utrlbau) << 32) + utrlba;
>> +    hwaddr utrd_addr = utrl_base_addr + slot * sizeof(UtpTransferReqDesc);
>> +
>> +    return utrd_addr;
>> +}
>> +
>> +static inline hwaddr ufs_get_req_upiu_base_addr(const UtpTransferReqDesc *utrd)
>> +{
>> +    uint32_t cmd_desc_base_addr_lo =
>> +        le32_to_cpu(utrd->command_desc_base_addr_lo);
>> +    uint32_t cmd_desc_base_addr_hi =
>> +        le32_to_cpu(utrd->command_desc_base_addr_hi);
>> +
>> +    return (((hwaddr)cmd_desc_base_addr_hi) << 32) + cmd_desc_base_addr_lo;
>> +}
>> +
>> +static inline hwaddr ufs_get_rsp_upiu_base_addr(const UtpTransferReqDesc *utrd)
>> +{
>> +    hwaddr req_upiu_base_addr = ufs_get_req_upiu_base_addr(utrd);
>> +    uint32_t rsp_upiu_byte_off =
>> +        le16_to_cpu(utrd->response_upiu_offset) * sizeof(uint32_t);
>> +    return req_upiu_base_addr + rsp_upiu_byte_off;
>> +}
>> +
>> +static MemTxResult ufs_dma_read_utrd(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    hwaddr utrd_addr = ufs_get_utrd_addr(u, req->slot);
>> +    MemTxResult ret;
>> +
>> +    ret = ufs_addr_read(u, utrd_addr, &req->utrd, sizeof(req->utrd));
>> +    if (ret) {
>> +        trace_ufs_err_dma_read_utrd(req->slot, utrd_addr);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    hwaddr req_upiu_base_addr = ufs_get_req_upiu_base_addr(&req->utrd);
>> +    UtpUpiuReq *req_upiu = &req->req_upiu;
>> +    uint32_t copy_size;
>> +    uint16_t data_segment_length;
>> +    MemTxResult ret;
>> +
>> +    /*
>> +     * To know the size of the req_upiu, we need to read the
>> +     * data_segment_length in the header first.
>> +     */
>> +    ret = ufs_addr_read(u, req_upiu_base_addr, &req_upiu->header,
>> +                        sizeof(UtpUpiuHeader));
>> +    if (ret) {
>> +        trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
>> +        return ret;
>> +    }
>> +    data_segment_length = be16_to_cpu(req_upiu->https://protect2.fireeye.com/v1/url?k=62228ed9-3dbea7f3-62230596-000babe598f7-b6885126c3989767&q=1&e=d20f362c-c592-4425-86c7-2f65b07a0d0e&u=http%3A%2F%2Fheader.data%2F_segment_length);
>> +
>> +    copy_size = sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
>> +                data_segment_length;
>> +
>> +    ret = ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_size);
>> +    if (ret) {
>> +        trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    uint16_t prdt_len = le16_to_cpu(req->utrd.prd_table_length);
>> +    uint16_t prdt_byte_off =
>> +        le16_to_cpu(req->utrd.prd_table_offset) * sizeof(uint32_t);
>> +    uint32_t prdt_size = prdt_len * sizeof(UfshcdSgEntry);
>> +    UfshcdSgEntry *prd_entries;
>> +    hwaddr req_upiu_base_addr, prdt_base_addr;
>> +    int err;
>> +
>> +    assert(!req->sg);
>> +
>> +    if (prdt_len == 0) {
>> +        return MEMTX_OK;
>> +    }
>> +
>> +    prd_entries = g_new(UfshcdSgEntry, prdt_size);
>> +    if (!prd_entries) {
>> +        trace_ufs_err_memory_allocation();
>> +        return MEMTX_ERROR;
>> +    }
>> +
>> +    req_upiu_base_addr = ufs_get_req_upiu_base_addr(&req->utrd);
>> +    prdt_base_addr = req_upiu_base_addr + prdt_byte_off;
>> +
>> +    err = ufs_addr_read(u, prdt_base_addr, prd_entries, prdt_size);
>> +    if (err) {
>> +        trace_ufs_err_dma_read_prdt(req->slot, prdt_base_addr);
>> +        return err;
>
>prd_entries is leaked. I suggest using g_autofree to avoid manual
>g_free() calls in return paths.
>

Thanks, I'll fix it to use g_autofree.

>> +    }
>> +
>> +    req->sg = g_malloc0(sizeof(QEMUSGList));
>> +    if (!req->sg) {
>> +        trace_ufs_err_memory_allocation();
>> +        g_free(prd_entries);
>> +        return MEMTX_ERROR;
>> +    }
>> +    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
>> +
>> +    for (uint16_t i = 0; i < prdt_len; ++i) {
>> +        hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
>> +        int32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
>> +        qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
>> +    }
>> +    g_free(prd_entries);
>> +
>> +    return MEMTX_OK;
>> +}
>> +
>> +static MemTxResult ufs_dma_read_upiu(UfsRequest *req)
>> +{
>> +    MemTxResult ret;
>> +
>> +    ret = ufs_dma_read_utrd(req);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    ret = ufs_dma_read_req_upiu(req);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    ret = ufs_dma_read_prdt(req);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static MemTxResult ufs_dma_write_utrd(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    hwaddr utrd_addr = ufs_get_utrd_addr(u, req->slot);
>> +    MemTxResult ret;
>> +
>> +    ret = ufs_addr_write(u, utrd_addr, &req->utrd, sizeof(req->utrd));
>> +    if (ret) {
>> +        trace_ufs_err_dma_write_utrd(req->slot, utrd_addr);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    hwaddr rsp_upiu_base_addr = ufs_get_rsp_upiu_base_addr(&req->utrd);
>> +    uint32_t rsp_upiu_byte_len =
>> +        le16_to_cpu(req->utrd.response_upiu_length) * sizeof(uint32_t);
>> +    uint16_t data_segment_length =
>> +        be16_to_cpu(req->rsp_upiu.header.data_segment_length);
>> +    uint32_t copy_size = sizeof(UtpUpiuHeader) +
>> +                         UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
>> +                         data_segment_length;
>> +    MemTxResult ret;
>> +
>> +    if (copy_size > rsp_upiu_byte_len) {
>> +        copy_size = rsp_upiu_byte_len;
>> +    }
>> +
>> +    ret = ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_size);
>> +    if (ret) {
>> +        trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
>> +{
>> +    MemTxResult ret;
>> +
>> +    ret = ufs_dma_write_rsp_upiu(req);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    return ufs_dma_write_utrd(req);
>> +}
>> +
>>  static void ufs_irq_check(UfsHc *u)
>>  {
>>      PCIDevice *pci = PCI_DEVICE(u);
>> @@ -34,6 +261,36 @@ static void ufs_irq_check(UfsHc *u)
>>      }
>>  }
>>  
>> +static void ufs_process_db(UfsHc *u, uint64_t val)
>> +{
>> +    uint32_t slot;
>> +    uint32_t nutrs = u->params.nutrs;
>> +    uint32_t utrldbr = ldl_le_p(&u->reg.utrldbr);
>> +    UfsRequest *req;
>> +
>> +    val &= ~utrldbr;
>> +    if (!val) {
>> +        return;
>> +    }
>> +    stl_le_p(&u->reg.utrldbr, utrldbr | val);
>> +
>> +    slot = find_first_bit(&val, nutrs);
>> +
>> +    while (slot < nutrs) {
>> +        req = &u->req_list[slot];
>> +        if (req->state != UFS_REQUEST_IDLE) {
>> +            trace_ufs_err_utrl_slot_busy(req->slot);
>> +            return;
>> +        }
>> +
>> +        trace_ufs_process_db(slot);
>> +        req->state = UFS_REQUEST_READY;
>> +        slot = find_next_bit(&val, nutrs, slot + 1);
>> +    }
>> +
>> +    qemu_bh_schedule(u->doorbell_bh);
>> +}
>> +
>>  static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
>>  {
>>      uint32_t is = ldl_le_p(&u->reg.is);
>> @@ -85,6 +342,7 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
>>      uint32_t is = ldl_le_p(&u->reg.is);
>>      uint32_t hcs = ldl_le_p(&u->reg.hcs);
>>      uint32_t hce = ldl_le_p(&u->reg.hce);
>> +    uint32_t utrldbr = ldl_le_p(&u->reg.utrldbr);
>>      uint32_t utrlcnr = ldl_le_p(&u->reg.utrlcnr);
>>      uint32_t utrlba, utmrlba;
>>  
>> @@ -119,7 +377,9 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
>>          stl_le_p(&u->reg.utrlbau, data);
>>          break;
>>      case A_UTRLDBR:
>> -        /* Not yet supported */
>> +        ufs_process_db(u, data);
>> +        utrldbr |= data;
>> +        stl_le_p(&u->reg.utrldbr, utrldbr);
>>          break;
>>      case A_UTRLRSR:
>>          stl_le_p(&u->reg.utrlrsr, data);
>> @@ -199,6 +459,632 @@ static const MemoryRegionOps ufs_mmio_ops = {
>>      },
>>  };
>>  
>> +static void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type,
>> +                                  uint8_t flags, uint8_t response,
>> +                                  uint8_t scsi_status,
>> +                                  uint16_t data_segment_length)
>> +{
>> +    memcpy(&req->rsp_upiu.header, &req->req_upiu.header, sizeof(UtpUpiuHeader));
>> +    req->rsp_upiu.header.trans_type = trans_type;
>> +    req->rsp_upiu.header.flags = flags;
>> +    req->rsp_upiu.header.response = response;
>> +    req->rsp_upiu.header.scsi_status = scsi_status;
>> +    req->rsp_upiu.header.data_segment_length = cpu_to_be16(data_segment_length);
>> +}
>> +
>> +static UfsReqResult ufs_exec_nop_cmd(UfsRequest *req)
>> +{
>> +    trace_ufs_exec_nop_cmd(req->slot);
>> +    ufs_build_upiu_header(req, UPIU_TRANSACTION_NOP_IN, 0, 0, 0, 0);
>> +    return UFS_REQUEST_SUCCESS;
>> +}
>> +
>> +/*
>> + * This defines the permission of flags based on their IDN. There are some
>> + * things that are declared read-only, which is inconsistent with the ufs spec,
>> + * because we want to return an error for features that are not yet supported.
>> + */
>> +static const int flag_permission[QUERY_FLAG_IDN_COUNT] = {
>> +    [QUERY_FLAG_IDN_FDEVICEINIT] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET,
>> +    /* Write protection is not supported */
>> +    [QUERY_FLAG_IDN_PERMANENT_WPE] = UFS_QUERY_FLAG_READ,
>> +    [QUERY_FLAG_IDN_PWR_ON_WPE] = UFS_QUERY_FLAG_READ,
>> +    [QUERY_FLAG_IDN_BKOPS_EN] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET |
>> +                                UFS_QUERY_FLAG_CLEAR | UFS_QUERY_FLAG_TOGGLE,
>> +    [QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE] =
>> +        UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET | UFS_QUERY_FLAG_CLEAR |
>> +        UFS_QUERY_FLAG_TOGGLE,
>> +    /* Purge Operation is not supported */
>> +    [QUERY_FLAG_IDN_PURGE_ENABLE] = UFS_QUERY_FLAG_NONE,
>> +    /* Refresh Operation is not supported */
>> +    [QUERY_FLAG_IDN_REFRESH_ENABLE] = UFS_QUERY_FLAG_NONE,
>> +    /* Physical Resource Removal is not supported */
>> +    [QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL] = UFS_QUERY_FLAG_READ,
>> +    [QUERY_FLAG_IDN_BUSY_RTC] = UFS_QUERY_FLAG_READ,
>> +    [QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE] = UFS_QUERY_FLAG_READ,
>> +    /* Write Booster is not supported */
>> +    [QUERY_FLAG_IDN_WB_EN] = UFS_QUERY_FLAG_READ,
>> +    [QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN] = UFS_QUERY_FLAG_READ,
>> +    [QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8] = UFS_QUERY_FLAG_READ,
>> +};
>> +
>> +static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
>> +{
>> +    if (idn >= QUERY_FLAG_IDN_COUNT) {
>> +        return QUERY_RESULT_INVALID_IDN;
>> +    }
>> +
>> +    if (!(flag_permission[idn] & op)) {
>> +        if (op == UFS_QUERY_FLAG_READ) {
>> +            trace_ufs_err_query_flag_not_readable(idn);
>> +            return QUERY_RESULT_NOT_READABLE;
>> +        }
>> +        trace_ufs_err_query_flag_not_writable(idn);
>> +        return QUERY_RESULT_NOT_WRITEABLE;
>> +    }
>> +
>> +    return QUERY_RESULT_SUCCESS;
>> +}
>> +
>> +static const int attr_permission[QUERY_ATTR_IDN_COUNT] = {
>> +    /* booting is not supported */
>> +    [QUERY_ATTR_IDN_BOOT_LU_EN] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_POWER_MODE] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_ACTIVE_ICC_LVL] =
>> +        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_OOO_DATA_EN] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_BKOPS_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_PURGE_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_MAX_DATA_IN] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_MAX_DATA_OUT] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_DYN_CAP_NEEDED] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_REF_CLK_FREQ] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_CONF_DESC_LOCK] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_MAX_NUM_OF_RTT] =
>> +        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_EE_CONTROL] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_EE_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_SECONDS_PASSED] = UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_CNTX_CONF] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_FFU_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_PSA_STATE] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_PSA_DATA_SIZE] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>> +    [QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_CASE_ROUGH_TEMP] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_HIGH_TEMP_BOUND] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_LOW_TEMP_BOUND] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_THROTTLING_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_WB_FLUSH_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE] = UFS_QUERY_ATTR_READ,
>> +    /* refresh operation is not supported */
>> +    [QUERY_ATTR_IDN_REFRESH_STATUS] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_REFRESH_FREQ] = UFS_QUERY_ATTR_READ,
>> +    [QUERY_ATTR_IDN_REFRESH_UNIT] = UFS_QUERY_ATTR_READ,
>> +};
>> +
>> +static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
>> +{
>> +    if (idn >= QUERY_ATTR_IDN_COUNT) {
>> +        return QUERY_RESULT_INVALID_IDN;
>> +    }
>> +
>> +    if (!(attr_permission[idn] & op)) {
>> +        if (op == UFS_QUERY_ATTR_READ) {
>> +            trace_ufs_err_query_attr_not_readable(idn);
>> +            return QUERY_RESULT_NOT_READABLE;
>> +        }
>> +        trace_ufs_err_query_attr_not_writable(idn);
>> +        return QUERY_RESULT_NOT_WRITEABLE;
>> +    }
>> +
>> +    return QUERY_RESULT_SUCCESS;
>> +}
>> +
>> +static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
>> +{
>> +    UfsHc *u = req->hc;
>> +    uint8_t idn = req->req_upiu.qr.idn;
>> +    uint32_t value;
>> +    QueryRespCode ret;
>> +
>> +    ret = ufs_flag_check_idn_valid(idn, op);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    value = *(((uint8_t *)&u->flags) + idn);
>> +    if (idn == QUERY_FLAG_IDN_FDEVICEINIT) {
>> +        value = 0;
>> +    } else if (op == UFS_QUERY_FLAG_READ) {
>> +        value = *(((uint8_t *)&u->flags) + idn);
>
>This value was already loaded a few lines above.
>

Okay, I'll remove the line above.

>> +    } else if (op == UFS_QUERY_FLAG_SET) {
>> +        value = 1;
>> +    } else if (op == UFS_QUERY_FLAG_CLEAR) {
>> +        value = 0;
>> +    } else if (op == UFS_QUERY_FLAG_TOGGLE) {
>> +        value = !value;
>> +    } else {
>> +        trace_ufs_err_query_invalid_opcode(op);
>> +        return QUERY_RESULT_INVALID_OPCODE;
>> +    }
>> +
>> +    *(((uint8_t *)&u->flags) + idn) = value;
>> +    req->rsp_upiu.qr.value = cpu_to_be32(value);
>> +    return QUERY_RESULT_SUCCESS;
>> +}
>> +
>> +static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
>> +{
>> +    switch (idn) {
>> +    case QUERY_ATTR_IDN_BOOT_LU_EN:
>> +        return u->attributes.boot_lun_en;
>> +    case QUERY_ATTR_IDN_POWER_MODE:
>> +        return u->attributes.current_power_mode;
>> +    case QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
>> +        return u->attributes.active_icc_level;
>> +    case QUERY_ATTR_IDN_OOO_DATA_EN:
>> +        return u->attributes.out_of_order_data_en;
>> +    case QUERY_ATTR_IDN_BKOPS_STATUS:
>> +        return u->attributes.background_op_status;
>> +    case QUERY_ATTR_IDN_PURGE_STATUS:
>> +        return u->attributes.purge_status;
>> +    case QUERY_ATTR_IDN_MAX_DATA_IN:
>> +        return u->attributes.max_data_in_size;
>> +    case QUERY_ATTR_IDN_MAX_DATA_OUT:
>> +        return u->attributes.max_data_out_size;
>> +    case QUERY_ATTR_IDN_DYN_CAP_NEEDED:
>> +        return be32_to_cpu(u->attributes.dyn_cap_needed);
>> +    case QUERY_ATTR_IDN_REF_CLK_FREQ:
>> +        return u->attributes.ref_clk_freq;
>> +    case QUERY_ATTR_IDN_CONF_DESC_LOCK:
>> +        return u->attributes.config_descr_lock;
>> +    case QUERY_ATTR_IDN_MAX_NUM_OF_RTT:
>> +        return u->attributes.max_num_of_rtt;
>> +    case QUERY_ATTR_IDN_EE_CONTROL:
>> +        return be16_to_cpu(u->attributes.exception_event_control);
>> +    case QUERY_ATTR_IDN_EE_STATUS:
>> +        return be16_to_cpu(u->attributes.exception_event_status);
>> +    case QUERY_ATTR_IDN_SECONDS_PASSED:
>> +        return be32_to_cpu(u->attributes.seconds_passed);
>> +    case QUERY_ATTR_IDN_CNTX_CONF:
>> +        return be16_to_cpu(u->attributes.context_conf);
>> +    case QUERY_ATTR_IDN_FFU_STATUS:
>> +        return u->attributes.device_ffu_status;
>> +    case QUERY_ATTR_IDN_PSA_STATE:
>> +        return be32_to_cpu(u->attributes.psa_state);
>> +    case QUERY_ATTR_IDN_PSA_DATA_SIZE:
>> +        return u->attributes.psa_data_size;
>> +    case QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME:
>> +        return u->attributes.ref_clk_gating_wait_time;
>> +    case QUERY_ATTR_IDN_CASE_ROUGH_TEMP:
>> +        return u->attributes.device_case_rough_temperaure;
>> +    case QUERY_ATTR_IDN_HIGH_TEMP_BOUND:
>> +        return u->attributes.device_too_high_temp_boundary;
>> +    case QUERY_ATTR_IDN_LOW_TEMP_BOUND:
>> +        return u->attributes.device_too_low_temp_boundary;
>> +    case QUERY_ATTR_IDN_THROTTLING_STATUS:
>> +        return u->attributes.throttling_status;
>> +    case QUERY_ATTR_IDN_WB_FLUSH_STATUS:
>> +        return u->attributes.wb_buffer_flush_status;
>> +    case QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE:
>> +        return u->attributes.available_wb_buffer_size;
>> +    case QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST:
>> +        return u->attributes.wb_buffer_life_time_est;
>> +    case QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE:
>> +        return be32_to_cpu(u->attributes.current_wb_buffer_size);
>> +    case QUERY_ATTR_IDN_REFRESH_STATUS:
>> +        return u->attributes.refresh_status;
>> +    case QUERY_ATTR_IDN_REFRESH_FREQ:
>> +        return u->attributes.refresh_freq;
>> +    case QUERY_ATTR_IDN_REFRESH_UNIT:
>> +        return u->attributes.refresh_unit;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
>> +{
>> +    switch (idn) {
>> +    case QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
>> +        u->attributes.active_icc_level = value;
>> +        break;
>> +    case QUERY_ATTR_IDN_MAX_DATA_IN:
>> +        u->attributes.max_data_in_size = value;
>> +        break;
>> +    case QUERY_ATTR_IDN_MAX_DATA_OUT:
>> +        u->attributes.max_data_out_size = value;
>> +        break;
>> +    case QUERY_ATTR_IDN_REF_CLK_FREQ:
>> +        u->attributes.ref_clk_freq = value;
>> +        break;
>> +    case QUERY_ATTR_IDN_MAX_NUM_OF_RTT:
>> +        u->attributes.max_num_of_rtt = value;
>> +        break;
>> +    case QUERY_ATTR_IDN_EE_CONTROL:
>> +        u->attributes.exception_event_control = cpu_to_be16(value);
>> +        break;
>> +    case QUERY_ATTR_IDN_SECONDS_PASSED:
>> +        u->attributes.seconds_passed = cpu_to_be32(value);
>> +        break;
>> +    case QUERY_ATTR_IDN_PSA_STATE:
>> +        u->attributes.psa_state = value;
>> +        break;
>> +    case QUERY_ATTR_IDN_PSA_DATA_SIZE:
>> +        u->attributes.psa_data_size = cpu_to_be32(value);
>> +        break;
>> +    }
>> +}
>> +
>> +static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
>> +{
>> +    UfsHc *u = req->hc;
>> +    uint8_t idn = req->req_upiu.qr.idn;
>> +    uint32_t value;
>> +    QueryRespCode ret;
>> +
>> +    ret = ufs_attr_check_idn_valid(idn, op);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    if (op == UFS_QUERY_ATTR_READ) {
>> +        value = ufs_read_attr_value(u, idn);
>> +    } else {
>> +        value = be32_to_cpu(req->req_upiu.qr.value);
>> +        ufs_write_attr_value(u, idn, value);
>> +    }
>> +
>> +    req->rsp_upiu.qr.value = cpu_to_be32(value);
>> +    return QUERY_RESULT_SUCCESS;
>> +}
>> +
>> +static const RpmbUnitDescriptor rpmb_unit_desc = {
>> +    .length = sizeof(RpmbUnitDescriptor),
>> +    .descriptor_idn = 2,
>> +    .unit_index = UFS_UPIU_RPMB_WLUN,
>> +    .lu_enable = 0,
>> +};
>> +
>> +static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
>> +{
>> +    uint8_t lun = req->req_upiu.qr.index;
>> +
>> +    if (lun != UFS_UPIU_RPMB_WLUN && lun > UFS_MAX_LUS) {
>> +        trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, lun);
>> +        return QUERY_RESULT_INVALID_INDEX;
>> +    }
>> +
>> +    if (lun == UFS_UPIU_RPMB_WLUN) {
>> +        memcpy(&req->rsp_upiu.qr.data, &rpmb_unit_desc, rpmb_unit_desc.length);
>> +    } else {
>> +        /* unit descriptor is not yet supported */
>> +        return QUERY_RESULT_INVALID_INDEX;
>> +    }
>> +
>> +    return QUERY_RESULT_SUCCESS;
>> +}
>> +
>> +static const StringDescriptor manufacturer_str_desc = {
>> +    .length = 0x12,
>> +    .descriptor_idn = QUERY_DESC_IDN_STRING,
>> +    .UC = { 'S', 'A', 'M', 'S', 'U', 'N', 'G' },
>
>What is the endianness of these 16-bit characters? I noticed endianness
>issues in several other places but will not audit the patch
>exhaustively. Please review all guest-visible fields carefully and add
>cpu_to_leXX()/cpu_to_beXX() where necessary.
>

I'm sorry, lack of consideration for endianness.
It should be big endian. 
I'll carefully review all the guest-visible fields defined in block/ufs.h
and add cpu_to_leXX() / cpu_to_beXX().
Thanks.

>> +};
>> +
>> +static const StringDescriptor product_name_str_desc = {
>> +    .length = 0x22,
>> +    .descriptor_idn = QUERY_DESC_IDN_STRING,
>> +    .UC = { 'Q', 'E', 'M', 'U', '-', 'U', 'F', 'S' },
>> +};
>> +
>> +static const StringDescriptor product_rev_level_str_desc = {
>> +    .length = 0x0a,
>> +    .descriptor_idn = QUERY_DESC_IDN_STRING,
>> +    .UC = { '0', '0', '0', '1' },
>> +};
>> +
>> +static const StringDescriptor null_str_desc = {
>> +    .length = 0x02,
>> +    .descriptor_idn = QUERY_DESC_IDN_STRING,
>> +};
>> +
>> +static QueryRespCode ufs_read_string_desc(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    uint8_t index = req->req_upiu.qr.index;
>> +    if (index == u->device_desc.manufacturer_name) {
>> +        memcpy(&req->rsp_upiu.qr.data, &manufacturer_str_desc,
>> +               manufacturer_str_desc.length);
>> +    } else if (index == u->device_desc.product_name) {
>> +        memcpy(&req->rsp_upiu.qr.data, &product_name_str_desc,
>> +               product_name_str_desc.length);
>> +    } else if (index == u->device_desc.serial_number) {
>> +        memcpy(&req->rsp_upiu.qr.data, &null_str_desc, null_str_desc.length);
>> +    } else if (index == u->device_desc.oem_id) {
>> +        memcpy(&req->rsp_upiu.qr.data, &null_str_desc, null_str_desc.length);
>> +    } else if (index == u->device_desc.product_revision_level) {
>> +        memcpy(&req->rsp_upiu.qr.data, &product_rev_level_str_desc,
>> +               product_rev_level_str_desc.length);
>> +    } else {
>> +        trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, index);
>> +        return QUERY_RESULT_INVALID_INDEX;
>> +    }
>> +    return QUERY_RESULT_SUCCESS;
>> +}
>> +
>> +static const InterconnectDescriptor interconnect_desc = {
>> +    .length = sizeof(InterconnectDescriptor),
>> +    .descriptor_idn = QUERY_DESC_IDN_INTERCONNECT,
>> +    .bcd_unipro_version = 0x180,
>> +    .bcd_mphy_version = 0x410,
>
>What is the endianness of these two 16-bit fields?
>

It should be big endian too.
I'll fix it as well.

>> +};
>> +
>> +static QueryRespCode ufs_read_desc(UfsRequest *req)
>> +{
>> +    UfsHc *u = req->hc;
>> +    QueryRespCode status;
>> +    uint8_t idn = req->req_upiu.qr.idn;
>> +    uint16_t length = be16_to_cpu(req->req_upiu.qr.length);
>> +
>> +    switch (idn) {
>> +    case QUERY_DESC_IDN_DEVICE:
>> +        memcpy(&req->rsp_upiu.qr.data, &u->device_desc, sizeof(u->device_desc));
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    case QUERY_DESC_IDN_UNIT:
>> +        status = ufs_read_unit_desc(req);
>> +        break;
>> +    case QUERY_DESC_IDN_GEOMETRY:
>> +        memcpy(&req->rsp_upiu.qr.data, &u->geometry_desc,
>> +               sizeof(u->geometry_desc));
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    case QUERY_DESC_IDN_INTERCONNECT: {
>> +        memcpy(&req->rsp_upiu.qr.data, &interconnect_desc,
>> +               sizeof(interconnect_desc));
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    }
>> +    case QUERY_DESC_IDN_STRING:
>> +        status = ufs_read_string_desc(req);
>> +        break;
>> +    case QUERY_DESC_IDN_POWER:
>> +        /* mocking of power descriptor is not supported */
>> +        memset(&req->rsp_upiu.qr.data, 0, sizeof(PowerParametersDescriptor));
>> +        req->rsp_upiu.qr.data[0] = sizeof(PowerParametersDescriptor);
>> +        req->rsp_upiu.qr.data[1] = QUERY_DESC_IDN_POWER;
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    case QUERY_DESC_IDN_HEALTH:
>> +        /* mocking of health descriptor is not supported */
>> +        memset(&req->rsp_upiu.qr.data, 0, sizeof(DeviceHealthDescriptor));
>> +        req->rsp_upiu.qr.data[0] = sizeof(DeviceHealthDescriptor);
>> +        req->rsp_upiu.qr.data[1] = QUERY_DESC_IDN_HEALTH;
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    default:
>> +        length = 0;
>> +        trace_ufs_err_query_invalid_idn(req->req_upiu.qr.opcode, idn);
>> +        status = QUERY_RESULT_INVALID_IDN;
>> +    }
>> +
>> +    if (length > req->rsp_upiu.qr.data[0]) {
>> +        length = req->rsp_upiu.qr.data[0];
>> +    }
>> +    req->rsp_upiu.qr.opcode = req->req_upiu.qr.opcode;
>> +    req->rsp_upiu.qr.idn = req->req_upiu.qr.idn;
>> +    req->rsp_upiu.qr.index = req->req_upiu.qr.index;
>> +    req->rsp_upiu.qr.selector = req->req_upiu.qr.selector;
>> +    req->rsp_upiu.qr.length = cpu_to_be16(length);
>> +
>> +    return status;
>> +}
>> +
>> +static QueryRespCode ufs_exec_query_read(UfsRequest *req)
>> +{
>> +    QueryRespCode status;
>> +    switch (req->req_upiu.qr.opcode) {
>> +    case UPIU_QUERY_OPCODE_NOP:
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    case UPIU_QUERY_OPCODE_READ_DESC:
>> +        status = ufs_read_desc(req);
>> +        break;
>> +    case UPIU_QUERY_OPCODE_READ_ATTR:
>> +        status = ufs_exec_query_attr(req, UFS_QUERY_ATTR_READ);
>> +        break;
>> +    case UPIU_QUERY_OPCODE_READ_FLAG:
>> +        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_READ);
>> +        break;
>> +    default:
>> +        trace_ufs_err_query_invalid_opcode(req->req_upiu.qr.opcode);
>> +        status = QUERY_RESULT_INVALID_OPCODE;
>> +        break;
>> +    }
>> +
>> +    return status;
>> +}
>> +
>> +static QueryRespCode ufs_exec_query_write(UfsRequest *req)
>> +{
>> +    QueryRespCode status;
>> +    switch (req->req_upiu.qr.opcode) {
>> +    case UPIU_QUERY_OPCODE_NOP:
>> +        status = QUERY_RESULT_SUCCESS;
>> +        break;
>> +    case UPIU_QUERY_OPCODE_WRITE_DESC:
>> +        /* write descriptor is not supported */
>> +        status = QUERY_RESULT_NOT_WRITEABLE;
>> +        break;
>> +    case UPIU_QUERY_OPCODE_WRITE_ATTR:
>> +        status = ufs_exec_query_attr(req, UFS_QUERY_ATTR_WRITE);
>> +        break;
>> +    case UPIU_QUERY_OPCODE_SET_FLAG:
>> +        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_SET);
>> +        break;
>> +    case UPIU_QUERY_OPCODE_CLEAR_FLAG:
>> +        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_CLEAR);
>> +        break;
>> +    case UPIU_QUERY_OPCODE_TOGGLE_FLAG:
>> +        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_TOGGLE);
>> +        break;
>> +    default:
>> +        trace_ufs_err_query_invalid_opcode(req->req_upiu.qr.opcode);
>> +        status = QUERY_RESULT_INVALID_OPCODE;
>> +        break;
>> +    }
>> +
>> +    return status;
>> +}
>> +
>> +static UfsReqResult ufs_exec_query_cmd(UfsRequest *req)
>> +{
>> +    uint8_t query_func = req->req_upiu.header.query_func;
>> +    uint16_t data_segment_length;
>> +    QueryRespCode status;
>> +
>> +    trace_ufs_exec_query_cmd(req->slot, req->req_upiu.qr.opcode);
>> +    if (query_func == UPIU_QUERY_FUNC_STANDARD_READ_REQUEST) {
>> +        status = ufs_exec_query_read(req);
>> +    } else if (query_func == UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST) {
>> +        status = ufs_exec_query_write(req);
>> +    } else {
>> +        status = QUERY_RESULT_GENERAL_FAILURE;
>> +    }
>> +
>> +    data_segment_length = be16_to_cpu(req->rsp_upiu.qr.length);
>> +    ufs_build_upiu_header(req, UPIU_TRANSACTION_QUERY_RSP, 0, status, 0,
>> +                          data_segment_length);
>> +
>> +    if (status != QUERY_RESULT_SUCCESS) {
>> +        return UFS_REQUEST_ERROR;
>> +    }
>> +    return UFS_REQUEST_SUCCESS;
>> +}
>> +
>> +static void ufs_exec_req(UfsRequest *req)
>> +{
>> +    UfsReqResult req_result;
>> +
>> +    if (ufs_dma_read_upiu(req)) {
>> +        return;
>> +    }
>> +
>> +    switch (req->req_upiu.header.trans_type) {
>> +    case UPIU_TRANSACTION_NOP_OUT:
>> +        req_result = ufs_exec_nop_cmd(req);
>> +        break;
>> +    case UPIU_TRANSACTION_COMMAND:
>> +        /* Not yet implemented */
>> +        req_result = UFS_REQUEST_ERROR;
>> +        break;
>> +    case UPIU_TRANSACTION_QUERY_REQ:
>> +        req_result = ufs_exec_query_cmd(req);
>> +        break;
>> +    default:
>> +        trace_ufs_err_invalid_trans_code(req->slot,
>> +                                         req->req_upiu.header.trans_type);
>> +        req_result = UFS_REQUEST_ERROR;
>> +    }
>> +
>> +    ufs_complete_req(req, req_result);
>> +}
>> +
>> +static void ufs_process_req(void *opaque)
>> +{
>> +    UfsHc *u = opaque;
>> +    UfsRequest *req;
>> +    int slot;
>> +
>> +    for (slot = 0; slot < u->params.nutrs; slot++) {
>> +        req = &u->req_list[slot];
>> +
>> +        if (req->state != UFS_REQUEST_READY) {
>> +            continue;
>> +        }
>> +        trace_ufs_process_req(slot);
>> +        req->state = UFS_REQUEST_RUNNING;
>> +
>> +        ufs_exec_req(req);
>> +    }
>> +}
>> +
>> +static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
>> +{
>> +    UfsHc *u = req->hc;
>> +    assert(req->state == UFS_REQUEST_RUNNING);
>> +
>> +    if (req_result == UFS_REQUEST_SUCCESS) {
>> +        req->utrd.header.dword_2 = OCS_SUCCESS;
>> +    } else {
>> +        req->utrd.header.dword_2 = OCS_INVALID_CMD_TABLE_ATTR;
>> +    }
>
>How does byte-swapping work in your patch series? This looks like native
>endian but it should be little-endian.
>

You are right. It should be litte-endian.
I'll review all fields that use uint16_t and uint32_t
and use the appropriate endian conversion function.

>> +
>> +    trace_ufs_complete_req(req->slot);
>> +    req->state = UFS_REQUEST_COMPLETE;
>> +    qemu_bh_schedule(u->complete_bh);
>> +}
>> +
>> +static void ufs_clear_req(UfsRequest *req)
>> +{
>> +    if (req->sg != NULL) {
>> +        qemu_sglist_destroy(req->sg);
>> +        g_free(req->sg);
>> +        req->sg = NULL;
>> +    }
>> +
>> +    memset(&req->utrd, 0, sizeof(req->utrd));
>> +    memset(&req->req_upiu, 0, sizeof(req->req_upiu));
>> +    memset(&req->rsp_upiu, 0, sizeof(req->rsp_upiu));
>> +}
>> +
>> +static void ufs_sendback_req(void *opaque)
>> +{
>> +    UfsHc *u = opaque;
>> +    UfsRequest *req;
>> +    int slot;
>> +
>> +    for (slot = 0; slot < u->params.nutrs; slot++) {
>> +        uint32_t is = ldl_le_p(&u->reg.is);
>> +        uint32_t utrldbr = ldl_le_p(&u->reg.utrldbr);
>> +        uint32_t utrlcnr = ldl_le_p(&u->reg.utrlcnr);
>> +
>> +        req = &u->req_list[slot];
>> +
>> +        if (req->state != UFS_REQUEST_COMPLETE) {
>> +            continue;
>> +        }
>> +
>> +        if (ufs_dma_write_upiu(req)) {
>> +            continue;
>
>Does this error handling work? It looks to me like a failed DMA
>transaction will repeat every time ufs_sendback_req() is called instead
>of stopping the request (changing req->state).
>

This should be fixed. I'll introduce the UFS_REQUEST_ERROR state
to prevent re-execution for DMA error situations.

>> +        }
>> +
>> +        /*
>> +         * TODO: UTP Transfer Request Interrupt Aggregation Control is not yet
>> +         * supported
>> +         */
>> +        if (req->utrd.header.dword_2 != OCS_SUCCESS ||
>> +            req->utrd.header.dword_0 & UTP_REQ_DESC_INT_CMD) {
>> +            is = FIELD_DP32(is, IS, UTRCS, 1);
>> +        }
>> +
>> +        utrldbr &= ~(1 << slot);
>> +        utrlcnr |= (1 << slot);
>> +
>> +        stl_le_p(&u->https://protect2.fireeye.com/v1/url?k=914d23dd-ced10af7-914ca892-000babe598f7-e6ca9abf6ef07b74&q=1&e=d20f362c-c592-4425-86c7-2f65b07a0d0e&u=http%3A%2F%2Freg.is%2F, is);
>> +        stl_le_p(&u->reg.utrldbr, utrldbr);
>> +        stl_le_p(&u->reg.utrlcnr, utrlcnr);
>> +
>> +        trace_ufs_sendback_req(req->slot);
>> +
>> +        ufs_clear_req(req);
>> +        req->state = UFS_REQUEST_IDLE;
>> +    }
>> +
>> +    ufs_irq_check(u);
>> +}
>> +
>>  static bool ufs_check_constraints(UfsHc *u, Error **errp)
>>  {
>>      if (u->params.nutrs > UFS_MAX_NUTRS) {
>> @@ -232,6 +1118,23 @@ static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
>>      u->irq = pci_allocate_irq(pci_dev);
>>  }
>>  
>> +static void ufs_init_state(UfsHc *u)
>> +{
>> +    u->req_list = g_new0(UfsRequest, u->params.nutrs);
>> +
>> +    for (int i = 0; i < u->params.nutrs; i++) {
>> +        u->req_list[i].hc = u;
>> +        u->req_list[i].slot = i;
>> +        u->req_list[i].sg = NULL;
>> +        u->req_list[i].state = UFS_REQUEST_IDLE;
>> +    }
>> +
>> +    u->doorbell_bh = qemu_bh_new_guarded(ufs_process_req, u,
>> +                                         &DEVICE(u)->mem_reentrancy_guard);
>> +    u->complete_bh = qemu_bh_new_guarded(ufs_sendback_req, u,
>> +                                         &DEVICE(u)->mem_reentrancy_guard);
>> +}
>> +
>>  static void ufs_init_hc(UfsHc *u)
>>  {
>>      uint32_t cap = 0;
>> @@ -249,6 +1152,54 @@ static void ufs_init_hc(UfsHc *u)
>>      cap = FIELD_DP32(cap, CAP, CS, 0);
>>      stl_le_p(&u->reg.cap, cap);
>>      stl_le_p(&u->reg.ver, UFS_SPEC_VER);
>> +
>> +    memset(&u->device_desc, 0, sizeof(DeviceDescriptor));
>> +    u->device_desc.length = sizeof(DeviceDescriptor);
>> +    u->device_desc.descriptor_idn = QUERY_DESC_IDN_DEVICE;
>> +    u->device_desc.device_sub_class = 0x01;
>> +    u->device_desc.number_lu = 0x00;
>> +    u->device_desc.number_wlu = 0x04;
>> +    /* TODO: Revisit it when Power Management is implemented */
>> +    u->device_desc.init_power_mode = 0x01; /* Active Mode */
>> +    u->device_desc.high_priority_lun = 0x7F; /* Same Priority */
>> +    u->device_desc.spec_version = cpu_to_be16(0x0310);
>
>Can UFS_SPEC_VER be used here instead of hardcoding a magic number?
>

Okay, I'll fix it.

>> +    u->device_desc.manufacturer_name = 0x00;
>> +    u->device_desc.product_name = 0x01;
>> +    u->device_desc.serial_number = 0x02;
>> +    u->device_desc.oem_id = 0x03;
>> +    u->device_desc.ud_0_base_offset = 0x16;
>> +    u->device_desc.ud_config_p_length = 0x1A;
>> +    u->device_desc.device_rtt_cap = 0x02;
>> +    u->device_desc.queue_depth = u->params.nutrs;
>> +    u->device_desc.product_revision_level = 0x04;
>> +    u->device_desc.extended_ufs_features_support = 0x00;
>> +
>> +    memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
>> +    u->geometry_desc.length = sizeof(GeometryDescriptor);
>> +    u->geometry_desc.descriptor_idn = QUERY_DESC_IDN_GEOMETRY;
>> +    u->geometry_desc.total_raw_device_capacity = 0;
>> +    u->geometry_desc.max_number_lu = (UFS_MAX_LUS == 32) ? 0x1 : 0x0;
>> +    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4KB */
>> +    u->geometry_desc.allocation_unit_size = 0x1; /* 4KB */
>> +    u->geometry_desc.min_addr_block_size = 0x8; /* 4KB */
>> +    u->geometry_desc.max_in_buffer_size = 0x8;
>> +    u->geometry_desc.max_out_buffer_size = 0x8;
>> +    u->geometry_desc.rpmb_read_write_size = 0x40;
>> +    u->geometry_desc.data_ordering =
>> +        0x0; /* out-of-order data transfer is not supported */
>> +    u->geometry_desc.max_context_id_number = 0x5;
>> +    u->geometry_desc.supported_memory_types = cpu_to_be16(0x8001);
>> +
>> +    memset(&u->attributes, 0, sizeof(u->attributes));
>> +    u->attributes.max_data_in_size = 0x08;
>> +    u->attributes.max_data_out_size = 0x08;
>> +    u->attributes.ref_clk_freq = 0x01; /* 26 MHz */
>> +    /* configure descriptor is not supported */
>> +    u->attributes.config_descr_lock = 0x01;
>> +    u->attributes.max_num_of_rtt = 0x02;
>> +
>> +    memset(&u->flags, 0, sizeof(u->flags));
>> +    u->flags.permanently_disable_fw_update = 1;
>>  }
>>  
>>  static void ufs_realize(PCIDevice *pci_dev, Error **errp)
>> @@ -259,10 +1210,24 @@ static void ufs_realize(PCIDevice *pci_dev, Error **errp)
>>          return;
>>      }
>>  
>> +    ufs_init_state(u);
>>      ufs_init_hc(u);
>>      ufs_init_pci(u, pci_dev);
>>  }
>>  
>> +static void ufs_exit(PCIDevice *pci_dev)
>> +{
>> +    UfsHc *u = UFS(pci_dev);
>> +
>> +    qemu_bh_delete(u->doorbell_bh);
>> +    qemu_bh_delete(u->complete_bh);
>> +
>> +    for (int i = 0; i < u->params.nutrs; i++) {
>> +        ufs_clear_req(&u->req_list[i]);
>> +    }
>> +    g_free(u->req_list);
>> +}
>> +
>>  static Property ufs_props[] = {
>>      DEFINE_PROP_STRING("serial", UfsHc, params.serial),
>>      DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
>> @@ -281,6 +1246,7 @@ static void ufs_class_init(ObjectClass *oc, void *data)
>>      PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
>>  
>>      pc->realize = ufs_realize;
>> +    pc->exit = ufs_exit;
>>      pc->class_id = PCI_CLASS_STORAGE_UFS;
>>  
>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
>> index 3c28f4e62d..5d4fd818f9 100644
>> --- a/hw/ufs/ufs.h
>> +++ b/hw/ufs/ufs.h
>> @@ -18,6 +18,31 @@
>>  #define UFS_MAX_LUS 32
>>  #define UFS_LOGICAL_BLK_SIZE 4096
>>  
>> +typedef enum UfsRequestState {
>> +    UFS_REQUEST_IDLE = 0,
>> +    UFS_REQUEST_READY = 1,
>> +    UFS_REQUEST_RUNNING = 2,
>> +    UFS_REQUEST_COMPLETE = 3,
>> +} UfsRequestState;
>> +
>> +typedef enum UfsReqResult {
>> +    UFS_REQUEST_SUCCESS = 0,
>> +    UFS_REQUEST_ERROR = 1,
>> +} UfsReqResult;
>> +
>> +typedef struct UfsRequest {
>> +    struct UfsHc *hc;
>> +    UfsRequestState state;
>> +    int slot;
>> +
>> +    UtpTransferReqDesc utrd;
>> +    UtpUpiuReq req_upiu;
>> +    UtpUpiuRsp rsp_upiu;
>> +
>> +    /* for scsi command */
>> +    QEMUSGList *sg;
>> +} UfsRequest;
>> +
>>  typedef struct UfsParams {
>>      char *serial;
>>      uint8_t nutrs; /* Number of UTP Transfer Request Slots */
>> @@ -30,6 +55,12 @@ typedef struct UfsHc {
>>      UfsReg reg;
>>      UfsParams params;
>>      uint32_t reg_size;
>> +    UfsRequest *req_list;
>> +
>> +    DeviceDescriptor device_desc;
>> +    GeometryDescriptor geometry_desc;
>> +    Attributes attributes;
>> +    Flags flags;
>>  
>>      qemu_irq irq;
>>      QEMUBH *doorbell_bh;
>> @@ -39,4 +70,18 @@ typedef struct UfsHc {
>>  #define TYPE_UFS "ufs"
>>  #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
>>  
>> +typedef enum UfsQueryFlagPerm {
>> +    UFS_QUERY_FLAG_NONE = 0x0,
>> +    UFS_QUERY_FLAG_READ = 0x1,
>> +    UFS_QUERY_FLAG_SET = 0x2,
>> +    UFS_QUERY_FLAG_CLEAR = 0x4,
>> +    UFS_QUERY_FLAG_TOGGLE = 0x8,
>> +} UfsQueryFlagPerm;
>> +
>> +typedef enum UfsQueryAttrPerm {
>> +    UFS_QUERY_ATTR_NONE = 0x0,
>> +    UFS_QUERY_ATTR_READ = 0x1,
>> +    UFS_QUERY_ATTR_WRITE = 0x2,
>> +} UfsQueryAttrPerm;
>> +
>>  #endif /* HW_UFS_UFS_H */
>> -- 
>> 2.34.1
>> 

