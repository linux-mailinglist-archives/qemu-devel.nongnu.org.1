Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76374EC38
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 13:05:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJBAP-00074c-Rw; Tue, 11 Jul 2023 07:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qJBAJ-00073w-Q4; Tue, 11 Jul 2023 07:04:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qJBAH-0007wm-R5; Tue, 11 Jul 2023 07:04:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36BAbgLU010960; Tue, 11 Jul 2023 11:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mDhxjq/QmC1z2rGY+oxAtuh2JkMsBXRXmAH9078XYzs=;
 b=mcFkaPW7BjW0lmZ2GIOe79m4N0OtSIekO2Xawf67l1vjW1sOU8zCkIC+35rvQWoC8v/5
 iWYxb4VJ04T8F1CiZTOkk322TS0R8HNetNCbDS+wEJnydg9uGrHml2NhRAAFtnbQ2/8M
 Mj9UbBYDf5CiY2/1er8uXLVNN1jxo+BUJaS+v/oBI22IpiZBGMLpUnLo43G0HTpAV4LT
 FnX8s6c/yaGfxvL2SAIyB9xsRTD0fh2HSiLPE0wz1uEMJyDnplT+V5IUosLDkRgtijd/
 NdYXFgPPPBnM+VOKga2Rqwb2lJenWvbAJh9dvuPp88J730y/QE04Lf/O/qUkWw38qPTO 8g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs459g6hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jul 2023 11:04:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BB49du003609
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Jul 2023 11:04:10 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 04:03:53 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <npiggin@gmail.com>
CC: <alex.bennee@linaro.org>, <fbarrat@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-stable@nongnu.org>, <quic_mathbern@quicinc.com>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
Date: Tue, 11 Jul 2023 08:03:43 -0300
Message-ID: <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230711085903.304496-1-npiggin@gmail.com>
References: <20230711085903.304496-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: RKnAF7Xt7Csx42ruYRrbkxksPZMIysrV
X-Proofpoint-GUID: RKnAF7Xt7Csx42ruYRrbkxksPZMIysrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=589
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110099
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
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

> Nicholas Piggin <npiggin@gmail.com> wrote:
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 6911b73c07..ce8b42eb15 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
>              return;
>      }
>      if (runstate_is_running()) {
> -        /* when the CPU is running, we cannot do anything except stop
> -           it when receiving a char */
> +        /*
> +         * When the CPU is running, we cannot do anything except stop
> +         * it when receiving a char. This is expected on a Ctrl-C in the
> +         * gdb client. Because we are in all-stop mode, gdb sends a
> +         * 0x03 byte which is not a usual packet, so we handle it specially
> +         * here, but it does expect a stop reply.
> +         */
> +        if (ch != 0x03) {
> +            warn_report("gdbstub: client sent packet while target running\n");
> +        }
> +        gdbserver_state.allow_stop_reply = true;
>          vm_stop(RUN_STATE_PAUSED);
>      } else
>  #endif

Makes sense to me, but shouldn't we send the stop-reply packet only for
Ctrl+C/0x03?

