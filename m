Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF6736430
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:14:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBVYh-0001w3-C5; Tue, 20 Jun 2023 03:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qBVYM-0001q4-Cy; Tue, 20 Jun 2023 03:13:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qBVYI-0004n1-Ne; Tue, 20 Jun 2023 03:13:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35K77wvf015446; Tue, 20 Jun 2023 07:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S0MHy0zQd+uoHhikSYkWwxXlHmjnAem1dnJeYF9W078=;
 b=FRrhUy0jwCjEgj3K27eqpMyV6zwcWA/cp698DUbR3og4TmdSiGpq+f3FnKXwT/h50tIz
 TOgQrOiFK3OumOQOPFBsuuFAPb7tXGUPf28gxP8fSXkNs+GMEbSxZhNYosiDcc4zsYG1
 /o0iL7dtUkYMuZl0e3Z4GQwT2T1PaQXeZQ8EUzUvYYF4+x2JXf5KS7GIs47j9pF1mdwX
 8nCwAkNT7nYUmB37slXBqUYs5TsM64tycuKrA76S1TQr62n0i5ON8HpZlcADlpelry9x
 eMKRytvTWp7WSfa3tcSn29Z92nZvOwD8GQXJAfC56i91jZ8jLr2N8HNEGF9vZPfYErSw NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb755rtca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 07:13:16 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35K78LQG019733;
 Tue, 20 Jun 2023 07:12:40 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb755rsnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 07:12:40 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35K40FMp031759;
 Tue, 20 Jun 2023 07:11:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e1egd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 07:11:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35K7Bo3g9634556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 07:11:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 805D920040;
 Tue, 20 Jun 2023 07:11:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 388AA2004B;
 Tue, 20 Jun 2023 07:11:50 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jun 2023 07:11:50 +0000 (GMT)
Message-ID: <3775436e-70ed-a9e2-92a1-95bdfcf52a26@linux.ibm.com>
Date: Tue, 20 Jun 2023 09:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 3/9] MAINTAINERS: Add reviewer for XIVE
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-4-clg@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230620055911.187065-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fhR1I_LNfRzkBk8HkAD87UfBeNjtqSO-
X-Proofpoint-ORIG-GUID: OHpBasW8TerAviYFSJHsSaCVwhhya9pD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 20/06/2023 07:59, Cédric Le Goater wrote:
> Fred discusses frequently with the IBM HW designers, he is fluent in
> XIVE logic, add him as a reviewer.
> 
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90fb83c4cb58..2e8c715eaca4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2445,6 +2445,7 @@ T: git https://github.com/philmd/qemu.git fw_cfg-next
>   
>   XIVE
>   M: Cédric Le Goater <clg@kaod.org>
> +R: Frédéric Barrat <fbarrat@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/*xive*

