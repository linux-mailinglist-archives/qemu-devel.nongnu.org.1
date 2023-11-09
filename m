Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A07E6A88
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1462-0002JO-5n; Thu, 09 Nov 2023 07:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1r145x-0002HG-Um; Thu, 09 Nov 2023 07:25:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1r145s-0007iI-9q; Thu, 09 Nov 2023 07:25:11 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9Bsk52018195; Thu, 9 Nov 2023 12:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=UNCsdKw++zkCEueL9PrcNSNSQ83rLpGUXfwMuFbXR7U=;
 b=q6zkLyT38T/hTZzvv90RnAcpMzDxk6lGZmLp0Q1aQZ/DxlwqFLOnrlvwKz95v+SukZ2x
 4vb24kjtJYoQYjkhryqnKPJmchzSqWrvVEDwdwqnudkFjv73jFGGvSzjER7Z3CcM9lND
 I2iEW9MMVkFJ94RKDJ+/GHK6rrNsU5jOc7LHpcwEDs655tqDcIPLuPjc5XE1jOL/a6US
 eo7s63tM+sRJ526WOvBfEt2AmRBjocqZ0cgKbE4KBmhehW/yzswGP0WNwuNm2c2uJcin
 Ll9a4Vrn286QXULHDpXGF3p7iDElvhnNIv6c+0ArOHnbf8D1NDJ63b3NzFNDZXBZArLN iA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xyd0ytk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:25:05 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9BuekU024697;
 Thu, 9 Nov 2023 12:25:04 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xyd0yt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:25:04 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9BAch6003424; Thu, 9 Nov 2023 12:25:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w223n40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:25:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9CP2sa5767730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 12:25:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1068820040;
 Thu,  9 Nov 2023 12:25:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC0A92004B;
 Thu,  9 Nov 2023 12:25:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 12:25:01 +0000 (GMT)
Date: Thu, 9 Nov 2023 13:24:28 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, 
 thuth@redhat.com
Subject: Re: [PATCH v2 3/3] target/s390x/arch_dump: Add arch cleanup
 function for PV dumps
Message-ID: <20231109132428.296fa163@p-imbrenda>
In-Reply-To: <20231109120443.185979-4-frankja@linux.ibm.com>
References: <20231109120443.185979-1-frankja@linux.ibm.com>
 <20231109120443.185979-4-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vo5Ii_LVIF0of62SBeHL8A45i-WtuCtL
X-Proofpoint-ORIG-GUID: dEbgBMab0wem7GmHPW2UQHRF0o2Qq_eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311090092
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Thu,  9 Nov 2023 12:04:43 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> PV dumps block vcpu runs until dump end is reached. If there's an
> error between PV dump init and PV dump end the vm will never be able
> to run again. One example of such an error is insufficient disk space
> for the dump file.
> 
> Let's add a cleanup function that tries to do a dump end. The dump
> completion data is discarded but there's no point in writing it to a
> file anyway if there's a possibility that other PV dump data is
> missing.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  target/s390x/arch_dump.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
> index bdb0bfa0e7..7e8a1b4fc0 100644
> --- a/target/s390x/arch_dump.c
> +++ b/target/s390x/arch_dump.c
> @@ -433,6 +433,22 @@ static int arch_sections_write(DumpState *s, uint8_t *buff)
>      return 0;
>  }
>  
> +static void arch_cleanup(DumpState *s)
> +{
> +    g_autofree uint8_t *buff = NULL;
> +    int rc;
> +
> +    if (!pv_dump_initialized) {
> +        return;
> +    }
> +
> +    buff = g_malloc(kvm_s390_pv_dmp_get_size_completion_data());
> +    rc = kvm_s390_dump_completion_data(buff);
> +    if (!rc) {
> +            pv_dump_initialized = false;
> +    }
> +}
> +
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const struct GuestPhysBlockList *guest_phys_blocks)
>  {
> @@ -448,6 +464,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>          info->arch_sections_add_fn = *arch_sections_add;
>          info->arch_sections_write_hdr_fn = *arch_sections_write_hdr;
>          info->arch_sections_write_fn = *arch_sections_write;
> +        info->arch_cleanup_fn = *arch_cleanup;
>      }
>      return 0;
>  }


