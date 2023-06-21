Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F527388BD
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 17:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzc2-0005Fb-Ec; Wed, 21 Jun 2023 11:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qBzbz-0005DW-Mu; Wed, 21 Jun 2023 11:19:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qBzbx-0007b4-Ra; Wed, 21 Jun 2023 11:19:11 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LF9jQX019186; Wed, 21 Jun 2023 15:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4jkSRyyY4aAkPquaPMYIpVmDUFXs1PhKKGMVUX+JQUU=;
 b=njDSWXQeCzier7YhWAr97XQirQZtSdN2t/3M50JCD3JD+SVXvknFm58LM9V29FH2vH7/
 kgNGbhI9uQ0lCdJRuwe9kp0L8Cwa6BxG1JoBFB2K7ja5ljvHdczq4YXy6X3GhW3z/9fe
 epaFkbSmFGiO8whREDiLp2CLZkz/BWag5FPRCiRuyZFRvoFeokK+8HpZkDK1Jcc0OPE6
 p2cvZgTgJDkiV3Ttn5iu780mOjz0fWj9L3i7vg7RbDySqkNPyjHDLjs2X7CQglXHy1rp
 cob6zhnb451FoetBlTelbJOjpyL3rHz94KnjBlADYmmZvLXRQAXvyQ9fwRWpSweIDSfF Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc3a3gugc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 15:18:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LFAJUb021951;
 Wed, 21 Jun 2023 15:18:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc3a3guf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 15:18:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L2fTR8003861;
 Wed, 21 Jun 2023 15:18:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f52u0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 15:18:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LFIqBA20709904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 15:18:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C8FC2004B;
 Wed, 21 Jun 2023 15:18:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04E0820040;
 Wed, 21 Jun 2023 15:18:52 +0000 (GMT)
Received: from [9.171.1.141] (unknown [9.171.1.141])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 15:18:51 +0000 (GMT)
Message-ID: <93480aa2-3639-1758-0395-a91bd7640099@linux.ibm.com>
Date: Wed, 21 Jun 2023 17:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PULL 05/29] pnv/xive2: Handle TIMA access through all ports
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org
References: <20230610133132.290703-1-danielhb413@gmail.com>
 <20230610133132.290703-6-danielhb413@gmail.com>
 <CAFEAcA_KKSc=Ns9n1UJKdnhZ846EGK-nFbsG_e2mw_zwMoOJcw@mail.gmail.com>
 <4ad1a081-bf98-1b7d-05c9-82c230da34ce@kaod.org>
 <9f71ffc4-2b37-d8b8-56c6-658d264242c4@linux.ibm.com>
 <c300d299-a90b-c29a-b556-83a2545adc30@kaod.org>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <c300d299-a90b-c29a-b556-83a2545adc30@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ztQmok55BeA03o5MfX__pz2RdGrgZgE
X-Proofpoint-ORIG-GUID: b3AOeqX9XzHkkTmutJs0CnKDxQZNaM8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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



On 21/06/2023 09:18, Cédric Le Goater wrote:
> The XIVE2 TM ops are implemented with a shortcut (See the TODO in
> pnv_xive2_tm_*()). We could
> 
> 1. extend xive_tctx_tm_write/read with a 'bool gen1_tima_os' parameter:
> 
>      xive_tctx_tm_write(xptr, tctx, offset, value, size, gen1_tima_os);
> 
>     and use the bool in xive_tm_find_op() to select a XiveTmOp array.
>     The new xive2_tm_operations[] would be defined as xive_tm_operations[]
>     but with an override of HV_PUSH_OS_CTX_OFFSET and 
> HV_PULL_OS_CTX_OFFSET.
> 
> 2. or extend the XivePresenterClass with a get_config() handler like it
>     was done for Xive2RouterClass().
> 
> 3. or introduce an array of XiveTmOp under XivePresenterClass defined by
>     the controller variant.
> 
> In any case, we need a new xive2_tm_operations[] for the XIVE2 TM register
> layout. Option 1 is simpler I think.


I was also leaning on introducing a xive2_tm_operations[] array of 
operations to fix it correctly.

While I agree it's the simplest, I'm not fond of (1), since we'd need to 
carry that extra parameter to xive_tm_find_op(). Admittedly it's just 
one extra level, but I went with something which is hopefully what you 
had in mind for (2). I like that we can easily extend it in the future.


> This would  also "fix" the indirect ops in XIVE2, not that we care much
> but it will be cleaner.

I'm not sure I see what you mean here. It cleans up nicely 
pnv_xive2_tm_read/write(), but is that really what you had in mind?


Something related I notice is that when doing an indirect access to the 
TIMA through the IC BAR, we call the TIMA access functions with a NULL 
reference to the presenter:

static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
                                               unsigned size)
{
     PnvXive2 *xive = PNV_XIVE2(opaque);
...
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
         val = xive_tctx_tm_read(NULL, tctx, offset, size);
     }

We seem to mostly ignore that first parameter in 
xive_tctx_tm_read/write(). IIUC, the special ops will be checked with a 
page offset matching ring 0 and won't match anything. Still, it seems a 
bit dangerous and I was wondering:
1. can't we just create it from the PnvXive2 we have at hand?
2. in any case, isn't it always redundant with tctxt->presenter?

   Fred

