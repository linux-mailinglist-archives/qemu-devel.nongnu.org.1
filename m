Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69C70520A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywWq-00084x-Ja; Tue, 16 May 2023 11:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pywWi-00084M-KM; Tue, 16 May 2023 11:23:48 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pywWg-0005xQ-QI; Tue, 16 May 2023 11:23:48 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-ba2362d4ea9so10510554276.3; 
 Tue, 16 May 2023 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684250625; x=1686842625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5uAojLvnK0PZ6/mxvHq7LeHYsEaEBfEVJNbZtHOUt9k=;
 b=pUvp8g0DNe1znNqPaDp2eVi3as6YjKS9Dd3T8gbY3AqYU8SYNaXXRU8eqkVvPHRD5K
 5clPXKxm1VFj0v1s1YItLT6Pp1ZDHkfWrob1GSmVd1UM8Mzq9oik+HAsguK5N+jSmrb/
 +/6rqlLlydD3jKxE5pzpuZ8mdheRe/rH/te6sDFE/eH/K6K9RbQXs/BVBRB1dzQKX+lW
 fF+ogQqNQISng1Ca8vvoMu9R+YpG8JE7ujK+yTyfJkOEK1pPRp8zT7//OOcxxyqE7eOv
 YrjNZAX+C0Ua/+gwKyyxcK07NuXAbkvRvxphXaGp5I0GV0+9jDs4G45tLsV1pey4DwJn
 yP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684250625; x=1686842625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5uAojLvnK0PZ6/mxvHq7LeHYsEaEBfEVJNbZtHOUt9k=;
 b=Eh4HTPL37XXTblFVffU9f0cC6m7OJVorXlY4LjKZ9g6sy06jXN+/VYW6iQn8ajY3Ks
 TqZT0sqx5She5uVlArmMo3yLa2jkHRxfLzNbLRRCQJRriQ3JpfB4p3tKaDz09q7QvOpa
 /rbXJOqkxn5JBfu9o/hmmjtpvoaeMSQDTSeHp5884aIhb7kbyA1O7YVHeB6n6A40geH3
 UhvsXDzAuU1Eov3S2vOxqpIYy/kICyMctpsDDCpREIJN8nW0lz4jde4KBEuZhvs7ZkjG
 psHq+PX0fjTkSNFSn1uAch7tJtoFOlMKEVnP0EYFY0hk1l9Ftt8p7MwAjIqK/moko1jN
 3DKg==
X-Gm-Message-State: AC+VfDw6lQ1AddInCyRguiegHTop/9SnlTMFkBwShHx8wrVTW33b6y33
 5dtf6JufhDFU8DjRxFhcvC9Mq2qizKJIcVYxtRc=
X-Google-Smtp-Source: ACHHUZ7dfkiyV/+0sH97zacRbnnyhM3cRBM6fTIallqwj61N+Ui/BxvAJjLe4O8nv763ikV/a9D7hWJl9d2lUN2p2h4=
X-Received: by 2002:a25:cc5:0:b0:b9a:663b:eced with SMTP id
 188-20020a250cc5000000b00b9a663becedmr29000221ybm.36.1684250625310; Tue, 16
 May 2023 08:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230516102016.581877-1-thuth@redhat.com>
 <CAJSP0QUMB51Y_FFx4KozwwDVJAFYmCdHvfEpNz3+aD8r0PmSng@mail.gmail.com>
 <1eb9b297-9a59-1baa-ce9c-123b62861f10@redhat.com>
In-Reply-To: <1eb9b297-9a59-1baa-ce9c-123b62861f10@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 May 2023 11:23:32 -0400
Message-ID: <CAJSP0QV=sqD+Y5gjb7tWJQJoSB8xZ-wgUZjCrV4wrtQN5CKHjA@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Fam Zheng <fam@euphon.net>, 
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=stefanha@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 16 May 2023 at 10:50, Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/05/2023 15.40, Stefan Hajnoczi wrote:
> > On Tue, 16 May 2023 at 06:20, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> We cannot use the generic reentrancy guard in the LSI code, so
> >> we have to manually prevent endless reentrancy here. The problematic
> >> lsi_execute_script() function has already a way to detect whether
> >> too many instructions have been executed - we just have to slightly
> >> change the logic here that it also takes into account if the function
> >> has been called too often in a reentrant way.
> >>
> >> The code in fuzz-lsi53c895a-test.c has been taken from an earlier
> >> patch by Mauro Matteo Cascella.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1563
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   hw/scsi/lsi53c895a.c               |  7 ++++++-
> >>   tests/qtest/fuzz-lsi53c895a-test.c | 33 ++++++++++++++++++++++++++++++
> >>   2 files changed, 39 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> >> index 048436352b..8b34199ab8 100644
> >> --- a/hw/scsi/lsi53c895a.c
> >> +++ b/hw/scsi/lsi53c895a.c
> >> @@ -1134,10 +1134,13 @@ static void lsi_execute_script(LSIState *s)
> >>       uint32_t addr, addr_high;
> >>       int opcode;
> >>       int insn_processed = 0;
> >> +    static int reentrancy_level;
> >> +
> >> +    reentrancy_level++;
> >>
> >>       s->istat1 |= LSI_ISTAT1_SRUN;
> >>   again:
> >> -    if (++insn_processed > LSI_MAX_INSN) {
> >> +    if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
> >
> > Why 8 and not some other number?
>
> It's just a random number which seemed to be a good compromise to me. We
> need at least 2 to be able to boot Linux. And if I add some debug printf and
> use it with the reproducer from the bug ticket, QEMU crashes after it
> reached level 1569. Anything in between should be OK at a first glance, but
> I'd take at least 3 or 4 to be one the safe side for some exotic use cases.
> 8 should really cover all real life cases, I guess. Or what would you suggest?

Please add a comment explaining that 8 is an arbitrary number that
should be sufficient for all legitimate guest drivers.

Thanks,
Stefan

