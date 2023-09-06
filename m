Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EA793DEB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdso0-0000n2-4u; Wed, 06 Sep 2023 09:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qdsnx-0000mo-MD; Wed, 06 Sep 2023 09:42:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qdsnu-0002Iv-Sm; Wed, 06 Sep 2023 09:42:49 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386DXvkW018015; Wed, 6 Sep 2023 13:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=utCYaSnmHbv/UwgQ/r89M64gnfKcXlWVSZODoE7eI0o=;
 b=GFY5hJBKlROFvaNUQ0NjwfJTOrz9/rrvXlYkm5CPVL0L33+2BAZemu2V2xNYGlsajD+C
 gpY5QcwGfBKR8NIq4OFz0isTRRL4lhYZy8o9uK1YgX51J1hRLxH2CaLkiB+DyXEWJQjA
 ft2LHJ4bEIb8ursCJdVQK6sE5QhHv/luA3mzL71L2dXUuFP311UECqLMSGabTzreczXb
 vq5c6giDUWiED9BOGRYU+e0UbAb7HLsHqm47WFtMH2FhupulXtDWR8/681DPkM8vjmxg
 ASxfcPj9oHqtOGj571nozk2avKEFN8QzteMQzOwJypp2kQEWr/1ZPwIYado8tDDmEXDT 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxtdtrmxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 13:42:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386DY5th018854;
 Wed, 6 Sep 2023 13:42:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxtdtrkhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 13:42:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 386DbP7o026818; Wed, 6 Sep 2023 13:41:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcnk6cf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 13:41:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 386DfHnn17826330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 13:41:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D518E20049;
 Wed,  6 Sep 2023 13:41:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6632120040;
 Wed,  6 Sep 2023 13:41:17 +0000 (GMT)
Received: from [9.171.93.132] (unknown [9.171.93.132])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 13:41:17 +0000 (GMT)
Message-ID: <b32fe1b9-e05d-971b-41d7-0ab925853014@linux.ibm.com>
Date: Wed, 6 Sep 2023 15:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] s390x: do a subsystem reset before the unprotect on reboot
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, seiden@linux.ibm.com, mhartmay@linux.ibm.com,
 thuth@redhat.com, david@redhat.com, mimu@linux.ibm.com
References: <80b007e8-91d7-8298-f628-77c30616f0f4@linux.ibm.com>
 <20230901114851.154357-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230901114851.154357-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G0b1vk-anP-pOTjEUXD1pM0XNLa5dCda
X-Proofpoint-ORIG-GUID: v1qnsHuzeILXbn71eBpGA-dVFOeZORsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060117
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 01.09.23 um 13:48 schrieb Janosch Frank:
> Bound APQNs have to be reset before tearing down the secure config via
> s390_machine_unprotect(). Otherwise the Ultravisor will return a error
> code.
> 
> So let's do a subsystem_reset() which includes a AP reset before the
> unprotect call. We'll do a full device_reset() afterwards which will
> reset some devices twice. That's ok since we can't move the
> device_reset() before the unprotect as it includes a CPU clear reset
> which the Ultravisor does not expect at that point in time.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Makes sense.
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
> 
> I'm not able to test this for the PV AP case right new, that has to
> wait to early next week. However Marc told me that the non-AP PV test
> works fine now.
> 
> ---
>   hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3dd0b2372d..2d75f2131f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
>       switch (reset_type) {
>       case S390_RESET_EXTERNAL:
>       case S390_RESET_REIPL:
> +        /*
> +         * Reset the subsystem which includes a AP reset. If a PV
> +         * guest had APQNs attached the AP reset is a prerequisite to
> +         * unprotecting since the UV checks if all APQNs are reset.
> +         */
> +        subsystem_reset();
>           if (s390_is_pv()) {
>               s390_machine_unprotect(ms);
>           }
>   
> +        /*
> +         * Device reset includes CPU clear resets so this has to be
> +         * done AFTER the unprotect call above.
> +         */
>           qemu_devices_reset(reason);
>           s390_crypto_reset();
>   

