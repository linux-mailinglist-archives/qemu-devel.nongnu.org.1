Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA275291E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJzW1-0001Tm-Gs; Thu, 13 Jul 2023 12:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJzVy-0001Ta-CQ
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:50:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJzVw-0005eM-07
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:50:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DGknAN001518; Thu, 13 Jul 2023 16:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vaIFl0aNZ0zlUJ1O2EirrDwYg8E6E4fXJZAwARSc4og=;
 b=fHq50nuIn9B2n9viPIvRD4TS+W+VFE2T3b51nSuIUeL35T5k1scYM0a0Uu1Pade4EZle
 mCquTx+hJKD9Xle/6lNijSMt9nsogSEkEpO2Xw0H1ABHvWFqMNWhDEs3l3HFmbYr9b2o
 VFWMMVWSW1XABBPvZ98e+b+2J7d+3xLFXvozRnSnpo2fJbhLuLslLCq7heGq8qR3vn/O
 SaWxJHc31mkb6Y+XzzbIPGva6WOzE0jMtgk9CrwV3Fs7oe9NahbzV98vJHkLB2Y0ijXX
 WTnHx/02GUUl36/fRvxt86mncqIKX1lnVXut67e/FNuJxricIQRDzvQE4A+l76xr1JYF Dw== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtn3dr1hp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:49:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DFXpUs019726; Thu, 13 Jul 2023 16:49:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqmu0vj3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:49:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DGnuhP62390652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 16:49:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DE405804E;
 Thu, 13 Jul 2023 16:49:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39BDE58055;
 Thu, 13 Jul 2023 16:49:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 16:49:56 +0000 (GMT)
Message-ID: <78bd19ff-709e-d152-ffe0-5d50ecb693c5@linux.ibm.com>
Date: Thu, 13 Jul 2023 12:49:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/11] tpm_tis_sysbus: fix crash when PPI is enabled
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-10-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-10-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kLIDaSZKuA61uxGVT3-sXYs6Ps_MGETs
X-Proofpoint-GUID: kLIDaSZKuA61uxGVT3-sXYs6Ps_MGETs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/12/23 23:51, Joelle van Dyne wrote:
> If 'ppi' property is set, then `tpm_ppi_reset` is called on reset
> which SEGFAULTs because `tpmppi->buf` is not allocated.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/tpm/tpm_tis_sysbus.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 45e63efd63..1014d5d993 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -124,6 +124,10 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>           error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> +
> +    if (s->ppi_enabled) {
> +        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ppi.ram);
> +    }
>   }
> 

The tpm-tis-device doesn't work for x86_64 but for aarch64.


We have this here in this file:

     DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),

I don't know whether ppi would work on aarch64. It needs firmware support like in edk2.
I think the best solution is to remove this DEFINE_PROP_BOOL() and if someone wants
to enable it they would have to add firmware support and test it before re-enabling it.

    Stefan

>   static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)

