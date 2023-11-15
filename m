Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D177ECAC3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 19:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3KuI-0007Zr-HN; Wed, 15 Nov 2023 13:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1r3Ktd-0007Wr-64; Wed, 15 Nov 2023 13:45:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1r3Kta-0000Jh-V5; Wed, 15 Nov 2023 13:45:52 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFIAXKf025219; Wed, 15 Nov 2023 18:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KgHivebTENwFYGhjAlxl9QFG94/TI04c0QlpXci8SYQ=;
 b=Ll11HlQoQAWGrLB0I5K9wrUtkjFJZwtvzjZfbHfB096cN7jxGEyWRArTXP8abgK6mjBc
 ZUpUoN+d5sS4l4nTWmrq+rDAF2GtCEmAtIEzO2rxCtl06J1lU7u8cLOMUhrGvcjdSQ+z
 525D3s/CcQXqBI9/uhXmiKr12X0fn8hBhzhFFMZV7nAFhv2z68692lYI7/D0kjN14aYd
 bVzzC7IjVci4Vk5qwqbnFH8fnN3E705KORqkEIkXuVO7q/7Vuoe8YGuaNyTpkZ5qxXdh
 TayMEBQM80HaWp3BL29211qT4/shJsHDi5wB56FbrtYQNaQaYcLrQ/WONr9XcgDm8r1M Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud26etehq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 18:45:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFILf1M032000;
 Wed, 15 Nov 2023 18:45:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud26etegx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 18:45:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFICW7i020506; Wed, 15 Nov 2023 18:45:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnhckr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 18:45:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AFIjg7X23134860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 18:45:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DFFE5804E;
 Wed, 15 Nov 2023 18:45:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62E285803F;
 Wed, 15 Nov 2023 18:45:40 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.49.33]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Nov 2023 18:45:40 +0000 (GMT)
Message-ID: <f78e408d6f04897271e64191c8ad5e5003c71adb.camel@linux.ibm.com>
Subject: Re: [PATCH v6 16/21] vfio/ccw: Allow the selection of a given iommu
 backend
From: Eric Farman <farman@linux.ibm.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com, Matthew
 Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "open
 list:vfio-ccw" <qemu-s390x@nongnu.org>
Date: Wed, 15 Nov 2023 13:45:39 -0500
In-Reply-To: <20231114100955.1961974-17-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uZUiyPA5k7tTbDBCW8chzDzx5FbwDUqY
X-Proofpoint-GUID: jH8XjCwU2CaW9eNk8KAPTl2NDYBknaoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_18,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=967 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150147
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

On Tue, 2023-11-14 at 18:09 +0800, Zhenzhong Duan wrote:
> Now we support two types of iommu backends, let's add the capability
> to select one of them. This depends on whether an iommufd object has
> been linked with the vfio-ccw device:
>=20
> If the user wants to use the legacy backend, it shall not
> link the vfio-ccw device with any iommufd object:
>=20
> =C2=A0-device vfio-ccw,sysfsdev=3D/sys/bus/mdev/devices/XXX
>=20
> This is called the legacy mode/backend.
>=20
> If the user wants to use the iommufd backend (/dev/iommu) it
> shall pass an iommufd object id in the vfio-ccw device options:
>=20
> =C2=A0-object iommufd,id=3Diommufd0
> =C2=A0-device vfio-ccw,sysfsdev=3D/sys/bus/mdev/devices/XXX,iommufd=3Diom=
mufd0
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> =C2=A0hw/vfio/ccw.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

