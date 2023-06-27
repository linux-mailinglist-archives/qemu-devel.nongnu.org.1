Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74473F9A5
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5a5-0000it-TR; Tue, 27 Jun 2023 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE5a3-0000iC-Vn; Tue, 27 Jun 2023 06:05:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE5a2-000627-CY; Tue, 27 Jun 2023 06:05:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RA5la2032546; Tue, 27 Jun 2023 10:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jw8uUc4265mmHnXaSgJg/juEWsHLpVma+zk36+mtE3I=;
 b=syq4eH/vWCFtSgys9gHTKLx531nMzZanomZ2PMJyGBY6sKgEfPCRZ5pRr0SYkxm+FYEf
 pCnmItqRP4lm9YckOwcUTwvCq4d0y72+GmM178aeMzBiNPkfzDXcq81UxZYmn8Xa8yZk
 H5/JjDkyQuklimdeCSY5KxO3u1UgfOyCUuMkKH000rrVsXWn134IQ1ozdrIfRLFzqrkA
 08HNBeoJia9ou96sihOwSwQAsUp2/+CtZVCIryxfU0rN2Hxl0ZayYBQm7xnl47XlTUQ4
 b30ffjGBS5NW45KNk68cCheKe0QV3ysdJP3hyd2a1yHQTbFPxCD9cnXkoXnuIYXX8BHq +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwh307pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:05:46 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9qYpE021867;
 Tue, 27 Jun 2023 10:05:46 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwh307md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:05:46 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R7tANB014675;
 Tue, 27 Jun 2023 10:02:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
 by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3rdr45dqcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:02:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RA2sai262822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:02:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5720C58054;
 Tue, 27 Jun 2023 10:02:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA9ED58052;
 Tue, 27 Jun 2023 10:02:52 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.34.238]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 10:02:52 +0000 (GMT)
Message-ID: <7c6827ce50832b18c05b3ace0807d87cdd7d9dee.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] pc-bios/s390-ccw: Provide space for initial
 stack frame in start.S
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Marc
 Hartmayer <mhartmay@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Date: Tue, 27 Jun 2023 06:02:52 -0400
In-Reply-To: <511457be-fa9b-bcfc-447d-bb79f7873a55@linaro.org>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-3-thuth@redhat.com>
 <877crp9uq9.fsf@li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com>
 <511457be-fa9b-bcfc-447d-bb79f7873a55@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UXvhtM0gHqUYtJeD1oEcRfO6Xz7JbAS_
X-Proofpoint-ORIG-GUID: VlUtwfke3wU7JtZA7W_F9NhM7WT3Wp9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=931 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

T24gVHVlLCAyMDIzLTA2LTI3IGF0IDExOjE0ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToKPiBPbiAyNy82LzIzIDEwOjI2LCBNYXJjIEhhcnRtYXllciB3cm90ZToKPiA+IFRo
b21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPiB3cml0ZXM6Cj4gPiAKPiA+ID4gUHJvdmlkaW5n
IHRoZSBzcGFjZSBvZiBhIHN0YWNrIGZyYW1lIGlzIHRoZSBkdXR5IG9mIHRoZSBjYWxsZXIsCj4g
PiA+IHNvIHdlIHNob3VsZCByZXNlcnZlIDE2MCBieXRlcyBiZWZvcmUganVtcGluZyBpbnRvIHRo
ZSBtYWluCj4gPiA+IGZ1bmN0aW9uLgo+ID4gPiBPdGhlcndpc2UgdGhlIG1haW4oKSBmdW5jdGlv
biBtaWdodCB3cml0ZSBwYXN0IHRoZSBzdGFjayBhcnJheS4KPiA+ID4gCj4gPiA+IFdoaWxlIHdl
J3JlIGF0IGl0LCBhZGQgYSBwcm9wZXIgU1RBQ0tfU0laRSBtYWNybyBmb3IgdGhlIHN0YWNrCj4g
PiA+IHNpemUKPiA+ID4gaW5zdGVhZCBvZiB1c2luZyBtYWdpYyBudW1iZXJzICh0aGlzIGlzIGFs
c28gcmVxdWlyZWQgZm9yIHRoZQo+ID4gPiBmb2xsb3dpbmcKPiA+ID4gcGF0Y2gpLgo+ID4gPiAK
PiA+ID4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBCb3JudHJhZWdlciA8Ym9ybnRyYWVnZXJAbGlu
dXguaWJtLmNvbT4KPiA+ID4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVk
aGF0LmNvbT4KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5j
b20+Cj4gPiA+IC0tLQo+ID4gPiDCoCBwYy1iaW9zL3MzOTAtY2N3L3N0YXJ0LlMgfCA0ICsrKy0K
PiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
IAo+IAo+ID4gPiArI2RlZmluZSBTVEFDS19TSVpFIDB4ODAwMAo+ID4gPiArCj4gPiA+IMKgwqDC
oMKgwqAgLmdsb2JsIF9zdGFydAo+ID4gPiDCoCBfc3RhcnQ6Cj4gPiA+IMKgIAo+ID4gPiAtwqDC
oMKgIGxhcmzCoMKgwqAgJXIxNSxzdGFjayArIDB4ODAwMMKgwqDCoMKgIC8qIFNldCB1cCBzdGFj
ayAqLwo+ID4gPiArwqDCoMKgIGxhcmzCoMKgwqAgJXIxNSxzdGFjayArIFNUQUNLX1NJWkUgLSAx
NjDCoMKgIC8qIFNldCB1cCBzdGFjayAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBe
Xl4KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgWW91IGNhbiBhbHNvIGFkZCBhIG1hY3Jv
Cj4gPiBmb3IgdGhpcwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGUuZy4gU1RBQ0tf
RlJBTUVfU0laRS4KPiAKPiBZZXMgcGxlYXNlIDopIE5vIG5lZWQgdG8gcmVzcGluLgo+IAo+IFJl
dmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+Cj4g
Cj4gPiBCZXNpZGVzIHRoYXQsCj4gPiBSZXZpZXdlZC1ieTogTWFyYyBIYXJ0bWF5ZXIgPG1oYXJ0
bWF5QGxpbnV4LmlibS5jb20+Cj4gPQoKRGl0dG8gOikKClJldmlld2VkLWJ5OiBFcmljIEZhcm1h
biA8ZmFybWFuQGxpbnV4LmlibS5jb20+Cgo=


