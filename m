Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302878E761
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:50:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcRb-000113-NM; Thu, 31 Aug 2023 03:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcRa-00010k-7x; Thu, 31 Aug 2023 03:50:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcRX-000126-Sp; Thu, 31 Aug 2023 03:50:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V7ao1L027278; Thu, 31 Aug 2023 07:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ma8UKPtB5xEuOdOJpskE061heCJL7IlVcD15CQlsJCY=;
 b=NdW8EgfppnCx1oTJkWk26nFdDkDr0EcLhZH7AAiPIp2jHL0kyZMffiXkyQkNUKRVkYdM
 e757MQH1ytb9DbE1AVHLyCB+inqk+alV3/wfDKzbJF6KpoDgwPX1rXbH0xgV6EBgkChY
 pPNKwjuKRFQhTvYgRpv9draGo7ifo+RG+V15rcCHVigniyuRVAKxlVIcme+t/NZhOrzM
 s3loiKxq/pjzFrIbhUdIyR7sZR6nC+mL/3gPS4SiMjkCHoPUdPf1SW66/y1tSacvYLq5
 Yjv9NFgupSx3fqO3huzCMc3Hri4t95voD3CkVOfJ6DMDd1tD4tp6fCkoDz4ThvRkdQW0 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3std7xbjbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:50:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37V7lDbq000943;
 Thu, 31 Aug 2023 07:50:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3std7xbjbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:50:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V5uYfL004946; Thu, 31 Aug 2023 07:50:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqt305k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:50:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37V7oC2o43450964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 07:50:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED1B220043;
 Thu, 31 Aug 2023 07:50:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A821C20040;
 Thu, 31 Aug 2023 07:50:11 +0000 (GMT)
Received: from [9.179.13.135] (unknown [9.179.13.135])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 31 Aug 2023 07:50:11 +0000 (GMT)
Message-ID: <a835ad10-0de5-7364-ab4c-444b8b9fd94e@linux.ibm.com>
Date: Thu, 31 Aug 2023 09:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] ppc/xive: Introduce a new XiveRouter end_notify()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230829143236.219348-1-clg@kaod.org>
 <20230829143236.219348-3-clg@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230829143236.219348-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3kyo9wtZDwSJTuTc5p_E4rDE1opOsOdY
X-Proofpoint-ORIG-GUID: MVsvhpr2M3egoBwFqMNYfXPZJgzCJyh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_05,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 29/08/2023 16:32, Cédric Le Goater wrote:
> It will help us model the END triggers on the PowerNV machine, which
> can be rerouted to another interrupt controller.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---



> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 56670b2cac6e..df3ee0496fe7 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1518,6 +1518,13 @@ static void xive_router_realize(DeviceState *dev, Error **errp)
>       assert(xrtr->xfb);
>   }
>   
> +static void xive_router_end_notify_handler(XiveRouter *xrtr, XiveEAS *eas)
> +{
> +    XiveRouterClass *xrc = XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->end_notify(xrtr, eas);
> +}
> +
>   /*
>    * Encode the HW CAM line in the block group mode format :
>    *
> @@ -1664,8 +1671,7 @@ static bool xive_router_end_es_notify(XiveRouter *xrtr, uint8_t end_blk,
>    * another chip. We don't model the PowerBus but the END trigger
>    * message has the same parameters than in the function below.
>    */
> -static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
> -                                   uint32_t end_idx, uint32_t end_data)
> +void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>   {
>       XiveEND end;
>       uint8_t priority;
> @@ -1675,6 +1681,10 @@ static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
>       XiveNVT nvt;
>       bool found;
>   
> +    uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
> +    uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
> +    uint32_t end_data = xive_get_field64(EAS_END_DATA,  eas->w);
> +
>       /* END cache lookup */
>       if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_blk,
> @@ -1817,10 +1827,7 @@ do_escalation:
>       /*
>        * The END trigger becomes an Escalation trigger
>        */
> -    xive_router_end_notify(xrtr,
> -                           xive_get_field32(END_W4_ESC_END_BLOCK, end.w4),
> -                           xive_get_field32(END_W4_ESC_END_INDEX, end.w4),
> -                           xive_get_field32(END_W5_ESC_END_DATA,  end.w5));
> +    xive_router_end_notify_handler(xrtr, (XiveEAS *) &end.w4);


I didn't like the cast, but I can see why you're doing it this way. We 
should be fine as long as the notify handler is not testing the validity 
bit of the EAS structure.

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   }
>   
>   void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
> @@ -1871,10 +1878,7 @@ void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>       /*
>        * The event trigger becomes an END trigger
>        */
> -    xive_router_end_notify(xrtr,
> -                           xive_get_field64(EAS_END_BLOCK, eas.w),
> -                           xive_get_field64(EAS_END_INDEX, eas.w),
> -                           xive_get_field64(EAS_END_DATA,  eas.w));
> +    xive_router_end_notify_handler(xrtr, &eas);
>   }
>   
>   static Property xive_router_properties[] = {
> @@ -1887,12 +1891,16 @@ static void xive_router_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
> +    XiveRouterClass *xrc = XIVE_ROUTER_CLASS(klass);
>   
>       dc->desc    = "XIVE Router Engine";
>       device_class_set_props(dc, xive_router_properties);
>       /* Parent is SysBusDeviceClass. No need to call its realize hook */
>       dc->realize = xive_router_realize;
>       xnc->notify = xive_router_notify;
> +
> +    /* By default, the router handles END triggers locally */
> +    xrc->end_notify = xive_router_end_notify;
>   }
>   
>   static const TypeInfo xive_router_info = {

