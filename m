Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B680085A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:36:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90sX-00040O-Fk; Fri, 01 Dec 2023 05:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1r90sS-0003zn-Tu; Fri, 01 Dec 2023 05:36:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1r90sQ-0003VR-Ei; Fri, 01 Dec 2023 05:36:07 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B17eXir007524; Fri, 1 Dec 2023 10:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=yu4d0GWHikch8xGl0PGozqyWCRDt9ZlGerfwRrP4sGs=;
 b=WbWp/bOoeBKMCN0rbbUYLioXaGQK44qtOsKR+mosK/JzFys+lMM2K2U55YozLjaX3AbO
 5BDQz8G8IUuYGwgoCPOYPEhSCbOmj6exU3MI3BNjdEgscIoztkd03wdPf3Tf7ydlNLaJ
 y+vsWHnNzIAfnBpE1/rK1D4GY/kjy/vKhsQITc2FXJOJsGJoEltvSIwW3jcUjnAno2kf
 xM1o7/1VIpdeGuXUEF7SmfGKqu37CUX9PNhe00wpZHPyGeaGv5asRyoocX+VOdBVMBWL
 dOaalM0MiejrVTA9S3+9vKC7CKnrEe5DTfUzl0Kpc5VIBz3w9JCD6EkJl78wDlfK4vrX Fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq79h8uyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 10:36:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1Aa2Bs012125
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 1 Dec 2023 10:36:02 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 02:35:58 -0800
Date: Fri, 1 Dec 2023 16:05:54 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Alex Benn?e <alex.bennee@linaro.org>
CC: <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v0 02/12] update-linux-headers: Include gunyah.h
Message-ID: <20231201103554.GB3618015@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-3-quic_svaddagi@quicinc.com>
 <87leag8q7d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87leag8q7d.fsf@draig.linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: t9_dsA67UNi1xozs_4kYnfQR0AbkKQ7f
X-Proofpoint-GUID: t9_dsA67UNi1xozs_4kYnfQR0AbkKQ7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_08,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

* Alex Benn?e <alex.bennee@linaro.org> [2023-11-29 16:44:06]:

> Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> writes:
> 
> > gunyah.h containts UAPI definitions exported by Gunyah Linux kernel
> > driver. This file will be referenced by Gunyah accelerator driver in
> > Qemu.
> >
> > Note: Gunyah Linux kernel driver is not yet merged in Linux kernel.
> > v14 of the patch series has been posted on mailing lists.
> >
> > https://lore.kernel.org/lkml/20230613172054.3959700-1-quic_eberman@quicinc.com/
> >
> > One of the subsequent versions of the patch is expected to be merged
> > upstream soon, after this this change to 'update-linux-headers' can be
> > run against the main Linux kernel source repository from kernel.org.
> >
> > In the meantime, a version of Gunyah kernel driver is available in
> > Android kernel repository, against which this change can be run.
> >
> > https://android.googlesource.com/kernel/common
> > Branch: android14-6.1
> >
> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> 
> with fix:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> although it will need another fixup on rebase due to other headers being
> added. Maybe now is the time to sort the header list to lessen the
> chance of clashes in future?

Sure will suggest sorted header list in my next revision!

- vatsa

 
> > ---
> >  scripts/update-linux-headers.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> > index 35a64bb501..3f3608bcbe 100755
> > --- a/scripts/update-linux-headers.sh
> > +++ b/scripts/update-linux-headers.sh
> > @@ -161,7 +161,8 @@ done
> >  rm -rf "$output/linux-headers/linux"
> >  mkdir -p "$output/linux-headers/linux"
> >  for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
> > -              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h vduse.h; do
> > +              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
> > +              vduse.h gunyah.h; do
> >      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
> >  done
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


