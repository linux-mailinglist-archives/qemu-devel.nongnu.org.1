Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0727A95C9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 18:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjMh5-0005qS-Bv; Thu, 21 Sep 2023 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qjMh1-0005pA-V4
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 12:38:20 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1qjMgz-0004iw-SE
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 12:38:19 -0400
Received: from juju-98d295-prod-launchpad-16.localdomain (unknown
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D651642333
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1695314289;
 bh=cX5FsTSdhUywsG48ZqvcSAGDfL/iwxXClFskkceGsvk=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Q5HlFtz2T/Jf+4A12VvpSy5iTEuo1Uzx5QtZhr0djx5capOImIVOY2jgKbONatQ4I
 sf53PiiIYJME7iizgXcR1OjcSoX+8Xne9U3siBVo5AsLA/1YDz7tkS8RrvMcT7LfJH
 /eOo0TrwYE5pH3654oxli5McKK5EaD9GyxvuLw7T2JI313LMF6cbLh1uwmtzvUw1u3
 MRhe6/2B3wWXYxIVB6Rfk2eNwSAuJW6hLx2Piz4zBlkNbwOiWqaDmorQXaClu2S3DZ
 GQPdbXs+9lmR5+xobhmh5+wQcSU7IqDQ72bxUn1mAzPUCWzheYBOPpKLlmgFY6lnrj
 krgaLB55w4NZw==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 9096C7E31B
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 16:38:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Sep 2023 16:26:00 -0000
From: John M <1819289@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: mttcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cbparker curryrice71 dgilbert-h philmd pmaydell
 th-huth
X-Launchpad-Bug-Reporter: John M (curryrice71)
X-Launchpad-Bug-Modifier: John M (curryrice71)
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
 <163031397124.5151.7828028292289278229.malone@gac.canonical.com>
Message-Id: <CA+Ay21K_JS4c0oDfJhhNr8N-bHVhvKxfrBr+dhRYF8CRiH1QoA@mail.gmail.com>
Subject: Re: [Bug 1819289] Re: Windows 95 and Windows 98 will not install or
 run
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d47b73632f1fccdd9fdd4e6145a4784874303779";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 9eb8fd85eb07c8a0fa6ea5a7ec188e87cacdb3b7
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
Reply-To: Bug 1819289 <1819289@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is happening again in 8.1. I used Windows 95 for a while in 6.1 and it
was fine, but when I tried to upgrade to 8.1, it started happening again. I
tried reducing the memory and it still happens. Not an urgent issue though.

On Mon, Aug 30, 2021 at 2:05=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <
1819289@bugs.launchpad.net> wrote:

> Brad said later after testing v6.1 it was fixed so please disregard
> previous comment =C2=AF\_(=E3=83=84)_/=C2=AF
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1819289
>
> Title:
>   Windows 95 and Windows 98 will not install or run
>
> Status in QEMU:
>   Fix Released
>
> Bug description:
>   The last version of QEMU I have been able to run Windows 95 or Windows
>   98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
>   either not install or will not run 95 or 98 at all. I have tried every
>   combination of options like isapc or no isapc, cpu pentium  or cpu as
>   486. Tried different memory configurations, but they just don't work
>   anymore.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions
>
>

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819289

Title:
  Windows 95 and Windows 98 will not install or run

Status in QEMU:
  Fix Released

Bug description:
  The last version of QEMU I have been able to run Windows 95 or Windows
  98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
  either not install or will not run 95 or 98 at all. I have tried every
  combination of options like isapc or no isapc, cpu pentium  or cpu as
  486. Tried different memory configurations, but they just don't work
  anymore.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions


