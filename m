Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD473B6FC
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfko-0002Ty-Nn; Fri, 23 Jun 2023 08:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qCfkd-0002Ru-Qk; Fri, 23 Jun 2023 08:18:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qCfkb-0001q0-5o; Fri, 23 Jun 2023 08:18:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35NBEMK4027294; Fri, 23 Jun 2023 12:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=xbNuUuaMWi+btH1Zt/bMFkqCaC5SmaYDxrOGgEwwLS4=;
 b=pVFOezscbGbpVnYSFxqa9HVdVhhsftCxXx3zs5MYbTEZV7bLJZv1gKqGU8A/N73sEOlK
 ZsA+5bpgo4lqZkahHxAnq4iK2w0vFZ12WOHzVK/lGFxAecg5eRvM55E7/XnIQq1LNorp
 4txfcB3qrK38pCkm3fc43GXPKfMEnTuelRsvQLrmqgJPvnGKAgCW/ICAYoTCBGKRk0+2
 xvV/YV/x/56URyvsfu+NPsN+rBPeOUdTvsL1S/pyGtiZ4gwczwWDKCbpCJdKm8flz/9o
 gapbHCdP9pxk1gGq32X+FftGv68ZGEYgoHsmAwnOPNIV/hhNSWnPd+JVWENoO6s0cfil aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcpjhap18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 12:18:43 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35NCIgVj009488; 
 Fri, 23 Jun 2023 12:18:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3r95wn29j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 12:18:42 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35NCIgwW009483;
 Fri, 23 Jun 2023 12:18:42 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 35NCIfRq009482
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 12:18:42 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id 2536A7376; Fri, 23 Jun 2023 09:18:41 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: npiggin@gmail.com
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 quic_mathbern@quicinc.com, tsimpson@quicinc.com
Subject: Re: [PATCH] gdbstub: Permit reverse step/break to provide stop
 response
Date: Fri, 23 Jun 2023 09:18:39 -0300
Message-Id: <5a4ff40f5adc9aa4a1b173fdfb4e179a53c922f3.1687522225.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230623035304.279833-1-npiggin@gmail.com>
References: <20230623035304.279833-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: Tlwjvw_3o3ye5cbXJh41dJB7HeHIqmzx
X-Proofpoint-GUID: Tlwjvw_3o3ye5cbXJh41dJB7HeHIqmzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=642 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230111
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

> Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The final part of the reverse step and break handling is to bring
> the machine back to a debug stop state. gdb expects a response.
> 
> A gdb 'rsi' command hangs forever because the gdbstub filters out
> the response (also observable with reverse_debugging.py avocado
> tests).
> 
> Fix by setting allow_stop_reply for the gdb backward packets.

Ah, it's interesting that [1] doesn't include 'bc' and 'bs' in the list
of cmds that may respond with a stop-reply packet:

    "The 'C', 'c', 'S', 's', 'vCont', 'vAttach', 'vRun', 'vStopped', and
    '?' packets can receive any of the below as a reply."

But their definitions at [2] do say the following:

    'bc' (and 'bc')
    [...]
    Reply: See Stop Reply Packets, for the reply specifications.

So I guess the list from [1] is not exhaustive. Anyway, thanks for the
fix!

Acked-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

[1]: https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets
[2]: https://sourceware.org/gdb/onlinedocs/gdb/Packets.html#Packets

