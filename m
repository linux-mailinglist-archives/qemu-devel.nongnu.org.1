Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A607C52DD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 14:06:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqXxa-0002XL-Lg; Wed, 11 Oct 2023 08:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qqXxS-0002Un-SK; Wed, 11 Oct 2023 08:04:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qqXxO-00025k-WC; Wed, 11 Oct 2023 08:04:57 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BC2RhR012779; Wed, 11 Oct 2023 12:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sIYZ5bpGAyhUcpOk1tLABHpXbeZNvH5YEq10fa4k71c=;
 b=fWB9WIxsr9CsVdBP0uheww5pYXhLBwMiVm66UMp2dtLmRSlQe5aT4YTgImhKNets7UzE
 7yWNZVRQ8mywEas7Oipz4l/JJqGbRReeS6rbb8mJgdfGYM8J4pr5nt/Z9xX+Hap11qWU
 Zh3NjrHqVi3LwbJ2AcmZai5u84aSGOPF/EtCe4oSFpXO1FL9geUp5zjZFyLsKejyQfiq
 Ah9zT1pICAUgYckobCcbnnfq3j0xQF2LPXvYm40J9hfzdjt5szg+dwsH8IaDHKectRG/
 hLoCPUv4782+pwtGrLHkQl8fNm81vb5f6MKH/m+cSnNFxHus9AvSlu1T9i9lSkFmfOfx tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnuc2g22y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 12:03:36 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BC3A71016755;
 Wed, 11 Oct 2023 12:03:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnuc2g1td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 12:03:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39B9V2kx000653; Wed, 11 Oct 2023 11:58:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kqjne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 11:58:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39BBwrGq24773288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 11:58:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA8E25805D;
 Wed, 11 Oct 2023 11:58:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C8F958057;
 Wed, 11 Oct 2023 11:58:51 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.12.195]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Oct 2023 11:58:51 +0000 (GMT)
Message-ID: <dbb857cfde3c03aae4233ad8d8d560124e947959.camel@linux.ibm.com>
Subject: Re: [PATCH 6/6] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Yanan Wang
 <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Markus Armbruster
 <armbru@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas
 Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Date: Wed, 11 Oct 2023 07:58:51 -0400
In-Reply-To: <20231009094747.54240-7-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-7-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hfr1RREH9ZoyZvue5V3_GEVdehs1HzEU
X-Proofpoint-ORIG-GUID: HVq94_dZt7qxXYtXpxWf7shwsuMaW1wQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=872 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2023-10-09 at 11:47 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix:
>=20
> =C2=A0 hw/s390x/sclpquiesce.c:90:22: error: declaration shadows a variabl=
e
> in the global scope [-Werror,-Wshadow]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QuiesceNotifier *qn =3D container_of(n, Qu=
iesceNotifier,
> notifier);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0 hw/s390x/sclpquiesce.c:86:3: note: previous declaration is here
> =C2=A0 } qn;
> =C2=A0=C2=A0=C2=A0 ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> =C2=A0hw/s390x/sclpquiesce.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

