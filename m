Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88478F8D9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 09:01:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qby9k-00057O-J4; Fri, 01 Sep 2023 03:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1qby9V-0004qL-AG; Fri, 01 Sep 2023 03:01:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1qby9S-0002AO-SP; Fri, 01 Sep 2023 03:01:08 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3816atqi021756; Fri, 1 Sep 2023 07:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5qaFs/IwcjvQV70EagjCBvupNpZ2/N0064UnYGjbufI=;
 b=Ym27cOz4TElKafFtlktah4wFDJHLcADcmaax3Z8FdB/3Svz0R40/0B5xVPliYfboqUqr
 UM6kB2g8X5XRbr0PPFGiVRzqf6gcWmYqSQ0loQL63vBMul9WoAsARwosUwQkCm/X3bfE
 6lqFwZtsNHu9Zf3RdNKAHWvnORkB0TTKFi+T+ERrxe0skYnnGO+MyRZOM5LZwQ8XZtZN
 WSkUxseHGLe5TAfj+Q+8si3lELIyvViuu/2i3g1o7ywUZooakY61wBeIwQGoNvM3Rkvx
 m+JwCM7r5T+nvLBfNRFvUIlfTV7djIZBDXgLkjf7rTnH8nGzE27SyLW21Ij5YBA3AnEo RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3su9ksa973-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 07:01:02 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3816b0bk022462;
 Fri, 1 Sep 2023 07:01:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3su9ksa8wu-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 07:01:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3813xi14020514; Fri, 1 Sep 2023 06:31:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv402wdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 06:31:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3816VRE720185724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Sep 2023 06:31:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B38420043;
 Fri,  1 Sep 2023 06:31:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BC5520040;
 Fri,  1 Sep 2023 06:31:26 +0000 (GMT)
Received: from [9.171.82.64] (unknown [9.171.82.64])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Sep 2023 06:31:26 +0000 (GMT)
Message-ID: <80b007e8-91d7-8298-f628-77c30616f0f4@linux.ibm.com>
Date: Fri, 1 Sep 2023 08:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] s390x: switch pv and subsystem reset ordering on
 reboot
To: Marc Hartmayer <mhartmay@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230823142219.1046522-1-seiden@linux.ibm.com>
 <20230823142219.1046522-3-seiden@linux.ibm.com>
 <87o7in2nec.fsf@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <87o7in2nec.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vmUSm0nqbYSeFiVDmd491ZRI6Oz1Xavk
X-Proofpoint-ORIG-GUID: V044V2brmhWM2UwWawuoN3pq_trjyGEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

T24gOC8zMS8yMyAxODoyMSwgTWFyYyBIYXJ0bWF5ZXIgd3JvdGU6DQo+IE9uIFdlZCwgQXVn
IDIzLCAyMDIzIGF0IDA0OjIyIFBNICswMjAwLCBTdGVmZmVuIEVpZGVuIDxzZWlkZW5AbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+PiBGcm9tOiBKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxp
bnV4LmlibS5jb20+DQo+Pg0KPj4gQm91bmQgQVBRTnMgaGF2ZSB0byBiZSByZXNldCBiZWZv
cmUgdGVhcmluZyBkb3duIHRoZSBzZWN1cmUgY29uZmlnIHZpYQ0KPj4gczM5MF9tYWNoaW5l
X3VucHJvdGVjdCgpLiBPdGhlcndpc2UgdGhlIFVsdHJhdmlzb3Igd2lsbCByZXR1cm4gYSBl
cnJvcg0KPj4gY29kZS4NCj4+DQo+PiBTbyBsZXQncyBzd2l0Y2ggdGhlIG9yZGVyaW5nIGFy
b3VuZCB0byBtYWtlIHRoYXQgaGFwcGVuLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gQm9ybnRyYWVnZXIgPGJvcm50cmFlZ2VyQGxpbnV4LmlibS5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+DQo+PiAtLS0N
Cj4+ICAgaHcvczM5MHgvczM5MC12aXJ0aW8tY2N3LmMgfCA2ICsrKy0tLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYyBiL2h3L3MzOTB4L3MzOTAt
dmlydGlvLWNjdy5jDQo+PiBpbmRleCA0YjM2Yzk5NzBlLi43OTVkZDUzZDY4IDEwMDY0NA0K
Pj4gLS0tIGEvaHcvczM5MHgvczM5MC12aXJ0aW8tY2N3LmMNCj4+ICsrKyBiL2h3L3MzOTB4
L3MzOTAtdmlydGlvLWNjdy5jDQo+PiBAQCAtNDQyLDEzICs0NDIsMTMgQEAgc3RhdGljIHZv
aWQgczM5MF9tYWNoaW5lX3Jlc2V0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgU2h1dGRvd25D
YXVzZSByZWFzb24pDQo+PiAgICAgICBzd2l0Y2ggKHJlc2V0X3R5cGUpIHsNCj4+ICAgICAg
IGNhc2UgUzM5MF9SRVNFVF9FWFRFUk5BTDoNCj4+ICAgICAgIGNhc2UgUzM5MF9SRVNFVF9S
RUlQTDoNCj4+ICsgICAgICAgIHFlbXVfZGV2aWNlc19yZXNldChyZWFzb24pOw0KPj4gKyAg
ICAgICAgczM5MF9jcnlwdG9fcmVzZXQoKTsNCj4+ICsNCj4+ICAgICAgICAgICBpZiAoczM5
MF9pc19wdigpKSB7DQo+PiAgICAgICAgICAgICAgIHMzOTBfbWFjaGluZV91bnByb3RlY3Qo
bXMpOw0KPj4gICAgICAgICAgIH0NCj4+ICAgDQo+PiAtICAgICAgICBxZW11X2RldmljZXNf
cmVzZXQocmVhc29uKTsNCj4+IC0gICAgICAgIHMzOTBfY3J5cHRvX3Jlc2V0KCk7DQo+PiAt
DQo+PiAgICAgICAgICAgLyogY29uZmlndXJlIGFuZCBzdGFydCB0aGUgaXBsIENQVSBvbmx5
ICovDQo+PiAgICAgICAgICAgcnVuX29uX2NwdShjcywgczM5MF9kb19jcHVfaXBsLCBSVU5f
T05fQ1BVX05VTEwpOw0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4gLS0gDQo+PiAyLjQxLjAN
Cj4+DQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCB0aGlzIGJyZWFrcyB0aGluZ3MgZm9yIG1lLiBZ
b3UgY2FuIHJlcHJvZHVjZSB0aGUgcHJvYmxlbQ0KPiBlYXNpbHnigKYgU3RhcnQgYW4gU0Ug
Z3Vlc3QgdmlhIGRpcmVjdCBrZXJuZWwgYm9vdCBhbmQgcmVib290IHRoZSBndWVzdA0KPiBh
ZnRlciB0aGUgZ3Vlc3QgaGFzIGJvb3RlZC4NCg0KU2VlbXMgbGlrZSB3ZSBkaWRuJ3QgdGVz
dCBhIGRpcmVjdCBrZXJuZWwgYm9vdCByZWJvb3QuLi4NCkknbSBsb29raW5nIGludG8gaXQu
DQoNCg==

