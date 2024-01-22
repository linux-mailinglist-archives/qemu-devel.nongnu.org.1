Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827283759B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:50:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2AW-0003Ye-Nv; Mon, 22 Jan 2024 16:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rS2AT-0003YO-Jj
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:49:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rS2AR-0000Ti-2U
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:49:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MKbNUo015995; Mon, 22 Jan 2024 21:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Y58ayR1uNZVFspwMfpr3hcZckA4v2BVgk9cODCHV0M0=;
 b=B8UjbL54ZFL9YjiA4pywqwkdH878BqGkRPLzoTkvtfULgwGwBE3VcFO+oesymH0asGvp
 ZoMD6TFluENKEpBPxUEhZa6hM6G6ZYDYOFpdHVqlqhmT2hGYnHJy0jb3t50RdYyJXKeZ
 PYtOxG0keDCiTgDQ6YfXWBUZuhgJq5uodB2Mki0fhUx6ni7cz3f8rEaB0ac2r5EHQ2IU
 GlkeEmKlsKmDyUAxPGwf7rEOjjAatXcnyX8ZXvimgxekkDkGPRq+eJ+G4cXPu6Cw3jlZ
 PpsWK3wRZKCtvWhrkvjGjMeDDuH+Nrcxm8UukS6OJAnITG4SGySIa7o1nd8jvW/i3BVQ ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsyj61g4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:49:07 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MLf41a026398;
 Mon, 22 Jan 2024 21:49:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsyj61g42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:49:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MIbFvp010855; Mon, 22 Jan 2024 21:49:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrvyke5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:49:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MLn4AQ7930424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:49:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B461758055;
 Mon, 22 Jan 2024 21:49:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E908958043;
 Mon, 22 Jan 2024 21:49:03 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.187.25]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jan 2024 21:49:03 +0000 (GMT)
Message-ID: <bf9d0a0f1ed254a34ef8a4891eff31681419dc5a.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] hw/s390x/css-bridge: switch virtual-css bus to
 3-phase-reset
From: Eric Farman <farman@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Date: Mon, 22 Jan 2024 16:49:03 -0500
In-Reply-To: <20240119163512.3810301-5-peter.maydell@linaro.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u1DC1oechHXv_llS114XUbiFFh0UbgWu
X-Proofpoint-ORIG-GUID: wiuVixUzVqpEWc2nGwMV_TuXCyXKUYGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220154
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

On Fri, 2024-01-19 at 16:35 +0000, Peter Maydell wrote:
> Switch the s390x virtual-css bus from using BusClass::reset to the
> Resettable interface.
>=20
> This has no behavioural change, because the BusClass code to support
> subclasses that use the legacy BusClass::reset will call that method
> in the hold phase of 3-phase reset.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> =C2=A0hw/s390x/css-bridge.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

