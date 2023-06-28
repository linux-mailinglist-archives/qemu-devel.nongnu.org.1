Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA017410D3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEU6n-0001Na-Hn; Wed, 28 Jun 2023 08:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qEU6k-0001Mu-Ko; Wed, 28 Jun 2023 08:17:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qEU6g-0007M5-7s; Wed, 28 Jun 2023 08:17:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35SBribA004157; Wed, 28 Jun 2023 12:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=KN3sJv160ghGx9yQaU9vLPh7dkb5f4fJ4uLyAesDelw=;
 b=WZFTkmL/oFN5DoHQ78cF0w84FXDqRcfi/kUnLMtVx0yiJSklVS+f/0JY5dlqN83aRv2X
 D8fHHW95jsVDl515vM0lsdkrRYXjpEvV2kuyxNlVho1j9lBaq+B39wwUeQ7Fj/FppgR9
 yQtsLDzTd46EMzY+tAXmQ/7KzTi7CldfPXYrJvYXv0ZdvL/yb/neI+HjLTl6OHFnwnj7
 1833BSBTqt8CgZ260C9VeuVhZkjkCHXfcNoNtCUJe/opsiRhSUCccguwinCcA0bUzqqb
 QPWYOD7A3gO08CP4gCk4Tce2wzjlLzrL7gwr3HIxHS8r9eNxEH4QgJbq7632s0+eCKMj IQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgaxcs85v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 12:17:03 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35SCH2gS004417; 
 Wed, 28 Jun 2023 12:17:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3rfhuwm402-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 12:17:02 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SCDVqq032690;
 Wed, 28 Jun 2023 12:17:02 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 35SCH1r0004389
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 12:17:02 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id 72DA57539; Wed, 28 Jun 2023 09:17:01 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: peter.maydell@linaro.org
Cc: alex.bennee@linaro.org, npiggin@gmail.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, quic_mathbern@quicinc.com, tsimpson@quicinc.com
Subject: Re: [PATCH] gdbstub: Permit reverse step/break to provide stop
 response
Date: Wed, 28 Jun 2023 09:16:59 -0300
Message-Id: <1697e28b822d3df25c6024089e42c090dfd74bb1.1687954443.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <CAFEAcA-jxGXzkyti3k-P=fOwcmJ+fSa1abKFvNHodYzA+VS+bA@mail.gmail.com>
References: <CAFEAcA-jxGXzkyti3k-P=fOwcmJ+fSa1abKFvNHodYzA+VS+bA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: DQ3MoIQEQSjbj7cwW-5m2ZW-dPhvMOLO
X-Proofpoint-ORIG-GUID: DQ3MoIQEQSjbj7cwW-5m2ZW-dPhvMOLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxlogscore=605 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280108
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> On Fri, 23 Jun 2023 at 13:19, Matheus Tavares Bernardino <quic_mathbern@quicinc.com> wrote:
> >
> > Ah, it's interesting that [1] doesn't include 'bc' and 'bs' in the list
> > of cmds that may respond with a stop-reply packet:
> >
> >     "The 'C', 'c', 'S', 's', 'vCont', 'vAttach', 'vRun', 'vStopped', and
> >     '?' packets can receive any of the below as a reply."
> >
> > But their definitions at [2] do say the following:
> >
> >     'bc' (and 'bc')
> >     [...]
> >     Reply: See Stop Reply Packets, for the reply specifications.
> >
> > So I guess the list from [1] is not exhaustive. Anyway, thanks for the
> > fix!
> 
> That looks like it's probably a gdb docs bug (forgetting to
> update that list when the bc/bs packets were added); we
> should probably report that to upstream gdb.

Good idea, done: https://sourceware.org/pipermail/gdb/2023-June/050804.html

