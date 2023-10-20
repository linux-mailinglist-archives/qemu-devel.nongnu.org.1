Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3E7D11A1
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqYb-00006j-1l; Fri, 20 Oct 2023 10:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qtqYX-00005f-73; Fri, 20 Oct 2023 10:32:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qtqYV-0007cp-HT; Fri, 20 Oct 2023 10:32:52 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KEJYTD018672; Fri, 20 Oct 2023 14:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zNR1NXyQCG58AJ4YU2+rln2CrEhQqwTWZ70vkvEObkA=;
 b=e6iwD+PgJYlj526z5i2O3lxUkVH72bLEp/2Ut5eZKug0XYqcC7i7zWgg9hBTFiQD6kj/
 uR2mwiYiP+mhnt7sX8ZRhvrnDdgQCz64FkreBgWxL5N94UuCb8chpPemb9mQbZ5+h/Bp
 Rq2JJlzd+IjSk2FUJrzDEOPux2W2CjPP5lQ7OW/KxVlPaf1OYLo0PBL4huUMSng4RRbS
 hBc/0S5gS0I+xo4YdT8r7dz7HP6u9FSaz2ZY5FBpriUPZpa1yQoeR4U2nu0pkOZ3d69V
 xCckU//TDz2xLY7Qs26q+yyQLHvBIx+KXvUUq0CRnbjgXqP2oJKuVDd4Gao3NaUhysZj 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuu7bghuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 14:32:48 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39KESgcs015588;
 Fri, 20 Oct 2023 14:32:48 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuu7bghf8-18
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 14:32:48 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KCMqSQ019404; Fri, 20 Oct 2023 14:05:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc454ypg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 14:05:50 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39KE5nTC50332132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 14:05:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 885445805B;
 Fri, 20 Oct 2023 14:05:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DF2A5805C;
 Fri, 20 Oct 2023 14:05:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.43.147]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 14:05:48 +0000 (GMT)
Message-ID: <1e2021e9ab87d68ac2628ecfa33b2fb14c8088fd.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] hw/s390x: Don't call register_savevm_live() during
 instance_init()
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, David
 Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Date: Fri, 20 Oct 2023 10:05:48 -0400
In-Reply-To: <20231020125728.579747-1-thuth@redhat.com>
References: <20231020125728.579747-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m7VqlQfLD1PSzVr5wO3waZOH6PkF7sXm
X-Proofpoint-ORIG-GUID: hxnHizUjklNZNPWxcJd8gbt2SWhSEfz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=854 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Fri, 2023-10-20 at 14:57 +0200, Thomas Huth wrote:
> We must not call register_savevm_live() during instance_init()
> since instances can be created at any time, e.g. during introspection
> of a device. We must register the savevm handler during realize()
> instead. Fix it now in the s390x devices.
>=20
> Thomas Huth (3):
> =C2=A0 hw/s390x/s390-skeys: Don't call register_savevm_live() during
> =C2=A0=C2=A0=C2=A0 instance_init()
> =C2=A0 hw/s390x/s390-stattrib: Simplify handling of the "migration-
> enabled"
> =C2=A0=C2=A0=C2=A0 property
> =C2=A0 hw/s390x/s390-stattrib: Don't call register_savevm_live() during
> =C2=A0=C2=A0=C2=A0 instance_init()
>=20
> =C2=A0hw/s390x/s390-skeys.c=C2=A0=C2=A0=C2=A0 | 35 ++++++----------------=
----
> =C2=A0hw/s390x/s390-stattrib.c | 54 +++++++++++++++----------------------=
-
> --
> =C2=A02 files changed, 28 insertions(+), 61 deletions(-)

Man, this makes it a lot easier to read too. With the amended patch 3:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

