Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF207724DE
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 15:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSzsM-0006GH-Ao; Mon, 07 Aug 2023 09:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qSzsA-0006F0-0P
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 09:02:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qSzs5-0007Az-3q
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 09:02:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377C8iHd017050; Mon, 7 Aug 2023 13:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PgYqGOeygYCB951+osb8gT8ggp1QXxC5Wh2swGjmqck=;
 b=Jnk2hGX7ftHn0sl8AnMUaBTMlWYCHEsRZWa3bHe2274OCyAoou3kpbRxRVnl/p99FA6h
 FnZ3CB51bdB8SJQSDSvLxxGWbuXQe7lbkVfZh1tioWgr0KTlRpzcJf1Ee7nVP/KT3P30
 etyVsGVnfEDGDG73izKlnLKhEVfjPbcK9ZqtNJ7ikTC4eZB1BSpqr1oiXYdOlJ01Gx/l
 Q9x72b1N3dSmn3jGr+u6FPMIt3KxcVm4OsY//CXXz+azXGxvqryc9zWiP50qcxCw2q0r
 blljRSrWiuE7+o/CwdtnaeJgPQ78S1/qpUzCGW6goNJ0CiDl3Pv5NTTaFPWbEtNW8RFc TA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9f6pkdjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 13:01:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377D1mEr008983
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 7 Aug 2023 13:01:48 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 06:01:47 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <richard.henderson@linaro.org>
CC: <ale@rev.ng>, <alex.bennee@linaro.org>, <anjo@rev.ng>, <bcain@quicinc.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <quic_mathbern@quicinc.com>,
 <quic_mliebel@quicinc.com>, <stefanha@redhat.com>,
 <tsimpson@quicinc.com>, <npiggin@gmail.com>, <fbarrat@linux.ibm.com>
Subject: Re: [PULL v2 40/44] gdbstub: add test for untimely stop-reply packets
Date: Mon, 7 Aug 2023 10:01:37 -0300
Message-ID: <20230807130137.2306481-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <de9dfae3-4145-6933-80aa-e7ef9d9bfb3a@linaro.org>
References: <de9dfae3-4145-6933-80aa-e7ef9d9bfb3a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: bip44Lm6Iz8jVztLjDIf0RNK34EHzpzf
X-Proofpoint-GUID: bip44Lm6Iz8jVztLjDIf0RNK34EHzpzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi, Richard

Richard Henderson <richard.henderson@linaro.org> wrote:
>
> On 5/18/23 13:04, Taylor Simpson wrote:
> > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > 
> > In the previous commit, we modified gdbstub.c to only send stop-reply
> > packets as a response to GDB commands that accept it. Now, let's add a
> > test for this intended behavior. Running this test before the fix from
> > the previous commit fails as QEMU sends a stop-reply packet
> > asynchronously, when GDB was in fact waiting an ACK.
> > 
> > Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > Acked-by: Alex Bennée <alex.bennee@linaro.org>
> > Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> > Message-Id: <a30d93b9a8d66e9d9294354cfa2fc3af35f00202.1683214375.git.quic_mathbern@quicinc.com>
> > ---
> >   tests/guest-debug/run-test.py                    | 16 ++++++++++++----
> >   .../tcg/multiarch/system/Makefile.softmmu-target | 16 +++++++++++++++-
> >   2 files changed, 27 insertions(+), 5 deletions(-)
> 
> This test is failing for me on x86_64 and aarch64 host, aarch64 guest:
> 
> 
> qemu-system-aarch64: -gdb unix:path=/tmp/tmptlr0fa8hqemu-gdbstub/gdbstub.socket,server=on: 
> info: QEMU waiting for connection on: 
> disconnected:unix:/tmp/tmptlr0fa8hqemu-gdbstub/gdbstub.socket,server=on
> qemu-system-aarch64: warning: gdbstub: client sent packet while target running
> 
>    GREP    file
>    untimely-packet.gdb.err
> make[1]: *** [/home/rth/qemu/src/tests/tcg/multiarch/system/Makefile.softmmu-target:33: 
> run-gdbstub-untimely-packet] Error 1

This looks like the recent breakage I reported at
https://lore.kernel.org/qemu-devel/456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com/

