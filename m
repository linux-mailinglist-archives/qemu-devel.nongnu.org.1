Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A177111A
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 19:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSLJJ-0003Nt-AW; Sat, 05 Aug 2023 13:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSLJH-0003Ng-8S
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:43:27 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSLJF-0000yn-IB
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691257401; x=1691862201; i=deller@gmx.de;
 bh=pRiLm6CGY3HVYw+4R0+WU314iO0FUL0kOH2ciq9Ne+s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Dsr5/zhVKc4qopg2Oo184PUSGY9Hx3AdaWa1m4PpkNOSVZT3jat/fAXWdYXEeVsNKCfqPpv
 cJM0SW/ocLW2eSiYygL/3lEHKYRi47QG4pVZHUOsWu2+644xtu2DJdkxqX4aXw4cNpS+rrMnL
 Drkqyv7fwbe7mRfe4/lC4Vu77VULSp6D2gu2hUjo3lk1l8Sv/3iK5LHVmGhLnoxuPPpFT07QW
 5zIMFrk1ioC4lLDyr8EKWsOMRUlYLAdc6Es/8RZduwgWDuecE1M+w77xAflfrJC6Nk8g5GjWT
 hUoP1utPu1BthE4OEBiLC0Kv5upcvvF6nM3X00HmmbLBtB9vewng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.145.133]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXBj-1qfrxI3eJF-00DU3z; Sat, 05
 Aug 2023 19:43:21 +0200
Date: Sat, 5 Aug 2023 19:43:20 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Subject: Re: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
Message-ID: <ZM6KOBfqFLumgpwm@p100>
References: <ZM59CkNZg5n4WXO3@p100>
 <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org>
X-Provags-ID: V03:K1:HLJRRXBBLsxb5LbwS82/udupfdiY3//DdBE378rlUsGpvTyNBdu
 QH+yTUw1nHD6gLa7U+h2Lv2CxSO/U2oAca5Fy/Ee9DVV3CXYCZgMXfRWepp2/1hTyvg/mii
 g10nDPf+mECmDoySI2x0VpAan2/N141SYogwu/5MphfhjiLe+nOVvmpJ9SoGAKecrYUkwRP
 ihuvfjOM7sHvhwVxk1SLw==
UI-OutboundReport: notjunk:1;M01:P0:gejHHyqhcLk=;m95HG4/MGWDOT2RDeuG3esIcnA8
 uDkyibh1QVrB2IXzibAwHzDxSH7J6rLvhbigNtcO3LgAixlhFZGWskQJ64OFfqP1I7O8McOhL
 ewdEj8CwWRfRFqMMMDWrvhgfwntxdgdxptqNlrbMcMyLUFAUGNtmJhtXM0biFN6aQvTRyy0Gt
 ZORRF1aBDenr/bNdmjKUtXkXfS0WUrB9cbz1527rBEPUJtjP+77jl+jHsCBU28zWPxZkzqx+3
 Jgji2BKnouAkH54V4t5mT5bW6T2FNkDQTJNqLLFOTskRJLpm/0GE/91AfReVSbAClh6r4J1gj
 r6HHeAJjLuQPjDSXOV8iDhONXAl5dEUxBTnLbaMEKfHNu14D+9pSW6gJw/gcinN0eGmErbbwp
 jz68d1B+HjTSjkGFDdry1CS3KqXgkXM3TBsiVKx/crrLyud6OAP+XdkpR2cSj5vt/QFpfuAjW
 dWIaHfu8pyRIYuJPS1Z4hwLCjHyh7XR4lYqqnPXOQ3fUV7El6GhcSaQ2qLmMIxm+PomeEK1lb
 wVZGb6aK1ol8uImAhXHbD0sw/8ND5wgrmEFB6EjoMbLDEVVlNU1s/ats9aKtScKNU9GcrwdTU
 3A0/YMYZ1IkIUQHUo1RADCWXGmheUeUqZQH5mshHxJ6YQ1kLt0OldAcNORs/bwXlTPvFczJR4
 036gYdqNtyHMt7x7eFzP+rWPi1cuKSmQfFgrs8v3rDoh8fIS/dEIwVPrhQpbD9fA3Qdj1QDtO
 xkt/aSThpR+4b6kpSriGonVC68MohKjexOQMYuq1J7+J8t3O/WMI/Pur5ZuVUv/wgG7Oq/1au
 QzukOw63+buoORZNA87QWhkHlrRyfSzyjq8xOMKv3J7NTxcGLOLENrb+4HNDqaxO8frBtYFr1
 0su85gGktCwPjwbiyNuBxydC2VFyZME9yXIGebDz+gjtORrJvgObD5kFjlob6GITadioF3/t1
 4GV+iQ==
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> On 8/5/23 09:47, Helge Deller wrote:
> > Do we want to enable such an performance optimization?
> > If so, I see two possibilities:
> >
> > a) Re-define NB_MMU_MODES per target
>
> No, we've just gotten rid of per target definitions of NB_MMU_MODES, on =
the
> way to being able to support multiple targets simultaneously.

Ok, I assume that answer :-)

> This only affects x86, and for only 6 bytes per memory access.  While sa=
ving
> code size is a nice goal, I sincerely doubt you can measure any performa=
nce
> difference.

Maybe. I don't know. I'm sure the gain is small, but the patch is small
too.

> If there were a way to change no more than two lines of code, that would=
 be
> fine.  But otherwise I don't see this as being worth making the rest of =
the
> code base any more complex.

Ok. What about that 6-line patch below for x86?
It's trivial and all what's needed for x86.
Btw, any index which is >=3D 9 will use the shorter code sequence.

Helge

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..3e71e666db 100644
=2D-- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2251,11 +2251,11 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list

 /* MMU modes definitions */
-#define MMU_KSMAP_IDX   0
-#define MMU_USER_IDX    1
-#define MMU_KNOSMAP_IDX 2
-#define MMU_NESTED_IDX  3
-#define MMU_PHYS_IDX    4
+#define MMU_KSMAP_IDX   11
+#define MMU_USER_IDX    12
+#define MMU_KNOSMAP_IDX 13
+#define MMU_NESTED_IDX  14
+#define MMU_PHYS_IDX    15

 static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
 {

