Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3897A5CBF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:40:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWGS-0002Ls-Bn; Tue, 19 Sep 2023 04:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiWGG-00027b-RH; Tue, 19 Sep 2023 04:39:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiWGB-0005lE-A8; Tue, 19 Sep 2023 04:39:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8aRAs030819; Tue, 19 Sep 2023 08:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lezfYbjDjlGWTIWOIwy0gNVRg/vwNXUINqNuoBQUjj8=;
 b=Zt1RrBd7FMz6vmBO2ObRZIqhZ5sZvCqzdHPSpPFwp7a5ocbnRgGko7SXjMRtofkpQP85
 A/FRb37TkEBYTKMDQU97m2AJY+x/+lPdFnNn15A5KB3cw1WCne/2hVBOUa1YIqJWplQr
 lxcEmqjGDeERzhNxXOBpmhuc/yPsnwfF7zvtBKLQU8fMt35wOJJay3O8Zv1xDZzQ2gFH
 bbng32Wvp+UE0SMcSQEq2kmzLEhTFRiUp/nfgTrJorcHG1sTFuGlAqY6n6Pth18a4sal
 0uNIrVAjRuO7bPE8hK6G0+oGn8kNg/Lju+sgPCkkLqmLkk+v3RLSj490qfB326yreWOK Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76tkabvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:39:00 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J8atZr001655;
 Tue, 19 Sep 2023 08:39:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76tkabuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:39:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J7kJNC016436; Tue, 19 Sep 2023 08:38:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1sx98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 08:38:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J8cw9153215666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 08:38:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AE0C58059;
 Tue, 19 Sep 2023 08:38:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EC2F58043;
 Tue, 19 Sep 2023 08:38:55 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 08:38:55 +0000 (GMT)
Message-ID: <6539ab03-b630-91d4-c36b-b74f0757709a@linux.ibm.com>
Date: Tue, 19 Sep 2023 14:08:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 7/8] spapr/pci: Clean up local variable shadowing in
 spapr_phb_realize()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-8-clg@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230918145850.241074-8-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3JZ1G2UQn_G13O2iJhhgSsVhc19XNcvT
X-Proofpoint-ORIG-GUID: DGlnkpUEe0JZQq9aamMEW8OnzokzvtUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=624 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/18/23 20:28, Cédric Le Goater wrote:
> Rename SysBusDevice variable to avoid this warning :
> 
>    ../hw/ppc/spapr_pci.c: In function ‘spapr_phb_realize’:
>    ../hw/ppc/spapr_pci.c:1872:24: warning: declaration of ‘s’ shadows a previous local [-Wshadow=local]
>     1872 |         SpaprPhbState *s;
>          |                        ^
>    ../hw/ppc/spapr_pci.c:1829:19: note: shadowed declaration is here
>     1829 |     SysBusDevice *s = SYS_BUS_DEVICE(dev);
>          |                   ^
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_pci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index ce1495931744..370c5a90f218 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1826,9 +1826,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>           (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                     TYPE_SPAPR_MACHINE);
>       SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
> -    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> -    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);

Declaration of SpaprPhbState *s later in the code could be brought here?

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> +    PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
>       MachineState *ms = MACHINE(spapr);
>       char *namebuf;
>       int i;

