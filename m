Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F527A959E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:47:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLsS-00051y-BU; Thu, 21 Sep 2023 11:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qjLsC-000514-Tq; Thu, 21 Sep 2023 11:45:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qjLs7-0003Va-83; Thu, 21 Sep 2023 11:45:48 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LFc4NZ010403; Thu, 21 Sep 2023 15:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=stYd+O9zrT72E52G9gqAe2M8o8+gYlYoMbKaTWAvG2o=;
 b=g+U3YDdi6vb0V9fO1W4cyTIoZ9nPqhlz34ZnY5GvYIcm2j5UrugQV34s5PctjTFCzZ0a
 /9YG6sbJpNoBCLH9JigsmwKsbp+9NZeChaKly7VTq0Kufu5nm4r8gWPjktt3v9ro1VK0
 xhjLVdc+bjSJuhM6EK6em7ip7ZoFQyOe1xuY9c1Kwdk0hgesMI6E8deuK6XycXsi5Z5R
 XamOtFN2ErYyJGsiWtjARXrZhWf7rnu7LjjGAwAuhhrRPXXYAoM1HD+emVzbBy0Q/PEQ
 2sUQqVgVmv8VBoZAzY4F9nr+K0FOYV2DxJZbyXR/SBDGB74FJLTwCK/qwps9FDJN2hFh Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t84py9deb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 15:45:29 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LFcMHB012086;
 Thu, 21 Sep 2023 15:45:29 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t84py9de3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 15:45:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LFGUR2016463; Thu, 21 Sep 2023 15:45:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd2mekx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 15:45:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38LFjRct28705186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Sep 2023 15:45:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D35305805F;
 Thu, 21 Sep 2023 15:45:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C53F58068;
 Thu, 21 Sep 2023 15:45:27 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Sep 2023 15:45:27 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 21 Sep 2023 10:45:26 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 2/4] target/ppc: Add recording of taken branches to BHRB
In-Reply-To: <955aa084c1e56559943f17514d7bed73@linux.vnet.ibm.com>
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202421.3381779-1-milesg@linux.vnet.ibm.com>
 <CVJ33XKZ3RO0.22BRA1VHY26PJ@wheely>
 <955aa084c1e56559943f17514d7bed73@linux.vnet.ibm.com>
Message-ID: <bd1fb03f3ec5a7da9201b1a20f146879@linux.vnet.ibm.com>
X-Sender: milesg@linux.vnet.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qYGoJQHfjU3KzlMRJ9er6gIbl9HPT25L
X-Proofpoint-GUID: NOAzsx5p75DeIEQSfD6Zv2ft_R2iP9sF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=475
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210134
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


>> It all looks pretty good otherwise. I do worry about POWER8/9 which
>> do not have BHRB disable bit. How much do they slow down I wonder?
> 
> That is a good question!  I'll see if I can get some linux boot times
> with and without the changes on P9.
> 

I ran some tests booting ubuntu 20.04 on the powrnv9 model and found
that it took about 5% longer to boot to the login prompt with the
changes than without.  As discussed offline, I'll remove this support
from P8/P9 as the 5% reduction in performance is not worth the added
functionality.  We could perhaps add it back in the future with a
command line option that has it disabled by default on P8/P9.

P10 and on has it disabled for non problem state branches, so we
should be good there.

Thanks,

Glenn

