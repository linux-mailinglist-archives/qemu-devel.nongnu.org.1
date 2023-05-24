Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC08E70F1DF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kWj-0000qA-LK; Wed, 24 May 2023 05:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q1kWh-0000oY-GH
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:11:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q1kWe-0000Z8-Rv
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:11:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34O9AiKZ017047; Wed, 24 May 2023 09:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/2/IUdJ8o2BrZCJKu0t1z5wMSfAgUmOsjn1xLTsI+GI=;
 b=HZWnKAkfxWWoEIM77WocXp3UbLX5JKeesMU/6+kMMKV7TVo/ruUQM7SFOPzHZaTD7lmK
 GqVc2+wXa9ZvfM09BIZ2HzN6HNvG4ytTt9aWvmOmkauvNF1IeUItgDgT4UEnB6sSem2l
 LrBhm7Q9SFSH8GOyC6STFrfuNF3z8loTl4OOYyg1tScUJAphS/5zGc5kQo531eKHHiJ3
 p01Lau9MkxiwjurCvqn6gNX77D/xBj2Xh0fByY+Xxkn+S+g8XiUdoZtU1i6FO37BcxFZ
 56Rj6i9rZGXIndhklO64ObwkWUUiFIzSO6XXZT7nTjn+JbIbn9Acyj7a3rWxEKnsHn+b Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsd4m49ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 09:11:17 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34O9BGbQ022104;
 Wed, 24 May 2023 09:11:16 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsd4m490d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 09:11:12 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34O3uI9e017652;
 Wed, 24 May 2023 09:01:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qppc11hwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 09:01:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34O91VxQ46268776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 May 2023 09:01:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAA1F2004B;
 Wed, 24 May 2023 09:01:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C07720043;
 Wed, 24 May 2023 09:01:31 +0000 (GMT)
Received: from [9.179.22.56] (unknown [9.179.22.56])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 May 2023 09:01:31 +0000 (GMT)
Message-ID: <d37056648233345f177d1fef57a9471bb25e8e6d.camel@linux.ibm.com>
Subject: PING: [PATCH RESEND 0/6] gdbstub: Add support for info proc mappings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Andreas Arnez
 <arnez@linux.ibm.com>, qemu-devel@nongnu.org
Date: Wed, 24 May 2023 11:01:30 +0200
In-Reply-To: <20230510202654.225689-1-iii@linux.ibm.com>
References: <20230510202654.225689-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gHzLqhSRwqloKsSBQvDDP1ltqs0R_RYQ
X-Proofpoint-ORIG-GUID: QqiUzW5ko_lVEJS-mG8rYrOMz_KLxsLu
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

T24gV2VkLCAyMDIzLTA1LTEwIGF0IDIyOjI2ICswMjAwLCBJbHlhIExlb3Noa2V2aWNoIHdyb3Rl
Ogo+IFtBcG9sb2dpZXMgdG8gcGVvcGxlIGluIFRvOiBhbmQgQ2M6LCB3aG8gd2lsbCBnZXQgdGhp
cyB0aGUgc2Vjb25kCj4gdGltZSAtCj4gSSBmb3Jnb3QgdG8gQ2M6IHRoZSBtYWlsaW5nIGxpc3Qg
aW5pdGlhbGx5Ll0KPiAKPiBIaSwKPiAKPiB0aGlzIHNlcmllcyBwYXJ0aWFsbHkgaW1wbGVtZW50
cyB0aGUgSG9zdCBJL08gZmVhdHVyZSBvZiB0aGUgR0RCCj4gUmVtb3RlCj4gU2VyaWFsIFByb3Rv
Y29sIGluIG9yZGVyIHRvIG1ha2UgZ2VuZXJhdGUtY29yZS1maWxlIHdvcmsgd2l0aCBxZW11LQo+
IHVzZXIuCj4gSXQgYm9ycm93cyBoZWF2aWx5IGZyb20gdGhlIGFiYW5kb25lZCBwYXRjaCBieSBE
b21pbmlrIFsxXSwgaGVuY2UgNC82Cj4gY2FycmllcyB0aGUgcmVzcGVjdGl2ZSBDby1kZXZlbG9w
ZWQtYnk6IHRhZy4gSSBob3BlIHRoYXQncyBva2F5LiBJCj4gYWxzbwo+IHBlZWtlZCBhdCBnZGJz
ZXJ2ZXIvaG9zdGlvLmNjIHF1aXRlIGEgZmV3IHRpbWVzLgo+IAo+IFRoZSBjaGFuZ2VzIGNvbXBh
cmVkIHRvIERvbWluaWsncyBwYXRjaCBhcmU6Cj4gCj4gLSBJbXBsZW1lbnQgcmVhZGxpbmsuCj4g
LSBNb3ZlIHRoZSBtYWluIGZ1bmN0aW9uYWxpdHkgdG8gdXNlci10YXJnZXQuYy4KPiAtIEFsbG9j
YXRlIGJ1ZmZlcnMgb24gaGVhcC4KPiAtIEFkZCBhIHRlc3QuCj4gLSBVcGRhdGUgZ2RiLnJzdC4K
PiAtIFNwbGl0IHJlZmFjdG9yaW5ncyB0byB0aGUgZXhpc3RpbmcgY29kZSBpbnRvIHNlcGFyYXRl
IHBhdGNoZXMuCj4gLSBSZW5hbWUgZG9fb3BlbmF0KCkgdG8gZG9fZ3Vlc3Rfb3BlbmF0KCkuCj4g
LSBEbyBub3QgcmV0cnkgcHJlYWQoKSwgc2luY2UgR0RCIGlzIGNhcGFibGUgb2YgZG9pbmcgaXQg
aXRzZWxmLgo+IC0gQWRkIGFuIGV4dHJhIHNhbml0eSBjaGVjayB0byBnZGJfaGFuZGxlX3F1ZXJ5
X3hmZXJfZXhlY19maWxlKCkuCj4gLSBSZXBsYWNlIGNpdGF0aW9ucyBvZiB0aGUgc3BlYyBieSBh
IHNpbmdsZSBsaW5rLgo+IAo+IEJlc3QgcmVnYXJkcywKPiBJbHlhCj4gCj4gWzFdCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwMjIxMDMwOTEwLjMyMDMwNjMtMS1kb21pbmlrLmIu
Y3phcm5vdGFAZ21haWwuY29tLwo+IAo+IElseWEgTGVvc2hrZXZpY2ggKDYpOgo+IMKgIGxpbnV4
LXVzZXI6IEV4cG9zZSBkb19ndWVzdF9vcGVuYXQoKSBhbmQgZG9fZ3Vlc3RfcmVhZGxpbmsoKQo+
IMKgIGdkYnN0dWI6IEV4cG9zZSBnZGJfZ2V0X3Byb2Nlc3MoKSBhbmQKPiBnZGJfZ2V0X2ZpcnN0
X2NwdV9pbl9wcm9jZXNzKCkKPiDCoCBnZGJzdHViOiBSZXBvcnQgdGhlIGFjdHVhbCBxZW11LXVz
ZXIgcGlkCj4gwqAgZ2Ric3R1YjogQWRkIHN1cHBvcnQgZm9yIGluZm8gcHJvYyBtYXBwaW5ncwo+
IMKgIGRvY3M6IERvY3VtZW50IHNlY3VyaXR5IGltcGxpY2F0aW9ucyBvZiBkZWJ1Z2dpbmcKPiDC
oCB0ZXN0cy90Y2c6IEFkZCBhIHRlc3QgZm9yIGluZm8gcHJvYyBtYXBwaW5ncwo+IAo+IMKgZG9j
cy9zeXN0ZW0vZ2RiLnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDE1ICsrCj4gwqBnZGJzdHViL2dkYnN0dWIuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4NiArKysrKysr
Ky0tLQo+IMKgZ2Ric3R1Yi9pbnRlcm5hbHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNyArCj4gwqBnZGJzdHViL3VzZXItdGFyZ2V0
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMzkK
PiArKysrKysrKysrKysrKysrKysKPiDCoGxpbnV4LXVzZXIvcWVtdS5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArCj4gwqBs
aW51eC11c2VyL3N5c2NhbGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCA1NCArKysrLS0tCj4gwqB0ZXN0cy90Y2cvYWFyY2g2NC9NYWtlZmls
ZS50YXJnZXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArLQo+IMKgdGVzdHMvdGNn
L211bHRpYXJjaC9NYWtlZmlsZS50YXJnZXTCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA3ICsK
PiDCoC4uLi9tdWx0aWFyY2gvZ2Ric3R1Yi90ZXN0LXByb2MtbWFwcGluZ3MucHnCoMKgIHzCoCA1
NSArKysrKysrCj4gwqB0ZXN0cy90Y2cvczM5MHgvTWFrZWZpbGUudGFyZ2V0wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstCj4gwqAxMCBmaWxlcyBjaGFuZ2VkLCAzMzIgaW5z
ZXJ0aW9ucygrKSwgMzkgZGVsZXRpb25zKC0pCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMv
dGNnL211bHRpYXJjaC9nZGJzdHViL3Rlc3QtcHJvYy1tYXBwaW5ncy5weQoKUGluZy4K

