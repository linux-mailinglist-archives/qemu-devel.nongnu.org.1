Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A374790E
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 22:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGmiy-0000sL-FX; Tue, 04 Jul 2023 16:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qGmiw-0000s2-4i
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 16:34:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1qGmiu-0004Gz-C9
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 16:34:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 364KUbVP027237; Tue, 4 Jul 2023 20:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=/x7IqhENgBsKuDxwwaDVTOSeEHAtfrZd78JbuOzuFMs=;
 b=jGKUJalaJ0r4uCtoYo5jGze7lUIcMEoXTp6PZQTK9s2gRBFLyeTNhVTIB1ViqxrpRUtC
 k7y4OPboN98AyDcqHMs1BvsywpaBGL1RH9Qh7ZF7rtjSHnr9vjVgSGaQHFeT0na1++C+
 bGOdvN9CYzlecxr064qU5RMhmsSuuXWvvwOq/4nS68uq5rCvHn5sniZVZZNSfR6iJ0S8
 acBn4YKse+29uEddeyGW9OZRaeuLpx0Gn+fGRSDBveK55QBjyUSGEXR//DVwdFNHDerl
 2vjnVSPahIddSh+rK/+IuQga3Xmq2mdXiFGBDPxZ3YyvV8ogE1uN4d4/vAx3QMACPQp5 MA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm0063c0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 20:34:05 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 364KURie026911; 
 Tue, 4 Jul 2023 20:34:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3rjd7mvjq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 20:34:04 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364KURBn026905;
 Tue, 4 Jul 2023 20:34:04 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 364KY4xj030507
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 20:34:04 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id 1B9FB77EC; Tue,  4 Jul 2023 17:34:04 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: quic_mathbern@quicinc.com
Cc: bcain@quicinc.com, ltaylorsimpson@gmail.com, qemu-devel@nongnu.org,
 quic_mliebel@quicinc.com
Subject: Re: [PATCH] Hexagon: move GETPC() calls to top level helpers
Date: Tue,  4 Jul 2023 17:34:02 -0300
Message-Id: <9c645447573f3232a0b8309f24a05a968f26ea0e.1688502294.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com>
References: <d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 0U8q8GfqAzRM1I6fdrycS6H-z2eqwNs4
X-Proofpoint-GUID: 0U8q8GfqAzRM1I6fdrycS6H-z2eqwNs4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_14,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=648 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040179
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

> Matheus Tavares Bernardino <quic_mathbern@quicinc.com> wrote:
>
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 5451b061ee..efb8013912 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -173,14 +173,20 @@
>  #define MEM_STORE8(VA, DATA, SLOT) \
>      MEM_STORE8_FUNC(DATA)(cpu_env, VA, DATA, SLOT)
>  #else
> -#define MEM_LOAD1s(VA) ((int8_t)mem_load1(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD1u(VA) ((uint8_t)mem_load1(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD2s(VA) ((int16_t)mem_load2(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD2u(VA) ((uint16_t)mem_load2(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD4s(VA) ((int32_t)mem_load4(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD4u(VA) ((uint32_t)mem_load4(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD8s(VA) ((int64_t)mem_load8(env, pkt_has_store_s1, slot, VA))
> -#define MEM_LOAD8u(VA) ((uint64_t)mem_load8(env, pkt_has_store_s1, slot, VA))
> +
> +#define MEM_LOADn(SIZE, VA) ({ \
> +    check_noshuf(env, pkt_has_store_s1, slot, VA, SIZE); \
> +    cpu_ldub_data_ra(env, VA, GETPC()); \
> +})
> +
> +#define MEM_LOAD1s(VA) ((int8_t)MEM_LOADn(1, VA))
> +#define MEM_LOAD1u(VA) ((uint8_t)MEM_LOADn(1, VA))
> +#define MEM_LOAD2s(VA) ((int16_t)MEM_LOADn(2, VA))
> +#define MEM_LOAD2u(VA) ((uint16_t)MEM_LOADn(2, VA))
> +#define MEM_LOAD4s(VA) ((int32_t)MEM_LOADn(4, VA))
> +#define MEM_LOAD4u(VA) ((uint32_t)MEM_LOADn(4, VA))
> +#define MEM_LOAD8s(VA) ((int64_t)MEM_LOADn(8, VA))
> +#define MEM_LOAD8u(VA) ((uint64_t)MEM_LOADn(8, VA))

Oops, an oversight from my side: this simplification is not correct
since the mem_load*() functions all call different variants of
cpu_ld*_data_ra(). I'll send a v2 correcting that.

