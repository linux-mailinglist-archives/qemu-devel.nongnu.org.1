Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A370C979
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1BVT-0004ym-HY; Mon, 22 May 2023 15:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1q1BVL-0004yC-TS; Mon, 22 May 2023 15:47:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1q1BVK-00054a-2T; Mon, 22 May 2023 15:47:39 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MJktur025198; Mon, 22 May 2023 19:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yedHbQ3TFlHq6yfvLew0FF9aQmw0CarYHtSHvrQVmfM=;
 b=TGI48b4VqU7PjL7vE30iYqEppQhwaHyANfcbVcuYF1/ABh7bpaSkE6U9W0SOxjSTK8RV
 AasQOhf+C0X6kwlZINKcQ8lAgJcEjiiW192K7g1oQpGAf0pCtcaXCRw47VC6LLPIfdaG
 BkIeg7ohYoi4Mc7jeWpnuY1Pv/C+5jSCY4tJLBROrCBWMUVlpu2CsYjPFsP6M4V1m8uN
 4NrJEB9xqkZPYa+h+aHzjgf+Yik/4MmhvQ09RS3SQIOUgMDYdoa5PPROvy9w840VoPyE
 Ka/S8s9m0HiAeAH8fxee8FcxJuGZtRxeKmNvZk9fXf+pmzDM/9eIdPQF/pHFXRYVt15A tA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qre6q99w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 19:47:27 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MJVEp3023748;
 Mon, 22 May 2023 19:47:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qre6q99vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 19:47:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMi16Q025356;
 Mon, 22 May 2023 19:47:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3h3ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 19:47:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34MJlJWA59375886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 May 2023 19:47:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC06820049;
 Mon, 22 May 2023 19:47:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC93B20043;
 Mon, 22 May 2023 19:47:17 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown
 [9.171.42.164]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 May 2023 19:47:17 +0000 (GMT)
Message-ID: <c268bd5b3246bdd0b7736eeeaba200a10546c470.camel@linux.ibm.com>
Subject: Re: [PATCH v20 16/21] tests/avocado: s390x cpu topology entitlement
 tests
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
Date: Mon, 22 May 2023 21:47:17 +0200
In-Reply-To: <20230425161456.21031-17-pmorel@linux.ibm.com>
References: <20230425161456.21031-1-pmorel@linux.ibm.com>
 <20230425161456.21031-17-pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OUgY8OabcnxDrLPkN5w-49LhCbwzwIrG
X-Proofpoint-ORIG-GUID: Xro6b8icC8Sl5BEdmOummKEFsT3BfGgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_14,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 2023-04-25 at 18:14 +0200, Pierre Morel wrote:
> This test takes care to check the changes on different entitlements
> when the guest requests a polarization change.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  tests/avocado/s390_topology.py | 56 ++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>=20
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology=
.py
> index 30d3c0d0cb..64e1cc9209 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -244,3 +244,59 @@ def test_polarisation(self):
>                  '/bin/cat /sys/devices/system/cpu/dispatching', '0')
> =20
>          self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +    def test_entitlement(self):
> +        """
> +        This test verifies that QEMU modifies the polarization
> +        after a guest request.
> +
> +        :avocado: tags=3Darch:s390x
> +        :avocado: tags=3Dmachine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.add_args('-smp',
> +                         '1,drawers=3D2,books=3D2,sockets=3D3,cores=3D2,=
maxcpus=3D24')
> +        self.vm.add_args('-device', 'z14-s390x-cpu,core-id=3D1')
> +        self.vm.add_args('-device', 'z14-s390x-cpu,core-id=3D2')
> +        self.vm.add_args('-device', 'z14-s390x-cpu,core-id=3D3')

Why the -device statements? Won't they result in the same as specifying -sm=
p 4,...?
Same for patch 17.

> +        self.vm.launch()
> +        self.wait_for_console_pattern('no job control')
> +
> +        self.system_init()
> +
> +        res =3D self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 0, 'entitlement': 'low'})
> +        self.assertEqual(res['return'], {})
> +        res =3D self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 1, 'entitlement': 'medium'})
> +        self.assertEqual(res['return'], {})
> +        res =3D self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 2, 'entitlement': 'high'})
> +        self.assertEqual(res['return'], {})
> +        res =3D self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 3, 'entitlement': 'high'})
> +        self.assertEqual(res['return'], {})
> +        self.check_topology(0, 0, 0, 0, 'low', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'high', False)
> +        self.check_topology(3, 1, 0, 0, 'high', False)
> +
> +        exec_command(self, 'echo 1 > /sys/devices/system/cpu/dispatching=
')
> +        time.sleep(0.2)
> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', '1')
> +
> +        self.check_topology(0, 0, 0, 0, 'low', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'high', False)
> +        self.check_topology(3, 1, 0, 0, 'high', False)
> +
> +        exec_command(self, 'echo 0 > /sys/devices/system/cpu/dispatching=
')
> +        time.sleep(0.2)
> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', '0')
> +
> +        self.check_topology(0, 0, 0, 0, 'low', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'high', False)
> +        self.check_topology(3, 1, 0, 0, 'high', False)


