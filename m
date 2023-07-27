Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10834765F03
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP8Ol-00061G-Oj; Thu, 27 Jul 2023 17:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qP8Oe-0005zS-Ag
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:19:44 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qP8Oc-0002AR-5y
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690492769; x=1691097569; i=deller@gmx.de;
 bh=F71tvw2vKgx8IzbfPlwp+ghj/oXqyFL0fUUvyGmhc/Q=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=hlZ3HuxOOmNKLw5lw0CRO416AK9P/o9ot1n9YtxCmGz5HMCWQj97PjGJjpQUecT9Ul0O3ln
 QIIENwGI/zfAiGA6zfX1du2GxrG0pBvzcMMSYd8HTDTUal0ZIyZzHwZuXvK1uPCIloGZDYGpw
 rnnxeBSsjTCVgpTe4q53J6WbHJjF1e6JcpTIWcNtC23HcAQy4yv4hRyQoVThThZVaPz2NaZLu
 S9vQXaD2FodFDEz9X8nA2vGR8BWcMQhqw2pa7TlRPBGo5Ulo4b1hBoRqhZRaYQvmV4G/ZQ5ue
 C2wSOfIZ+qzO3oesJx8BSB3GYUtepr2irNr/i5OLmkZ8scy2dwhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.159.20]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1pi3qn2znY-010s5j; Thu, 27
 Jul 2023 23:19:29 +0200
Date: Thu, 27 Jul 2023 23:19:28 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Subject: linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Message-ID: <ZMLfYE3fYCUhnaEE@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:eOFO/yFx6XtL/LpNz2vRh4bvgpzPqqB+UmVlyOGCulX/PUUUlOY
 HiQJWeTs3fhgcRNkO1VrZhAoJfzxs2Qm8TF4JaVMe8MgeOOCFDvtpni9fmReC8eraANL0mQ
 Fedy6oWiSB9WdQTPCmGEMpX0M5NlLAR3koSgiWZ+npc2k429iMLC5zQzXzVrS5e61bj5Sk2
 bTC91BwXBIhYeEqCiEv1w==
UI-OutboundReport: notjunk:1;M01:P0:EtX2tAjE22g=;wqgFsLXgKeU8ekIAYQ66GQ6MqWY
 nTUP+KnoiD9x/jL0mseRynTaxAnQafSgroiYpRz5qhHotpktyBSxuawCaCKVx+ccB14Y38zF9
 +PawULOJ2JKiAPlpfdjOckiXph86ouv7mGzBjrPhRCmZWuPxCvqBEBM7dBJD/r/QjP9C4Xklb
 2yHpNa7gB7G1hY3u7ogq9oic0yFwjTGiEBt2ZD3kEpYw7BRjHPjKNqCqqOLu2Y7lmuaPDAMl/
 jWR6JHl7gB9qbdGDGwWz+sgMZn+Ua6deIXJPKoJbhaB62XQyFg9pqZrBthz7rwKjYvR1h2jSE
 XEIKD/YVMaRYx1DYKKOaFyl8RmWbZxmEdRe9LG0/Asr3PsLIraNkkumjySWyH00s9tXq6kAUI
 /Dy4FYKrbwNXsJoiAgiHetjb/EiKr1RBEBNUCdodUwM502Ra0Qm/tsFNo1LA5E/lbmxBXdlKG
 2Q0Ec4YDXyxeQJQpMC30ufD234OUOppl3+pUDURvGUgBGQcYp96PAAl12VWQbROTTW8y81Kpb
 zexC7mdRxzsdylb/K5QQjr1mgKFfzdAogKgqOpuad/wUVWsfTd+IwOieTi1Gl7kGA2wND0zIP
 3sT9kMtSyfgcfZsNNlLPGquf1sLGB1mxcV9rDtc2PBKhTcmP8wlAepn0pnc1qL5vCLS5N1/oK
 2PZGTw2KIoT3039EOc7f9KQ8riaRpg6LuXxlBVsxn6TnUFtBh2SXX7K0VMzn4aPd5pZE5mCnQ
 Gwq2hBrLs4HpqS4imFSdtOqp7facWb81KAKM/gXec1+mAl5dwiLoQfoupe4ZkOygpzm55vvMg
 9X9P/wWwJt8/vofEcCSix0rebnb2I6RfxMs0mxIn1kFzqXH0RGf0MzWs3XCyRF7H1z3Ilgz1+
 qhKQ+wyzV40pNvH3tqWarUwKzW7fZo0NQMzknaXLEordJwZfxukl8LaoUysT8F8GEyyFbWOWA
 wsSZrSSS4+4MSpK6AyxXn21skVk=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Words are stored in big endian in the guest memory for armeb.

Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with
host atomics") switched to use qatomic_cmpxchg() to swap a word with the
memory content, but missed to endianess-swap the oldval and newval
values when emulating an armeb CPU.

The bug can be verified with qemu >=3D v7.2 on any little-endian host,
when starting the armeb binary of the upx program, which just hangs
without this patch.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Reported-by: John Reiser <jreiser@BitWagon.com>
Closes: https://github.com/upx/upx/issues/687

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index a992423257..ff0bff7c63 100644
=2D-- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -117,8 +117,8 @@ static void arm_kernel_cmpxchg32_helper(CPUARMState *e=
nv)
 {
     uint32_t oldval, newval, val, addr, cpsr, *host_addr;

-    oldval =3D env->regs[0];
-    newval =3D env->regs[1];
+    oldval =3D tswap32(env->regs[0]);
+    newval =3D tswap32(env->regs[1]);
     addr =3D env->regs[2];

     mmap_lock();

