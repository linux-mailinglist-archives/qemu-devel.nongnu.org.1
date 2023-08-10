Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2677837F
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 00:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDuX-0006K8-6k; Thu, 10 Aug 2023 18:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUDuU-0006Jz-Re
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:13:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUDuT-00085N-5u
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:13:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AMAeFt009908; Thu, 10 Aug 2023 22:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=U0aFoGFNwPNC+W9MexvYabnRQNywMjzwzQWnJVTXgSA=;
 b=eBjN+mgCOXCmx21WeD9V7Oahzff3MPUJnQntvlmlN40xPGxu3DRr9e7/DYdvqS15zU95
 hENB89XBAFYthv3Of3pUmOt7BgcsY2h3sXdBKJ+wyxVHoWpYdLEiHc4quFLj185oRa7O
 FOZ9QPOUkkAS5/uvc2flAFb3e8+PdQaPsv23MF/wQaqlsBGKm9BB+de/7CaNHDyUozxk
 67CqcIq9YJJhRvfQbCWDk5IJE4KvTnBrZR6G6VJ6a6hMhPFXdxbepm0x3E7zf9BpZf8W
 uTmU/+CvvQJc7gM+cu+YvzfFlnfo6k1fGE+6km0xU8K6ByiWIjWKsYmgV7RZoB0eZWf4 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd89e85e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 22:13:34 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37AMBb4u013011;
 Thu, 10 Aug 2023 22:13:34 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd89e85e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 22:13:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ALa7OC001802; Thu, 10 Aug 2023 22:13:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f2cxg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 22:13:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37AMDWYk15205056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 22:13:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19EAD20043;
 Thu, 10 Aug 2023 22:13:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B606820040;
 Thu, 10 Aug 2023 22:13:31 +0000 (GMT)
Received: from [9.171.63.20] (unknown [9.171.63.20])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 22:13:31 +0000 (GMT)
Message-ID: <2e293848cbacd4b048c32bdcbfd226b510066faa.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] linux-user: Fix the build on systems without
 MAP_SHARED_VALIDATE
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Date: Fri, 11 Aug 2023 00:13:31 +0200
In-Reply-To: <b662c6e4-8905-b6e0-c258-6985a35dd0e7@gmx.de>
References: <20230810215706.1394220-1-iii@linux.ibm.com>
 <20230810215706.1394220-3-iii@linux.ibm.com>
 <b662c6e4-8905-b6e0-c258-6985a35dd0e7@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EbF-Usjqo79q3T8uYsLGPRLoHtVc9004
X-Proofpoint-GUID: H89UW0YaPy1UWLgIJJsDbxNvtxDGOcjL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=665
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308100190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2023-08-11 at 00:03 +0200, Helge Deller wrote:
> On 8/10/23 23:51, Ilya Leoshkevich wrote:
> > CentOS 7 does not define MAP_SHARED_VALIDATE. Use a definition
> > provided
> > by the QEMU's copy of linux/mman.h.
> >=20
> > Fixes: 4b840f96096d ("linux-user: Populate more bits in
> > mmap_flags_tbl")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> Does it fix the missing MADV_WIPEONFORK as well?
> https://gitlab.com/qemu-project/qemu/-/issues/1824#note_1507837354
>=20
> Helge

What a coincidence, that multiple people ran into this on the same day.

This should be fixed by [3/3] of this series.

Best regards,
Ilya

