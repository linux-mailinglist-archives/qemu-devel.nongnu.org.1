Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD482A4E4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhpv-0001UX-MI; Wed, 10 Jan 2024 18:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNhpa-0001F3-DG; Wed, 10 Jan 2024 18:17:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNhpY-0002IA-R4; Wed, 10 Jan 2024 18:17:54 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AMvXS1006150; Wed, 10 Jan 2024 23:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CJswFmRWSp5Rg893I6qlcgWxDqaJpvGjsJ2AF4UWe0s=;
 b=kVXpxKgP3h8xEJjK9ayqlv1Fw3rariv+XaoPApr06nGbgx2DJE7obaP3z5kI4DwgWiYv
 pwtNTngg2fSWDlQiMmkIA7su4UZH1RrzLlBXEv/rH2733KM9vKyEqXNDU1z+My7AmEPf
 Pt0eSQ6UDhAfRyM27a7G+tuca/Usw+TgFzGspwyU70KbmDn3eBUvhDj2Xp/2tGIiOFp8
 YKyQvM/MkUvGQ9dTZLXLM1tsGu7P+cOmoSf/9HPrzNKTSa/SagFj5RtifEI02FKvOkF1
 HOiB4CJTX4BBLrI41CRTxc3yVLJXpONi0RNpcHJi2QKcu+yhmdZybAJYyQZjpsxRAIhI lA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vj4g0gff3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 23:17:36 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AN9daS009235;
 Wed, 10 Jan 2024 23:17:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vj4g0gfee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 23:17:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AMlhpd000926; Wed, 10 Jan 2024 23:17:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdkftpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 23:17:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40ANHYte24838870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 23:17:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FCD65803F;
 Wed, 10 Jan 2024 23:17:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 281C158060;
 Wed, 10 Jan 2024 23:17:34 +0000 (GMT)
Received: from [9.61.76.45] (unknown [9.61.76.45])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jan 2024 23:17:34 +0000 (GMT)
Message-ID: <9da3b6c6-631d-48c4-8af7-2b9e25393008@linux.ibm.com>
Date: Wed, 10 Jan 2024 17:17:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Introduce model for IBM's FSI
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <d9d29531-e3a1-4f16-b0af-f9328d72508f@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <d9d29531-e3a1-4f16-b0af-f9328d72508f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fs6dPg8UM9rPEep_bQ3K75wW_cE9yJGg
X-Proofpoint-GUID: ka680qEjeqYpwGU67y3o7d6uWlRIPO62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_12,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=757 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100184
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Cedric,


>>   include/hw/fsi/aspeed-apb2opb.h |  34 ++++
>
> aspeed-apb2opb is a HW logic bridging the FSI world and Aspeed. It
> doesn't belong to the FSI susbsytem. Since we don't have a directory
> for platform specific devices, I think the model shoud go under hw/misc/.
>
Moved it to hw/misc directory
>
>>   include/hw/fsi/cfam.h           |  45 +++++
>
> scratchpad is the only lbus device and it is quite generic, we could
> move it to lbus files. It would be nice to implement more than one
> reg.
Moved scratchpad to lbus files.
>
>
>>   include/hw/fsi/fsi-master.h     |  32 ++++
>>   include/hw/fsi/fsi-slave.h      |  29 +++
>>   include/hw/fsi/fsi.h            |  24 +++
>
> I would move the definitions and implementation of the fsi bus and
> the fsi slave under the fsi.h and fsi.c files
Moved fsi-slave to fsi files.
>
>
>>   include/hw/fsi/lbus.h           |  40 ++++
>>   include/hw/fsi/opb.h            |  25 +++
>
> opb is quite minimal now and I think it could be hidden under
> aspeed-apb2opb.
Moved opb to aspeed-apb2opb files.
>
>>   hw/fsi/Kconfig                  |  21 +++
>
> one CONFIG_FSI option and one CONFIG_FSI_APB2OPB should be enough.
> CONFIG_FSI_APB2OPB should select FSI and depends on CONFIG_ASPEED_SOC.
Reduced number of configs as you suggested.

Thanks for the review.

Regards,

Ninad


