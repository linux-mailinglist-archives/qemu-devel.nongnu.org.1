Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468974845C
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:46:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1t1-0002ef-Ed; Wed, 05 Jul 2023 08:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qH1sz-0002eU-5U
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:45:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qH1sx-0006NC-1T
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:45:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365CNsNq014854; Wed, 5 Jul 2023 12:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=MyNMlbMYqLV6BYOl92Ns8JiVU8upJxtZGUj4Du3zTRs=;
 b=QjbB4GvefTdpUAfEb/9t/sBOyQcP2qwbSNXQ24ucnpOUS8nL5D17AzId581P56ncgMgU
 1qDv2zXAlzBh9Guzon74y75heZYgF9nTaeR7eqwXvN0YYiCOsXtP6MepJgA2C9GSw2mR
 LU60e17or7NIOcI1g7QiQh6q6aGMZqLy+2TT1mMSAdo38gRSFTiSxko6q7Morsuj6/v8
 Gt/izOR391GVefhqdAshXEeSIQ0t/g7wDvBOmq92fcbt17W3mt8bIb/caHxuTez9H1XW
 LBhnIayPEo/ExmK9CT1nbAVe/BrQ2wbwx+Dh9KXQKNlcZknxRoaEKYIqtADCB/KO5MRK jQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5mfrj7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 12:45:25 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 365Cf7MG025401; 
 Wed, 5 Jul 2023 12:45:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7n4494-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 12:45:24 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365CjOEC030745;
 Wed, 5 Jul 2023 12:45:24 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 365CjO8a030740
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 12:45:24 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id 1B4827808; Wed,  5 Jul 2023 09:45:24 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: ltaylorsimpson@gmail.com
Cc: bcain@quicinc.com, qemu-devel@nongnu.org, quic_mathbern@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org,
 e.emanuelegiuseppe@gmail.com
Subject: Re: [PATCH] Hexagon: move GETPC() calls to top level helpers
Date: Wed,  5 Jul 2023 09:45:20 -0300
Message-Id: <20230705124520.2693489-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <000001d9aec2$fa0154e0$ee03fea0$@gmail.com>
References: <000001d9aec2$fa0154e0$ee03fea0$@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: sLkuK-21CUcOoqdFksvimP9s58_ASTUK
X-Proofpoint-ORIG-GUID: sLkuK-21CUcOoqdFksvimP9s58_ASTUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_04,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=877 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050113
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> Taylor <ltaylorsimpson@gmail.com> wrote:
>
> > Matheus Tavares Bernardino <quic_mathbern@quicinc.com> wrote:
> >
> > diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
> > 5451b061ee..efb8013912 100644
> > --- a/target/hexagon/macros.h
> > +++ b/target/hexagon/macros.h
> > +
> > +#define MEM_LOADn(SIZE, VA) ({ \
> > +    check_noshuf(env, pkt_has_store_s1, slot, VA, SIZE); \
> > +    cpu_ldub_data_ra(env, VA, GETPC()); \
> > +})
> 
> Note that check_noshuf calls HELPER(probe_noshuf_load) and
> HELPER(commit_store).  Both of those call GETPC() from within.  So, you'll
> need to pull the contents into separate functions that take ra as an
> argument.

Ah, good point. It was my understanding that, in case of a memory
exception in one of those nested helper calls, the GETPC() we would want
to use for unwinding was the one from the most recent helper. I'm still
trying to wrap my head around these concepts, though, so I might have
misunderstood it. Is this not the case?

> Does this pass the test suite?  You are only using the SIZE parameter in
> check_noshuf, but cpu_ldub_data_ra only reads a single byte.

My oversight, this has to be fixed, thanks.

