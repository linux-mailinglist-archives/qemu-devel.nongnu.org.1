Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46982953C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:36:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNU4k-00020B-Jn; Wed, 10 Jan 2024 03:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rNU4d-0001yC-Jp; Wed, 10 Jan 2024 03:36:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rNU4a-0002Ac-PH; Wed, 10 Jan 2024 03:36:30 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40A6U9rr023752; Wed, 10 Jan 2024 08:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-type:in-reply-to; s=qcppdkim1; bh=nRnNf/PE
 hcJUBKeQqhLQSXGvZOD4hqs+EOvQ8YGFVaQ=; b=RBGQZiUiFpigM2gUodYiV62U
 wBoJebXTlZeOILnnAgcOYLgaGL3hyIyjxOmwTL0RyIC3BWcCTrfsRxit7dCbbzTV
 SZNpcb4bTSuUb9qS1E1f12oyXm4CRC2XQ+eP15lhXp/UbwPw2G+rAHAGyEknt2of
 ri529elMuzlT2uVhh9gBEiL04pRKDb0pnXVD71wmIJE9tl66+jz3wSvMDQHDgktO
 TpcMn4ZwO1hVTKiDj5i+mBbG0NnfPlUT7K7pAFjyzV+UEL4WIv2X5ZBSQQeD9MX2
 xfjg68bKK0/ANS/AlQHZCsibfNV1Rc0T/ZiqJ7NMcVqTLZZ+XxIFgNThVUVCkQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhjh2rmnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 08:36:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A8aOEB024296
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 08:36:24 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 00:36:20 -0800
Date: Wed, 10 Jan 2024 14:06:16 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Philippe Mathieu-Daud? <philmd@linaro.org>
CC: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v1 07/11] gunyah: Specify device-tree location
Message-ID: <20240110083616.GC1649721@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
 <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
 <282dc91e-0f56-4a74-9110-ea4824e6d61d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <282dc91e-0f56-4a74-9110-ea4824e6d61d@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: KCj817lzD3af04Lj1YCtw97NpSDialCH
X-Proofpoint-GUID: KCj817lzD3af04Lj1YCtw97NpSDialCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=733 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

* Philippe Mathieu-Daud? <philmd@linaro.org> [2024-01-09 14:36:12]:

> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "sysemu/gunyah.h"
> > +#include "sysemu/gunyah_int.h"
> > +#include "linux-headers/linux/gunyah.h"
> I'm getting on macOS:
> 
> In file included from ../../target/arm/gunyah.c:13:
> linux-headers/linux/gunyah.h:13:10: fatal error: 'linux/types.h' file not
> found
> #include <linux/types.h>
>          ^~~~~~~~~~~~~~~
> 1 error generated.
> 
> Maybe we need the following change?
> 
> -- >8 --
> diff --git a/meson.build b/meson.build
> index 6ded60063e..fb20ca04d1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -712,5 +712,5 @@ endif
> 
>  gunyah = not_found
> -if get_option('gunyah').allowed()
> +if get_option('gunyah').allowed() and host_os == 'linux'
>      accelerators += 'CONFIG_GUNYAH'
>  endif

Ok sure will include that change in my next version.

- vatsa

