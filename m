Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B3C76C9B0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 11:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR8O7-0008BH-Rt; Wed, 02 Aug 2023 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qR8O5-0008B1-FS
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:43:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qR8O4-0007uh-1a
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:43:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3727Fmwv019851; Wed, 2 Aug 2023 09:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : to : from : subject : cc : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=JfdiiyqDi8h4Z12+vlHTZLCKuvTHxkW2ebz4y/rxSYU=;
 b=CXaAARaihbG0hCaY8MYMZp+fT6jYYt92yhh369ax40CXEjtXm/E+uvpmsZNfsNcSdwac
 LncY3AgGM3C2fMRfkkv/Ba4Vk0JzzgN1F6belL/v8F7f4owBNCrpnHh6HaKwCk2m+Ndi
 muZg24DVPwhLY/iCejsyJ0HXJmfchpSQsq0FeZLTwe+RWcuyFSjO1kkxHquqyY76OnSX
 sgJPf8PXC5DdOIukV+zddxgg+OIsiuu//xu/AmlsWbj4iswBuqhOqiodcX0XZnXTcA5/
 mvHvBSe4UI+LnwSfb3wCzapKFT/gSkXSbP6S1rZyJmg/3Ei9v+jCHffjFtML/b9dsJ1Y zA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bp6995d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Aug 2023 09:43:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3729hFVQ024419
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 2 Aug 2023 09:43:15 GMT
Received: from [10.111.142.62] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 02:43:14 -0700
Message-ID: <0c8d712b-a890-26fb-cdee-88e686243ae7@quicinc.com>
Date: Wed, 2 Aug 2023 11:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <qemu-devel@nongnu.org>, <graf@amazon.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
Subject: hvf: Invalid ISV on data abort
CC: Mark Burton <quic_mburton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Z7ze1kFCVVOGcMt0AMWxFnapUgSd6e45
X-Proofpoint-ORIG-GUID: Z7ze1kFCVVOGcMt0AMWxFnapUgSd6e45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=301 bulkscore=0 suspectscore=0 clxscore=1011 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
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

Hi there,

I am trying to bring up a guest on HVF, which at a certain point is 
trying to write to an area of mmio space and it triggers a data abort 
where ISV=0 (translation fault level 2).

I wonder what could cause it and how to recover.

Kind regards,
Antonio

