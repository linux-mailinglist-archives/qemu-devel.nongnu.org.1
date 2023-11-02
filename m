Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A24927DFA59
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:52:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qycmv-00062c-2c; Thu, 02 Nov 2023 14:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qycms-0005xm-VH; Thu, 02 Nov 2023 14:51:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qycmr-0007Xo-7Y; Thu, 02 Nov 2023 14:51:26 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A2IlsYT005396; Thu, 2 Nov 2023 18:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3doe3cTTk0DyLIRXdJa7hYoNldaR5cMbSmIQQPxlIlg=;
 b=P2zdl84k1xjEpAYbSyB3x+oQU+g1D6uTqwf5UzalShiKVJPqLi1hbt7gCpQqvL/RYebJ
 rinIl972/wx2S2ATiqbVWNRSGVfq8KZ1HttLRJrmZg68L7GWHhh6U61MhJ6KCv9tMwjc
 O1VPYF/8e2R+QGUdBkIhEKRQ5CxDHmTs2sl4ToBBPQ78t7KFajlKmJ6orsZhvb+Xqmxo
 +ByDINlkin7aUfWAlGI7IV9u2MrrwL2260WqBbatZ9wkngWmZewFDGA4OuvgAXMUva0D
 tLMchlkwKOuKw2+JHsRjQFd0QULEcmF7S97uAXRmoh6ITSg8ju0oPHI4hfP6ls8CWyNb Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4h72rh4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Nov 2023 18:51:21 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A2Ilvs0005671;
 Thu, 2 Nov 2023 18:51:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4h72rgt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Nov 2023 18:51:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A2HiVmt007664; Thu, 2 Nov 2023 18:50:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmp0sbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Nov 2023 18:50:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A2Ioo6r60948742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Nov 2023 18:50:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEADC5805A;
 Thu,  2 Nov 2023 18:50:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5B6B58054;
 Thu,  2 Nov 2023 18:50:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.184.176]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Nov 2023 18:50:48 +0000 (GMT)
Message-ID: <0cb53eda95889a41d485b993003a10600a7d4424.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/sclp: fix SCLP facility map
From: Eric Farman <farman@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Thu, 02 Nov 2023 14:50:48 -0400
In-Reply-To: <20231024100703.929679-1-hca@linux.ibm.com>
References: <20231024100703.929679-1-hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tphAdjKbF-lO4whqozU41MBNkQcLYprJ
X-Proofpoint-ORIG-GUID: Usa5pFJZp--QYOo_yCFRDH_oLYeEmhD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_09,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

KCtjYyBxZW11LWRldmVsKQoKT24gVHVlLCAyMDIzLTEwLTI0IGF0IDEyOjA3ICswMjAwLCBIZWlr
byBDYXJzdGVucyB3cm90ZToKPiBRZW11J3MgU0NMUCBpbXBsZW1lbnRhdGlvbiBpbmNvcnJlY3Rs
eSByZXBvcnRzIHRoYXQgaXQgc3VwcG9ydHMgQ1BVCj4gcmVjb25maWd1cmF0aW9uLiBJZiBhIGd1
ZXN0IGlzc3VlcyBhIENQVSByZWNvbmZpZ3VyYXRpb24gcmVxdWVzdCBpdAo+IGlzIHJlamVjdGVk
IGFzIGludmFsaWQgY29tbWFuZC4KPiAKPiBGaXggdGhlIFNDTFBfSEFTX0NQVV9JTkZPIG1hc2ss
IGFuZCByZW1vdmUgdGhlIHVudXNlZAo+IFNDTFBfQ01EV19DT05GSUdVUkVfQ1BVIGFuZCBTQ0xQ
X0NNRFdfREVDT05GSUdVUkVfQ1BVIGRlZmluZXMuCj4gCj4gUmV2aWV3ZWQtYnk6IEVyaWMgRmFy
bWFuIDxmYXJtYW5AbGludXguaWJtLmNvbT4KPiBSZXZpZXdlZC1ieTogSGFsaWwgUGFzaWMgPHBh
c2ljQGxpbnV4LmlibS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSGVpa28gQ2Fyc3RlbnMgPGhjYUBs
aW51eC5pYm0uY29tPgo+IC0tLQo+IMKgaW5jbHVkZS9ody9zMzkweC9zY2xwLmggfCA0ICstLS0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKClRob21h
cywgYW55IGNvbmNlcm5zPyBDb3VsZCB0aGlzIGdldCBwaWNrZWQgdXAgZm9yIDguMiwgcGxlYXNl
PwoKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9zMzkweC9zY2xwLmggYi9pbmNsdWRlL2h3
L3MzOTB4L3NjbHAuaAo+IGluZGV4IDlhZWY2ZDkzNzAxMi4uYjRlY2QwNGUyMzQxIDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvaHcvczM5MHgvc2NscC5oCj4gKysrIGIvaW5jbHVkZS9ody9zMzkweC9z
Y2xwLmgKPiBAQCAtMzgsMTAgKzM4LDggQEAKPiDCoCNkZWZpbmUgTUFYX1NUT1JBR0VfSU5DUkVN
RU5UU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTAyMAo+IMKgCj4gwqAvKiBD
UFUgaG90cGx1ZyBTQ0xQIGNvZGVzICovCj4gLSNkZWZpbmUgU0NMUF9IQVNfQ1BVX0lORk/CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IDB4MEMwMDAwMDAwMDAw
MDAwMFVMTAo+ICsjZGVmaW5lIFNDTFBfSEFTX0NQVV9JTkZPwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiAweDA4MDAwMDAwMDAwMDAwMDBVTEwKPiDCoCNkZWZp
bmUgU0NMUF9DTURXX1JFQURfQ1BVX0lORk/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAweDAwMDEwMDAxCj4gLSNkZWZpbmUgU0NMUF9DTURXX0NPTkZJR1VSRV9DUFXCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMTEwMDAxCj4gLSNkZWZpbmUgU0NMUF9DTURXX0RF
Q09ORklHVVJFX0NQVcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDEwMDAwMQo+IMKg
Cj4gwqAvKiBTQ0xQIFBDSSBjb2RlcyAqLwo+IMKgI2RlZmluZSBTQ0xQX0hBU19JT0FfUkVDT05G
SUfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiAweDAwMDAwMDAwNDAwMDAw
MDBVTEwK


