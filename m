Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B987D0BB0
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlmA-0006TG-MF; Fri, 20 Oct 2023 05:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtlm5-0006Sm-Nu; Fri, 20 Oct 2023 05:26:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtlm4-0003wY-10; Fri, 20 Oct 2023 05:26:33 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39K99ZwL016137; Fri, 20 Oct 2023 09:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3neMqrzf1wcm9TGYy6TmSjTOqZuUwgOb/cxUJHyKhm8=;
 b=NyRHOUfCJjCVnRgTuThb9HPLwIwWe+hUgcObKlINsrh8a4Jlt+Lw8qYhziaxI26whGzM
 TYIjJw5RFajzs7qnKGfeEt9AyvAUeJm26gDu7/MUbAB6wYaJvLwzUKO2WU4JYWTso2tg
 wHwRtOHNN0dp9p5J/4UqAdONaHgeIN2G/OrCn9NOGTb8VVo7ndDOiCEhcmC8nq7Yz2Nn
 Un54djHzDVVxiolY4a7LsjBiC3FcHdLwc//RxE5fnJt6HY/+ZA0KxFdH0askw/iCjiHn
 Usb6UGellXnJnoXwMnRpoSlXYpBEzinO8hMSR3TnSVAIpwN4OtM6YU27B2/vCRyxQMoK 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tupnxrm78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 09:26:29 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39K99s1L017868;
 Fri, 20 Oct 2023 09:26:29 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tupnxrm54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 09:26:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39K94ERI002779; Fri, 20 Oct 2023 09:26:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc44bkut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 09:26:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39K9QPn719595844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 09:26:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F04E20049;
 Fri, 20 Oct 2023 09:26:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5EAB20040;
 Fri, 20 Oct 2023 09:26:24 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.19.184]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 09:26:24 +0000 (GMT)
Message-ID: <5408668c13072f4afbfeeee05b7a340a0077e533.camel@linux.ibm.com>
Subject: Re: [PULL 06/25] s390x/cpu topology: resetting the
 Topology-Change-Report
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org
Date: Fri, 20 Oct 2023 11:26:24 +0200
In-Reply-To: <1fb044ef-2d63-4101-bc65-80133e9f7c5a@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
 <20231018130716.286638-7-thuth@redhat.com>
 <CAJSP0QXc1yeRYMaEZ_1cRc2d7_E2-vb7Ai4D2P0uRQYTqDqDsA@mail.gmail.com>
 <991f3195f7e4e3989e43e45e9e1910cda410c444.camel@linux.ibm.com>
 <1fb044ef-2d63-4101-bc65-80133e9f7c5a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l6Dj7q7ldmoc6X1LrYZ6hggw6BC3Zwh5
X-Proofpoint-ORIG-GUID: Z7dqSd2h025clWwoZ2OU1U2wxwQWFWZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 mlxlogscore=873 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2023-10-19 at 21:32 +0200, Thomas Huth wrote:

[...]

> Thanks, that seems to fix the issue with --enable-debug, too.
> I'll squash that into the related patch (also fixing the indentation in=
=20
> s390_has_topology()) and respin the pull request.
>=20
>   Thomas
>=20

Thanks!

