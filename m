Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B7749A8A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHN4d-0000jf-Jk; Thu, 06 Jul 2023 07:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qHN4M-0000jF-NQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:22:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qHN4K-00030u-HE
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:22:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 366Av8gx023968; Thu, 6 Jul 2023 11:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=R3IcTeyJMfr35xfkZ7xP7rB3UjE7S13CWV2OtliNp6E=;
 b=ngZ7ruk6Tg2EbZn9qlcdmXAft1pe0PWab4bgrVqth2GlFaMMzayEcrfDbpYktSfEn94f
 YRu3yU3ah12saIUCQbJJ3e2oDLB5j5UL8HSBS/zOl7Ht7Yick2WMa6H2TmYHKhv8oHFy
 aj3ruojcUok05ZN+mePCcEE4b1dohzpbfG/MSyOHE0TLTUI+A3WcHPpCYPxhpyiHr86A
 sM+R0ARRrL6f13fCsYrwUWF5yQZoXSEmU3Gpyno6v42lnkVJOQaDj+0lcSW3IYxl+Cvj
 ZzUcy7o/QU+FkTZJT0YeGm34goG/AKMJXsBqt2wkXiwkl6eejv6C8aDKc1TbflOKKO1l nA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnvaa81hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jul 2023 11:22:37 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 366BMamW018669; 
 Thu, 6 Jul 2023 11:22:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3rnpkvuyxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jul 2023 11:22:36 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 366BMawO018664;
 Thu, 6 Jul 2023 11:22:36 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 366BMaRk018663
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jul 2023 11:22:36 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id 0C7AE7982; Thu,  6 Jul 2023 08:22:36 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: ltaylorsimpson@gmail.com
Cc: bcain@quicinc.com, qemu-devel@nongnu.org, quic_mathbern@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
Date: Thu,  6 Jul 2023 08:22:34 -0300
Message-Id: <20230706112234.3267878-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <00a701d9af8e$7de644c0$79b2ce40$@gmail.com>
References: <00a701d9af8e$7de644c0$79b2ce40$@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: kE5NmhCUmfPtxNiGh-laadmxMAhdAdVg
X-Proofpoint-ORIG-GUID: kE5NmhCUmfPtxNiGh-laadmxMAhdAdVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=653 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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


> ltaylorsimpson@gmail.com wrote:
>
> > -----Original Message-----
> > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > Sent: Wednesday, July 5, 2023 12:35 PM
> > To: qemu-devel@nongnu.org
> > Cc: quic_mathbern@quicinc.com; bcain@quicinc.com;
> > ltaylorsimpson@gmail.com; quic_mliebel@quicinc.com;
> > richard.henderson@linaro.org
> > Subject: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
> >
> > diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
> > 5451b061ee..e44a932434 100644
> > --- a/target/hexagon/macros.h
> > +++ b/target/hexagon/macros.h
> > @@ -173,15 +173,6 @@
> >  #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
> > -    DST = (size##SIZE##SIGN##_t)MEM_LOAD##SIZE##SIGN(EA)
> > +    DST =  (size##SIZE##SIGN##_t)({ \
> > +        check_noshuf(env, pkt_has_store_s1, slot, EA, SIZE, GETPC()); \
> > +        MEM_LOAD##SIZE(env, EA, GETPC()); \
> > +    })
> >  #endif
> 
> This should be formatted as
> #define fLOAD(...) \
>     do { \
>         check_noshuf(...); \
>         DST = ...; \
>     } while (0)

Ah, indeed, thanks!

> > a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h index
> > 8f3764d15e..7744e819ef 100644
> > --- a/target/hexagon/op_helper.h
> > +++ b/target/hexagon/op_helper.h
> > +void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
> > +                  uint32_t slot, target_ulong vaddr, int size,
> > +uintptr_t ra);
> 
> Are you sure this needs to be non-static?

Yeah, since we remove the mem_load*() functions, check_noshuf() must
now be visible to the other compilation units that include macros.h,
as we will expand the fLOAD() macro to call it.

