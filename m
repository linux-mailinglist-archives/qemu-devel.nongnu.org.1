Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76D82B1CD
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:28:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwxj-00085U-0J; Thu, 11 Jan 2024 10:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rNwxg-000855-K2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:27:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rNwxf-0008S8-14
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:27:16 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BEkWfF025686
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p+3Ny6e3+4ReiHAKj1O0HLdaZk2IURCRHcWooOwP6Us=;
 b=o3gyc9lPKXfPtm/ZjZ3ZNaLzTzOwuyEfkAi9Qw4Fy731Kyq454m4+n6sp4k2XmeiA8XE
 FzZmG13C/IYkKFMPlT4wdbSs7+DE8/TDs8WF7OpeMOO59nwRCS4oUMaOD+l5y4PKlfzu
 2S68KzIjuKDN8rl0NalKQm1ugYHY8s8yhF45KywAvsdvXHBdPN2Guo1XPBLn0TI6h4Ug
 aZxR5pHqVoBDQMZdaZBBEbvQ4bNUuQlXV4fQY2LXcVS1L7fMb1c96nJoABQNaqKVfOy2
 W66VaXZye3PIwsJDORvfknIfAW5GORJpScfp1o83KYLj86nGw77L4Huke+zD0aACmgv7 ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj671hr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:27:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BEWHWq005542
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:27:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj671hq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 15:27:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BERMMh022781; Thu, 11 Jan 2024 15:27:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjyvcw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 15:27:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40BFRAuD3539672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 15:27:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A91458055;
 Thu, 11 Jan 2024 15:27:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9237B58059;
 Thu, 11 Jan 2024 15:27:09 +0000 (GMT)
Received: from [9.61.0.193] (unknown [9.61.0.193])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 15:27:09 +0000 (GMT)
Message-ID: <0021d6d6-7381-4c8a-a89e-3e65bf3cf3b4@linux.ibm.com>
Date: Thu, 11 Jan 2024 10:27:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] s390x: do a subsystem reset before the unprotect on
 reboot
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20230912114112.296428-1-thuth@redhat.com>
 <20230912114112.296428-3-thuth@redhat.com>
 <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
 <287dbe42-5a10-4667-b3fa-111270242b1d@linux.ibm.com>
 <e22ebb27-26d0-4e1d-86ab-ab9feb44d645@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <e22ebb27-26d0-4e1d-86ab-ab9feb44d645@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V9lbK8RQ_O5XBW2G1AXD0YW1_Xf22ltZ
X-Proofpoint-ORIG-GUID: bJsOq2YjOvulMrkqCeDK36JG4C6X2stq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_07,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=737 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110121
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

On 1/11/24 4:43 AM, Cédric Le Goater wrote:

> OK. this condition is considered serious enough to be reported to a
> management level. This seems a bit excessive since the recovery can be
> handled by software, but manually. Are there any plans to address this
> problem ?

Yes, eventually.  Currently for drivers other than QEMU+vfio-pci we rely on automated PCI recovery to handle this event, but today we do not forward the event to QEMU when using vfio-pci because the code in vfio_err_notifier_handler will halt the guest.  This leaves the device in an error state to be recovered manually.  The intent is to eventually address this by triggering the guest to initiate the recovery action rather than halting the guest for s390.




