Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B38677B9F32
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPDJ-00008j-4S; Thu, 05 Oct 2023 10:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qoPD9-00008H-LW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:20:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qoPD6-0001ln-UW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:20:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395EF9G4004181; Thu, 5 Oct 2023 14:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=paU7WOZjJSJnRMm3vXxkNShs5zBgAhx2iY3K+rkR/Jw=;
 b=lTKqd5Z5XeWOWxKdJPsuQx0Z12MhCxuNeQezM9AAwQqL36DZYc5IaLyI7HYpqXv7fGW1
 H951GmmmxAa56EWVYEn/7es8A46HnzHFIK/pT6E1XR6I2mh+1gF9S+VCLXpVWqIJ00J3
 v31yCcWDkYrNzjKl7/dE9WHiiznUI/iNe7hyh2QT3XSx18ae1DtV+9ViPzNHArgR151x
 X0XsU5JVhpAHRlpzKRsahathlReCjYuR/p+CRSxe8r0NY365m/HRKTnN4QpMQNMtMcTp
 ycMz6jxI7WjmbLezGhqNfPUXwdQaIUE98q+Fjy0JmDLuVHRpwIzJbbPR2UKjC6FZrB3a og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thw9j647b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 14:20:10 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395CZvda005308;
 Thu, 5 Oct 2023 14:18:44 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thw9j5119-132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 14:18:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395D7r4K010941; Thu, 5 Oct 2023 13:57:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q2bbds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 13:57:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395DvDhv3277352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 13:57:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E9355805D;
 Thu,  5 Oct 2023 13:57:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB74558058;
 Thu,  5 Oct 2023 13:57:11 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.80.55])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 13:57:11 +0000 (GMT)
Message-ID: <6a9b9967d1f94d423aa87e6da007d8b3c3f08d31.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/2] tpm: add backend for mssim
From: James Bottomley <jejb@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 05 Oct 2023 09:57:10 -0400
In-Reply-To: <afab0b07-51b4-81e5-2e7f-03099a7be858@linaro.org>
References: <20231004184219.6594-1-jejb@linux.ibm.com>
 <20231004184219.6594-3-jejb@linux.ibm.com>
 <afab0b07-51b4-81e5-2e7f-03099a7be858@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kat7xxnC5OzjNE6asNR3r0E3gOjAzOL1
X-Proofpoint-ORIG-GUID: AobYcHGMeUD15oXswbAaUGDaz6gVzdys
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310050110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jejb@linux.ibm.com;
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
Reply-To: jejb@linux.ibm.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 2023-10-05 at 08:49 +0200, Philippe Mathieu-Daudé wrote:
> Hi James,
> 
> On 4/10/23 20:42, James Bottomley wrote:
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > 
> > The Microsoft Simulator (mssim) is the reference emulation platform
> > for the TCG TPM 2.0 specification.
> > 
> > https://github.com/Microsoft/ms-tpm-20-ref.git
> > 
> > It exports a fairly simple network socket based protocol on two
> > sockets, one for command (default 2321) and one for control
> > (default
> > 2322).  This patch adds a simple backend that can speak the mssim
> > protocol over the network.  It also allows the two sockets to be
> > specified on the command line.  The benefits are twofold: firstly
> > it
> > gives us a backend that actually speaks a standard TPM emulation
> > protocol instead of the linux specific TPM driver format of the
> > current emulated TPM backend and secondly, using the microsoft
> > protocol, the end point of the emulator can be anywhere on the
> > network, facilitating the cloud use case where a central TPM
> > service
> > can be used over a control network.
> > 
> > The implementation does basic control commands like power off/on,
> > but
> > doesn't implement cancellation or startup.  The former because
> > cancellation is pretty much useless on a fast operating TPM
> > emulator
> > and the latter because this emulator is designed to be used with
> > OVMF
> > which itself does TPM startup and I wanted to validate that.
> > 
> > To run this, simply download an emulator based on the MS
> > specification
> > (package ibmswtpm2 on openSUSE) and run it, then add these two
> > lines
> > to the qemu command and it will use the emulator.
> > 
> >      -tpmdev mssim,id=tpm0 \
> >      -device tpm-crb,tpmdev=tpm0 \
> > 
> > to use a remote emulator replace the first line with
> > 
> >      -tpmdev
> > "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote'
> > ,'port':'2321'}}"
> > 
> > tpm-tis also works as the backend.
> > 
> > Signed-off-by: James Bottomley <jejb@linux.ibm.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > 
> > ---
> > 
> > v2: convert to SocketAddr json and use
> > qio_channel_socket_connect_sync()
> > v3: gate control power off by migration state keep control socket
> > disconnected
> >      to test outside influence and add docs.
> > v7: TPMmssim -> TPMMssim; doc and json fixes
> >      Make command socket open each time (makes OS debugging easier)
> > ---
> >   MAINTAINERS              |   6 +
> >   backends/tpm/Kconfig     |   5 +
> >   backends/tpm/meson.build |   1 +
> >   backends/tpm/tpm_mssim.c | 319
> > +++++++++++++++++++++++++++++++++++++++
> >   backends/tpm/tpm_mssim.h |  44 ++++++
> >   docs/specs/tpm.rst       |  39 +++++
> >   qapi/tpm.json            |  32 +++-
> >   softmmu/tpm-hmp-cmds.c   |   9 ++
> >   8 files changed, 451 insertions(+), 4 deletions(-)
> >   create mode 100644 backends/tpm/tpm_mssim.c
> >   create mode 100644 backends/tpm/tpm_mssim.h
> 
> 
> > diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> > index efe124a148..4fe6c5f051 100644
> > --- a/docs/specs/tpm.rst
> > +++ b/docs/specs/tpm.rst
> > @@ -274,6 +274,42 @@ available as a module (assuming a TPM 2 is
> > passed through):
> >     /sys/devices/LNXSYSTEM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm0/pcr-
> > sha256/9
> >     ...
> >   
> > +The QEMU TPM Microsoft Simulator Device
> > +---------------------------------------
> > +
> > +The Microsoft Simulator (mssim) is the reference emulation
> > platform
> > +for the TCG TPM 2.0 specification.  It provides a reference
> > +implementation for the TPM 2.0 written by Microsoft (See
> > +`ms-tpm-20-ref`_ on github).  The reference implementation starts
> > a
> > +network server and listens for TPM commands on port 2321 and TPM
> > +Platform control commands on port 2322, although these can be
> > altered.
> > +The QEMU mssim TPM backend talks to this implementation.  By
> > default
> > +it connects to the default ports on localhost:
> > +
> > +.. code-block:: console
> > +
> > +  qemu-system-x86_64 <qemu-options> \
> > +    -tpmdev mssim,id=tpm0 \
> > +    -device tpm-crb,tpmdev=tpm0
> > +
> > +
> > +Although it can also communicate with a remote host, which must be
> > +specified as a SocketAddress via json or dotted keys on the
> > command
> > +line for each of the command and control ports:
> > +
> > +.. code-block:: console
> > +
> > +  qemu-system-x86_64 <qemu-options> \
> > +    -tpmdev
> > "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'remot
> > e','port':'2321'},'control':{'type':'inet','host':'remote','port':'
> > 2322'}}" \
> > +    -device tpm-crb,tpmdev=tpm0
> 
> Did you test running this command line on a big-endian host?

Well no, big endian machines are rather rare nowadays.  However, since
the QIOChannelSocket abstraction is based on SocketAddress, which is a
qapi wrapper around strings, what makes you think the endianness would
matter?

James


