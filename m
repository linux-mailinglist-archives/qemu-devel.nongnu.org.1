Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9870175981F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM85Z-0006JV-5N; Wed, 19 Jul 2023 10:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM85S-00068F-NQ; Wed, 19 Jul 2023 10:23:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM85Q-0003NS-W7; Wed, 19 Jul 2023 10:23:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JE61ff017222; Wed, 19 Jul 2023 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=F72wRfciU2nBABbiIrme0NQCqy7LI0uIFvWRbyDwB0s=;
 b=bq6P2toOv+zDfeA3uMbZjk+8rT13s6apkmniahwGGpU3LuHaBRSrrQIHgq/TUDGfprEF
 9HuEBuP/zC0/oDQsUtRAWIx6eBnzUfCA5sxieuI2zVfcIcJzLnnCj8mSRqItio+4k/r1
 Xym1VOCHlqGGiVHgoWscIgK95RWL2cJtYrtbmfuNKdBZ6Ua4IV/d/4Icm3tIFwC3kdTY
 ex9U5YitFmhbklNM15A16qWZTMo/cyMoYu40HPQKkwl3nSjeyxdqFRN/DwoIwEN7gFPy
 uXOvtAeDKI0raKMG7omxSoxrdbTnB23JfnOGp7bc5giy9rIh3GzvaOd3Boo7glpbgPBg 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxfmhuce2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:23:25 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JE68ms018349;
 Wed, 19 Jul 2023 14:23:25 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxfmhucda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:23:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JCPBUE016870; Wed, 19 Jul 2023 14:23:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srtywd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:23:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JENMAr39584078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 14:23:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4868920043;
 Wed, 19 Jul 2023 14:23:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2651C20040;
 Wed, 19 Jul 2023 14:23:22 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 14:23:22 +0000 (GMT)
Message-ID: <457789cd8f90ccc35beccd35a0399bd9becb4ffe.camel@linux.ibm.com>
Subject: Re: [PATCH v2 08/14] tests/tcg/s390x: Test CKSM
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Wed, 19 Jul 2023 16:23:22 +0200
In-Reply-To: <49180c28-17ec-7b99-0135-0b37515ffbab@redhat.com>
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-9-iii@linux.ibm.com>
 <49180c28-17ec-7b99-0135-0b37515ffbab@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3AHk1SY7MO496MnPcTIMWudKyZmF8D3m
X-Proofpoint-GUID: 7Inc64yn1zc4FrWOrEMAGRMFfRSFA2Cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

T24gV2VkLCAyMDIzLTA3LTE5IGF0IDE2OjIwICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToKPiBP
biAxOS8wNy8yMDIzIDExLjQ0LCBJbHlhIExlb3Noa2V2aWNoIHdyb3RlOgo+ID4gQWRkIGEgc21h
bGwgdGVzdCB0byBwcmV2ZW50IHJlZ3Jlc3Npb25zLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBJ
bHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXguaWJtLmNvbT4KPiA+IC0tLQo+ID4gwqAgdGVzdHMv
dGNnL3MzOTB4L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IHzCoCAxICsKPiA+IMKgIHRlc3RzL3Rj
Zy9zMzkweC9ja3NtLlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjkKPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5z
ZXJ0aW9ucygrKQo+ID4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9zMzkweC9ja3Nt
LlMKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9zMzkweC9NYWtlZmlsZS5zb2Z0bW11
LXRhcmdldAo+ID4gYi90ZXN0cy90Y2cvczM5MHgvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQKPiA+
IGluZGV4IDI0MmM3YjBmODNjLi5lODEzZTMxOGRiOSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RzL3Rj
Zy9zMzkweC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldAo+ID4gKysrIGIvdGVzdHMvdGNnL3MzOTB4
L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0Cj4gPiBAQCAtMTYsNiArMTYsNyBAQCBMREZMQUdTPS1u
b3N0ZGxpYiAtc3RhdGljCj4gPiDCoCAKPiA+IMKgIEFTTV9URVNUUwo+ID4gPcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoAo+ID4gwqAgXAo+ID4gwqDCoMKgwqDCoAo+ID4gYmFswqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+
IMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqAKPiA+IGNrc23CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKg
wqDCoMKgwqDCoMKgIFwKPiA+IMKgwqDCoMKgwqAgZXhybC1zc20tCj4gPiBlYXJsecKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
Cj4gPiDCoMKgwqDCoMKgCj4gPiBzYW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoMKgwqAg
XAo+ID4gwqDCoMKgwqDCoAo+ID4gbHBzd8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoMKgwqAg
XAo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9zMzkweC9ja3NtLlMgYi90ZXN0cy90Y2cvczM5
MHgvY2tzbS5TCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwMDAu
LmE0NWYzZWY2YmZkCj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi90ZXN0cy90Y2cvczM5MHgv
Y2tzbS5TCj4gPiBAQCAtMCwwICsxLDI5IEBACj4gPiArwqDCoMKgIC5vcmcgMHg4ZQo+ID4gK3By
b2dyYW1faW50ZXJydXB0aW9uX2NvZGU6Cj4gPiArwqDCoMKgIC5vcmcgMHgxZDDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcHJvZ3JhbSBuZXcgUFNX
ICovCj4gPiArwqDCoMKgIC5xdWFkIDAscGdtCj4gPiArwqDCoMKgIC5vcmcgMHgyMDDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbG93Y29yZSBwYWRk
aW5nICovCj4gPiArwqDCoMKgIC5nbG9ibCBfc3RhcnQKPiA+ICtfc3RhcnQ6Cj4gPiArwqDCoMKg
IGxtZyAlcjAsJXIxLGNrc21fYXJncwo+ID4gK8KgwqDCoCBja3NtICVyMiwlcjAKPiA+ICvCoMKg
wqAgYyAlcjIsY2tzbV9leHAKPiA+ICvCoMKgwqAgam5lIGZhaWx1cmUKPiA+ICvCoMKgwqAgY2tz
bSAlcjIsJXIxNQo+IAo+IENsYW5nIGlzIHNtYXJ0IGVub3VnaCB0byBkZXRlY3QgdGhhdCB0aGlz
IGlzIGEgYmFkIGluc3RydWN0aW9uOgo+IAo+ICQgbWFrZSBjaGVjay10Y2cKPiDCoMKgIEJVSUxE
wqDCoCBzMzkweC1zb2Z0bW11IGd1ZXN0LXRlc3RzCj4gdGVzdHMvdGNnL3MzOTB4L2Nrc20uUzox
MjoxNDogZXJyb3I6IGludmFsaWQgcmVnaXN0ZXIgcGFpcgo+IMKgwqDCoMKgIGNrc20gJXIyLCVy
MTUKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeCj4gCj4gSSBndWVzcyB5b3UgaGF2ZSB0
byBtYW51YWxseSBjcmVhdGUgdGhlIG9wY29kZSBoZXJlPwo+IAo+IMKgIFRob21hcwoKQXJnaCwg
SSByZWFsbHkgbmVlZCB0byBzdGFydCB0ZXN0aW5nIG15IHN1Ym1pc3Npb25zIHdpdGggY2xhbmcu
ClRoYW5rcyBmb3Igbm90aWNpbmcsIEkgd2lsbCBmaXggdGhpcy4K


