Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20B758226
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 18:32:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLnbf-0006WP-Rm; Tue, 18 Jul 2023 12:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qLnbd-0006WC-Jh; Tue, 18 Jul 2023 12:31:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qLnba-0002Xo-IX; Tue, 18 Jul 2023 12:31:21 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IGLEkM002012; Tue, 18 Jul 2023 16:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=viCJs7dIgQEH5vfIlayD9iQph1ly3ILoOWjMw3Xq/vc=;
 b=PaVDjpXwsvM/yCw/svVnSH35NvZAVP27y10QiGr03Q1i08NUcmu/Kx6ihkwZH3XE7gaa
 9BslbYdWA9CbyJcanUaGNx/38S9rTld8YPLG8W1+ConaTqWU0D8GMIykXAbJEAFXUgEe
 UnDNLMzAlhE+6+YPh8wJgIXlMN8ilzf3XklMeSHcq4XwQ0jKwM9OINTK3eAPQeXPePcB
 eUNnQkDF34/8VZaRcvvWRQc4WDeoP7Ne9wBG7OavinDCuHzW0ijL4/fYpZCIUx7B5IW/
 XQArndpgU5lBYQUPwW4hWOttDdDzj1kHGSbvnEnvCf6C/N6n81XHNX1ynK9rtHdGgbON EA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwx6b879m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 16:31:08 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IGMKMZ004759;
 Tue, 18 Jul 2023 16:31:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwx6b8794-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 16:31:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IEIGbN029098; Tue, 18 Jul 2023 16:31:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smdhhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 16:31:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36IGV3vL61800766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 16:31:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B29A20040;
 Tue, 18 Jul 2023 16:31:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F48020043;
 Tue, 18 Jul 2023 16:31:02 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.14.18]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 16:31:01 +0000 (GMT)
Message-ID: <9c8847ad9d8e07c2e41f9c20716ba3ed6dd6b3dc.camel@linux.ibm.com>
Subject: Re: [PATCH v21 01/20] s390x/cpu topology: add s390 specifics to CPU
 topology
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
Date: Tue, 18 Jul 2023 18:31:01 +0200
In-Reply-To: <20230630091752.67190-2-pmorel@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-2-pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oQxSeuEKqCgjdqdGVTq6oP4Gb2ndvhHY
X-Proofpoint-ORIG-GUID: w8rvYo7t5ppFyk_6ZHXbjVJxYhcqUiwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_12,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

ClJldmlld2VkLWJ5OiBOaW5hIFNjaG9ldHRlcmwtR2xhdXNjaCA8bnNnQGxpbnV4LmlibS5jb20+
CgpTb21lIG5vdGVzIGJlbG93LgoKVGhlIHMzOTB4LyBwcmVmaXggaW4gdGhlIHRpdGxlIG1pZ2h0
IHN1Z2dlc3QgdGhhdCB0aGlzIHBhdGNoCmlzIHMzOTAgc3BlY2lmaWMsIGJ1dCBpdCB0b3VjaGVz
IGNvbW1vbiBmaWxlcy4KCk9uIEZyaSwgMjAyMy0wNi0zMCBhdCAxMToxNyArMDIwMCwgUGllcnJl
IE1vcmVsIHdyb3RlOgo+IFMzOTAgYWRkcyB0d28gbmV3IFNNUCBsZXZlbHMsIGRyYXdlcnMgYW5k
IGJvb2tzIHRvIHRoZSBDUFUKPiB0b3BvbG9neS4KPiBUaGUgUzM5MCBDUFUgaGF2ZSBzcGVjaWZp
YyB0b3BvbG9neSBmZWF0dXJlcyBsaWtlIGRlZGljYXRpb24KClMzOTAgQ1BVcyBoYXZlIHNwZWNp
ZmljIHRvcG9sb2d5IGZlYXR1cmVzIGxpa2UgZGVkaWNhdGlvbiBhbmQKZW50aXRsZW1lbnQuIFRo
ZXNlIGluZGljYXRlIHRvIHRoZSBndWVzdCBpbmZvcm1hdGlvbiBvbiBob3N0CnZDUFUgc2NoZWR1
bGluZyBhbmQgaGVscCB0aGUgZ3Vlc3QgbWFrZSBiZXR0ZXIgc2NoZWR1bGluZyBkZWNpc2lvbnMu
Cgo+IGFuZCBlbnRpdGxlbWVudCB0byBnaXZlIHRvIHRoZSBndWVzdCBpbmRpY2F0aW9ucyBvbiB0
aGUgaG9zdAo+IHZDUFVzIHNjaGVkdWxpbmcgYW5kIGhlbHAgdGhlIGd1ZXN0IHRha2UgdGhlIGJl
c3QgZGVjaXNpb25zCj4gb24gdGhlIHNjaGVkdWxpbmcgb2YgdGhyZWFkcyBvbiB0aGUgdkNQVXMu
Cj4gCj4gTGV0IHVzIHByb3ZpZGUgdGhlIFNNUCBwcm9wZXJ0aWVzIHdpdGggYm9va3MgYW5kIGRy
YXdlcnMgbGV2ZWxzCj4gYW5kIFMzOTAgQ1BVIHdpdGggZGVkaWNhdGlvbiBhbmQgZW50aXRsZW1l
bnQsCj4gCj4gU2lnbmVkLW9mZi1ieTogUGllcnJlIE1vcmVsIDxwbW9yZWxAbGludXguaWJtLmNv
bT4KPiAtLS0KPiDCoHFhcGkvbWFjaGluZS1jb21tb24uanNvbsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAyMiArKysrKysrKysrKysrCj4gwqBxYXBpL21hY2hpbmUuanNvbsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIxICsrKysrKysrKystLS0KPiDCoGluY2x1ZGUvaHcv
Ym9hcmRzLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwICsrKysrLQo+IMKg
aW5jbHVkZS9ody9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmggfMKgIDQgKysrCj4gwqB0YXJnZXQv
czM5MHgvY3B1LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKysK
PiDCoGh3L2NvcmUvbWFjaGluZS1zbXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
OCArKysrKysrKysrKysrKysrKysrKysrKystLS0KPiAtLQo+IMKgaHcvY29yZS9tYWNoaW5lLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysrCj4gwqBody9jb3Jl
L3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uY8KgwqDCoCB8IDEzICsrKysrKysrCj4gwqBody9zMzkw
eC9zMzkwLXZpcnRpby1jY3cuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKwo+IMKgc29mdG1t
dS92bC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
NiArKysrCj4gwqB0YXJnZXQvczM5MHgvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA3ICsrKysrCj4gwqBxYXBpL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgcWVtdS1vcHRpb25zLmh4wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKystLQo+IMKgMTMgZmlsZXMg
Y2hhbmdlZCwgMTM3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHFhcGkvbWFjaGluZS1jb21tb24uanNvbgo+IAo+IGRpZmYgLS1naXQgYS9xYXBp
L21hY2hpbmUtY29tbW9uLmpzb24gYi9xYXBpL21hY2hpbmUtY29tbW9uLmpzb24KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAuLmJjMGQ3NjgyOWMKPiAtLS0gL2Rldi9u
dWxsCj4gKysrIGIvcWFwaS9tYWNoaW5lLWNvbW1vbi5qc29uCj4gQEAgLTAsMCArMSwyMiBAQAo+
ICsjIC0qLSBNb2RlOiBQeXRob24gLSotCj4gKyMgdmltOiBmaWxldHlwZT1weXRob24KPiArIwo+
ICsjIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHUEws
IHZlcnNpb24gMiBvcgo+IGxhdGVyLgo+ICsjIFNlZSB0aGUgQ09QWUlORyBmaWxlIGluIHRoZSB0
b3AtbGV2ZWwgZGlyZWN0b3J5Lgo+ICsKPiArIyMKPiArIyA9IE1hY2hpbmVzIFMzOTAgZGF0YSB0
eXBlcwoKQ29tbW9uIGRlZmluaXRpb25zIGZvciBtYWNoaW5lLmpzb24gYW5kIG1hY2hpbmUtdGFy
Z2V0Lmpzb24KCgpbLi4uXQo=


