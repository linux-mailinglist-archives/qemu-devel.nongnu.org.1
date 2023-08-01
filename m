Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CA876BCA9
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuIj-0000Ro-TO; Tue, 01 Aug 2023 14:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qQuIh-0000Rb-E8; Tue, 01 Aug 2023 14:40:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qQuIf-0005Qv-M8; Tue, 01 Aug 2023 14:40:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3718A5YD021417; Tue, 1 Aug 2023 18:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QfOkjIYR0xcLipvP0ecN9OGrYqN6F1bxmgzSnsjiPCc=;
 b=k5/w8eLMHJPKtoK3zS2I+iuRCBjFiocqRaWzvlJvGiuBNGukkarsski+wEhskNd1kw+l
 CMhW9X7nJq5gGEyoaOUugd3GX/RlYvbMSVsrDe44MUPkbtnwXtcKcwQ5aeyIfEnyQ+8d
 y+UQAflqjWZvAlvtaFoGyQc8TrLO4B41RJmoZOO9dLRa0TLvgLXvWrukonwJiK8wuY2z
 HqvT2TYB275gRtAFoeCYYSHErfgpTl+nXsu6N8MZznclOyvUcYS/LNYSeY/bYTIxeW6i
 0gdZfukGxDuEBJVbht8JRhw/WD1DAtub/R6Zo4AiWfFOveh1AMH62rlkXuZlHKo2mBx5 XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d0muy0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 18:40:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371Iekks005047
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Aug 2023 18:40:46 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 11:40:46 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <npiggin@gmail.com>
CC: <alex.bennee@linaro.org>, <fbarrat@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-stable@nongnu.org>, <quic_mathbern@quicinc.com>, <bcain@quicinc.com>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
Date: Tue, 1 Aug 2023 15:40:36 -0300
Message-ID: <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
References: <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: rWRd8uF741kEsQsFJLr01Z8ZWB1Nx0xM
X-Proofpoint-ORIG-GUID: rWRd8uF741kEsQsFJLr01Z8ZWB1Nx0xM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=848 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010167
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

Hi, Nick.

> Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > > index 6911b73c07..ce8b42eb15 100644
> > > --- a/gdbstub/gdbstub.c
> > > +++ b/gdbstub/gdbstub.c
> > > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
> > >              return;
> > >      }
> > >      if (runstate_is_running()) {
> > > -        /* when the CPU is running, we cannot do anything except stop
> > > -           it when receiving a char */
> > > +        /*
> > > +         * When the CPU is running, we cannot do anything except stop
> > > +         * it when receiving a char. This is expected on a Ctrl-C in the
> > > +         * gdb client. Because we are in all-stop mode, gdb sends a
> > > +         * 0x03 byte which is not a usual packet, so we handle it specially
> > > +         * here, but it does expect a stop reply.
> > > +         */
> > > +        if (ch != 0x03) {
> > > +            warn_report("gdbstub: client sent packet while target running\n");
> > > +        }
> > > +        gdbserver_state.allow_stop_reply = true;
> > >          vm_stop(RUN_STATE_PAUSED);
> > >      } else
> > >  #endif
> >
> > Makes sense to me, but shouldn't we send the stop-reply packet only for
> > Ctrl+C/0x03?
> 
> Good question.
> 
> I think if we get a character here that's not a 3, we're already in
> trouble, and we eat it so even worse. Since we only send a stop packet
> back when the vm stops, then if we don't send one now we might never
> send it. At least if we send one then the client might have some chance
> to get back to a sane state.

I just noticed now (as I was integrating the latest upstream patches
with our downstream qemu-system-hexagon) that this causes the
gdbstub-untimely-packet tcg test to fail.

My first thought was that, if 0x3 is the only valid case where we will
read a char when the cpu is running, perhaps not issuing the stop-reply
isn't that bad as GDB would ignore it anyways. E.g. from a `set debug
remote 1` output:

  Sending packet: $qSupported:multiprocess+;swbreak+;hwbreak+;qRelocInsn+;
                   fork-events+;vfork-events+;exec-events+;vContSupported+;
		   QThreadEvents+;no-resumed+;
		   xmlRegisters=i386#6a...
  Packet instead of Ack, ignoring it

So, perhaps, we could do:

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f123b40ce7..8af066301a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2055,8 +2055,9 @@ void gdb_read_byte(uint8_t ch)
          */
         if (ch != 0x03) {
             warn_report("gdbstub: client sent packet while target running\n");
+        } else {
+            gdbserver_state.allow_stop_reply = true;
         }
-        gdbserver_state.allow_stop_reply = true;
         vm_stop(RUN_STATE_PAUSED);
     } else
 #endif
-- >8 --

Alternatively, since GDB ignores the packet anyways, should we just let
this be and refactor/remove the test?

