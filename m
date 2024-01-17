Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310A83092C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:07:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7Vj-0008SF-GB; Wed, 17 Jan 2024 10:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7Vd-0008QL-7X; Wed, 17 Jan 2024 10:07:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7Va-0004bI-P6; Wed, 17 Jan 2024 10:07:16 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HF2EOf001439; Wed, 17 Jan 2024 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DizgWx7ltXSyyQDh2Gyuj4y5APU6xm7ywnKywfVQcVg=;
 b=czipE1i/z86oXM3NZQiDbmQcy8CKiktbtJFOhzLqEXwIvr5dKBR+A6Ucku83Xnpe5+Cf
 /uPccnxXaEQ2yK9iy0+6QNaS6Cy0xfbuJlG6eS4xdFzf1Jp3BnGP0wfgcCOMJabfqJou
 iJdv3TW6+7Phx7LOAglsxmYJA+j28NHCTuXYMZNfnp0bTvk24dTxV1jetTP/nFLkShq2
 2l1uQjgfMMtpYbbMhLcNZ9B623wWzlhsjzekQv+ZHiFEZ3W//QGdKmG80eAoTdexg0Kp
 IVcm/m1/N6FL8rb5kyvyjoHn1SRRYhTgmU6tdjioiUS2sTcxm9yXIihSoWLw7/gK7vli pA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph66g8gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:07:10 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HF2fnd003194;
 Wed, 17 Jan 2024 15:07:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph66g8fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:07:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HEJDrO023373; Wed, 17 Jan 2024 15:07:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bknvf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:07:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HF77M949414882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:07:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B2D458056;
 Wed, 17 Jan 2024 15:07:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1BBD5803F;
 Wed, 17 Jan 2024 15:07:06 +0000 (GMT)
Received: from [9.61.163.245] (unknown [9.61.163.245])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 15:07:06 +0000 (GMT)
Message-ID: <94974eef-e894-4864-93a1-f3211c2d8b0a@linux.ibm.com>
Date: Wed, 17 Jan 2024 10:07:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, clg@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-4-mjrosato@linux.ibm.com>
 <6967e5faa99d1388bc2d1e0541163ef0bb97098d.camel@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <6967e5faa99d1388bc2d1e0541163ef0bb97098d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R1EZ1srJu929eV-kvcXYzcgZite8OwRF
X-Proofpoint-ORIG-GUID: S0fDeGn2kHrk3_RnVwEcVSoRxsIHAE5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=920 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170109
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 1/16/24 10:01 PM, Eric Farman wrote:
> On Tue, 2024-01-16 at 17:31 -0500, Matthew Rosato wrote:

>>  
>> +void s390_pci_ism_reset(void)
>> +{
>> +    S390pciState *s = s390_get_phb();
>> +
>> +    S390PCIBusDevice *pbdev, *next;
>> +
>> +    /* Trigger reset event for each passthrough ISM device currently
>> in-use */
>> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
>> +        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
>> +            pbdev->fh & FH_MASK_ENABLE) {
>> +            s390_pci_kvm_aif_disable(pbdev);
>> +
>> +            pci_device_reset(pbdev->pdev);
> 
> Do we care about the loss of a reset for ISM devices in a
> !interpretation case? (I seem to think such a configuration is not
> possible today, and so we don't care, but could use a reminder.)
> 

ISM passthrough is currently only allowed when interpretation is enabled.  So the check is redundant today but allows us to re-evaluate the need if we ever add support for ISM without interpretation.


