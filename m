Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 063377619AB
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHvn-0002QD-1G; Tue, 25 Jul 2023 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Gautam.Menghani@linux.ibm.com>)
 id 1qOGPc-0003AV-O7; Tue, 25 Jul 2023 07:41:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Gautam.Menghani@linux.ibm.com>)
 id 1qOGPX-0008S8-Q5; Tue, 25 Jul 2023 07:41:07 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36PBdGWA004270; Tue, 25 Jul 2023 11:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RzoOkCAviU5sADUQwg/ZalFA9GQ7TH32hEjwN9XXz6Q=;
 b=OmfTkDk24/6WWgp8QiqkxZPPLGSgFnhhuk7bhOQHlWwP6dBTP0TpVKdVjH3ThEU6kCXV
 YE+sm02L6BaPXzrzB5EHVgSYNwrJ8akyfXd5tJzugr6f/qTo23cdeeC0fEIn1tLD1KNg
 hACZ6FtNSUpqCRxL1qzqjA0+IRFy+AHlgtlHsbzyN10QmLeVOESCN3dLUSXlwLc/zpuM
 5RArfaqODhmN8IyO3eN21XBr7ahQqGbEQfO8/4BvioNdN+IuTgbaOLbNwWfNRwTUQE9v
 fZwyQGfxPeSrI1VUmxCtZEhy0RfXwF8Jw5d6aKaJQYC+TdGyatk9VgsexE/XbAM1b10/ oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2batbsad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 11:40:52 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PBdrpA005719;
 Tue, 25 Jul 2023 11:40:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2batbsa4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 11:40:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36PAxHoP002059; Tue, 25 Jul 2023 11:40:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0temujwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 11:40:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36PBelCE35127638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jul 2023 11:40:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FACF20043;
 Tue, 25 Jul 2023 11:40:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25D4420040;
 Tue, 25 Jul 2023 11:40:45 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.204.206.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Jul 2023 11:40:44 +0000 (GMT)
Date: Tue, 25 Jul 2023 17:10:37 +0530
From: Gautam Menghani <Gautam.Menghani@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, danielhb413@gmail.com,
 harshpb@linux.ibm.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, fbarrat@linux.ibm.com
Subject: Re: [PATCH] ppc: spapr: Fix device tree entries in absence of XIVE
 native mode
Message-ID: <5qjfrlq4n7unowongoda3evmhmo5ivj6blmubwluwj5cfng4ju@z5ihjx5aheh4>
References: <20230630053056.14933-1-gautam@linux.ibm.com>
 <20230630085112.16d77032@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630085112.16d77032@bahia>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9pVd8Ng_WUUu141QTpsaAvgrOMPbx_1j
X-Proofpoint-GUID: 8g3xHVjxfee5JVg0jSW3XGs1wtqO1ZHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=782 impostorscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307250101
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=Gautam.Menghani@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jul 2023 09:18:23 -0400
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

Ok noted, thanks for the feedback Greg and Cedric.

Thanks,
Gautam

