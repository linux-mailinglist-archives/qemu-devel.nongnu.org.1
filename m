Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14228746B12
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:50:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaml-0005qw-KH; Tue, 04 Jul 2023 03:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1qGamd-0005dH-JX; Tue, 04 Jul 2023 03:49:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1qGamb-0004vJ-Dj; Tue, 04 Jul 2023 03:49:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3647W7LU016563; Tue, 4 Jul 2023 07:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=YZ/nG/jYb/Pk6gy5HrsmEHSZTPjOSV0vmJxuqy6j++0=;
 b=IqW65t0/PE1PzxoBUHJWO94wZig+vtnuI0IIeiaJD8wFa2YWBqrhy12Bl8ju2EUvuSAz
 V0iE8jAFwwALEKdihKy0JBDnYU9EfKnvp7km6MoSC36eZzS1AS0d0tenTQr+xIDl3CpY
 /Xs4qKSHe6EttsOgdI/5izHt03r5Sfz6oGhSjimhWip0Hs22394qZLWwc7Dsb+WHHKJB
 4x6Y8+JEpQjaZzKoKf0fAYh9g4AinqJMaDZ/e3pk/IeRUf9DIhh6iOFAQwNdfeCetkBj
 bMlesBqPurz50s5xqX8tF16XGOiLIHU2uxGOz/psN/pzjeVOeccu1fIICfQwyGs18IGe Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmf4c8dhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:48:54 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3647drp8012507;
 Tue, 4 Jul 2023 07:48:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmf4c8dgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:48:53 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3642UMdQ032581;
 Tue, 4 Jul 2023 07:48:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sw91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:48:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3647mm3l58851630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 07:48:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7B8E20040;
 Tue,  4 Jul 2023 07:48:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11E802004B;
 Tue,  4 Jul 2023 07:48:45 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.179.9.155])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue,  4 Jul 2023 07:48:44 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Tue, 04 Jul 2023 13:18:44 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, danielhb413@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 npiggin@linux.ibm.com, harshpb@linux.ibm.com, sbhat@linux.ibm.com,
 nnmlinux@linux.ibm.com
Subject: Re: [PATCH v4] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
In-Reply-To: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
References: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
Date: Tue, 04 Jul 2023 13:18:44 +0530
Message-ID: <87y1jwxgkj.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BCQ6Gi6nXW-XKprEly2CZpASYX-E_uMq
X-Proofpoint-GUID: FY4Guk3LOWs1QRw6PBufVWmlslzl6uHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 mlxlogscore=892 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vaibhav@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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


Thanks for fixing this Narayana,

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> Currently on PPC64 qemu always dumps the guest memory in
> Big Endian (BE) format even though the guest running in Little Endian
> (LE) mode. So crash tool fails to load the dump as illustrated below:
>
> Log :
> $ virsh dump DOMAIN --memory-only dump.file
>
> Domain 'DOMAIN' dumped to dump.file
>
> $ crash vmlinux dump.file
>
> <snip>
> crash 8.0.2-1.el9
>
> WARNING: endian mismatch:
>           crash utility: little-endian
>           dump.file: big-endian
>
> WARNING: machine type mismatch:
>           crash utility: PPC64
>           dump.file: (unknown)
>
> crash: dump.file: not a supported file format
> <snip>
>
> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
> always set for powerNV even though the guest is not running in hv mode.
> The hv mode should be taken from msr_mask MSR_HVB bit
> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
> the guest endianness.
>
> The crash tool also expects guest kernel endianness should match the
> endianness of the dump.
>
> The patch was tested on POWER9 box booted with Linux as host in
> following cases:
>
> Host-Endianess Qemu-Target-Machine                Qemu-Generated-Guest
>                                                   Memory-Dump-Format
> BE             powernv(OPAL/PowerNV)                   LE
> BE             powernv(OPAL/PowerNV)                   BE
> LE             powernv(OPAL/PowerNV)                   LE
> LE             powernv(OPAL/PowerNV)                   BE
> LE             pseries(OPAL/PowerNV/pSeries) KVMHV     LE
> LE             pseries TCG                             LE
>
> Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory
> dumps")
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

Reviewed-by: Vaibhav Jain<vaibhav@linux.ibm.com>

-- 
Cheers
~ Vaibhav

