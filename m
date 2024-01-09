Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E715F828927
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 16:39:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNEBs-00046V-TY; Tue, 09 Jan 2024 10:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1rNEBq-00046C-J7; Tue, 09 Jan 2024 10:38:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1rNEBo-00083R-Q7; Tue, 09 Jan 2024 10:38:54 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409Fcnmm005589; Tue, 9 Jan 2024 15:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=afZqp6JrYmf0jalASMXTm140oxtUBQj5tFM8F35NLHw=;
 b=G4TLA0csLNdORNCs4pwDqKgNYZ9gCVFOETVwf93PjkkURmdNja+FSPGiEwHWl7Fs/TaG
 j8nNlZ6SkqymSUwCEPK0oAkn97PSZt/IidiT3CBOvtuSwF6htIlmfHX5xAO60ac9A9jn
 0xof/PKkYDFCkxL6DiZDAT0XRM9PgFnam9B9L+9YlRpVrIqIi5dtGJUWmWj/CBU+INHd
 Tj7liBUYsOyOiqKy1ous7Z5rAKK8R7UN9l8Fhbrc3ax/23hrU59F3Fc8OS+BnG9jLJGU
 Rkr/BpNppilsyqvhfNaG+tMLjSTbHuzRq7LlftFk0TEebefntVIXGRKwG6zfAYRrl+hP ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh78yukmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:38:49 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409F0J1H028419;
 Tue, 9 Jan 2024 15:38:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh78yujs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:38:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409ECJZN023399; Tue, 9 Jan 2024 15:36:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6nfddd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:36:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409Fa7H312190338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 15:36:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B592520043;
 Tue,  9 Jan 2024 15:36:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 041A020040;
 Tue,  9 Jan 2024 15:36:07 +0000 (GMT)
Received: from [9.171.46.58] (unknown [9.171.46.58])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 15:36:06 +0000 (GMT)
Message-ID: <d2d2a47a-50cf-47b1-a1b6-1125be5688b6@linux.ibm.com>
Date: Tue, 9 Jan 2024 16:36:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/kvm/pv: Provide some more useful information
 if decryption fails
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20240109143038.155512-1-thuth@redhat.com>
 <ZZ1bY3qm3EvKxLWl@redhat.com>
 <d89b6903-0d15-415b-88ec-6f23cf436172@redhat.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 xsFNBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABzSVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+wsF3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbazsFNBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABwsFfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
In-Reply-To: <d89b6903-0d15-415b-88ec-6f23cf436172@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bupxdHxRGMtgfYayilL0GVjclzD0xRyP
X-Proofpoint-ORIG-GUID: Whet33fw1isf_pFTPj2Ck_eeMqAC5NqM
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_07,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=843 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401090127
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

T24gMS85LzI0IDE1OjUyLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gT24gMDkvMDEvMjAyNCAxNS40
MiwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+IE9uIFR1ZSwgSmFuIDA5LCAyMDI0IGF0
IDAzOjMwOjM4UE0gKzAxMDAsIFRob21hcyBIdXRoIHdyb3RlOg0KPj4+IEl0J3MgYSBjb21tb24g
c2NlbmFyaW8gdG8gY29weSBndWVzdCBpbWFnZXMgZnJvbSBvbmUgaG9zdCB0byBhbm90aGVyDQo+
Pj4gdG8gcnVuIHRoZSBndWVzdCBvbiB0aGUgb3RoZXIgbWFjaGluZS4gVGhpcyAob2YgY291cnNl
KSBkb2VzIG5vdCB3b3JrDQo+Pj4gd2l0aCAic2VjdXJlIGV4ZWN0aW9uIiBndWVzdHMgc2luY2Ug
dGhleSBhcmUgZW5jcnlwdGVkIHdpdGggb25lIGNlcnRhaW4NCj4+PiBob3N0IGtleS4gSG93ZXZl
ciwgaWYgeW91IHN0aWxsIChhY2NpZGVudGFsbHkpIGRvIGl0LCB5b3Ugb25seSBnZXQgYQ0KPj4+
IHZlcnkgdXNlci11bmZyaWVuZGx5IGVycm9yIG1lc3NhZ2UgdGhhdCBsb29rcyBsaWtlIHRoaXM6
DQo+Pg0KPj4gTm90IGEgY29tbWVudCBvbiB0aGUgcGF0Y2gsIGJ1dCBteSBvd24gaW50ZXJlc3Qg
aG93L3doZXJlIGRvZXMgdGhlDQo+PiBkaXNrIGltYWdlIGVuY3J5cHRpb24vZGVjcnlwdGlvbiBo
YXBwZW4gPyAgSXMgdGhhdCBpbiBndWVzdCBrZXJuZWwNCj4+IGNvbnRleHQsIGFuZCBhbnkgaW5m
byBvbiB3aGF0IGZvcm1hdCB0aGUgZW5jcnlwdGlvbiB1c2VzID8NCj4gDQo+IFRoZXJlIGlzIGFu
ICJ1bHRyYXZpc29yIiAocGFydCBvZiB0aGUgaG9zdCBmaXJtd2FyZSkgdGhhdCB0YWtlcyBjYXJl
IG9mIHRoZQ0KPiBkZWNyeXB0aW9uLiBTZWUgZS5nLiBDbGF1ZGlvJ3MgdGFsayBoZXJlOg0KPiAN
Cj4gICAgaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1KMllpYnJMZkI0cw0KDQpBbmQg
aGVyZSdzIHRoZSB0b29sIHRoYXQgY3JlYXRlcyB0aGUgZW5jcnlwdGVkIGltYWdlOg0KaHR0cHM6
Ly9naXRodWIuY29tL2libS1zMzkwLWxpbnV4L3MzOTAtdG9vbHMvdHJlZS9tYXN0ZXIvZ2VucHJv
dGltZw0KDQpJZiBJIHJlbWVtYmVyIGNvcnJlY3RseSB0aGUgaW1hZ2Ugc2hvdWxkIGJlIGFlcy0y
NTYteHRzLg0KVGhlIFNFIGhlYWRlciAodGhhdCBjb250YWlucyB0aGUgaW1hZ2Uga2V5KSBzaG91
bGQgYmUgYWVzLTI1Ni1nY20uDQpUaGUgaGVhZGVyIGhhcyBrZXlzbG90cyBzbyBlYWNoIG1hY2hp
bmUgdGhlIFZNIGlzIGFsbG93ZWQgdG8gcnVuIG9uIGNhbiANCnVud3JhcCB0aGUgaGVhZGVyIGlu
ZGVwZW5kZW50bHkuDQoNCkFkZGluZyBNYXJjIHRvIGtlZXAgbWUgaG9uZXN0IGhlcmUgc2luY2Ug
aGUgd3JvdGUgZ2VucHJvdGltZy4NCg==

