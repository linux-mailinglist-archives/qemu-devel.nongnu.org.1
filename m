Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A37E7C32
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 13:36:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1QNo-0003Kf-Hg; Fri, 10 Nov 2023 07:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1r1QNk-0003KA-9C
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 07:13:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1r1QNf-0000bI-AX
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 07:13:04 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAA6xxx008454; Fri, 10 Nov 2023 12:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Wok5H2mfpVN9JX67K+yEafRFnFO4S/k+LL+beWWytRw=;
 b=iUUHfO3scHfS+hTKz3bqO8RmyHBiHxr10x/clR2pdeWuWgKxt3xEIEeYlVb5BGvBaXmC
 1dV4sdbLnuv8g4UINIqTswfhLtJxhNjPYfVhD/TAqr5WM0BuN3pRhIzWRnYaZEC3qJ6D
 RaDw8xDCs04mqj5UqR6N9JDut3vEr7zBz309vC2lRw7Cg/U8cRs+RG6tVN5J9V25d5Vc
 u6zE/+gU8fpvAx5nHlmjnUouY12fik9GqqXLZor/a6ESdeoRAdZS4XJ3RpYSS1iLVb+5
 4QqmMMunLjnMs0Bzx10LbrA4fXkLjDsqLjMpFR2bfQs4BVatFzcxyenz3OEHmvDY8ub/ UQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9f3k0ssr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 12:12:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AACCq7Z026131
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 12:12:52 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 04:12:52 -0800
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <ltaylorsimpson@gmail.com>
CC: <ale@rev.ng>, <anjo@rev.ng>, <bcain@quicinc.com>, <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <quic_mathbern@quicinc.com>,
 <richard.henderson@linaro.org>, <sidneym@quicinc.com>
Subject: Re: [RFC PATCH] Hexagon (target/hexagon) Make generators object
 oriented
Date: Fri, 10 Nov 2023 09:12:42 -0300
Message-ID: <ee22b1aa814dd18733bf11ecd1be473c1d379522.1699618162.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231109212549.356168-1-ltaylorsimpson@gmail.com>
References: <20231109212549.356168-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: kBUnEyKt62Y_HCLLTzJre4PzDIy6s1Tf
X-Proofpoint-GUID: kBUnEyKt62Y_HCLLTzJre4PzDIy6s1Tf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=14
 lowpriorityscore=0
 spamscore=14 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=14
 priorityscore=1501 phishscore=0 clxscore=1011 mlxlogscore=78
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100100
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Taylor Simpson <ltaylorsimpson@gmail.com> wrote:
>
> RFC - This patch handles gen_tcg_funcs.py.  I'd like to get comments
> on the general approach before working on the other Python scripts.
> 
> The generators are generally a bunch of Python if-then-else
> statements based on the regtype and regid.  Encapsulate regtype/regid
> into a class hierarchy.  Clients lookup the register and invoke
> methods.
> 
> This has several advantages for making the code easier to read,
> understand, and maintain
> - The class name makes it more clear what the operand does
> - All the methods for a given type of operand are together
> - Don't need as many calls to hex_common.bad_register
> - We can remove the functions in hex_common that use regtype/regid
>   (e.g., is_read)
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>

Really nice! I personally think it's a great separation and it improves
the code readability.

