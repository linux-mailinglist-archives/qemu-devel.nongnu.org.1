Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1F750681
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYGC-0004l3-6z; Wed, 12 Jul 2023 07:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qJYGA-0004jC-BW
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:43:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qJYG8-00079o-5J
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:43:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36C8dfp9005676; Wed, 12 Jul 2023 11:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=F4THtZnbdSbiDQ/zjq+LrXDBYTnQ6qecOcSoFdLw1F4=;
 b=gTVoMvwPAICZgABl9YCiBVZV1AMGVEJxlmscbs7+DBqnUE3D+89xYtLWbTdmvoe5M7RR
 cUfYB9gMmHNpR48GGCpB64DlZxF/gt/xMVxO4lEyS0yplE1+gR3VYeXtqIuNP8SqIM78
 ebWTk8GlVBcnVpdtuWXMLazAxQYnz3Sod+6Ng7fWG2lvhqgSQi2kyThFYd13xc2u6q2H
 itZ0Vth/7x0nUAbTEIvrrep49uSDPA9PRCyy7Nsj5gwRfjCP2FmBcv3qAk/vwRMsiyom
 /DOJOrqwJh2nobrC03v/H3jcQTg8LUB9Fs2N6Djtfj85kZZB7rZKw72gyyM7XC5KLymc 4A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgar95um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 11:43:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBhjdN029291
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 11:43:45 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:43:45 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <quic_mathbern@quicinc.com>
CC: <bcain@quicinc.com>, <ltaylorsimpson@gmail.com>, <qemu-devel@nongnu.org>, 
 <quic_mliebel@quicinc.com>, <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] Hexagon: move GETPC() calls to top level helpers
Date: Wed, 12 Jul 2023 08:43:32 -0300
Message-ID: <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689162018.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <2c74c3696946edba7cc5b2942cf296a5af532052.1689070412.git.quic_mathbern@quicinc.com>
References: <2c74c3696946edba7cc5b2942cf296a5af532052.1689070412.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: I0nIBWG0jqmeZpmeGR9zmkIhXDFKXUcJ
X-Proofpoint-ORIG-GUID: I0nIBWG0jqmeZpmeGR9zmkIhXDFKXUcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 mlxlogscore=694 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Matheus Tavares Bernardino <quic_mathbern@quicinc.com> wrote:
>
> Subject: [PATCH v3] Hexagon: move GETPC() calls to top level helpers

Apologies, I had some problems with my send-email and server
configuration, thus ended up sending this v3 multiple times. Please
ignore the others and consider only this one (i.e.
https://lore.kernel.org/qemu-devel/2c74c3696946edba7cc5b2942cf296a5af532052.1689070412.git.quic_mathbern@quicinc.com/).

Thanks,
Matheus

