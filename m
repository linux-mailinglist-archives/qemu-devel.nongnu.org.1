Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CDF76CB80
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 13:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR9k3-0005tE-Ci; Wed, 02 Aug 2023 07:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qR9jz-0005sl-Fj
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 07:10:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qR9jx-0001IM-R0
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 07:10:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3724Y6jW022364; Wed, 2 Aug 2023 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tVQ/YvMKE7mwap4IDtOehc/QFk+rnEPeI5tZgr28MbY=;
 b=VRFU3NMSUC63ANGz4LxMM6ncpdzR1mwp3Wqy7pK0iS1BtP+hgNq3wuZmg+LLIIPOQcch
 9lXr1ovgC38cA6WdobEP+A3XmE5PDIH3ZuRS96FFLGe9fO+2UB+NGT4/pmGfwI5rXnnW
 MC66ZOcSNZyKJC9KqVZBIhmtxwOGZzJZj7RTM3vP9r5zNzlNzbEVuLu1EvIz79HNYDjs
 P6q40xUlUSaXCCCehShHBcRQ879sQmw+UT5/9B40R2fMnZLlMbPICOItpmx0+VyodECh
 oaTAivzgvBK8ytMBU2Fe2ZAB20yU4H9UDblAP49Y/gz4t6iXqBBSSbidMVm3L6YyCuva BA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b326bp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Aug 2023 11:05:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372B51Tp001672
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 2 Aug 2023 11:05:01 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 04:05:01 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <iii@linux.ibm.com>
CC: <alex.bennee@linaro.org>, <bcain@quicinc.com>, <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <quic_mathbern@quicinc.com>
Subject: Re: [PATCH] gdbstub: use 0 ("any process") on packets with no PID
Date: Wed, 2 Aug 2023 08:04:51 -0300
Message-ID: <781bf772bf3575e3fcd8ad26141e7c1d42a6a999.1690974182.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <922a658a278cf241e7ca0f49b2249c7d5a6871b6.camel@linux.ibm.com>
References: <922a658a278cf241e7ca0f49b2249c7d5a6871b6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: RfENxMUiKQBF2bIkWyDGregKAZlTvgW2
X-Proofpoint-ORIG-GUID: RfENxMUiKQBF2bIkWyDGregKAZlTvgW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=841 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020098
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

Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2023-08-01 at 12:37 -0300, Matheus Tavares Bernardino wrote:
> > Previously, qemu-user would always report PID 1 to GDB. This was
> > changed
> > at dc14a7a6e9 (gdbstub: Report the actual qemu-user pid, 2023-06-30),
> > but read_thread_id() still considers GDB packets with "no PID" as
> > "PID
> > 1", which is not the qemu-user PID. Fix that by parsing "no PID" as
> > "0",
> > which the GDB Remote Protocol defines as "any process".
> > 
> > Note that this should have no effect for system emulation as, in this
> > case, gdb_create_default_process() will assign PID 1 for the first
> > process and that is what the gdbstub uses for GDB requests with no
> > PID,
> > or PID 0.
> > 
> > This issue was found with hexagon-lldb, which sends a "Hq" packet
> > with
> > only the thread-id, but no process-id, leading to the invalid usage
> > of
> > "PID 1" by qemu-hexagon and a subsequent "E22" reply.
>
> Did you mean "Hg"?

Oops, that's right, thanks.

