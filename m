Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7231582DB9D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:46:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOE0-0007P0-I1; Mon, 15 Jan 2024 09:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1rPODx-0007Ob-HQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:46:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1rPODu-0005bK-Ca
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:46:00 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FCuTcx028068; Mon, 15 Jan 2024 14:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=uy0YMCyhku2nRbcfbVQjLuGXacgE/HQp/cZ0PtpTj5Q=; b=bN
 RweZi9wU7QuYE423v/8VI7PB1R2Vxk4YQ7FZR34OxkufbfFh477cZSjbi1Ezm1Fc
 NCcBlPjDuCZefCHbLEVJ75mCABodD96CLoTcCLrLpxsiK2PpUE8wMS/zJEgbl8Q+
 Xv1TD2LB/qY0wj5x0RDAcEdTYAbjOElPM9M9EFLaJt1vlYFmMn/K6dPhT0zIZtcL
 CrKIEgx80ikL9FfxYRU1mak8/BoWDpMFlXjSkGjphGt3O0Y0FFI/XFHykSYgz3Ur
 1o0Fkm/rxIairGFPZLuAk1MU42CDcKoVhHejhswTz18ob7j1kVpOzjKLDqFhxAv5
 +sou/474ib0DDFlo1NBQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmjc3kqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 14:45:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FEjo3Y030064
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 14:45:50 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 06:45:50 -0800
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: Brian Cain <bcain@quicinc.com>
CC: <qemu-devel@nongnu.org>, <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] Reduce scope of def_regnum, remove dead assignment
Date: Mon, 15 Jan 2024 11:45:30 -0300
Message-ID: <20240115144530.2187353-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240114234453.4114587-1-bcain@quicinc.com>
References: <20240114234453.4114587-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: d5FicufViSfy_rByRQD9EGDKkzvoFtMf
X-Proofpoint-ORIG-GUID: d5FicufViSfy_rByRQD9EGDKkzvoFtMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 mlxlogscore=373
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150107
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

On Sun, 14 Jan 2024 15:44:53 -0800 Brian Cain <bcain@quicinc.com> wrote:
>
> This is intended to address a coverity finding: CID 1527408.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---

Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

