Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A171F2DB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nrg-0004bi-9k; Thu, 01 Jun 2023 15:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1q4nrd-0004bO-3P; Thu, 01 Jun 2023 15:21:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1q4nrb-0004dL-3z; Thu, 01 Jun 2023 15:21:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351CcSqF013666; Thu, 1 Jun 2023 19:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=qcppdkim1;
 bh=jy7Vz7+QoAV1gYOjVqIajxeJCEfuMb3sj9YDg0s+HeQ=;
 b=IgxesAb7exQx6PXReL2H85A8gX0dBRTtVpw7QTTDOydOR352K2ryCLUQPwVc2KjFmiOt
 P5B99R2sEjt+FHRIXOCcF3miuENISgQdY0cwiwS2ojZ3IkTkHD2etl9DJvgMjDkL7pnN
 wgcrDlDmSj48RSx3Ghh1O7PoBALUv2fGoFolQpiIO9uLAYW9jqLRD4OI3UUe45s5eRXV
 75uIBKE3qaSQtgQ7Bq22gKHG5JheoW1nhW1T2evpiPqJur0YQ2C2qW6R+m9B6JNULSHs
 4PWBAVRnYafQOjdp7NuRo11QSNBhvXAsPyvBM8SZMmeoPSvgdaIGGOMOo6YwxnvtRc7L GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr8ytg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 19:21:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351JLRvF007729
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 19:21:27 GMT
Received: from smtpclient.apple (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 12:21:25 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hvf: Handle EC_INSNABORT
From: Mark Burton <quic_mburton@quicinc.com>
In-Reply-To: <CAFEAcA8tCZ0shxEiA4hOVsHhOBvGmQ6HLJq1dPKDuSqBXKdtJw@mail.gmail.com>
Date: Thu, 1 Jun 2023 21:21:21 +0200
CC: Antonio Caggiano <quic_acaggian@quicinc.com>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alexander Graf
 <agraf@csgraf.de>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <033C707D-C8DF-4DA7-BE50-F19DE2A17FB4@quicinc.com>
References: <20230601143312.69691-1-quic_acaggian@quicinc.com>
 <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
 <11f8fb60-abe7-d99d-c3bb-aaa405425668@quicinc.com>
 <B0A9BD1B-B98C-4710-987D-03ADDBB993B7@quicinc.com>
 <CAFEAcA8tCZ0shxEiA4hOVsHhOBvGmQ6HLJq1dPKDuSqBXKdtJw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: jL5a4r5oUDnE4qHSP8wyYbTb6lVt96Tw
X-Proofpoint-ORIG-GUID: jL5a4r5oUDnE4qHSP8wyYbTb6lVt96Tw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=637 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010167
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mburton@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



> On 1 Jun 2023, at 18:45, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> WARNING: This email originated from outside of Qualcomm. Please be =
wary of any links or attachments, and do not enable macros.
>=20
> On Thu, 1 Jun 2023 at 17:00, Mark Burton <quic_mburton@quicinc.com> =
wrote:
>> This patch came from a discussion on the KVM call the other day.
>> It may well be the case there is a better/different implementation
>> - so the patch is more by way of asking the question.
>>=20
>> Re-phrasing your question - I think it boils down to =E2=80=9Cshould =
HVF
>> (and KVM) support executing instructions from IO space?=E2=80=9D.
>=20
> I think this falls into "might theoretically be nice but is
> probably too painful to actually implement". In practice
> well-behaved guests don't try to execute out of MMIO devices.
>=20

>> In that case, this is a =E2=80=98partial=E2=80=99 answer to providing =
such
>> support for HVF - partial in that it relies upon a memory
>> region being created =E2=80=9Cdynamically=E2=80=9D for the IO space =
that
>> has been accessed as a side-effect of a normal access.
>=20
> But nothing in (upstream) QEMU magically creates MemoryRegions
> just because the guest tries to access them. Either there's
> nothing there in the AddressSpace at all (definitely can't
> execute from it) or there's already RAM (happy case) or there's
> already a device there. If there's already a device there
> then something would need to do a "put a bit of RAM in
> temporarily, fill in the single instruction by doing an
> address_space_read() to find the data value and writing it
> to the scratch RAM, tell KVM/HVF to do a single-step, undo
> everything again".
>=20

Indeed, that=E2=80=99s basically what we=E2=80=99re implementing. In TCG =
mode you =E2=80=99see=E2=80=99 the access, we=E2=80=99re just making it =
so that in HVF you equally =E2=80=98see=E2=80=99 such accesses to the =
=E2=80=98device=E2=80=99 (so you can put the bit of RAM in, out, shake =
it all about). A cleaner implementation may be some sort of =
=E2=80=9Cpre-i-side-access-op I=E2=80=99m about to access this =
device/address please register a =E2=80=98memory region=E2=80=99 I can =
use (temporarily)=E2=80=9D. I=E2=80=99d have thought that could be =
useful any time you execute from e.g. a temporary ram of any sort =
(whatever the accelerator).

Cheers
Mark.


> -- PMM


