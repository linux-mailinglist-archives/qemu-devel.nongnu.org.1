Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63371A394
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kjJ-0003Xq-3R; Thu, 01 Jun 2023 12:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1q4kjC-0003VG-Bs; Thu, 01 Jun 2023 12:00:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mburton@quicinc.com>)
 id 1q4kj7-0001Pe-6N; Thu, 01 Jun 2023 12:00:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351AhO46030209; Thu, 1 Jun 2023 16:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=qcppdkim1;
 bh=jyY6kjFSaGcQJ+JYRuB30GPnDSNlestm6teiGorRjXY=;
 b=OApaPwoxp9kRuXHkvUgh27bX+u7zV097/FERJH5mAqiMg8T+ixnQ32gBecjxodh7fz1O
 x/XD1bgCLmqrfXiatiHUSb3P9W/T4xzUfeAz8DcR7HbC16o846yOZSrcIM8SHB5K1KW2
 mQsd+zOKXcE3gLk9RM36UHml16P1QfRqNv6UKniHEQ3mAKHzcYfbhUaFcQIjSA4dt+Xc
 UiBbfh1cUPA3DaHosdsEScUyUkxHYUgeeybzbyDPoIdoHKXk7lDIRRpCHO4H7B0btBLK
 +nbE3YO3HNOhN22SK9Ml8RRzy/vGaR4VcYGqbUS8N+dEDQrKNBuBCJeJxVnoRimd28Nw lA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxpt71cyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:00:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351G0Mbs008869
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 16:00:22 GMT
Received: from smtpclient.apple (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 09:00:19 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hvf: Handle EC_INSNABORT
From: Mark Burton <quic_mburton@quicinc.com>
In-Reply-To: <11f8fb60-abe7-d99d-c3bb-aaa405425668@quicinc.com>
Date: Thu, 1 Jun 2023 18:00:17 +0200
CC: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexander Graf <agraf@csgraf.de>, "open list:ARM TCG
 CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <B0A9BD1B-B98C-4710-987D-03ADDBB993B7@quicinc.com>
References: <20230601143312.69691-1-quic_acaggian@quicinc.com>
 <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
 <11f8fb60-abe7-d99d-c3bb-aaa405425668@quicinc.com>
To: Antonio Caggiano <quic_acaggian@quicinc.com>, Peter Maydell
 <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: Li3caJxjuFNmmt5y-ZamnEto8prUqREg
X-Proofpoint-GUID: Li3caJxjuFNmmt5y-ZamnEto8prUqREg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=967 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1011
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010139
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mburton@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch came from a discussion on the KVM call the other day.
It may well be the case there is a better/different implementation - so =
the patch is more by way of asking the question.

Re-phrasing your question - I think it boils down to =E2=80=9Cshould HVF =
(and KVM) support executing instructions from IO space?=E2=80=9D.

In that case, this is a =E2=80=98partial=E2=80=99 answer to providing =
such support for HVF - partial in that it relies upon a memory region =
being created =E2=80=9Cdynamically=E2=80=9D for the IO space that has =
been accessed as a side-effect of a normal access. In principle I think =
this is at least a reasonable approach to dynamically create memory =
regions in this way, potentially a cache could be constructed etc=E2=80=A6=
 of course the MR could be subsequently removed too=E2=80=A6. I=E2=80=99m =
less happy about it being a side-effect of a memory operation, but I =
don=E2=80=99t see a better path?

Perhaps there is a better way of handling this.

Cheers
Mark.




> On 1 Jun 2023, at 17:34, Antonio Caggiano <quic_acaggian@quicinc.com> =
wrote:
>=20
> Hi Peter,
>=20
> On 01/06/2023 16:58, Peter Maydell wrote:
>> On Thu, 1 Jun 2023 at 15:33, Antonio Caggiano =
<quic_acaggian@quicinc.com> wrote:
>>>=20
>>> Instead of aborting immediately, try reading the physical address =
where
>>> the instruction should be fetched by calling address_space_read. =
This
>>> would give any memory regions ops callback a chance to allocate =
and/or
>>> register an RAM/Alias memory region needed for resolving that =
physical
>>> address. Then, if the memory transaction is OK, retry HVF execution =
at
>>> the same PC.
>> What are the circumstances where this happens?
>> Do we try to support this on KVM ?
>=20
> We use qemu as a library and manage memory regions externally, =
allocating them on demand when there is a read or a write (through =
memory region ops callbacks).
>=20
> When enabling HVF, we hit an instruction abort on the very first =
instruction as there is no memory region alias for it yet in system =
memory.
>=20
>>> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>>> Co-authored-by: Mark Burton <quic_mburton@quicinc.com>
>>> ---
>>>  target/arm/hvf/hvf.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>=20
>>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>>> index ad65603445..6e527254b1 100644
>>> --- a/target/arm/hvf/hvf.c
>>> +++ b/target/arm/hvf/hvf.c
>>> @@ -1446,6 +1446,18 @@ int hvf_vcpu_exec(CPUState *cpu)
>>>              hvf_raise_exception(cpu, EXCP_UDEF, =
syn_uncategorized());
>>>          }
>>>          break;
>>> +    case EC_INSNABORT: {
>>> +        uint32_t sas =3D (syndrome >> 22) & 3;
>>> +        uint32_t len =3D 1 << sas;
>>> +        uint64_t val =3D 0;
>>> +
>>> +        MemTxResult res =3D address_space_read(
>>> +            &address_space_memory, =
hvf_exit->exception.physical_address,
>>> +            MEMTXATTRS_UNSPECIFIED, &val, len);
>>> +        assert(res =3D=3D MEMTX_OK);
>> You can't assert() this, it might not be true, especially if
>> we're here because hvf couldn't read from this address.
>=20
> The idea is to try reading so that memory region ops can create the =
Alias MR required, in which case it would return MEMTX_OK. In case of =
error, maybe we can just exit and report the error like the default =
case.
>=20
>>> +        flush_cpu_state(cpu);
>>> +        break;
>>> +    }
>>>      default:
>>>          cpu_synchronize_state(cpu);
>>>          trace_hvf_exit(syndrome, ec, env->pc);
>> thanks
>> -- PMM
>=20
> Cheers,
> Antonio


