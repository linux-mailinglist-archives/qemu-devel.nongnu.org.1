Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B678EF45
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:07:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiKW-0003ZK-OL; Thu, 31 Aug 2023 10:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qbiJs-0003Wk-CR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:06:55 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qbiJo-0000oY-7n
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:06:47 -0400
Received: from juju-98d295-prod-launchpad-16.localdomain (unknown
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B650E431B9
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1693490801;
 bh=4/hVjYAm3pnlt/6DrTFFILs8WrOKMdAYL9uhrppH8os=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=YZOW3xkbrLf0CZCN+Vydf2J+Gsqo8UqHRI9kG3jFOcGAV3CIzjP0LhZyLFcounXNX
 KNRPthUQlYr6RvGGI2l57FK+1JnZ/cq18zh+jyK9+bkZ3jm8S44vHFdMqj8PjvwNWN
 m5xpT8+qGlvFQL/qz8hyqAkqzEjyEK48/UzQnxuOZi2DaUq9vRpt9/1JoKz9ZirP3l
 +eGGvCGxrLJZN5lvyQ1r0o9lUUAfkTdeb9moRcftba7e2zT1Z1Wz80DNrBECOOuArg
 qlLxZZ2s74Cub3sRlW05e7yndRML24B+PyFVjj9j6ggwB+s8Hj5Q6/TYmnXaoDG7aW
 q8BOxzsNAtkhQ==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 944317EB93
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 14:06:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Aug 2023 13:57:24 -0000
From: Daniel Berrange <1863025@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: mttcg tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee berrange laurent-vivier samueloph yifanlu
X-Launchpad-Bug-Reporter: Yifan (yifanlu)
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
Message-Id: <ZPCcRD/zv/l80WWC@redhat.com>
Subject: Re: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="5e6925a96ee17ce45a766139d74108c2c83abbc9";
 Instance="launchpad-scripts"
X-Launchpad-Hash: f53bc3f799190c99261a3d064e065a6e6cdb6c05
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1863025 <1863025@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 31, 2023 at 03:40:25PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Samuel,
>=20
> On 31/8/23 14:48, Samuel Henrique wrote:
> > CVE-2020-24165 was assigned to this:
> > https://nvd.nist.gov/vuln/detail/CVE-2020-24165
> >=20
> > I had no involvement in the assignment, posting here for reference only.
> >=20
> > ** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-241=
65
>=20
> QEMU 4.2.0 was released in 2019. The issue you report
> has been fixed in commit 886cc68943 ("accel/tcg: fix race
> in cpu_exec_step_atomic (bug 1863025)") which is included
> in QEMU v5.0, released in April 2020, more than 3 years ago.
>=20
> What do you expect us to do here? I'm not sure whether assigning
> CVE for 3 years old code is a good use of engineering time.

In any case per our stated security policy, we do not consider TCG to
be providing a security boundary between host and guest, and thus bugs
in TCG aren't considered security flaws:

 https://www.qemu.org/docs/master/system/security.html#non-
virtualization-use-case

With regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863025

Title:
  Use-after-free after flush in TCG accelerator

Status in QEMU:
  Fix Released

Bug description:
  I believe I found a UAF in TCG that can lead to a guest VM escape. The
  security list informed me "This can not be treated as a security
  issue." and to post it here. I am looking at the 4.2.0 source code.
  The issue requires a race and I will try to describe it in terms of
  three concurrent threads.

  Thread A:

  A1. qemu_tcg_cpu_thread_fn runs work loop
  A2. qemu_wait_io_event =3D> qemu_wait_io_event_common =3D> process_queued=
_cpu_work
  A3. start_exclusive critical section entered
  A4. do_tb_flush is called, TB memory freed/re-allocated
  A5. end_exclusive exits critical section

  Thread B:

  B1. qemu_tcg_cpu_thread_fn runs work loop
  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

  Thread C:

  C1. qemu_tcg_cpu_thread_fn runs work loop
  C2. cpu_exec_step_atomic executes
  C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
  C4. start_exclusive critical section entered
  C5. cpu_tb_exec executes the TB code
  C6. end_exclusive exits critical section

  Consider the following sequence of events:
  =C2=A0=C2=A0B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed)=
 =3D> A5 =3D> B2 =3D>
  =C2=A0=C2=A0B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB=
 now executing) =3D> C6

  In short, because thread C uses the TB in the critical section, there
  is no guarantee that the pointer has not been "freed" (rather the
  memory is marked as re-usable) and therefore a use-after-free occurs.

  Since the TCG generated code can be in the same memory as the TB data
  structure, it is possible for an attacker to overwrite the UAF pointer
  with code generated from TCG. This can overwrite key pointer values
  and could lead to code execution on the host outside of the TCG
  sandbox.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863025/+subscriptions


