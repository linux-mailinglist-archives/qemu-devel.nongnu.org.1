Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DD768F36
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:53:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNhP-0003ZT-8K; Mon, 31 Jul 2023 03:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qQNh9-0003WZ-86; Mon, 31 Jul 2023 03:51:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qQNh6-00049t-8V; Mon, 31 Jul 2023 03:51:58 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36V7eUWB017717; Mon, 31 Jul 2023 07:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fz6CRiO4ygE4G++UKuHt8gMGW4VyuwBQmleBWtYAuis=;
 b=aLKEeH3h4T0/XBhG9iDZLhXLxAX5/V0lGOX4bDCD6fjOlUj0Hqik/OgmDZ/o7RWhfqJJ
 C1k8yQDmyZ8M8N+2Bchg2Brhjf41JRE1sJIr2DObZMYKq9cnYGgEod55A0JEAM0tQxdp
 /+OR/CMjJQ1CMq4F1hhdsUAMHdK0Ee52aIMK5sdiZYyIVAY9tPcoJl9R8kC3XVauUDnj
 iEcbrVlFAgmpUYWAq91l/xie/KSH7wdka0+kb4SWaswzybqzi+7r6thwh8Ssyb/SJqhh
 13tZuvBKKhsTcnT8XcKoavJqCGeyxJIP4ykpuZ2ZAii07MpDQzzPzSk6fl+2p2VJ1A2u nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s68cn0xaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 07:51:28 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V7eSqW017516;
 Mon, 31 Jul 2023 07:51:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s68cn0x9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 07:51:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36V71tEH019095; Mon, 31 Jul 2023 07:51:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5ekk1502-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 07:51:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36V7pOCR45810178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jul 2023 07:51:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4684020043;
 Mon, 31 Jul 2023 07:51:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1AE020040;
 Mon, 31 Jul 2023 07:51:22 +0000 (GMT)
Received: from [9.171.78.34] (unknown [9.171.78.34])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Jul 2023 07:51:22 +0000 (GMT)
Message-ID: <1c35cba86f433178467f4f1bcf8727f8e83215ea.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] tests/tcg: Add -fno-stack-protector
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar
 Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Date: Mon, 31 Jul 2023 09:51:22 +0200
In-Reply-To: <20230731065904.5869-4-akihiko.odaki@daynix.com>
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
 <20230731065904.5869-4-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uLLQ3ybwebLuIRWqBezBPAG4Oipxt5kA
X-Proofpoint-GUID: nIOZ4OwnHPviq3rjVc90_0MGltV1M1op
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=678 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310067
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDE1OjU4ICswOTAwLCBBa2loaWtvIE9kYWtpIHdyb3RlOgo+
IEEgYnVpbGQgb2YgR0NDIDEzLjIgd2lsbCBoYXZlIHN0YWNrIHByb3RlY3RvciBlbmFibGVkIGJ5
IGRlZmF1bHQgaWYKPiBpdAo+IHdhcyBjb25maWd1cmVkIHdpdGggLS1lbmFibGUtZGVmYXVsdC1z
c3Agb3B0aW9uLiBGb3Igc3VjaCBhIGNvbXBpbGVyLAo+IGl0IGlzIG5lY2Vzc2FyeSB0byBleHBs
aWNpdGx5IGRpc2FibGUgc3RhY2sgcHJvdGVjdG9yIHdoZW4gbGlua2luZwo+IHdpdGhvdXQgc3Rh
bmRhcmQgbGlicmFyaWVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFraWhpa28gT2Rha2kgPGFraWhp
a28ub2Rha2lAZGF5bml4LmNvbT4KPiAtLS0KPiDCoHRlc3RzL3RjZy9taXBzL2hlbGxvLW1pcHMu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKgdGVzdHMv
dGNnL2FhcmNoNjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXTCoMKgwqDCoCB8IDIgKy0KPiDCoHRl
c3RzL3RjZy9hYXJjaDY0L01ha2VmaWxlLnRhcmdldMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDIgKy0KPiDCoHRlc3RzL3RjZy9hbHBoYS9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldMKgwqDCoMKg
wqDCoCB8IDIgKy0KPiDCoHRlc3RzL3RjZy9hcm0vTWFrZWZpbGUudGFyZ2V0wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstCj4gwqB0ZXN0cy90Y2cvY3Jpcy9NYWtlZmlsZS50
YXJnZXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstCj4gwqB0ZXN0cy90Y2cv
aGV4YWdvbi9NYWtlZmlsZS50YXJnZXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstCj4g
wqB0ZXN0cy90Y2cvaTM4Ni9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldMKgwqDCoMKgwqDCoMKgIHwg
MiArLQo+IMKgdGVzdHMvdGNnL2kzODYvTWFrZWZpbGUudGFyZ2V0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMiArLQo+IMKgdGVzdHMvdGNnL2xvb25nYXJjaDY0L01ha2VmaWxlLnNv
ZnRtbXUtdGFyZ2V0IHwgMiArLQo+IMKgdGVzdHMvdGNnL21pbmlsaWIvTWFrZWZpbGUudGFyZ2V0
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+IMKgdGVzdHMvdGNnL21pcHMvTWFrZWZp
bGUudGFyZ2V0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+IMKgdGVzdHMv
dGNnL25pb3MyL01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0wqDCoMKgwqDCoMKgIHwgMiArLQo+IMKg
dGVzdHMvdGNnL3MzOTB4L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0wqDCoMKgwqDCoMKgIHwgMiAr
LQo+IMKgdGVzdHMvdGNnL3g4Nl82NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldMKgwqDCoMKgwqAg
fCAyICstCj4gwqAxNSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlv
bnMoLSkKCkFja2VkLWJ5OiBJbHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXguaWJtLmNvbT4K


