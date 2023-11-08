Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3387E523F
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 09:59:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0eOE-0005zn-4A; Wed, 08 Nov 2023 03:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0eOB-0005z2-Nd; Wed, 08 Nov 2023 03:58:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0eO7-0000oC-L4; Wed, 08 Nov 2023 03:58:19 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A88uP3h031786; Wed, 8 Nov 2023 08:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c7YnJVGcrEv04xX3Cw6UOODLSFePnkzqG+mibGU8UCU=;
 b=UsLVxs8jdX01m+Di74S8TPaYzHg5zNug15jFnL/I7Cb9MKN/utLU6jJpOYzuuaZGQIDI
 dVVdbINJx40etmeD9jtHnvSE0FhyiDVEFwscn98SS3jCG2ZjcTA9VHFy5rVwUQ1Ayt8W
 1XwHdi5D4KbVUS2b2mzriabupWSV8FKU89fNqeiPVcFAEElL3fEaw9YrPk8oyPnp5Z3g
 A2CTmTPQPLG5yA9p3H13KDhH1sCQn5jc/2otmlE43U7+e1Fh4mc4O9Rr532c9Q7bCWvw
 c/cGt80ypUjgcCRVomFGcFC0KlL7F0xgyZsLPGXs3cTVb7ZJc58iB0LFQVTgvXzE2JCJ UA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u86wh8t4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 08:58:12 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A88wB5i009198;
 Wed, 8 Nov 2023 08:58:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u86wh8t3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 08:58:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A88Z15m000652; Wed, 8 Nov 2023 08:58:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22um2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 08:58:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A88w7NO55640440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Nov 2023 08:58:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC05E20043;
 Wed,  8 Nov 2023 08:58:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D80720040;
 Wed,  8 Nov 2023 08:58:07 +0000 (GMT)
Received: from [9.171.60.52] (unknown [9.171.60.52])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Nov 2023 08:58:07 +0000 (GMT)
Message-ID: <6fc86959-5fd5-4e54-954f-cfda8a374f34@linux.ibm.com>
Date: Wed, 8 Nov 2023 09:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dump: Set dump info function pointers to NULL
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 imbrenda@linux.ibm.com
References: <20231107142048.22422-1-frankja@linux.ibm.com>
 <20231107142048.22422-2-frankja@linux.ibm.com>
 <CAJ+F1CL2anS58w0bffJGzN_76To30ORafstQYT=REUYa42h+nQ@mail.gmail.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <CAJ+F1CL2anS58w0bffJGzN_76To30ORafstQYT=REUYa42h+nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fIwrUz5q_wXgmw8p2uml9kva-GQmhhvI
X-Proofpoint-ORIG-GUID: m2Ed5XyXobymLtD4YKRmCGT9p68HqO7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=976
 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
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

T24gMTEvOC8yMyAwOTowMywgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3RlOg0KPiBIaQ0KPiAN
Cj4gT24gVHVlLCBOb3YgNywgMjAyMyBhdCA2OjIy4oCvUE0gSmFub3NjaCBGcmFuayA8ZnJh
bmtqYUBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+DQo+PiBCZXR0ZXIgdG8gbm90IHJlbHkg
b24gdGhlIHN0cnVjdCB6ZXJvaW5nIHNpbmNlIE5VTEwgaXMgbm90IG5lY2Vzc2FyaWx5DQo+
PiAwLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphbm9zY2ggRnJhbmsgPGZyYW5ramFAbGlu
dXguaWJtLmNvbT4NCj4+IC0tLQ0KPj4gICBkdW1wL2R1bXAuYyB8IDMgKysrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHVt
cC9kdW1wLmMgYi9kdW1wL2R1bXAuYw0KPj4gaW5kZXggZDM1NWFkYTYyZS4uMWQzODI3NDky
NSAxMDA2NDQNCj4+IC0tLSBhL2R1bXAvZHVtcC5jDQo+PiArKysgYi9kdW1wL2R1bXAuYw0K
Pj4gQEAgLTE3MDYsNiArMTcwNiw5IEBAIHN0YXRpYyB2b2lkIGR1bXBfc3RhdGVfcHJlcGFy
ZShEdW1wU3RhdGUgKnMpDQo+PiAgIHsNCj4+ICAgICAgIC8qIHplcm8gdGhlIHN0cnVjdCwg
c2V0dGluZyBzdGF0dXMgdG8gYWN0aXZlICovDQo+PiAgICAgICAqcyA9IChEdW1wU3RhdGUp
IHsgLnN0YXR1cyA9IERVTVBfU1RBVFVTX0FDVElWRSB9Ow0KPj4gKyAgICBzLT5kdW1wX2lu
Zm8uYXJjaF9zZWN0aW9uc19hZGRfZm4gPSBOVUxMOw0KPj4gKyAgICBzLT5kdW1wX2luZm8u
YXJjaF9zZWN0aW9uc193cml0ZV9oZHJfZm4gPSBOVUxMOw0KPj4gKyAgICBzLT5kdW1wX2lu
Zm8uYXJjaF9zZWN0aW9uc193cml0ZV9mbiA9IE5VTEw7DQo+PiAgIH0NCj4gDQo+IEkgdGhp
bmsgd2Ugd291bGQgYmUgaW4gdHJvdWJsZSBpZiBOVUxMIGlzIG5vdCAwLiBEbyB5b3UgaGF2
ZSBhIGJldHRlciBhcmd1bWVudD8NCj4gDQoNCkknbSBvbmUgb2YgdGhvc2UgcGVvcGxlIHdo
byBsaWtlcyB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHBvaW50ZXJzIGFuZCANCm5vbi1wb2lu
dGVycyBidXQgSSBoYXZlIG5vIHByb2JsZW0gZHJvcHBpbmcgdGhpcy4NCg0KDQpPVDogT24g
czM5MCAweDAgaXMgYSB2YWxpZCBhZGRyZXNzIGJ1dCB0aGUga2VybmVsIG1hcHMgJiBoYW5k
bGVzIGl0IGluIGEgDQp3YXkgdGhhdCBpdCB3aWxsIHJlc3VsdCBpbiBhIG51bGwgcG9pbnRl
ciBpZiByZWFkL3dyaXR0ZW4gdG8uDQoNCg==

