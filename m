Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D4C250FE
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Oct 2025 13:44:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEoSX-0007Nj-QP; Fri, 31 Oct 2025 08:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vEoST-0007MZ-Id; Fri, 31 Oct 2025 08:42:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vEoSL-0006h7-3l; Fri, 31 Oct 2025 08:42:20 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59V9Sxgv031961;
 Fri, 31 Oct 2025 12:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gaKsIU
 7dMVzvtNfd4Pw8wOYVoh4M2GP3dsNNusHGWvk=; b=Z7yjcFztAB69ofWKeazCMG
 DT24Xkx/4r2u/qnE25iU5ofLmTYHgXS0NtVpjNce5JxaoFy7j4Ae91NkX+7/eh3O
 HMlcAvdWXLHjBa1CzALMUVv0FBNL8M4L03NoYjw9qSiBa4AbTk2NkwxURVLDTbG/
 R0sIKodyXEPretk1U8Fo5jHzXAFjDluDSqO0RDt6Xr0qIFQqRelBgcG1YblDLEda
 8N6mEXONaXzsICASGLXWZAqAEpOsvGQ8EXx4gwr519PZiNl4mCckf4juXtjqp8dU
 weK7R6XeyS7692Cjic+Jb9EHirSrpPxhuZ16mcl606U/unaAJxAL0a2VSaPB9XkA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajwh6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Oct 2025 12:41:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59VCae0Q030910;
 Fri, 31 Oct 2025 12:41:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajwh6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Oct 2025 12:41:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59V8IrqU023869;
 Fri, 31 Oct 2025 12:41:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vxe5qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Oct 2025 12:41:51 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59VCfoJO31457820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Oct 2025 12:41:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5121658045;
 Fri, 31 Oct 2025 12:41:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DDE058056;
 Fri, 31 Oct 2025 12:41:46 +0000 (GMT)
Received: from [9.124.212.241] (unknown [9.124.212.241])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 31 Oct 2025 12:41:45 +0000 (GMT)
Message-ID: <d52da8d1-3d9c-46c4-99db-b22bd597db27@linux.ibm.com>
Date: Fri, 31 Oct 2025 18:11:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for PowerPC e500 little-endian pages
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=6904ae90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=__1j2KhZzCfPKJUQqiIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: wjRkopTEjQTd7cKM0Q2t7GLuAFSC9lRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX3DI1lIj1Mbvc
 ngh4AizrTYOs396qhE68yguFXMc1Au/2KrTXm5SPDhgp9Jkw0hi9e3La7Jnc12RBuqIQiOZrajg
 dLpA6Elgva9W1qMikrnxTokKcs5JxhWtSzdDveqjRHEs4ijYJfNrzNyLzW5tM5ZDwCZt0iJAElf
 4S04GmMJqYR5nY5uEslV1uLJYhZVS/E7UBEXqHloXz5P175I1xY6ITNbRezT9VfMwb8UsLpS8la
 9Tt/rITmei3AGKs1uvCRFfAcaC1B5IF7peh3iXeoGJsBTnfLcRYIkAVoZ5RW+oxo8cYj6TIulCR
 Lf/oZVlEErFu09edCCI1cwk7Z8jOxZTNAR4ZB6WKr5AGOo3BkOf3TcAydzi9kgawEn79wffeijK
 L5QIi9+yXqOREaH/Y2rJGR7O0bwiag==
X-Proofpoint-ORIG-GUID: 91hv7RaU17t8fWsNWmESJ7MmDCPm1Op_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/27/25 18:00, Danila Zhebryakov wrote:
> These changes make powerpc booke206 mmu pass TLB_BSWAP flag for pages marked as LE, and also fixes all the issues this causes.
>   - added TLB_BSWAP to non-MMIO flags
>   - inserted additional check for LE page when bswap-ing instructions
>   - removed assert for cross-page TLB_BSWAP accesses
>   - added gdbstub fix to account for TLB_BSWAP of the currently running code
>
> BE- and LE- atomic operations (used by load-and-reserve and store-conditional instructions) were unified to support TLB_BSWAP
>
> Some of the fixes are based on what is done in https://github.com/YetAnotherMod/qemu
>
> V2:
>   - Removed usage of PAGE_USER bit for LE (comment on previous version)
>   - Refactored MMU code so directly setting TLB_BSWAP is possible
>   - moved translation LE page detect to occur 1 time per translation (comment on previous version)
>   - Removed redundant assert in atomic_mmu_lookup (comment on previous version)
>   - Added assert on cross-endian accesses (ideally, there should be an exception)
>   - Changed atomic need_bswap handling (comment on previous version)
>   - Rebased and fixed atomics
>
> V3
>   - unfix assumed typo (if vs iff). Everything else unchanged
>
> V4
>   - fix leftovers from BE/LE atomic op tables
>   - fix uninitialized CPUTLBEntryFull full in mmu_common
>
> According to RM, unaligned accesses between LE and BE pages should cause an exception on e500.
> However, (as I understand it) supporting this would require adding a new callback to TCGCPUOps, likely just for E500 or maybe a couple other CPUs doing this.
> Such accesses are clearly not normal and usually don't occur in real applications, so I think just placing assert is OK here.
>
> Danila Zhebryakov (4):
>    accel/tcg: Unify big- and little- endian atomic ops
>    target/ppc: refactor MMU helpers
>    target/ppc: Add support for LE pages on PowerPC booke206 mmu
>    target/ppc: fix GDB stub to work correctly with LE pages
>
>   accel/tcg/atomic_common.c.inc       |  36 +--
>   accel/tcg/atomic_template.h         | 326 ++++++++++------------------
>   accel/tcg/cputlb.c                  |  29 ++-
>   accel/tcg/tcg-runtime.h             |  48 +---
>   accel/tcg/user-exec.c               |   2 +-
>   include/accel/tcg/cpu-ldst-common.h |  51 ++---
>   target/m68k/op_helper.c             |   4 +-
>   target/ppc/gdbstub.c                |  17 +-
>   target/ppc/internal.h               |   3 +-
>   target/ppc/mmu-booke.c              |  67 +++---
>   target/ppc/mmu-booke.h              |   2 +-
>   target/ppc/mmu-hash32.c             |  30 +--
>   target/ppc/mmu-hash32.h             |   3 +-
>   target/ppc/mmu-hash64.c             |  14 +-
>   target/ppc/mmu-hash64.h             |   2 +-
>   target/ppc/mmu-radix64.c            |  20 +-
>   target/ppc/mmu-radix64.h            |   2 +-
>   target/ppc/mmu_common.c             |  75 ++++---
>   target/ppc/mmu_helper.c             |  15 +-
>   target/ppc/translate.c              |  42 +++-
>   target/s390x/tcg/mem_helper.c       |   6 +-
>   tcg/tcg-op-ldst.c                   |  51 ++---
>   22 files changed, 374 insertions(+), 471 deletions(-)
>
Hey Danila,

This series is failing on QEMU_CI. You can check it here :
https://gitlab.com/rathc/qemu/-/pipelines/2131344109

<https://gitlab.com/rathc/qemu/-/pipelines/2131344109>

Here are some logs for quick reference :

|configuring with: '../configure' '--enable-werror' '--disable-docs' 
'--cross-prefix=powerpc64le-linux-gnu-' '--disable-tools' '--enable-kvm' 
'--disable-tcg' '--without-default-devices'
...
|||

|[1690/1838] Linking target qemu-system-ppc64|
|
||
FAILED: qemu-system-ppc64
||
powerpc64le-linux-gnu-gcc -m64 -mlittle-endian @qemu-system-ppc64.rsp
||
/usr/lib/gcc-cross/powerpc64le-linux-gnu/14/../../../../powerpc64le-linux-gnu/bin/ld: 
libqemu-ppc64-softmmu.a.p/target_ppc_gdbstub.c.o: in function 
`ppc_maybe_bswap_register':
||
/builds/rathc/qemu/build/../target/ppc/gdbstub.c:96:(.text+0xd0): 
undefined reference to `probe_access_full_mmu'
||
collect2: error: ld returned 1 exit status
||
[1691/1838] Linking target qemu-system-ppc
||
FAILED: qemu-system-ppc
||
powerpc64le-linux-gnu-gcc -m64 -mlittle-endian @qemu-system-ppc.rsp
||
/usr/lib/gcc-cross/powerpc64le-linux-gnu/14/../../../../powerpc64le-linux-gnu/bin/ld: 
libqemu-ppc-softmmu.a.p/target_ppc_gdbstub.c.o: in function 
`ppc_maybe_bswap_register':
||
/builds/rathc/qemu/build/../target/ppc/gdbstub.c:96:(.text+0xd0): 
undefined reference to `probe_access_full_mmu'
||
collect2: error: ld returned 1 exit status
||
[1692/1838] Generating pc-bios/edk2-arm-code.fd with a custom command 
(wrapped by meson to capture output)
||
ninja: build stopped: subcommand failed.
||make: *** [Makefile:168: run-ninja] Error 1
|
Thanks and regards,

Chinmay


