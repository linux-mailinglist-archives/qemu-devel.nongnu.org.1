Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4739FAB6F56
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 17:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl3-0004If-0C; Wed, 14 May 2025 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDDV-0001OL-VA; Wed, 14 May 2025 10:36:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDDT-0007Gh-UI; Wed, 14 May 2025 10:36:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E738eS026867;
 Wed, 14 May 2025 14:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1ekLl5
 LlnyS39zPlTFviV8iM0EW/k8lJVdpORbDeCMc=; b=dZO+GlsMMo0Sv9DggDLBoV
 5nFMxMh2v8DP5wzpI2WM63FGHID7BARdj5rJEDAu3hZCEA9pzYYwq4ZVn3QGUDBu
 9KOhCiM1VyE8TW5j/3qObnA7cICDgzvvbvLXyhyZYdVfBuonL6GRwmuiX89F4y+O
 PC6Hnq1pos/QfG+DV43VWCiDzLS7PKNpphUtT/rOG9JTwgvqHRelhR1avO1mX+6O
 U3Q+PjME0kYuzvQXBDVnGJjyAAd0SdRRMpaQJam/zWazrssRZQ7LO52ENNhZXyWj
 3llHaFvGsgUfksj8lpFdqgm4yADclfvO+6cRJ3zh1lYZYgdePZZ9inLBm9HCVV4A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6mrwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:36:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEaDxX012313;
 Wed, 14 May 2025 14:36:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6mrvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:36:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDg3as024449;
 Wed, 14 May 2025 14:36:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs4p0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:36:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEa16C30015974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:36:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D10745805A;
 Wed, 14 May 2025 14:36:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 701F958052;
 Wed, 14 May 2025 14:36:01 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:36:01 +0000 (GMT)
Message-ID: <44d9933c-bc59-4baa-aebd-2c6726a393ca@linux.ibm.com>
Date: Wed, 14 May 2025 09:36:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/50] ppc/xive: Fix pulling pool and phys contexts
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-17-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-17-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzMCBTYWx0ZWRfX0hil/Agy+b25
 DMpmgrJL5TqIckZCiLakhw/ifyXiXBKDFUGo2NzSDOlrA8xLpgX1+T3IMWK9UxKdrSYb1PNqM/B
 R8LM2np26I0xCtv0j93NsLk+aYKpOFHBKgQFA28/yegBCUNawqJmXeJOL1Q082s+JQoJst/okPT
 pBLGbBf1dPvDK8PwzJzxuFQ6dhjkj58uza6XtZ/8/mSbEOpLMRbLiKqO/v4fV8ZpD9T7kJWg4EE
 mx6kIHIfbN6qkCfdhQwwesYo5yQ4+icr2iQdEAPRiukW34R2A1KuD+2W4GfPLPdzkTMaAapo5MV
 0GY/BAwOq/5piz5ViOCZIg/LEL/lP4tKdvD8vY47XLYZLj5GqaJ12pNyirR2xhaLyyToAsECwq2
 eRSs3naV9iJPtgtol/6kqOExqb2QTOc52atvutbA2EgfDLeK6P+uhJWPJ18d3WHy6DbJnSrS
X-Proofpoint-ORIG-GUID: jedyu46ra6SnGcrXlDfPGhew3l7V22k8
X-Authority-Analysis: v=2.4 cv=d5f1yQjE c=1 sm=1 tr=0 ts=6824aa5e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Z2M4xorl1dFmOFgaFRYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ou-wyoNUxexElXllS9QKH8T-BUcejcPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=945 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:35 -0400
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


Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> This improves the implementation of pulling pool and phys contexts in
> XIVE1, by following closer the OS pulling code.
> 
> In particular, the old ring data is returned rather than the modified,
> and irq signals are reset on pull.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c2da23f9ea..1a94642c62 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -241,25 +241,75 @@ static uint64_t xive_tm_ack_hv_reg(XivePresenter *xptr, XiveTCTX *tctx,
>      return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
>  }
> 
> +static void xive_pool_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> +                                 uint32_t *nvt_idx, bool *vp)
> +{
> +    if (nvt_blk) {
> +        *nvt_blk = xive_nvt_blk(cam);
> +    }
> +    if (nvt_idx) {
> +        *nvt_idx = xive_nvt_idx(cam);
> +    }
> +    if (vp) {
> +        *vp = !!(cam & TM_QW2W2_VP);
> +    }
> +}
> +
> +static uint32_t xive_tctx_get_pool_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
> +                                       uint32_t *nvt_idx, bool *vp)
> +{
> +    uint32_t qw2w2 = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
> +    uint32_t cam = be32_to_cpu(qw2w2);
> +
> +    xive_pool_cam_decode(cam, nvt_blk, nvt_idx, vp);
> +    return qw2w2;
> +}
> +
> +static void xive_tctx_set_pool_cam(XiveTCTX *tctx, uint32_t qw2w2)
> +{
> +    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +}
> +
>  static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                        hwaddr offset, unsigned size)
>  {
> -    uint32_t qw2w2_prev = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>      uint32_t qw2w2;
> +    uint32_t qw2w2_new;
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool vp;
> 
> -    qw2w2 = xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
> -    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +    qw2w2 = xive_tctx_get_pool_cam(tctx, &nvt_blk, &nvt_idx, &vp);
> +
> +    if (!vp) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid POOL NVT %x/%x !?\n",
> +                      nvt_blk, nvt_idx);
> +    }
> +
> +    /* Invalidate CAM line */
> +    qw2w2_new = xive_set_field32(TM_QW2W2_VP, qw2w2, 0);
> +    xive_tctx_set_pool_cam(tctx, qw2w2_new);
> +
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
> +    xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
>      return qw2w2;
>  }
> 
>  static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                        hwaddr offset, unsigned size)
>  {
> -    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> -    uint8_t qw3b8;
> +    uint8_t qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    uint8_t qw3b8_new;
> +
> +    qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    if (!(qw3b8 & TM_QW3B8_VT)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid PHYS thread!?\n");
> +    }
> +    qw3b8_new = qw3b8 & ~TM_QW3B8_VT;
> +    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8_new;
> 
> -    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
> -    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
> +    xive_tctx_reset_signal(tctx, TM_QW3_HV_PHYS);
>      return qw3b8;
>  }
> 
> @@ -489,7 +539,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      qw1w2 = xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
> 
>      if (!vo) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x !?\n",
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid OS NVT %x/%x !?\n",
>                        nvt_blk, nvt_idx);
>      }
> 


