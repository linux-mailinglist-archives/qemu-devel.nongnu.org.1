Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A773E294
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:55:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDnbv-0006Bw-1t; Mon, 26 Jun 2023 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qDnbs-0006Bh-7h; Mon, 26 Jun 2023 10:54:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qDnbp-0001w5-Hi; Mon, 26 Jun 2023 10:54:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QEes7h024717; Mon, 26 Jun 2023 14:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lsBzG9OpdEr2fWOQw8j5i0mv0Dop1a2UkXHXzMHa+UM=;
 b=cS4qVHKhIwXAvyqQtdwq5D0iJQKygyu3+E7T4tLnkXrkO247fW0VO8b2pdZ8r8V3XdVe
 J8TZY46fEjyZOaHsBwHFmWhrJpVG5khsfmZ75nmeVQhJUZ7urIrUl53CTuWCSPaUbT6y
 UsxcuMB5dsPmoV93PWDDUMIgIYp3juDh86foom/1IpU98zmRnEU0ZQ/FTDTwnGbRS8M1
 dwI1XY3/Q7s2+04MDuxMNFlgHIQDemI2W0igy07m8F1aDRgORNoX2Zotb49mnXScZSfd
 43c7g4AfdG3rYVmS2IeicQGYTVN7S1O6Yc56KJ9sKFAH2pO5uAKf3nKpzSTdGrWQn35B nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfcccrnc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 14:54:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35QEfiIR028220;
 Mon, 26 Jun 2023 14:54:18 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfcccrnb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 14:54:18 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q2U9Mf012264;
 Mon, 26 Jun 2023 14:54:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr451068-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 14:54:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35QEsDCP11403836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 14:54:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1ED20043;
 Mon, 26 Jun 2023 14:54:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DBEC20040;
 Mon, 26 Jun 2023 14:54:13 +0000 (GMT)
Received: from [9.171.45.40] (unknown [9.171.45.40])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jun 2023 14:54:12 +0000 (GMT)
Message-ID: <a807476d-fe97-3c05-32d2-371b0a82b92a@linux.ibm.com>
Date: Mon, 26 Jun 2023 16:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] pc-bios/s390-ccw: Move the stack array into start.S
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mrezanin@redhat.com,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230626132138.87668-1-thuth@redhat.com>
 <20230626132138.87668-4-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230626132138.87668-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EuhSQDBsvrdvBfx-yPglFJ_uShAidi18
X-Proofpoint-GUID: 65EsWO0st5PJiGXeIU7f6f6NSlhQs0YM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_11,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260131
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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


Am 26.06.23 um 15:21 schrieb Thomas Huth:

> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 29b0a9ece0..47ef6e8aa8 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -120,3 +120,8 @@ external_new_mask:
>       .quad   0x0000000180000000
>   io_new_mask:
>       .quad   0x0000000180000000
> +
> +.bss
> +
> +    .align  16
> +    .lcomm  stack,STACK_SIZE

IIRC, the ELF ABI defines the stack to be 8 byte aligned, but 16 certainly does not hurt.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


