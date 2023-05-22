Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FDF70C94D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1BTk-000438-Cl; Mon, 22 May 2023 15:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1q1BTi-00042t-2F; Mon, 22 May 2023 15:45:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1q1BTg-0004nP-5G; Mon, 22 May 2023 15:45:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MJd3pJ025562; Mon, 22 May 2023 19:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=asFqEK4jS1cxympzwrCDk2p3tKRpiGz4CFdqkh3No54=;
 b=piusIZJmN6S1YpoMgdo/Skxaztz2sONP8dGQN4zslWWYwZj5G1bbdFubcleGtMlWCptF
 s5fP5GJ2SLp5HNEeZWq62sBimRyoMFVe4pcdM8/BKyaSQ1hOXhb2gWCEATD2Kp5QGRWG
 QtusT9rLSzccqVPpNyeWvIKNSlG9YS+Uc1D7U51lI0dbfs5DV2NHRG2W/akMNjSpJlFl
 GGoKu/MMPeFlMq9FjWVotpairMXprrfeSqIKIJpQiRh1xHd938T3hX3WFuvz9IdSvWCI
 B7rlyLvYr8Av+5sAhd+DkoKsPRsWXrowTQ5+C8EBv4klPK8PRHfL+3BQ/FEt/0/l+xSh NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qregs8cv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 19:45:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MJfw6I002447;
 Mon, 22 May 2023 19:45:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qregs8cua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 19:45:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8tUoP032622;
 Mon, 22 May 2023 19:45:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3h3xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 19:45:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34MJjdjR45154670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 May 2023 19:45:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2460720049;
 Mon, 22 May 2023 19:45:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDABE20040;
 Mon, 22 May 2023 19:45:37 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown
 [9.171.42.164]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 May 2023 19:45:37 +0000 (GMT)
Message-ID: <b695a55e294038b2a9e300031f27a74c36b49b5d.camel@linux.ibm.com>
Subject: Re: [PATCH v20 15/21] tests/avocado: s390x cpu topology polarisation
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
Date: Mon, 22 May 2023 21:45:37 +0200
In-Reply-To: <20230425161456.21031-16-pmorel@linux.ibm.com>
References: <20230425161456.21031-1-pmorel@linux.ibm.com>
 <20230425161456.21031-16-pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6SWkhdH-QcwS7EiTZQqpnNlqFLMxlQzR
X-Proofpoint-GUID: vFgGmVsO3G4aPhyHxXDIl6cZHW3g8i46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_14,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Try to be consistent in the spelling of polarization.
You use an s in the title and in the test name below.

On Tue, 2023-04-25 at 18:14 +0200, Pierre Morel wrote:
> Polarization is changed on a request from the guest.
> Let's verify the polarization is accordingly set by QEMU.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  tests/avocado/s390_topology.py | 38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology=
.py
> index ce119a095e..30d3c0d0cb 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -104,6 +104,15 @@ def kernel_init(self):
>                           '-initrd', initrd_path,
>                           '-append', kernel_command_line)
> =20
> +    def system_init(self):
> +        self.log.info("System init")
> +        exec_command(self, 'mount proc -t proc /proc')
> +        time.sleep(0.2)
> +        exec_command(self, 'mount sys -t sysfs /sys')
> +        time.sleep(0.2)
> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', '0')
> +
>      def test_single(self):
>          self.kernel_init()
>          self.vm.launch()
> @@ -206,3 +215,32 @@ def test_hotplug_full(self):
>          self.check_topology(3, 1, 1, 1, 'high', False)
>          self.check_topology(4, 1, 1, 1, 'medium', False)
>          self.check_topology(5, 2, 1, 1, 'high', True)
> +
> +    def test_polarisation(self):

I would unite this test with test_query_polarization, they are very similar=
.

> +        """
> +        This test verifies that QEMU modifies the entitlement change aft=
er
> +        several guest polarization change requests.
> +
> +        :avocado: tags=3Darch:s390x
> +        :avocado: tags=3Dmachine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.launch()
> +        self.wait_for_console_pattern('no job control')
> +
> +        self.system_init()
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +        exec_command(self, 'echo 1 > /sys/devices/system/cpu/dispatching=
')
> +        time.sleep(0.2)

Can you find a way to wait for the event here?

> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', '1')

I think it would be good to refactor this snippet into a function.

def guest_set_dispatching(self, dispatching):
        exec_command(self, f'echo {dispatching} > /sys/devices/system/cpu/d=
ispatching')
        #TODO wait
        exec_command_and_wait_for_pattern(self,
                '/bin/cat /sys/devices/system/cpu/dispatching', dispatching=
)

or similar, you could also put the path into a variable.

> +
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +        exec_command(self, 'echo 0 > /sys/devices/system/cpu/dispatching=
')
> +        time.sleep(0.2)
> +        exec_command_and_wait_for_pattern(self,
> +                '/bin/cat /sys/devices/system/cpu/dispatching', '0')
> +
> +        self.check_topology(0, 0, 0, 0, 'medium', False)


