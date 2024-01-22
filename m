Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBDE83758C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:40:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS20Q-0008BY-Et; Mon, 22 Jan 2024 16:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rS20O-0008BG-Co; Mon, 22 Jan 2024 16:38:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rS20M-0006cL-MB; Mon, 22 Jan 2024 16:38:56 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MLHESa025242; Mon, 22 Jan 2024 21:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=6f5rEqJGkawSR9gyWKH3B9MU5YHoXAqaIsLZQMdNxoE=;
 b=V9vPL4hmhR8mxu9q8dV6/8aJrbBcGuU5oTOSb+qLxzPs8tIUYEmjr2AB7kHP9xccSULS
 W5H3PtVPCVXPpb/USHplHlPwJGTuOBSCWxBKJymatJ7uBLFVfV5kt7hKhTNA1llp+S8/
 ctgn8IzLpZ4jJdsx1HW/4G1sLuQIYuOgHKAhlvKiczWKAhHnyEYxCXaPfrTvztnRNrTp
 wRvpsa1CxG09AYi670lzO6z9pX8zQVskv8CAnMIbF9s6WeZgbzDWr+m0Go7u4kG94Ir7
 0Gi3mR4hDFvOH9CgLSOcewMieTSuWSOjUelNoE229BZW4xOwr5Cmgj1D4IQ1Ur0jRtVF cA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsy4f1ve9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:38:51 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MLHLJ8025522;
 Mon, 22 Jan 2024 21:38:50 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsy4f1vdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:38:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MKnDJ8028287; Mon, 22 Jan 2024 21:38:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72asbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:38:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MLcmP160096974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:38:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D6CB20049;
 Mon, 22 Jan 2024 21:38:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D191220040;
 Mon, 22 Jan 2024 21:38:47 +0000 (GMT)
Received: from heavy (unknown [9.171.83.169])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Jan 2024 21:38:47 +0000 (GMT)
Date: Mon, 22 Jan 2024 22:38:46 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 15/38 6/6] target/s390x: Improve general case of
 disas_jcc
Message-ID: <grg5xrqkzomr4aqoc2vlmzwkfgeasw7caxxyqo3lhehvodztei@igmdmyoa7vgu>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
 <20240119232302.50393-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119232302.50393-6-philmd@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r_g_4FDKpWhXkKRdB5rbONxLjZirsYmz
X-Proofpoint-ORIG-GUID: 0_fZmHSlfBD5nbLIZA2_d2qRYpjsWkGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=494 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Jan 20, 2024 at 12:23:02AM +0100, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Avoid code duplication by handling 7 of the 14 cases
> by inverting the test for the other 7 cases.
> 
> Use TCG_COND_TSTNE for cc in {1,3}.
> Use (cc - 1) <= 1 for cc in {1,2}.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/s390x/tcg/translate.c | 52 +++++++++++-------------------------
>  1 file changed, 15 insertions(+), 37 deletions(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

