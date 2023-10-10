Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 452187BF9FC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqB7W-0002k3-92; Tue, 10 Oct 2023 07:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qqB7R-0002fX-PQ; Tue, 10 Oct 2023 07:41:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qqB7O-000587-5w; Tue, 10 Oct 2023 07:41:45 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ABXtGl003465; Tue, 10 Oct 2023 11:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=My2MHZAsAgcn0+pIB4SdzWNgsLDVAt57B8DNHBPFmZk=;
 b=cr8RiFrv/JcFFM59tVI0Ro7WM/uxNh27thlziWXOpsqjQnrQw1oHv+WpKvf43m/jMbtA
 cbjIZs0WhULTrx1W2BTJ8TZZnG9hWaMP4GZzlxFWMIgJCknaa6TMlhHkcqjdgBRRxR7q
 Dt2xg3qZsmkpKfTzjulbpU9GYvBPwfJKwwujqZls9Iv9GwUuJJO5wF7sHH6zXwhZHHJR
 ML9MaNcX3aTKQvzLjWfoWXRrKEFEQZUSG8lOF1A5/q4GMMUF2xYnlCbp71Y7IPKlvk+8
 zD9BG668FJxOjXgcTNDwiO9/JxWDeDONrr6pDSDJgZfbr3jpc6FENAn5WetOdY0Qjjta bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn5m30jq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:41:39 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ABfctO021731;
 Tue, 10 Oct 2023 11:41:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn5m30jpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:41:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AA8LKY028239; Tue, 10 Oct 2023 11:41:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1y073a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:41:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39ABfZwA25494036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 11:41:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 344CC2004B;
 Tue, 10 Oct 2023 11:41:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1696E20049;
 Tue, 10 Oct 2023 11:41:35 +0000 (GMT)
Received: from [9.152.224.53] (unknown [9.152.224.53])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Oct 2023 11:41:35 +0000 (GMT)
Message-ID: <d21556f0-c551-cab0-4fc7-fadb7775bc79@linux.ibm.com>
Date: Tue, 10 Oct 2023 13:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] target/s390x/kvm: Simplify the GPRs, ACRs, CRs and
 prefix synchronization code
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
References: <20231009170745.63446-1-thuth@redhat.com>
 <20231009170745.63446-3-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20231009170745.63446-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MawiuFiRgfpNYsPP6BDD0aX7k6T7J7-g
X-Proofpoint-GUID: v8A51ccqSdXyH3e9ogyWPmbXMG5r5oMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_07,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=508 clxscore=1015
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310100085
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



Am 09.10.23 um 19:07 schrieb Thomas Huth:
[...]

> @@ -483,20 +482,14 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>       cs->kvm_run->psw_addr = env->psw.addr;
>       cs->kvm_run->psw_mask = env->psw.mask;
>   
> -    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
> -        for (i = 0; i < 16; i++) {
> -            cs->kvm_run->s.regs.gprs[i] = env->regs[i];
> -            cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> -        }
> -    } else {
> -        for (i = 0; i < 16; i++) {
> -            regs.gprs[i] = env->regs[i];
> -        }
> -        r = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
> -        if (r < 0) {
> -            return r;
> -        }
> -    }
> +    g_assert((cs->kvm_run->kvm_valid_regs & KVM_SYNC_REQUIRED_BITS) ==
> +             KVM_SYNC_REQUIRED_BITS);
> +    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_REQUIRED_BITS;
> +    memcpy(cs->kvm_run->s.regs.gprs, env->regs, sizeof(cs->kvm_run->s.regs.gprs));


> +    memcpy(cs->kvm_run->s.regs.acrs, env->aregs, sizeof(cs->kvm_run->s.regs.acrs));
> +    memcpy(cs->kvm_run->s.regs.crs, env->cregs, sizeof(cs->kvm_run->s.regs.crs));
> +
> +    cs->kvm_run->s.regs.prefix = env->psa;

These 3 have only been saved for level> KVM_PUT_RUNTIME_STATE. By moving the memcpy
into this position you would always write them. Probably ok but a change in
behaviour. Was this intentional?

