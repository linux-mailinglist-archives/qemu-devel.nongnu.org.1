Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A118BA7F06
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Sep 2025 06:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v35Wb-0002vU-TJ; Mon, 29 Sep 2025 00:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benh@kernel.crashing.org>)
 id 1v35WN-0002tS-Pt; Mon, 29 Sep 2025 00:29:55 -0400
Received: from gate.crashing.org ([63.228.1.57])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>)
 id 1v35W1-0005zY-4A; Mon, 29 Sep 2025 00:29:41 -0400
Received: from [IPv6:::1] (localhost [127.0.0.1])
 by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 58T4SvPL1031045;
 Sun, 28 Sep 2025 23:28:59 -0500
Message-ID: <4b0138bc76c60385de71c26eb55a4aecd8d1786d.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] target/ppc: Have gen_pause() actually pause vCPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 bharata.rao@gmail.com, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org
Date: Mon, 29 Sep 2025 14:28:57 +1000
In-Reply-To: <20250924173028.53658-3-philmd@linaro.org>
References: <20250924173028.53658-1-philmd@linaro.org>
 <20250924173028.53658-3-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=63.228.1.57;
 envelope-from=benh@kernel.crashing.org; helo=gate.crashing.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2025-09-24 at 19:30 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> gen_pause() sets CPUState::halted =3D 0, effectively unhalting
> (a.k.a. "running") the cpu. Correct by setting the '1' value
> to really halt the cpu.

What will resume it though ? The smt_low() case isn't meant to *halt*
the CPUs permanently. smt_*() levels are about SMT thread priorities.
Using a "pause" that just gets out of TCG (and back in), is a way to=20
"yield" to another thread, thus enabling more forward progress when a
thread is spinning on an smt_low() loop. This happens in firmware and
in some spinlock cases.

This isn't about stopping until some external event resumes it.

Cheers,
Ben.


