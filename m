Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4B67BEA37
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:59:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvSL-0006bI-PS; Mon, 09 Oct 2023 14:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qpvSJ-0006aw-8h; Mon, 09 Oct 2023 14:58:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qpvSH-0003TY-5y; Mon, 09 Oct 2023 14:58:15 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 399IlNig031386; Mon, 9 Oct 2023 18:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gIDH4KnjooV7MDzo3JNLyVbJg0F9mwPBPGkgV5yXSyM=;
 b=ZJa2/MNOMLosShevxVf9XJXedNAx7oaKLstxFvsvQ7po64la6ZZXSy8UrnZ3FSlAnke/
 puvf6Jk0kx865VoybHDkeP9vqt+ir4oEIxOixvEd1ikz+H8PN1fvQRTba+aEAaI3flAR
 jtBirlt13x7tpgx6Dl6xcYdrZPfgDTD/vhe0zV8fA8bY0thsxLRrtzVccY7NRiPOziSb
 TSKJFq32jToFT0loyAkUi4oCQYYFRmDN9yQhHZ7p5wgJeS17MA4coEt0dIOVCilv9rOc
 RX4Mlzafzmz8TMShOl9JXaGjUavPTWyqU32Iw51eUINH/QoP5k0Zq6LpX51SZdkPquLB ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmq3t0a41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 18:58:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 399IvmPv013845;
 Mon, 9 Oct 2023 18:58:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmq3t0a1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 18:58:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 399HGm3f025927; Mon, 9 Oct 2023 18:58:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnn328e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 18:58:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 399Iw5Ki21692828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Oct 2023 18:58:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D7DB58059;
 Mon,  9 Oct 2023 18:58:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71EFB58058;
 Mon,  9 Oct 2023 18:58:04 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.123.191]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Oct 2023 18:58:04 +0000 (GMT)
Message-ID: <d34762a121f76d7c837ea405d464ce391bee25b2.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW
From: Eric Farman <farman@linux.ibm.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 mjrosato@linux.ibm.com, borntraeger@linux.ibm.com, aik@ozlabs.ru,
 eric.auger@redhat.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 qemu-s390x@nongnu.org
Date: Mon, 09 Oct 2023 14:58:04 -0400
In-Reply-To: <20231009022048.35475-4-zhenzhong.duan@intel.com>
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
 <20231009022048.35475-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cojEcwTczAuVk0KGAlUQmxxH-AswpHf8
X-Proofpoint-GUID: HEaN7Eroqjf6SYevQWrJMQzX4S9YQjsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_17,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=742 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2023-10-09 at 10:20 +0800, Zhenzhong Duan wrote:
> No functional changes.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

I see Cedric has already queued this, but FWIW:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
> =C2=A0include/hw/s390x/vfio-ccw.h | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-
> ccw.h
> index 63a909eb7e..4209d27657 100644
> --- a/include/hw/s390x/vfio-ccw.h
> +++ b/include/hw/s390x/vfio-ccw.h
> @@ -22,6 +22,4 @@
> =C2=A0#define TYPE_VFIO_CCW "vfio-ccw"
> =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(VFIOCCWDevice, VFIO_CCW)
> =C2=A0
> -#define TYPE_VFIO_CCW "vfio-ccw"
> -
> =C2=A0#endif


