Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B117D9AA7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwNNg-0001oQ-Oh; Fri, 27 Oct 2023 10:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qwNNP-0001ns-Oc
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:59:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qwNNN-00057D-Am
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:59:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39RCCXfP025571; Fri, 27 Oct 2023 13:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=aB7ORh98B+L9sy0/EKb/+ZilnQQYMepyyPK00H/HT8g=;
 b=PuzzK/0oANdzqE7xdLZIISJGDjDDhYhScjk1eLaMwp+1ot5MYrWo66oJ6d6TMR8v1HLM
 xCot2ZjirWx2fmg9xoQgoAdreGWcm6aMQxlY/JfTFCUhJszXAEGnwyedpCkojVnF7tXy
 JRpw4NmNoia7RKHLh1PPlOpoJCLRHr5M9lzB18qacwHTIcBWBFUcrO8DzsOgHl/SOweW
 s9OrWUYSaQXrLhQMgiadxl3enzrV3yHoexlZKwZVWB1Bog5Pf7SRTJP9gWGWpWfx+l/2
 hDnvyBCPJn4OPaAqsPj+RVhbYnYXDb96qhQ7JBQN9X7e55ccj9iZifl1XsyYKx1KCE4I Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tywvta6hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Oct 2023 13:59:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RDxh5B027336
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Oct 2023 13:59:44 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 06:59:43 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, <bcain@quicinc.com>
Subject: --prefix gets lost on config regen for cross Windows build
Date: Fri, 27 Oct 2023 10:59:31 -0300
Message-ID: <e379a2b44886b7d2b974191bf08aaf78a2488595.1698414087.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: cbPfTGqAfQ2LFnWoKf8cPfIvGshYzmoj
X-Proofpoint-ORIG-GUID: cbPfTGqAfQ2LFnWoKf8cPfIvGshYzmoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=600 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270121
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

Hi,

It seems that we lose the install prefix option when regenerating config
for a Windows cross-build. Looks like this behavior appeared with c36dd41ba2
(configure: move target-specific defaults to an external machine file,
2023-10-16), but I couldn't find the specific root cause yet.

To reproduce the issue, first run:

    ../configure --prefix=/tmp/install --without-default-features \
        --cross-prefix=x86_64-w64-mingw32- --target-list=aarch64-softmmu

Which correctly prints:

    Directories
        [...]
        Install prefix: /tmp/install

But then if we run `touch ../meson.build && make`, we get:

    Directories
        [...]
        Install prefix: /qemu

Reverting c36dd41ba2 does fix the issue, but I couldn't yet find what
is causing this among the changes. Or even if it could be a meson bug
itself. I'd appreciate any help.

Thanks,
Matheus

