Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C89367D010F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXHt-0001IZ-Pu; Thu, 19 Oct 2023 13:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtXHr-00014Z-D4; Thu, 19 Oct 2023 13:58:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtXHp-0001Rz-DY; Thu, 19 Oct 2023 13:58:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JHlJSb022932; Thu, 19 Oct 2023 17:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OwY9xZ266K8KxTGPeJc4XWdPqYn+uuxmjHU1GiVomqM=;
 b=nMhHh0gCDuEbk4LBkBoSESX7YuFO9iNZ43fLKLsS3y70qUgzTlAwPBPeGTP/aIXYKHj4
 dIFN8u8qFb9O6CqmsUg1Vi37fJHkMHemDYJTa6K2TupnlveZHFJihC8N9Nfgk+6q6h1E
 d+vtpa9c2fdreBa2V/fQr5QwS0A7TVPZDaGGV0uklPdJPXzEXoYfFe8ZDddZjUAlbHSZ
 nzR9Z6InvEFlZWcqQC5UHTpBPAwNEdVTf4gSCRC7L0fMCdwR3dM/Gm3uldEiukPj2EG7
 PebKtYorlkfMo+QBoXGpMrMq6zjbAvm0bXijDkA5Py83ejRyJ/t3e94qwDS4U6LAbWnH uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu95pre5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:58:19 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JHlShB024173;
 Thu, 19 Oct 2023 17:58:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu95prd5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:58:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JHIE38027154; Thu, 19 Oct 2023 17:55:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tktbym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:55:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JHtZfK41091506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 17:55:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 481EA20043;
 Thu, 19 Oct 2023 17:55:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC30520040;
 Thu, 19 Oct 2023 17:55:34 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.84.173]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 17:55:34 +0000 (GMT)
Message-ID: <991f3195f7e4e3989e43e45e9e1910cda410c444.camel@linux.ibm.com>
Subject: Re: [PULL 06/25] s390x/cpu topology: resetting the
 Topology-Change-Report
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org
Date: Thu, 19 Oct 2023 19:55:34 +0200
In-Reply-To: <CAJSP0QXc1yeRYMaEZ_1cRc2d7_E2-vb7Ai4D2P0uRQYTqDqDsA@mail.gmail.com>
References: <20231018130716.286638-1-thuth@redhat.com>
 <20231018130716.286638-7-thuth@redhat.com>
 <CAJSP0QXc1yeRYMaEZ_1cRc2d7_E2-vb7Ai4D2P0uRQYTqDqDsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EzNC1ZJY2BMLh_D1rwigzjCyWAWcPcL9
X-Proofpoint-ORIG-GUID: mgsmykuW2zvX5Rmmb_93wlXudEA_wQXH
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
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

On Thu, 2023-10-19 at 09:35 -0700, Stefan Hajnoczi wrote:
> On Wed, 18 Oct 2023 at 06:09, Thomas Huth <thuth@redhat.com> wrote:
> >=20
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > During a subsystem reset the Topology-Change-Report is cleared
> > by the machine.
> > Let's ask KVM to clear the Modified Topology Change Report (MTCR)
> > bit of the SCA in the case of a subsystem reset.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Message-ID: <20231016183925.2384704-7-nsg@linux.ibm.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  include/hw/s390x/cpu-topology.h |  1 +
> >  target/s390x/cpu.h              |  1 +
> >  target/s390x/kvm/kvm_s390x.h    |  1 +
> >  hw/s390x/cpu-topology.c         | 11 +++++++++++
> >  hw/s390x/s390-virtio-ccw.c      |  3 +++
> >  target/s390x/cpu-sysemu.c       | 13 +++++++++++++
> >  target/s390x/kvm/kvm.c          | 17 +++++++++++++++++
> >  7 files changed, 47 insertions(+)
> >=20
> > diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-top=
ology.h
> > index f95d26d37c..e33e7c66df 100644
> > --- a/include/hw/s390x/cpu-topology.h
> > +++ b/include/hw/s390x/cpu-topology.h
> > @@ -56,6 +56,7 @@ static inline void s390_topology_setup_cpu(MachineSta=
te *ms,
> >  #endif
> >=20
> >  extern S390Topology s390_topology;
> > +void s390_topology_reset(void);
>=20
> Please take a look at the following CI failure:
>=20
> /usr/bin/ld: libqemu-s390x-softmmu.fa.p/hw_s390x_s390-virtio-ccw.c.o:
> in function `subsystem_reset':
> /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/../hw/s390x=
/s390-virtio-ccw.c:128:
> undefined reference to `s390_topology_reset'
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/5330218593

I can replicate this with --disable-kvm, tho I don't think that's what the =
CI does.
Fix looks something like this (copy pasted):

--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -45,6 +45,7 @@ typedef QTAILQ_HEAD(, S390TopologyEntry) S390TopologyList;
 #ifdef CONFIG_KVM
 bool s390_has_topology(void);
 void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp);
+void s390_topology_reset(void);
 #else
 static inline bool s390_has_topology(void)
 {
@@ -53,10 +54,14 @@ static inline bool s390_has_topology(void)
 static inline void s390_topology_setup_cpu(MachineState *ms,
                                            S390CPU *cpu,
                                            Error **errp) {}
+static inline void s390_topology_reset(void)
+{
+    /* Unreachable, CPU topology not implemented for TCG */
+    assert(false);
+}
 #endif

 extern S390Topology s390_topology;
-void s390_topology_reset(void);

 static inline int s390_std_socket(int n, CpuTopology *smp)
 {


