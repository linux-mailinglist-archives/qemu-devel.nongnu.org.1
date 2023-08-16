Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5C77DE89
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 12:22:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWDel-0007Xv-1Q; Wed, 16 Aug 2023 06:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWDec-0007U6-Qc; Wed, 16 Aug 2023 06:21:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWDea-0002qx-M3; Wed, 16 Aug 2023 06:21:30 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GA9kDV029758; Wed, 16 Aug 2023 10:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=my98DqpJsGjhJRWyTjoeT8RWhtWMpxbap4VzCASW7+8=;
 b=WfjkkTrUAEYdjCVGCLBfFQ6ytDlNo33R6A3Uu4stfk94gj31VXuZWi3AlMiU/sX+eT/+
 iXBOhW+6Z/DM24XOUw5wFcO67GdEtbr/10RzU0v5bLHoRCH2DfPKMdCso48J5qF4dqAL
 tTLWp9Uh2h1iBjJOZRlcPg8ZzQ6FsnO9PvttTzhLTE389cQEgTfOYgBuaLh7YD0yMrEV
 i4wVjAC/tCTKPd4eu7V0mSSQXHqaWYCDHll4gG/yVU5SBRcaFqzRPkkDXxrV29PD9pTN
 j2NBib+iIpvFUf1XTUakEcLEZSzVwKXK2nXxvDJM6jXBZJEyf0erGn03fwltUxMqBhGj Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgv96grry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 10:21:14 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GAAqX8003918;
 Wed, 16 Aug 2023 10:21:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgv96grrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 10:21:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37G7tKhf001073; Wed, 16 Aug 2023 10:21:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsybu46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 10:21:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37GALB7m13238934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 10:21:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A20520043;
 Wed, 16 Aug 2023 10:21:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC7A920040;
 Wed, 16 Aug 2023 10:21:10 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Aug 2023 10:21:10 +0000 (GMT)
Message-ID: <500264e15aa52df6350474407533722451b03667.camel@linux.ibm.com>
Subject: Re: [PATCH 5/9] tests/tcg: clean-up gdb confirm/pagination settings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>, David
 Hildenbrand <david@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Nicholas
 Piggin <npiggin@gmail.com>
Date: Wed, 16 Aug 2023 12:20:55 +0200
In-Reply-To: <20230815145126.3444183-6-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gXdsJjk_pGp47ClM3elmEkTFF1VRImsQ
X-Proofpoint-ORIG-GUID: FQRAqIT9N_0wfRphBCdyYLBfyJBE5SC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_08,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

T24gVHVlLCAyMDIzLTA4LTE1IGF0IDE1OjUxICswMTAwLCBBbGV4IEJlbm7DqWUgd3JvdGU6Cj4g
V2UgY2FuIGRvIHRoaXMgYWxsIGluIHRoZSBydW4tdGVzdC5weSBzY3JpcHQgc28gcmVtb3ZlIHRo
ZSBleHRyYW5lb3VzCj4gYml0cyBmcm9tIHRoZSBpbmRpdmlkdWFsIHRlc3RzIHdoaWNoIGdvdCBj
b3BpZWQgZnJvbSB0aGUgb3JpZ2luYWwKPiBub24tQ0kgZ2RiIHRlc3RzLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KPiAtLS0KPiDCoHRl
c3RzL2d1ZXN0LWRlYnVnL3J1bi10ZXN0LnB5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArKwo+IMKgdGVzdHMvdGNnL2FhcmNoNjQvZ2Ric3R1Yi90
ZXN0LXN2ZS1pb2N0bC5wecKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyAtLS0KPiDCoHRlc3RzL3Rj
Zy9hYXJjaDY0L2dkYnN0dWIvdGVzdC1zdmUucHnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDMgLS0tCj4gwqB0ZXN0cy90Y2cvbXVsdGlhcmNoL2dkYnN0dWIvbWVtb3J5LnB5wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzIC0tLQo+IMKgdGVzdHMvdGNnL211bHRp
YXJjaC9nZGJzdHViL3NoYTEucHnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCA0IC0tLS0KPiDCoHRlc3RzL3RjZy9tdWx0aWFyY2gvZ2Ric3R1Yi90ZXN0LXByb2MtbWFwcGlu
Z3MucHnCoMKgwqDCoCB8IDQgLS0tLQo+IMKgdGVzdHMvdGNnL211bHRpYXJjaC9nZGJzdHViL3Rl
c3QtcXhmZXItYXV4di1yZWFkLnB5wqDCoCB8IDQgLS0tLQo+IMKgdGVzdHMvdGNnL211bHRpYXJj
aC9nZGJzdHViL3Rlc3QtdGhyZWFkLWJyZWFrcG9pbnQucHkgfCA0IC0tLS0KPiDCoHRlc3RzL3Rj
Zy9zMzkweC9nZGJzdHViL3Rlc3Qtc2lnbmFscy1zMzkweC5wecKgwqDCoMKgwqDCoMKgwqAgfCA0
IC0tLS0KPiDCoHRlc3RzL3RjZy9zMzkweC9nZGJzdHViL3Rlc3Qtc3ZjLnB5wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCAtLS0tCj4gwqAxMCBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoKQWNrZWQtYnk6IElseWEgTGVvc2hrZXZp
Y2ggPGlpaUBsaW51eC5pYm0uY29tPgo=


