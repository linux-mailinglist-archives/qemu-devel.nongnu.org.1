Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504F739896
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCF9c-0003W9-0t; Thu, 22 Jun 2023 03:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qCF9H-0003VD-1G; Thu, 22 Jun 2023 03:54:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qCF9E-0002PN-TS; Thu, 22 Jun 2023 03:54:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35M7axka020261; Thu, 22 Jun 2023 07:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5WhLJhmTPkUFVYUWT7oNAmD1bxuLuwPSbDN3NnGCuTE=;
 b=GpIsCMpIrnN44dfQGCcGDA71K3UakVzAK8dLwURkGu8nEjyOJUFB9ifWpKe2gx/zCqwx
 6zeqlwusgl/OGaL26u47gE+Xz9LCxBH2WnW/7CUvBESNqLtuOLTA7Qf1nRwuw7fTSCTv
 RO1T0U6UdD08K7jbNUSyz1QzBMysZUw4ET5EWgj8+Tnxe/mTkKgT3EhmVkMbqg8OWQkd
 /GTu1ehb7usaXpcC+f7mBLExBmduPve7lnJeekVeWP5FtzhpKVhfN8kcGJNluBfGWFW1
 RxYoyYVXOyIB5ha385Ym4ABbluTP8qk6BhAGL+azO10tqDsXMaoS7cDwPKEi0BUX8gKh Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchpe95x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 07:54:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35M7boCK027317;
 Thu, 22 Jun 2023 07:54:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchpe95wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 07:54:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M3u4nh028738;
 Thu, 22 Jun 2023 07:53:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r94f5ah2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 07:53:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35M7rjM623593668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 07:53:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0BEF20049;
 Thu, 22 Jun 2023 07:53:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DF9E20040;
 Thu, 22 Jun 2023 07:53:45 +0000 (GMT)
Received: from [9.171.58.93] (unknown [9.171.58.93])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jun 2023 07:53:45 +0000 (GMT)
Message-ID: <ab2be4bf-c100-80a4-47d3-c046ded43d61@linux.ibm.com>
Date: Thu, 22 Jun 2023 09:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 1/2] pnv/xive2: Add a get_config() method on the presenter
 class
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230621160306.896045-1-fbarrat@linux.ibm.com>
 <20230621160306.896045-2-fbarrat@linux.ibm.com>
 <a893b451-7262-c4ab-0564-fb5cb3618c5b@kaod.org>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <a893b451-7262-c4ab-0564-fb5cb3618c5b@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 61eN7_8jfm31V1ZQTGcmRA2wtcNyqIlT
X-Proofpoint-GUID: FqoSkEiAgp_VPF2Uhz_S5wNwDniFlRcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306220062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 22/06/2023 09:01, Cédric Le Goater wrote:
> On 6/21/23 18:03, Frederic Barrat wrote:
>> The presenters for xive on P9 and P10 are mostly similar but the
>> behavior can be tuned through a few CQ registers. This patch adds a
>> "get_config" method, which will allow to access that config from the
>> presenter in a later patch.
>> For now, just define the config for the TIMA version.
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> ---
>>   hw/intc/pnv_xive.c    | 11 +++++++++++
>>   hw/intc/pnv_xive2.c   | 12 ++++++++++++
> 
> spapr_xive.c needs an update too else QEMU will SEGV at first interrupt.


Sigh... I should really start using your qemu-ppc-boot tests.

   Fred

> 
> Thanks,
> 
> C.
> 
>>   hw/intc/xive.c        |  7 +++++++
>>   include/hw/ppc/xive.h |  3 +++
>>   4 files changed, 33 insertions(+)
>>
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index 622f9d28b7..e536b3ec26 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -479,6 +479,16 @@ static int pnv_xive_match_nvt(XivePresenter 
>> *xptr, uint8_t format,
>>       return count;
>>   }
>> +static uint32_t pnv_xive_presenter_get_config(XivePresenter *xptr)
>> +{
>> +    uint32_t cfg = 0;
>> +
>> +    /* TIMA GEN1 is all P9 knows */
>> +    cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;
>> +
>> +    return cfg;
>> +}
>> +
>>   static uint8_t pnv_xive_get_block_id(XiveRouter *xrtr)
>>   {
>>       return pnv_xive_block_id(PNV_XIVE(xrtr));
>> @@ -1991,6 +2001,7 @@ static void pnv_xive_class_init(ObjectClass 
>> *klass, void *data)
>>       xnc->notify = pnv_xive_notify;
>>       xpc->match_nvt  = pnv_xive_match_nvt;
>> +    xpc->get_config = pnv_xive_presenter_get_config;
>>   };
>>   static const TypeInfo pnv_xive_info = {
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index ec1edeb385..59534f6843 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -501,6 +501,17 @@ static int pnv_xive2_match_nvt(XivePresenter 
>> *xptr, uint8_t format,
>>       return count;
>>   }
>> +static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(xptr);
>> +    uint32_t cfg = 0;
>> +
>> +    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
>> +        cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;
>> +    }
>> +    return cfg;
>> +}
>> +
>>   static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
>>   {
>>       return pnv_xive2_block_id(PNV_XIVE2(xrtr));
>> @@ -1987,6 +1998,7 @@ static void pnv_xive2_class_init(ObjectClass 
>> *klass, void *data)
>>       xnc->notify    = pnv_xive2_notify;
>>       xpc->match_nvt  = pnv_xive2_match_nvt;
>> +    xpc->get_config = pnv_xive2_presenter_get_config;
>>   };
>>   static const TypeInfo pnv_xive2_info = {
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 5204c14b87..34a868b185 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -461,6 +461,13 @@ static void xive_tm_push_os_ctx(XivePresenter 
>> *xptr, XiveTCTX *tctx,
>>       }
>>   }
>> +static __attribute__((unused)) uint32_t 
>> xive_presenter_get_config(XivePresenter *xptr)
>> +{
>> +    XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
>> +
>> +    return xpc->get_config(xptr);
>> +}
>> +
>>   /*
>>    * Define a mapping of "special" operations depending on the TIMA page
>>    * offset and the size of the operation.
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index f7eea4ca81..3dfb06e002 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -430,6 +430,8 @@ typedef struct XivePresenterClass XivePresenterClass;
>>   DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
>>                          TYPE_XIVE_PRESENTER)
>> +#define XIVE_PRESENTER_GEN1_TIMA_OS     0x1
>> +
>>   struct XivePresenterClass {
>>       InterfaceClass parent;
>>       int (*match_nvt)(XivePresenter *xptr, uint8_t format,
>> @@ -437,6 +439,7 @@ struct XivePresenterClass {
>>                        bool cam_ignore, uint8_t priority,
>>                        uint32_t logic_serv, XiveTCTXMatch *match);
>>       bool (*in_kernel)(const XivePresenter *xptr);
>> +    uint32_t (*get_config)(XivePresenter *xptr);
>>   };
>>   int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> 

