Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A28327C3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 11:42:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmJ4-0003aV-GR; Fri, 19 Jan 2024 05:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rQmJ1-0003Zm-1g; Fri, 19 Jan 2024 05:40:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rQmIy-0002UE-Hx; Fri, 19 Jan 2024 05:40:58 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40JAW5di001839; Fri, 19 Jan 2024 10:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ZnczHaR4Meb4W0IyB1OyiLgbGc1nhMHaay8I8gS1uV4=;
 b=ihqC0Mz/AfDfDzD7ja8MInldQdzEysJxNqt8zkkj01USqZu5O5TsQyR03PY94pJ8ZL3w
 eoyd/1lZx/UdWEgDPsbyYCr8CHkwGduFQA+oJ0gMi5QLVi3eikUdB44Ro6M3pD8USqLB
 leb7BqOKgRpAWNlWuf/uIf7B6auB2ayAPsJgbP2J0LIUr7mlQaBiuYnnhsUnURKr1Y8m
 DfdAzdPFiYBV58KxGOsaesgtAaJrsySKgfVqrM4Zsdn2T7uRokE6grdk6YWBEr87sZJd
 I7b1UCXPBBUCStC055vWlN1ogbbn75lW+dgiOwcWmbNLMp1i/dxshROEhvo8xXhyla/4 VA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqqdpg6p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 10:40:50 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JAbJif016548;
 Fri, 19 Jan 2024 10:40:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqqdpg6ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 10:40:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40JARoBu011009; Fri, 19 Jan 2024 10:40:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm58017p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 10:40:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40JAekm014287574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jan 2024 10:40:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 440292004D;
 Fri, 19 Jan 2024 10:40:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6F1720040;
 Fri, 19 Jan 2024 10:40:45 +0000 (GMT)
Received: from heavy (unknown [9.171.83.169])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jan 2024 10:40:45 +0000 (GMT)
Date: Fri, 19 Jan 2024 11:40:44 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Ido Plat <Ido.Plat@ibm.com>
Subject: Re: Re: [PATCH 1/2] target/s390x: Emulate CVDG
Message-ID: <bqwzxucfiod52ef43ocn3j57bx6fnincuhyvdns5hwzi2ux6dr@d5xhi4fdxl4s>
References: <20240115202308.1930675-1-iii@linux.ibm.com>
 <20240115202308.1930675-2-iii@linux.ibm.com>
 <6d82413f-3729-4e6e-837b-996038ebaa63@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d82413f-3729-4e6e-837b-996038ebaa63@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SwMo5vpx9TL5qscwrqsiqFSEx_NUG2Gr
X-Proofpoint-ORIG-GUID: nBWoB7ontq5w7fsDwd7Bc-PY9typo-b6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_05,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=590
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Fri, Jan 19, 2024 at 08:12:18AM +1100, Richard Henderson wrote:
> On 1/16/24 07:21, Ilya Leoshkevich wrote:
> > CVDG is the same as CVD, except that it converts 64 bits into 128,
> > rather than 32 into 64. Use larger data types in the CVD helper and
> > reuse it.
> > 
> > Reported-by: Ido Plat <Ido.Plat@ibm.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   target/s390x/helper.h            |  1 +
> >   target/s390x/tcg/insn-data.h.inc |  1 +
> >   target/s390x/tcg/int_helper.c    | 11 ++++++++---
> >   target/s390x/tcg/translate.c     |  8 ++++++++
> >   4 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> > index 05102578fc9..332a9a9c632 100644
> > --- a/target/s390x/helper.h
> > +++ b/target/s390x/helper.h
> > @@ -89,6 +89,7 @@ DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
> >   DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
> >   DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
> >   DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
> > +DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
> >   DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
> >   DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
> >   DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
> > diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> > index 2f07f39d9cb..388dcb8dbbc 100644
> > --- a/target/s390x/tcg/insn-data.h.inc
> > +++ b/target/s390x/tcg/insn-data.h.inc
> > @@ -296,6 +296,7 @@
> >   /* CONVERT TO DECIMAL */
> >       C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
> >       C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
> > +    C(0xe32e, CVDG,    RXY_a, Z,   r1_o, a2, 0, 0, cvdg, 0)
> >   /* CONVERT TO FIXED */
> >       F(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0, IF_BFP)
> >       F(0xb399, CFDBR,   RRF_e, Z,   0, f2, new, r1_32, cfdb, 0, IF_BFP)
> > diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
> > index eb8e6dd1b57..defb8fc7681 100644
> > --- a/target/s390x/tcg/int_helper.c
> > +++ b/target/s390x/tcg/int_helper.c
> > @@ -99,10 +99,15 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
> >   }
> >   uint64_t HELPER(cvd)(int32_t reg)
> > +{
> > +    return helper_cvdg(reg);
> > +}
> > +
> > +Int128 HELPER(cvdg)(int64_t reg)
> >   {
> >       /* positive 0 */
> > -    uint64_t dec = 0x0c;
> > -    int64_t bin = reg;
> > +    Int128 dec = 0x0c;
> > +    Int128 bin = reg;
> >       int shift;
> >       if (bin < 0) {
> > @@ -110,7 +115,7 @@ uint64_t HELPER(cvd)(int32_t reg)
> >           dec = 0x0d;
> >       }
> > -    for (shift = 4; (shift < 64) && bin; shift += 4) {
> > +    for (shift = 4; (shift < 128) && bin; shift += 4) {
> >           dec |= (bin % 10) << shift;
> >           bin /= 10;
> >       }
> 
> None of this will work with the struct version of Int128 -- you need to use
> the int128_* functions for initialization and arithmetic.
> 
> I suggest you don't try to share code with CVD.
> 
> 
> r~

Hi,

I see, --cross-prefix=i686-linux-gnu- is very broken with this patch.
I will send a v2.

Best regards,
Ilya

