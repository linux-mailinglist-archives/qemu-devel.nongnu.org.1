Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6673863A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:08:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByV1-00063A-Rz; Wed, 21 Jun 2023 10:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qByUm-00062U-W1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:07:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qByUj-00009e-NY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:07:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LDvJib013212
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 14:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dw/tGSYjYcS5OubsF3lvnsbh16DFWLJ4db+FZhSf6Dg=;
 b=etaUcZYV86yxCI8f/zxQZZfY55SyD5xuKTHGaoFV/PWeATPKfN1pKmjh89ZcpOZrnERD
 nXKEpJQzKjSrd8T2n0N7IsrgmainkYzGpFb6BEV04iBJBzC1ecLY66Gx8+Y1Smd1LMIR
 zTDaVrofA0heXw3g/+dwyXSW9+hPiPvtSHEmowSiZjuxjPSTF4ncpe65oYo3tYaYdc0V
 7f95bDAgrj/IpeaNhy/FOG8xwQHQIuOLSKDqVjeKvbnhpd4NJdKZzyHpwlXzUD8WwB+k
 RQJsNTFm8i5ka/QDc9edZ6akTEnOwa/0hC5K83dZlEqIKr31dVgG8LLpgj6SG89MRJsW FA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2ctrjuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 14:07:34 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LE60tU008569
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 14:07:34 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2ctrjru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 14:07:33 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35LCC2ce001796;
 Wed, 21 Jun 2023 14:07:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e24d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 14:07:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LE7ShN10814032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 14:07:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E631B20040;
 Wed, 21 Jun 2023 14:07:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A88652004B;
 Wed, 21 Jun 2023 14:07:27 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown
 [9.171.51.126]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 14:07:27 +0000 (GMT)
Message-ID: <31e1b43a026886e08ed48dcebbd27626eede872e.camel@linux.ibm.com>
Subject: Re: [PATCH] git-submodule.sh: allow running in validate mode
 without previous update
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Date: Wed, 21 Jun 2023 16:07:27 +0200
In-Reply-To: <CABgObfa8kEiG22MAdsuhgpuWrzWq9yWMeRaFgvWA5x_eoROPUw@mail.gmail.com>
References: <20230618212039.102052-1-pbonzini@redhat.com>
 <d6a79a1d2159e0659cd0ed6ff545bf577c05bad3.camel@linux.ibm.com>
 <CABgObfa8kEiG22MAdsuhgpuWrzWq9yWMeRaFgvWA5x_eoROPUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bHuIot0M2ty8bKoiNFV8VLbrtD9TH_9r
X-Proofpoint-ORIG-GUID: WoNIq_TcPPZHQIV1ReIbXSBkec7PtyuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

On Tue, 2023-06-20 at 22:44 +0200, Paolo Bonzini wrote:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0=20
> Il mar 20 giu 2023, 19:35 Nina Schoetterl-Glausch <nsg@linux.ibm.com> ha =
scritto:
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules=3D"$modules $m"
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grep $m $substat > /dev/nu=
ll 2>&1 || $GIT submodule status $module >> $substat
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "warn: ignoring non-e=
xistent submodule $m"
> >=20
> > What is the rational for ignoring non-existing submodules, i.e. how do =
the arguments to
> > the script go stale as you say in the patch description?
>=20
> For example when a Makefile calls the script before the Makefile itself i=
s rebuilt.

Ah thanks. Can this still happen, roms/SLOF being the only remaining build =
time user of submodules,
as per 1f468152fb ("build: remove git submodule handling from main makefile=
")?
pc-bios/s390-ccw/Makefile explicitly names roms/SLOF, so if that were remov=
ed, the Makefile would
need to be fixed anyway.

>=20
> > I'm asking because the fedora spec file initializes a new git repo in o=
rder to apply
> > patches so the script exits with 0.
>=20
> You mean it succeeds even if roms/SLOF is empty?

Yeah, it does:

%prep
%autosetup -n qemu-%{version}%{?rcstr} -S git_am

Which I does a git init, git add ., git commit, so no submodules exist and =
git-submodule.sh ignores
every maybe_module.

Not a problem with qemu, I'm just wondering if this behavior is still the m=
ost sensible for git-submodule.sh


[...]

