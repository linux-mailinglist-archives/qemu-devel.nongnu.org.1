Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C62773980
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 12:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTJVl-0001dO-IG; Tue, 08 Aug 2023 06:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qTJVC-0001Qe-CA
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:59:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qTJV7-0005Zm-K5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 05:59:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3789rWFf024139; Tue, 8 Aug 2023 09:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vQVR+EwIER6N0NSzAXbXb2PuHTtwKp375wLWkk23n6g=;
 b=olCjfoUlHziXcWe7X1XU0/D2qkSpV4SwKbpDMg/Oa8WHShzgMZLS7yw5mrRBPj6z1fm5
 EjwHfgCtSMObS/JVhtU1b5yKcCt2gEOX2h/1BDMQQmpsynuU0/kXdWMc4swagKi84tk7
 Gfe8vZzE2GBaOXZBKij+G1TTHWFrdo0ATSBVUgqHICyBjBSb4j+zeHt4uJmoqAL9jpcb
 X8hxGkBMtxNS3TNoNX70VxHmpcPRXheODQVp1cwqwkw45v2ORYcp9mZktszOtMSRoK41
 6q95SZQ9nXAdkp74cRLwXqxwxJdFBvlPRU/nfX9/ZiAQeCKzCWYf2Hh4dbrarco3Pk// Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbkff83nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 09:59:35 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3789sSoR026371;
 Tue, 8 Aug 2023 09:59:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbkff83mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 09:59:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3788vsEv030364; Tue, 8 Aug 2023 09:59:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn5dv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 09:59:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3789xV3l33096424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Aug 2023 09:59:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 620D420043;
 Tue,  8 Aug 2023 09:59:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C36E20040;
 Tue,  8 Aug 2023 09:59:31 +0000 (GMT)
Received: from [9.171.66.239] (unknown [9.171.66.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Aug 2023 09:59:30 +0000 (GMT)
Message-ID: <309ee7ed61a0185c687ae184692198b3c2989970.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 1/1] tcg: Always pass the full write size to
 notdirty_write()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 08 Aug 2023 11:59:30 +0200
In-Reply-To: <93412928-2b4b-6541-631e-2d57ccd5f05e@linaro.org>
References: <20230807141846.786530-1-iii@linux.ibm.com>
 <20230807141846.786530-2-iii@linux.ibm.com>
 <93412928-2b4b-6541-631e-2d57ccd5f05e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ctxz3GWg6f1OAPlveoq_VDVXwBeL897O
X-Proofpoint-ORIG-GUID: u0LgchjfmPpeYQh6-tYUsGq0a6H1eUbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=414
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2023-08-07 at 11:21 -0700, Richard Henderson wrote:
> On 8/7/23 06:56, Ilya Leoshkevich wrote:
> > One of notdirty_write()'s responsibilities is detecting self-
> > modifying
> > code. Some functions pass the full size of a write to it, some pass
> > 1.
> > When a write to a code section begins before a TB start, but then
> > overlaps the TB, the paths that pass 1 don't flush a TB and don't
> > return to the translator loop.
> >=20
> > This may be masked, one example being HELPER(vstl). There,
> > probe_write_access() ultimately calls notdirty_write() with a size
> > of
> > 1 and misses self-modifying code. However, cpu_stq_be_data_ra()
> > ultimately calls mmu_watch_or_dirty(), which in turn calls
> > notdirty_write() with the full size.
> >=20
> > It's still worth improving this, because there may still be
> > user-visible adverse effects in other helpers.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> IIRC there are some uses of probe_access_* that set size =3D=3D 0.
> Should we adjust addr+size to cover the whole page for that case?
> That seems to be the intent, anyway.

There is a comment that says we shouldn't do watchpoint/smc detection
in this case:

    /* Per the interface, size =3D=3D 0 merely faults the access. */
    if (size =3D=3D 0) {
        return NULL;
    }

Come to think of it, qemu-user works this way too: SMC is detected on
the actual access, not the probe:

    helper_vstl()
      cpu_stq_be_data_ra()
        ...
           stq_he_p()
             <signal handler called>
               host_signal_handler()
                 handle_sigsegv_accerr_write()
                   page_unprotect()
                     tb_invalidate_phys_page_unwind()
                   cpu_loop_exit_noexc()

So all this is probably fine, I now think it's better to leave the code
as is, especially given that I cannot reproduce the original problem
anymore.

