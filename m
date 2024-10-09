Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A2997065
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Oct 2024 18:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syZ9k-0000gS-P8; Wed, 09 Oct 2024 12:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1syZ9V-0000Se-6S
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 12:03:05 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1syZ9S-0005cB-2B
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 12:03:04 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 4995wQlu007012; Wed, 9 Oct 2024 17:02:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=5NOUX0abEJLk+PXV5DCBwtrJPAC6cl04qnxryJYE1UA=; b=KhHhb/s0T585
 c4dNxgEYQql/A2yt+HMPCD3Qz9MbNtsiGxQzujEN3M1kba9EBvHRjgS09ETgHVK4
 yzupmCs9WAbp64zQMLE57U+J9mp4hNfr7DdyZImAi8ydsnB+FDHmkw32wAMTU2ka
 f62NtbTYXRDPIYA1SHGbuHJlKGZZLllOSlfnZKN7Ass5aLeQOZQRsLyjqj5XzefG
 ejppcITtJTAfnNQp2w4PZbnVh1LyBxxkcyxrUG6UI463PScln2Rmq16ofOjF/8Uf
 RgJ73fW23Ce5RFjXvohylQgrKX0wqcGRobpMnUEi/W6D8ibtdwGoMWPFsSij8JLo
 1oT+u5EzBw==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 422xqsgpge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Oct 2024 17:02:49 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 499DJmCL012844; Wed, 9 Oct 2024 12:02:49 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 423jbx95u3-1;
 Wed, 09 Oct 2024 12:02:48 -0400
Received: from [100.64.0.1] (unknown [172.27.166.123])
 by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 569162C6;
 Wed,  9 Oct 2024 16:02:47 +0000 (GMT)
Message-ID: <6187274e-7223-4c13-b950-57137f4422d1@akamai.com>
Date: Wed, 9 Oct 2024 11:02:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scsi: fetch unit attention when creating the request
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Fam Zheng <fam@euphon.net>,
 dharnett@akamai.com, "Hunt, Joshua" <johunt@akamai.com>
References: <20230712134352.118655-1-sgarzare@redhat.com>
 <20230712134352.118655-2-sgarzare@redhat.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20230712134352.118655-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-GUID: DJusg93bPZsbaYF_EVc0gaYYZMQ6ayTC
X-Proofpoint-ORIG-GUID: DJusg93bPZsbaYF_EVc0gaYYZMQ6ayTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410090100
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi All,

We have stumbled upon this bug in our production systems on QEMU 7.2.x. 
This is a pretty nasty bug because it has the effect of causing the root 
filesystem in the guest to switch into read only mode if our block 
storage products change attachments to running virtual machines.

Could we kindly ask to pull this identical patch for 7.2.15?

Last year, it just went to master and landed in 8.0.50. We're planning 
to upgrade, but it will be quite some time before we get around to that, 
and I suspect others are also running 7.2.x in production.

- Michael Galaxy

On 7/12/23 08:43, Stefano Garzarella wrote:
> Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
> calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi device.
> This had no drawback, until commit 8cc5583abe ("virtio-scsi: Send
> "REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
> bus unit attention.
>
> Having the two calls separated, all requests in the batch were prepared
> calling scsi_req_new() to report a sense.
> Then only the first one submitted calling scsi_req_enqueue() reported the
> right sense and reset it to NO_SENSE.
> The others reported NO_SENSE, causing SCSI errors in Linux.
>
> To solve this issue, let's fetch the unit attention as early as possible
> when we prepare the request, that way only the first request in the batch
> will carry the right sense.
>
> Fixes: 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs")
> Fixes: 8cc5583abe ("virtio-scsi: Send "REPORTED LUNS CHANGED" sense data upon disk hotplug events")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   include/hw/scsi/scsi.h |  1 +
>   hw/scsi/scsi-bus.c     | 36 +++++++++++++++++++++++++++++++++---
>   2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index e2bb1a2fbf..3692ca82f3 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -108,6 +108,7 @@ int cdrom_read_toc_raw(int nb_sectors, uint8_t *buf, int msf, int session_num);
>   /* scsi-bus.c */
>   struct SCSIReqOps {
>       size_t size;
> +    void (*init_req)(SCSIRequest *req);
>       void (*free_req)(SCSIRequest *req);
>       int32_t (*send_command)(SCSIRequest *req, uint8_t *buf);
>       void (*read_data)(SCSIRequest *req);
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index f80f4cb4fc..f083373021 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -412,19 +412,35 @@ static const struct SCSIReqOps reqops_invalid_opcode = {
>   
>   /* SCSIReqOps implementation for unit attention conditions.  */
>   
> -static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
> +static void scsi_fetch_unit_attention_sense(SCSIRequest *req)
>   {
> +    SCSISense *ua = NULL;
> +
>       if (req->dev->unit_attention.key == UNIT_ATTENTION) {
> -        scsi_req_build_sense(req, req->dev->unit_attention);
> +        ua = &req->dev->unit_attention;
>       } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
> -        scsi_req_build_sense(req, req->bus->unit_attention);
> +        ua = &req->bus->unit_attention;
>       }
> +
> +    /*
> +     * Fetch the unit attention sense immediately so that another
> +     * scsi_req_new does not use reqops_unit_attention.
> +     */
> +    if (ua) {
> +        scsi_req_build_sense(req, *ua);
> +        *ua = SENSE_CODE(NO_SENSE);
> +    }
> +}
> +
> +static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
> +{
>       scsi_req_complete(req, CHECK_CONDITION);
>       return 0;
>   }
>   
>   static const struct SCSIReqOps reqops_unit_attention = {
>       .size         = sizeof(SCSIRequest),
> +    .init_req     = scsi_fetch_unit_attention_sense,
>       .send_command = scsi_unit_attention
>   };
>   
> @@ -699,6 +715,11 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
>       object_ref(OBJECT(d));
>       object_ref(OBJECT(qbus->parent));
>       notifier_list_init(&req->cancel_notifiers);
> +
> +    if (reqops->init_req) {
> +        reqops->init_req(req);
> +    }
> +
>       trace_scsi_req_alloc(req->dev->id, req->lun, req->tag);
>       return req;
>   }
> @@ -798,6 +819,15 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req)
>   static void scsi_clear_unit_attention(SCSIRequest *req)
>   {
>       SCSISense *ua;
> +
> +    /*
> +     * scsi_fetch_unit_attention_sense() already cleaned the unit attention
> +     * in this case.
> +     */
> +    if (req->ops == &reqops_unit_attention) {
> +        return;
> +    }
> +
>       if (req->dev->unit_attention.key != UNIT_ATTENTION &&
>           req->bus->unit_attention.key != UNIT_ATTENTION) {
>           return;

