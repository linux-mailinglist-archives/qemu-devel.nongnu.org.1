Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99A941608
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jul 2024 17:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpC1-0001An-LC; Tue, 30 Jul 2024 11:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sYpBz-0001A8-7D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:55:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sYpBx-00079i-9I
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:55:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8uu8h023996;
 Tue, 30 Jul 2024 15:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 id3DzjrUnS+dz0DP/Y8RUJHN+IB9xf9uuXbDQXF8BHo=; b=dcBI+YiDYP6OiiMd
 twG4P85wT0Ogwv9CGhLOzEbsSC0l32Kawb+RLQl6UzieFRra+Bf2OZf0rgSa53hw
 0XgyWrzoDFTF1leeudg8BeJVLkTC/pqGVJDSry3t1M2tfaKFwkExXM/NS3wJIkva
 7q1djsfnWXyxJGG5G16NHo9gfspmGayFVWLDoMEXJu3wLW0yZSeVvlowEaeUPDBj
 q2QTiWP299KQ8g8tx8+tKlF5FAGzHgV2Zu0uplsN4QUV9OerX70LLZMVjzOLLrUa
 zJb9VfSZ2FT1+bcB2/WHvsMA4VqeHsjPT7LZ833Xy1MFksaSi7ggUEFtl977EqFH
 j/0Ruw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pw451c5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 15:55:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46UFt8qo002262
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 15:55:08 GMT
Received: from [10.110.37.171] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 08:55:07 -0700
Message-ID: <31e44dce-9b35-40c4-9b0e-2554e073bc88@quicinc.com>
Date: Tue, 30 Jul 2024 10:54:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Hexagon: fix F2_conv_* instructions for negative zero
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>, <sidneym@quicinc.com>,
 <ale@rev.ng>, <anjo@rev.ng>
References: <d88fd9a1122503beceea7ee2f466761d51c8a8b9.1722281008.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <d88fd9a1122503beceea7ee2f466761d51c8a8b9.1722281008.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: etowcKP8Gn0LFjDxM7uYQpaSbPhyv806
X-Proofpoint-ORIG-GUID: etowcKP8Gn0LFjDxM7uYQpaSbPhyv806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=702 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407300108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


On 7/29/2024 2:24 PM, Matheus Tavares Bernardino wrote:
> The implementation for these instructions handles -0 as an invalid float
> point value, whereas the Hexagon hardware considers it the same as +0
> (which is valid). Let's fix that and add a regression test.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Brian Cain <bcain@quicinc.com>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
> v2: updated the copyright year


Queued. thanks!


>   target/hexagon/op_helper.c | 18 +++++++++---------
>   tests/tcg/hexagon/usr.c    | 12 +++++++++++-
>   2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index ae5a605513..90e7aaa097 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License as published by
> @@ -683,7 +683,7 @@ uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -713,7 +713,7 @@ uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> @@ -743,7 +743,7 @@ uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -773,7 +773,7 @@ uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> @@ -803,7 +803,7 @@ uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -833,7 +833,7 @@ uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> @@ -863,7 +863,7 @@ uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -893,7 +893,7 @@ uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
> index 92bc86a213..f0b23d312b 100644
> --- a/tests/tcg/hexagon/usr.c
> +++ b/tests/tcg/hexagon/usr.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License as published by
> @@ -1007,6 +1007,11 @@ int main()
>       TEST_P_OP_R(conv_sf2d_chop,   SF_QNaN,  0xffffffffffffffffULL,  USR_FPINVF);
>       TEST_P_OP_R(conv_sf2d_chop,   SF_SNaN,  0xffffffffffffffffULL,  USR_FPINVF);
>   
> +    TEST_R_OP_R(conv_sf2uw,       SF_zero_neg,  0, USR_CLEAR);
> +    TEST_R_OP_R(conv_sf2uw_chop,  SF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_R(conv_sf2ud,       SF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_R(conv_sf2ud_chop,  SF_zero_neg,  0, USR_CLEAR);
> +
>       TEST_R_OP_P(conv_df2sf,       DF_QNaN,  SF_HEX_NaN,             USR_CLEAR);
>       TEST_R_OP_P(conv_df2sf,       DF_SNaN,  SF_HEX_NaN,             USR_FPINVF);
>       TEST_R_OP_P(conv_df2uw,       DF_QNaN,  0xffffffff,             USR_FPINVF);
> @@ -1020,6 +1025,11 @@ int main()
>       TEST_R_OP_P(conv_df2uw_chop,  DF_QNaN,  0xffffffff,             USR_FPINVF);
>       TEST_R_OP_P(conv_df2uw_chop,  DF_SNaN,  0xffffffff,             USR_FPINVF);
>   
> +    TEST_R_OP_P(conv_df2uw,       DF_zero_neg,  0, USR_CLEAR);
> +    TEST_R_OP_P(conv_df2uw_chop,  DF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_P(conv_df2ud,       DF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_P(conv_df2ud_chop,  DF_zero_neg,  0, USR_CLEAR);
> +
>       /* Test for typo in HELPER(conv_df2uw_chop) */
>       TEST_R_OP_P(conv_df2uw_chop, 0xffffff7f00000001ULL, 0xffffffff, USR_FPINVF);
>   

