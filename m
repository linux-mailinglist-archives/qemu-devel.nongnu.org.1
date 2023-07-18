Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F199757F45
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLlW5-0007jV-Uq; Tue, 18 Jul 2023 10:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qLlVg-0007h3-52
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:17:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qLlVa-0001bi-AN
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:17:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IEBqTv022034; Tue, 18 Jul 2023 14:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZNizKD5kmuuegXnJsVdOzTRJAwGJlkORZD0EiVTHoTo=;
 b=KD+12hZbfFZYy/hXNjHJuvT4Z1wt0XZXiQvebBrKirg7tfF3l1qIbDzJlezHnrAogXWc
 UHA+nCIRwRyRYJxg5ur2vnvdWkplqc7LBL9AFzENl8Kt5TwcbNULefa/dvGXeggOKaAs
 hH4RzWIqkYP43g0Sgiduacit+YrdiGBhrIgiHd+yIIC+NlLBRwhqxs0PXyNtMDF9TS9h
 SAjMfWJJ9xrUdnrhTxs0YiDwO7dbBCveKYb1yFmQ7k681jws5MM35izqyDRp20X8W/IS
 +YNOn9tLw2UO1BckQ+6qNCw29sTgTnI0D5y5DgkXYPP8a0PwT/hcmWBoPZQ1p021O8UQ Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwueghnnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 14:16:54 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IECGBw024235;
 Tue, 18 Jul 2023 14:16:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwueghnmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 14:16:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I73Wqc003394; Tue, 18 Jul 2023 14:16:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xd8cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 14:16:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36IEGqg029426364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 14:16:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ACBD58059;
 Tue, 18 Jul 2023 14:16:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BF2E58043;
 Tue, 18 Jul 2023 14:16:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 14:16:51 +0000 (GMT)
Message-ID: <efb02b9c-e8ff-c78f-b4c0-10dc0f41bb16@linux.ibm.com>
Date: Tue, 18 Jul 2023 10:16:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/11] tpm_crb: use the ISA bus
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-6-j@getutm.app>
 <20230717154630.64759bd1@imammedo.users.ipa.redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230717154630.64759bd1@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QZ16b7phS4tQu9PeJ7CoUNFS3-IYfz4W
X-Proofpoint-ORIG-GUID: Lsa6E5cMLJwnRvyyoXYBvO5gM3kN7C6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_10,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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



On 7/17/23 09:46, Igor Mammedov wrote:
> On Fri, 14 Jul 2023 00:09:21 -0700
> Joelle van Dyne <j@getutm.app> wrote:
> 
>> Since this device is gated to only build for targets with the PC
>> configuration, we should use the ISA bus like with TPM TIS.
> 
> does it affect migration in any way?
>  From guest pov it looks like there a new ISA device will appear
> and then if you do ping pong migration between old - new QEMU will really it work?


> 
> If it will, then commit message here shall describe why it safe and why it works
> 
I would just leave the existing device as-is. This seems safest and we know thta it works.
    Stefan

