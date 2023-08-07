Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B852772C9D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:19:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3s4-00038d-0q; Mon, 07 Aug 2023 13:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qT3s1-00038T-0l
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:18:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qT3rz-0003Dc-BX
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:18:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377HGHYi003833; Mon, 7 Aug 2023 17:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+ZrixFdtDTC1icQ+p68pMSYuvefbURPH6lDfj7CKXMg=;
 b=Q2Z6zVnTKinDLm6hD73tb/gttyf6PHqI5T5NEOYecvEITDAng5yenzgsvRR3xoLxQzgb
 TQ5guyOwrzeyBIgHRAzDhuhgarS77d1OmHN+cTFMhLVW+n9mF4b0kvM2qpBW5slA5gVE
 liZEAaGyon7FHzHt/rGj5o/Whlwt7EA7IVvSUoa9soFuRJcoGSTzJFA2o5f1i2YtmW6I
 KjXl7GHqffID3jHZJo8aPV+jvRtrX9N2+dHpe27YlGJqAo+W6Pelx4pfrNQJghv7WTMw
 6purHChFPFGzjVPD8WtloT/APM/fozkxqAJlK6WBlPu2aRXLWWYZJ9MQXZqwPTNb44KK JA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb4v0017a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 17:18:13 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377HHc38010289;
 Mon, 7 Aug 2023 17:18:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb4v0011y-13
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 17:18:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377Gf13B007592; Mon, 7 Aug 2023 16:53:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14xy4hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:53:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377GrRtZ41746886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 16:53:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F2B2004B;
 Mon,  7 Aug 2023 16:53:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AE7A20043;
 Mon,  7 Aug 2023 16:53:27 +0000 (GMT)
Received: from [9.179.26.52] (unknown [9.179.26.52])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 16:53:27 +0000 (GMT)
Message-ID: <6420392676438a75c2696236299d7b31abe12bd0.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] linux-user: cleanup unused linux-user/include/host
 directories
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org
Date: Mon, 07 Aug 2023 18:53:27 +0200
In-Reply-To: <20230807094807.471646-3-pbonzini@redhat.com>
References: <20230807094807.471646-1-pbonzini@redhat.com>
 <20230807094807.471646-3-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HaX9lTRZgH0jriBjWVKHdMM0RG4KO3SO
X-Proofpoint-GUID: wR8-yMlXEG7BIIl6f9qJbrkQX24m8vgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_18,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=905 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070158
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

On Mon, 2023-08-07 at 11:48 +0200, Paolo Bonzini wrote:
> Alpha and 31-bit s390 lack the assembly fragment to handle signals
> occurring at the same time as system calls, so they cannot run
> linux-user emulation anymore.=C2=A0 Drop the host-signal.h files for
> them.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0linux-user/include/host/alpha/host-signal.h |=C2=A0 55 --------
> =C2=A0linux-user/include/host/s390/host-signal.h=C2=A0 | 138 ------------=
------
> --
> =C2=A02 files changed, 193 deletions(-)
> =C2=A0delete mode 100644 linux-user/include/host/alpha/host-signal.h
> =C2=A0delete mode 100644 linux-user/include/host/s390/host-signal.h

s390/host-signal.h is included by s390x/host-signal.h, so on a (64-bit)
s390x host I get:

In file included from ../linux-user/signal.c:33:
../linux-user/include/host/s390x/host-signal.h:1:10: fatal error:
../s390/host-signal.h: No such file or directory
    1 | #include "../s390/host-signal.h"

