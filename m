Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D06177E5BF4
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 18:05:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0lyK-0001Uf-IF; Wed, 08 Nov 2023 12:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1r0lxz-0001U6-BL; Wed, 08 Nov 2023 12:03:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1r0lxf-0002O9-Tc; Wed, 08 Nov 2023 12:03:45 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A8GuLMX018205; Wed, 8 Nov 2023 17:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=WY15HxMwYzUesubXtvbUvd0VsLkEfoGgndHj6wHC51A=;
 b=Pq4hJ6/LA7UcsNkk8+IkL5VqMctbethsL462wwZsGRFP0sPfwke0K4dHY81rwWl3N1Zu
 mQ+Qj3WUXjRksEU4unVvmZTGS0SDOgGXB8BdU7ka7EjkC8NC5vGHNPcNLI98C8XLJq+A
 6dign1J66b3cbr3dt5+LYY71CDslwh1r2wVz/UjSq7evCBHAWy+/kwK2VIrV0VL5hAHj
 zFVR/uQwHRNVsdbrRJlD5zwekOK4hJ5fa/t0rPw9YaPhvlFleP907JqwXQcf2PZwcI1T
 vsKh1e//ZFAjCO6nbrjjoGDgScQQT5GlnHZz5Rfj8pjAag2dljyQ0AsDz672mGHQRYdd UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8dqn1j10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 17:03:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A8GvfPa024738;
 Wed, 8 Nov 2023 17:03:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8dqn1hyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 17:03:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A8GcNW3000726; Wed, 8 Nov 2023 17:03:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22x82p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 17:03:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A8H3Aef24052234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Nov 2023 17:03:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1E912004B;
 Wed,  8 Nov 2023 17:03:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A436F20040;
 Wed,  8 Nov 2023 17:03:10 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.152.224.212])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Nov 2023 17:03:10 +0000 (GMT)
Date: Wed, 8 Nov 2023 18:03:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix a couple s390 paths
Message-ID: <20231108180308.27d973d0.pasic@linux.ibm.com>
In-Reply-To: <20231020141509.2096591-1-farman@linux.ibm.com>
References: <20231020141509.2096591-1-farman@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uWq09R8KqoOkgjw_twqIulMfjI0J5XdT
X-Proofpoint-GUID: tzlyCTj2j4yyK3rX7CD6zJX9POvk3A2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_05,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=651 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311080141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 20 Oct 2023 16:15:09 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> : Fri, 20 Oct 2023 16:15:09 +0200
> X-Mailer: git-send-email 2.39.2
> 
> These are simple typos, since the directories don't exist but the
> files themselves do in hw/s390x/
> 
> Fixes: 56e3483402 ("MAINTAINERS: split out s390x sections")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by:  Halil Pasic <pasic@linux.ibm.com>

