Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD83773985
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 12:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTJXr-0003EE-1U; Tue, 08 Aug 2023 06:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qTJWt-0002kD-JU; Tue, 08 Aug 2023 06:01:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qTJWn-0006WQ-VS; Tue, 08 Aug 2023 06:01:31 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3789qXhf016060; Tue, 8 Aug 2023 10:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QC1kyAKm3sqR6i29Ud7yJR+MBThr2ov/qKAFfsfRU6I=;
 b=OOkbdP0VMuxyC5/1gBwqdoXA7WUD4CjlQvW/9icLPqbQDQ5yCOmCONQ5TDBgQhVhc+kK
 34+FVt3pfBkLc5xhyw+fvxx6cxcuoSNzsdJZnvGRC4sHKVS/3EeETSZko6tn47TMVhko
 4kr974970e6hY/HXFe+M+nAb5ZDkWvNnqTxpd0U+zgMSh2D5/JM9diu/jRhU93P88NYG
 64UH5tfWySvfgtky7DeM/pgiT3ey0/g8EptK+oPa4rnKK0zlqwVSdgv9sAtU+nYkT5BF
 DWIuTUBPN3qzf8IfU9K9WBjBIdTmoqGz3L3A+ZLtKVBjJBu+hmxauh5jEVNgGSCLXccd nQ== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbkey86sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 10:01:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3788vsG9030364; Tue, 8 Aug 2023 10:01:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn5eek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 10:01:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 378A11dj15008476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Aug 2023 10:01:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C758B2004B;
 Tue,  8 Aug 2023 10:01:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7049020040;
 Tue,  8 Aug 2023 10:01:01 +0000 (GMT)
Received: from [9.171.66.239] (unknown [9.171.66.239])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Aug 2023 10:01:01 +0000 (GMT)
Message-ID: <db9c8f96b7265ea64c4956c767e63c59e6f6c039.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] target/s390x: Use a 16-bit immediate in VREP
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Tue, 08 Aug 2023 12:01:01 +0200
In-Reply-To: <14b6e0d5-2824-5f9f-e9b6-dc15b0123742@tls.msk.ru>
References: <20230807163459.849766-1-iii@linux.ibm.com>
 <baa436ac-ffe4-8c7d-6eee-af9c26fe3c0f@redhat.com>
 <558af8b33fa9164b0a5a21f61aa583a3776784f7.camel@linux.ibm.com>
 <f4d98473-1ddd-e45c-ba01-767bde208a77@redhat.com>
 <14b6e0d5-2824-5f9f-e9b6-dc15b0123742@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TYdGVnTEavgpu3QGEg-tdc7nX-SMhbvy
X-Proofpoint-ORIG-GUID: TYdGVnTEavgpu3QGEg-tdc7nX-SMhbvy
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1011 adultscore=0 mlxlogscore=935 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308080086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

On Mon, 2023-08-07 at 20:27 +0300, Michael Tokarev wrote:
> > On 07.08.23 19:02, Ilya Leoshkevich wrote:
> ..>> None that I know of, but I thought this was still nice to have,
> and at
> > > the same time small enough to not cause any trouble.
>=20
> Ilya, do you have an idea why your messages don't reach qemu-stable@?
>=20
> I see e.g. David's replies to yuor messages in qemu-stable@ - this
> way
> I know you sent something, and copy that message from qemu-devel@.
>=20
> For example, this thread is shown in the archive with your messages
> unavailable:
>=20
> https://mail.gnu.org/archive/html/qemu-stable/2023-08/threads.html#00118

No, unfortunately I don't know. Everything looks normal on my end,
qemu-stable@ is properly Cc:ed and I don't see any typos.
I've sent a question about this to the mailing list owner.

