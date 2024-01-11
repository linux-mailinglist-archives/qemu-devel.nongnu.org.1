Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469882B13D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:01:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwYT-0002HU-2W; Thu, 11 Jan 2024 10:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1rNwYQ-0002H6-EB
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:01:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1rNwYO-0004Eu-BL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:01:10 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BENRMV004454
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xN86uMEQbOAEHtAZceLpCGiZieL+Xi0pDkzEe7NqKjg=;
 b=XzxeY/LdJkdIsn+t9Nzx8DV4YAUaDs8AmsGV4R0ykNPRVczCqZX6V08cFtLan1CtJj3A
 ieWfXoQDPAxSA5FheYSXiZ1dMo5a1DU1fNIvGbSYZQJqE+EEdoPsjIjyiWtqO0b1p74Z
 XxyNdsXO32IUsv2yneLL83opUogDieGK+810ole26cCca693HKJtXU70OLpPjO06/KXc
 zdFqAqI319YLd1HdqM+7EYG7K+BnAMMjd6HVThkbyHC3lUyga26AbZgubOxexHj7o27O
 edQFIxMhmF5SIaGcdJvmfGDrvtoGhhpUuO3TQDByjQKI8eb+47nQZWoy890BEvge7K5y RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj21s4sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:00:50 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BENbgr005361
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:00:49 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjj21s4rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 15:00:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BDjbBl026992; Thu, 11 Jan 2024 15:00:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2bm24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 15:00:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40BF0j7f16908912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 15:00:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 977E92004B;
 Thu, 11 Jan 2024 15:00:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22E3A20043;
 Thu, 11 Jan 2024 15:00:45 +0000 (GMT)
Received: from [9.171.40.19] (unknown [9.171.40.19])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 15:00:45 +0000 (GMT)
Message-ID: <72ef7f4f-8531-47b5-a003-fe1bf547b7f1@linux.ibm.com>
Date: Thu, 11 Jan 2024 16:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] s390x: do a subsystem reset before the unprotect on
 reboot
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20230912114112.296428-1-thuth@redhat.com>
 <20230912114112.296428-3-thuth@redhat.com>
 <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
 <287dbe42-5a10-4667-b3fa-111270242b1d@linux.ibm.com>
 <e22ebb27-26d0-4e1d-86ab-ab9feb44d645@redhat.com>
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
In-Reply-To: <e22ebb27-26d0-4e1d-86ab-ab9feb44d645@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aV75acE28Gb7FiY-RUlYYBjSlvU5ZgY6
X-Proofpoint-GUID: DuuYMwKo3uOFTSnCS_nlOyP089zS99uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_07,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401110118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

T24gMS8xMS8yNCAxMDo0MywgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+IE9uIDEvMTAv
MjQgMjE6MjgsIE1hdHRoZXcgUm9zYXRvIHdyb3RlOg0KPj4gT24gMS8xMC8yNCAxOjMwIFBN
LCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4+PiBPbiA5LzEyLzIzIDEzOjQxLCBUaG9t
YXMgSHV0aCB3cm90ZToNCj4+Pj4gRnJvbTogSmFub3NjaCBGcmFuayA8ZnJhbmtqYUBsaW51
eC5pYm0uY29tPg0KPj4+Pg0KPj4+PiBCb3VuZCBBUFFOcyBoYXZlIHRvIGJlIHJlc2V0IGJl
Zm9yZSB0ZWFyaW5nIGRvd24gdGhlIHNlY3VyZSBjb25maWcgdmlhDQo+Pj4+IHMzOTBfbWFj
aGluZV91bnByb3RlY3QoKS4gT3RoZXJ3aXNlIHRoZSBVbHRyYXZpc29yIHdpbGwgcmV0dXJu
IGEgZXJyb3INCj4+Pj4gY29kZS4NCj4+Pj4NCj4+Pj4gU28gbGV0J3MgZG8gYSBzdWJzeXN0
ZW1fcmVzZXQoKSB3aGljaCBpbmNsdWRlcyBhIEFQIHJlc2V0IGJlZm9yZSB0aGUNCj4+Pj4g
dW5wcm90ZWN0IGNhbGwuIFdlJ2xsIGRvIGEgZnVsbCBkZXZpY2VfcmVzZXQoKSBhZnRlcndh
cmRzIHdoaWNoIHdpbGwNCj4+Pj4gcmVzZXQgc29tZSBkZXZpY2VzIHR3aWNlLiBUaGF0J3Mg
b2sgc2luY2Ugd2UgY2FuJ3QgbW92ZSB0aGUNCj4+Pj4gZGV2aWNlX3Jlc2V0KCkgYmVmb3Jl
IHRoZSB1bnByb3RlY3QgYXMgaXQgaW5jbHVkZXMgYSBDUFUgY2xlYXIgcmVzZXQNCj4+Pj4g
d2hpY2ggdGhlIFVsdHJhdmlzb3IgZG9lcyBub3QgZXhwZWN0IGF0IHRoYXQgcG9pbnQgaW4g
dGltZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFub3NjaCBGcmFuayA8ZnJhbmtq
YUBsaW51eC5pYm0uY29tPg0KPj4+PiBNZXNzYWdlLUlEOiA8MjAyMzA5MDExMTQ4NTEuMTU0
MzU3LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tPg0KPj4+PiBUZXN0ZWQtYnk6IFZpa3RvciBN
aWhhamxvdnNraSA8bWloYWpsb3ZAbGludXguaWJtLmNvbT4NCj4+Pj4gQWNrZWQtYnk6IENo
cmlzdGlhbiBCb3JudHJhZWdlciA8Ym9ybnRyYWVnZXJAbGludXguaWJtLmNvbT4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+DQo+Pj4+IC0t
LQ0KPj4+PiAgIMKgIGh3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jIHwgMTAgKysrKysrKysr
Kw0KPj4+PiAgIMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9ody9zMzkweC9zMzkwLXZpcnRpby1jY3cuYyBiL2h3L3MzOTB4
L3MzOTAtdmlydGlvLWNjdy5jDQo+Pj4+IGluZGV4IDNkZDBiMjM3MmQuLjJkNzVmMjEzMWYg
MTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jDQo+Pj4+ICsr
KyBiL2h3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jDQo+Pj4+IEBAIC00MzgsMTAgKzQzOCwy
MCBAQCBzdGF0aWMgdm9pZCBzMzkwX21hY2hpbmVfcmVzZXQoTWFjaGluZVN0YXRlICptYWNo
aW5lLCBTaHV0ZG93bkNhdXNlIHJlYXNvbikNCj4+Pj4gICDCoMKgwqDCoMKgIHN3aXRjaCAo
cmVzZXRfdHlwZSkgew0KPj4+PiAgIMKgwqDCoMKgwqAgY2FzZSBTMzkwX1JFU0VUX0VYVEVS
TkFMOg0KPj4+PiAgIMKgwqDCoMKgwqAgY2FzZSBTMzkwX1JFU0VUX1JFSVBMOg0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgLyoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBSZXNldCB0aGUg
c3Vic3lzdGVtIHdoaWNoIGluY2x1ZGVzIGEgQVAgcmVzZXQuIElmIGEgUFYNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBndWVzdCBoYWQgQVBRTnMgYXR0YWNoZWQgdGhlIEFQIHJlc2V0
IGlzIGEgcHJlcmVxdWlzaXRlIHRvDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdW5wcm90
ZWN0aW5nIHNpbmNlIHRoZSBVViBjaGVja3MgaWYgYWxsIEFQUU5zIGFyZSByZXNldC4NCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN1YnN5c3Rl
bV9yZXNldCgpOw0KPj4+DQo+Pj4NCj4+PiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VkIGEgcmVn
cmVzc2lvbiB3aXRoIHBhc3MtdGhvdWdoIElTTSBkZXZpY2VzLg0KPj4+DQo+Pj4gQWZ0ZXIg
c3RhcnR1cCwgYSByZWJvb3Qgd2lsbCBnZW5lcmF0ZSBleHRyYSBkZXZpY2UgcmVzZXRzICh2
ZmlvLXBjaSBpbg0KPj4+IHRoaXMgY2FzZSkgd2hpY2ggYnJlYWsgdGhlIHBhc3MtdGhvdWdo
IElTTSBkZXZpY2UgaW4gYSBzdWJ0bGUgd2F5LA0KPj4NCj4+IEhpIENlZHJpYywgdGhhbmtz
IGZvciByZXBvcnRpbmcgdGhpcy4uLiAgSSB3YXMgYWJsZSB0byByZXByb2R1Y2UganVzdCBu
b3csIGFuZCBpdCBsb29rcyBsaWtlIElTTSBmaXJtd2FyZSBpcyB1bmhhcHB5IHNwZWNpZmlj
YWxseSB3aXRoIHRoaXMgc3VzYnlzdGVtX3Jlc2V0IGNhbGwgYWRkZWQgYnkgZWYxNTM1OTAx
YTAsIG5vdCBuZWNlc3NhcmlseSB0aGUgbXVsdGlwbGUgYXR0ZW1wdHMgYXQgcmVzZXQgLS0g
SSB2ZXJpZmllZCB0aGF0IHJldmVydGluZyBlZjE1MzU5MDFhMCByZXNvbHZlcyB0aGUgSVNN
IGlzc3VlLCBidXQgaWYgSSBpbnN0ZWFkIHRyeSByZXZlcnRpbmcgdGhlIG9sZGVyIDAzNDUx
OTUzYzc5ZSB3aGlsZSBsZWF2aW5nIGVmMTUzNTkwMWEwIGluIHBsYWNlIHRoZW4gSVNNIGRl
dmljZXMgc3RpbGwgYnJlYWsgb24gZ3Vlc3QgcmVib290Lg0KPj4NCj4+DQo+Pj4gcHJvYmFi
bHkgcmVsYXRlZCB0byBJT01NVSBtYXBwaW5nIGFjY29yZGluZyB0byAwMzQ1MTk1M2M3OWUN
Cj4+PiAoInMzOTB4L3BjaTogcmVzZXQgSVNNIHBhc3N0aHJvdWdoIGRldmljZXMgb24gc2h1
dGRvd24gYW5kIHN5c3RlbQ0KPj4+IHJlc2V0IikuIEFmdGVyIHBvd2Vyb2ZmLCB0aGUgZGV2
aWNlIGlzIGxlZnQgaW4gYSBzb3J0LW9mLWEtdXNlIHN0YXRlDQo+Pj4gb24gdGhlIGhvc3Qg
YW5kIHRoZSBMUEFSIGhhcyB0byBiZSByZWJvb3RlZCB0byBjbGVhciB0aGUgaW52YWxpZCBz
dGF0ZQ0KPj4+IG9mIHRoZSBkZXZpY2UuIFRvIGJlIG5vdGVkLCB0aGF0IHN0YW5kYXJkIFBD
SSBkZXZpY2VzIGFyZSBpbW11bmUgdG8NCj4+PiB0aGlzIGNoYW5nZS4NCj4+DQo+PiBBcyBh
IGJpdCBvZiBiYWNrZ3JvdW5kLCBJU00gZmlybXdhcmUgaXMgdmVyeSBzZW5zaXRpdmUgcmU6
IHRoZSBjb250ZW50cyBvZiB0aGUgKGhvc3QpIElPTU1VIGFuZCBhdHRlbXB0cyBhdCBtYW5p
cHVsYXRpb24gdGhhdCBpdCBkZWVtcyB0byBiZSBvdXQtb2Ytb3JkZXI7IHRoZSBwb2ludCBv
ZiAwMzQ1MTk1M2M3OWUgd2FzIHRvIGVuc3VyZSB0aGF0IHRoZSBkZXZpY2UgZ2V0cyBhIHJl
c2V0IGJlZm9yZSB3ZSBhdHRlbXB0IGF0IHVubWFwcGluZyBhbnl0aGluZyB0aGF0IHdhc24n
dCBjbGVhbmVkIHVwIGluIGFuIG9yZGVybHkgZmFzaGlvbiBieSB0aGUgKGd1ZXN0KSBpc20g
ZHJpdmVyIGF0IHRoZSB0aW1lIG9mIHNodXRkb3duL3Jlc2V0IChlLmcuIHVuZGVybHlpbmcg
ZmlybXdhcmUgbWF5IHZpZXcgZ3Vlc3QgU0JBcyBpbiB0aGUgSU9NTVUgYXMgc3RpbGwgcmVn
aXN0ZXJlZCBmb3IgdXNlIGFuZCB3aWxsIHRocm93IGFuIGVycm9yIGNvbmRpdGlvbiBhdCBh
dHRlbXB0cyB0byByZW1vdmUgdGhlaXIgZW50cmllcyBpbiB0aGUgSU9NTVUgd2l0aG91dCBm
aXJzdCBnb2luZyB0aHJvdWdoIGFuIHVucmVnaXN0cmF0aW9uIHByb2Nlc3MpLg0KPj4NCj4+
IFRoZSB1bm1hcCB0aGF0IHdvdWxkIG1ha2UgSVNNIHVwc2V0IHdvdWxkIGdlbmVyYWxseSBi
ZSBjb21pbmcgb3V0IG9mIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2RlbCB3aGVyZSB3ZSBqdXN0
IGRvIG9uZSBiaWcgdmZpb19kbWFfdW5tYXAgLS0gYSBxdWljayB0cmFjZSBzaG93cyB0aGF0
IHRoZSBzdWJzeXN0ZW1fcmVzZXQgY2FsbCBhZGRlZCBieSBlZjE1MzU5MDFhMCBpcyBjYXVz
aW5nIHRoZSB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9kZWwgdG8gb25jZSBhZ2FpbiB0cmlnZ2Vy
IGJlZm9yZSB0aGUgcGNpIHJlc2V0IG9mIHRoZSBJU00gZGV2aWNlLCBlZmZlY3RpdmVseSBy
ZS1pbnRyb2R1Y2luZyB0aGUgY29uZGl0aW9uIHRoYXQgMDM0NTE5NTNjNzllIHdhcyB0cnlp
bmcgdG8gcmVzb2x2ZS4NCj4gDQo+IFllcy4gSSBzYXcgdGhlIHZmaW9fbGlzdGVuZXJfcmVn
aW9uX2RlbCB0cmFjZSBjb21pbmcgZmlyc3QgYW5kIGNhbWUgdG8NCj4gdGhlIGNvbmNsdXNp
b24gaXQgd2FzIHJlbGF0ZWQgdG8gSU9NTVUgbWFwcGluZ3MuDQo+IA0KPj4+IFRoZSBleHRy
YSByZXNldHMgc2hvdWxkIGF2b2lkZWQgaW4gc29tZSB3YXlzLCAoYSBzaHV0ZG93biBub3Rp
ZmllciBhbmQNCj4+PiBhIHJlc2V0IGNhbGxiYWNrIGFyZSBhbHJlYWR5IHJlZ2lzdGVyZWQg
Zm9yIElTTSBkZXZpY2VzIGJ5IDAzNDUxOTUzYzc5ZSkNCj4+DQo+PiBTbyBhcyBtZW50aW9u
ZWQgYWJvdmUsIGl0J3Mgbm90IHRoZSBleHRyYSByZXNldHMgdGhhdCBhcmUgdGhlIGlzc3Vl
LCBpdCdzIHRoZSBvcmRlciBvZiBvcGVyYXRpb25zLiAgQmFzaWNhbGx5LCB3ZSBuZWVkIHRv
IGRyaXZlIHBjaV9kZXZpY2VfcmVzZXQgZm9yIGFueSBJU00gZGV2aWNlIGFzc29jaWF0ZWQg
d2l0aCB0aGUgZ3Vlc3QgYmVmb3JlIHdlIGRlc3Ryb3kgdGhlIHZmaW8gbWVtb3J5IGxpc3Rl
bmVyIChub3cgdHJpZ2dlcmVkIGluIHRoaXMgY2FzZSB2aWEgc3Vic3lzdGVtX3Jlc2V0KS4g
IFNvIGlmIHdlIG11c3QgZHJpdmUgdGhpcyBzdWJzeXN0ZW1fcmVzZXQgYmVmb3JlIHdlIHRy
aWdnZXIgdGhlIGRldmljZSByZXNldCBjYWxsYmFja3MgdGhlbiBpdCBtaWdodCByZXF1aXJl
IGEgczM5MCBwY2kgYnVzIHJvdXRpbmUgdGhhdCBpcyBjYWxsZWQgYmVmb3JlIG9yIGR1cmlu
ZyBzdWJ5c3RlbV9yZXNldCBqdXN0IHRvIHJlc2V0IHRoZSBJU00gZGV2aWNlcyBhc3NvY2lh
dGVkIHdpdGggdGhpcyBndWVzdCBmaXJzdDsgSSdtIG5vdCBzdXJlIHlldC4NCj4+DQo+PiBB
cyBhbiBhc2lkZTogIEkgd29uZGVyIHdoeSB3ZSBhcmUgYWx3YXlzIGRvaW5nIHRoZSBzdWJz
eXN0ZW1fcmVzZXQgaGVyZSB1bmNvbmRpdGlvbmFsbHkgcmF0aGVyIHRoYW4gb25seSB3aGVu
IHMzOTBfaXNfcHYoKSBzaW5jZSB0aGF0IHNlZW1zIHRvIGJlIHRoZSBvbmx5IGNhc2UgdGhh
dCByZXF1aXJlcyBpdC4NCj4gDQo+IFRoYXQgd291bGQgYmUgYSBzdGFydCB0byB3b3JrYXJv
dW5kIHRoZSBpc3N1ZS4NCj4gICAgDQoNCkkgY2FuIGhhdmUgYSBsb29rIGludG8gdGhhdCwg
SSdtIGp1c3QgYSBiaXQgaGVzaXRhbnQgc2luY2UgdGhlcmUncyBhbiANCm9taW5vdXMgZmVl
bGluZyBpbiBteSBicmFpbiB0aGF0IHRlbGxzIG1lIHRoYXQgdGhlcmUgbWlnaHQgaGF2ZSBi
ZWVuIGEgDQpyZWFzb24gdGhhdCBJIGZvcmdvdCBhZnRlciB0aGlzIHBhdGNoIHdhcyBwdWxs
ZWQuDQo=

