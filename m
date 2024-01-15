Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DBB82DE77
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:31:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQmb-0001O7-5L; Mon, 15 Jan 2024 12:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1rPQmQ-0001Nq-Ap
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:29:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1rPQmO-0006zq-GP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:29:46 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FETnrQ015733; Mon, 15 Jan 2024 17:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=44KnggkJHKZKTh8VXIx+hnSsGaAriowqHa/s98Rq5J4=; b=k1
 rsmQLWkNN/VoFig36nWN0PmX1xkfXBAF9oBP+bOHPALDLe8YHO9hVQo+P4zpBL4z
 9OsyPyBweTn6BRGYDmPncQM3UqTTnSkXPnOgynvsp6kbyB+/z7VA6JhnpHud+ML9
 2QsNgxjg2C7NaLY99FZ9WmRydBMrifuzrusAU+ZtM6nuhHXam3mO5A/3mVUAvxUm
 8IMOICBoYm0/ywi1Q5jcQykck0Sr1otoV0u0S9chydtng2wHM9bWeN2GVLWmL2pc
 Gc4rjo95SEFo+OAGUgdOPl7KS99PnrIILNSuzYWRW+xviC4bCK/D9T5DbpOz6KcY
 lTUIajXN4QQBg/uF6M8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmjukx7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 17:29:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FHTdXh021560
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 17:29:39 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 09:29:38 -0800
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: Brian Cain <bcain@quicinc.com>
CC: <qemu-devel@nongnu.org>, <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] tests/docker: Hexagon toolchain update
Date: Mon, 15 Jan 2024 14:29:13 -0300
Message-ID: <20240115172913.2189391-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240114232354.4109231-1-bcain@quicinc.com>
References: <20240114232354.4109231-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: OI5dOCAAggTm7Y5FtgGI9nvFajXCDNpK
X-Proofpoint-GUID: OI5dOCAAggTm7Y5FtgGI9nvFajXCDNpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxlogscore=575 clxscore=1011 malwarescore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150128
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 14 Jan 2024 15:23:54 -0800 Brian Cain <bcain@quicinc.com> wrote:
>
> This update includes support for privileged instructions.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---

Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Tested-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> index 7c38d7c9e4..60bd8faa20 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -38,9 +38,9 @@ RUN apt-get update && \
>  RUN /usr/bin/pip3 install tomli
>  
>  ENV TOOLCHAIN_INSTALL /opt
> -ENV TOOLCHAIN_RELEASE 16.0.0
> +ENV TOOLCHAIN_RELEASE 12.Dec.2023

FWIW, the changes can be seen here:
https://github.com/quic/toolchain_for_hexagon/compare/v16.0.0...v12.Dec.2023

