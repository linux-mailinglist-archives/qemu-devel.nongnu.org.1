Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23677B231C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 19:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qluMn-0004bh-CQ; Thu, 28 Sep 2023 12:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qluMj-0004bB-3x
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 12:59:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qluMf-0004xO-La
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 12:59:52 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38SGjuTi030243
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=6tAueajJeIlsm/eo04M5rJ7MnuX+V6wptFubCPAvq6g=;
 b=ZqxMpKMRTptAd1y+8P3Ln3boNVT6LLEdx7q5YKbgyzCjAc63YsCR/uR+Ee2sNkli6MFy
 mTMkTzcQHS7j6fZ2EwvRvunI/hlbaxmXp4QVTrKzCvr0YWfD3+YlvqEs94TiYcLvTMQs
 IvWaK7qgafIUl3nYTBgBpip+zeWV8xrVuOtz2QJaIsJgWnEk3IXQTMaoBEV1hqjH0RY6
 WsoVdxhaQi9IT1ORBkaBez+ZazL9o4sJtyNgpZGMStznxhKYBJqV281ynpkjoSeoieNk
 Er6VdboR59wwfAGXFaAKoGbttQlsk3NWDIM1P3AGi8o5X65YmhBM/0XuemrjppK8DVtl Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdbh5uv59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:59:44 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SGdsLZ008880
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:59:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdbh5uv4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 16:59:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38SGnbWe030746; Thu, 28 Sep 2023 16:59:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjkdpm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 16:59:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38SGxfmA63177188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Sep 2023 16:59:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D991758066;
 Thu, 28 Sep 2023 16:59:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF96458057;
 Thu, 28 Sep 2023 16:59:40 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.144.155])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 28 Sep 2023 16:59:40 +0000 (GMT)
Message-ID: <71a454d700b67fb88566ee05ef860404dcbf046b.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] tpm: add backend for mssim
From: James Bottomley <jejb@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 28 Sep 2023 12:59:39 -0400
In-Reply-To: <87bkdm6f2o.fsf@pond.sub.org>
References: <20230927164908.12891-1-jejb@linux.ibm.com>
 <20230927164908.12891-3-jejb@linux.ibm.com> <ZRRgVAMbwXDsvdk/@redhat.com>
 <87bkdm6f2o.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GoXnIcx4mDNdz6xB7Hm0qFSQ_3VETcs_
X-Proofpoint-ORIG-GUID: GWwHakfRx0uCVMuM6r2jEeUOc9xQ9r11
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 impostorscore=0 mlxlogscore=944 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280144
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

On Thu, 2023-09-28 at 07:29 +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Sep 27, 2023 at 12:49:08PM -0400, James Bottomley wrote:
> > > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > 
> > > The Microsoft Simulator (mssim) is the reference emulation
> > > platform
> > > for the TCG TPM 2.0 specification.
> > > 
> > > https://github.com/Microsoft/ms-tpm-20-ref.git
> > > 
> > > It exports a fairly simple network socket based protocol on two
> > > sockets, one for command (default 2321) and one for control
> > > (default
> > > 2322).  This patch adds a simple backend that can speak the mssim
> > > protocol over the network.  It also allows the two sockets to be
> > > specified on the command line.  The benefits are twofold: firstly
> > > it
> > > gives us a backend that actually speaks a standard TPM emulation
> > > protocol instead of the linux specific TPM driver format of the
> > > current emulated TPM backend and secondly, using the microsoft
> > > protocol, the end point of the emulator can be anywhere on the
> > > network, facilitating the cloud use case where a central TPM
> > > service
> > > can be used over a control network.
> > > 
> > > The implementation does basic control commands like power off/on,
> > > but
> > > doesn't implement cancellation or startup.  The former because
> > > cancellation is pretty much useless on a fast operating TPM
> > > emulator
> > > and the latter because this emulator is designed to be used with
> > > OVMF
> > > which itself does TPM startup and I wanted to validate that.
> > > 
> > > To run this, simply download an emulator based on the MS
> > > specification
> > > (package ibmswtpm2 on openSUSE) and run it, then add these two
> > > lines
> > > to the qemu command and it will use the emulator.
> > > 
> > >     -tpmdev mssim,id=tpm0 \
> > >     -device tpm-crb,tpmdev=tpm0 \
> > > 
> > > to use a remote emulator replace the first line with
> > > 
> > >     -tpmdev
> > > "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remot
> > > e','port':'2321'}}"
> > > 
> > > tpm-tis also works as the backend.
> > > 
> > > Signed-off-by: James Bottomley <jejb@linux.ibm.com>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> [...]
> 
> > > diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
> > > new file mode 100644
> > > index 0000000000..b8a12dce04
> > > --- /dev/null
> > > +++ b/backends/tpm/tpm_mssim.c
> > > @@ -0,0 +1,290 @@
> > > +/*
> > > + * Emulator TPM driver which connects over the mssim protocol
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * Copyright (c) 2022
> > > + * Author: James Bottomley <jejb@linux.ibm.com>
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qemu/sockets.h"
> > > +
> > > +#include "qapi/clone-visitor.h"
> > > +#include "qapi/qapi-visit-tpm.h"
> > > +
> > > +#include "io/channel-socket.h"
> > > +
> > > +#include "sysemu/runstate.h"
> > > +#include "sysemu/tpm_backend.h"
> > > +#include "sysemu/tpm_util.h"
> > > +
> > > +#include "qom/object.h"
> > > +
> > > +#include "tpm_int.h"
> > > +#include "tpm_mssim.h"
> > > +
> > > +#define ERROR_PREFIX "TPM mssim Emulator: "
> > > +
> > > +#define TYPE_TPM_MSSIM "tpm-mssim"
> > > +OBJECT_DECLARE_SIMPLE_TYPE(TPMMssim, TPM_MSSIM)
> > > +
> > > +struct TPMMssim {
> > > +    TPMBackend parent;
> > > +
> > > +    TPMMssimOptions opts;
> > > +
> > > +    QIOChannelSocket *cmd_qc, *ctrl_qc;
> > > +};
> > > +
> > > +static int tpm_send_ctrl(TPMMssim *t, uint32_t cmd, Error
> > > **errp)
> > > +{
> > > +    int ret;
> > > +
> > > +    qio_channel_socket_connect_sync(t->ctrl_qc, t->opts.control,
> > > errp);
> > 
> > Need to assign to 'ret' and check for failure here, otherwise the
> > next call to write_all will overwrite the useful message in 'errp'
> > with a less helpful one.
> 
> No, it'll crash :)
> 
> An @errp argument must point to a null pointer.  If it doesn't,
> setting
> an error will trip error_setv()'s assertion.
> 
> > +    cmd = htonl(cmd);
> > +    ret = qio_channel_write_all(QIO_CHANNEL(t->ctrl_qc),
> > +                                (char *)&cmd, sizeof(cmd), errp);
> > +    if (ret != 0) {
> > +        goto out;
> > +    }
> 
> qapi/error.h's big comment advises:
> 
>  * Receive and accumulate multiple errors (first one wins):
>  *     Error *err = NULL, *local_err = NULL;
>  *     foo(arg, &err);
>  *     bar(arg, &local_err);
>  *     error_propagate(&err, local_err);
>  *     if (err) {
>  *         handle the error...
>  *     }
>  *
>  * Do *not* "optimize" this to
>  *     Error *err = NULL;
>  *     foo(arg, &err);
>  *     bar(arg, &err); // WRONG!
>  *     if (err) {
>  *         handle the error...
>  *     }
>  * because this may pass a non-null err to bar().
>  *
>  * Likewise, do *not*
>  *     Error *err = NULL;
>  *     if (cond1) {
>  *         error_setg(&err, ...);
>  *     }
>  *     if (cond2) {
>  *         error_setg(&err, ...); // WRONG!
>  *     }
>  * because this may pass a non-null err to error_setg().
> 
> The quoted code is like the last example, except the error_setg()
> lurk within the functions called.

So this is what I chose:

 out:
    /*
     * need to close the channel here, but if that fails report it
     * while not letting a prior failure get overwritten
     */
    retc = qio_channel_close(QIO_CHANNEL(t->ctrl_qc), &local_err);
    error_propagate(errp, local_err);
    return retc ? retc : ret;

Hopefully that looks OK to everyone?

James


