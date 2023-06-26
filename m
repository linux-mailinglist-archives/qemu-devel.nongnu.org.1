Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE573DB69
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiWE-00013E-W3; Mon, 26 Jun 2023 05:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDiWB-00012p-QV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDiWA-0000sN-EA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687771697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhmAWT7uZJerclNaWqthTbAc0Vtt93e8ajC09PiYkKs=;
 b=U9RDG9HUmPY9S6GARV4yIwNKzHYIqkzWkGjBxjbZzLwaWfPQXAvrJ/KayxUHP1qjtFWrsW
 gM8RAO0G8/q/0NjzgmzzfvhkXHPgne7CWGjrtLRA6XqFeXBnDwn5BgP+PUvdWz5JONJXpB
 TSeSS9i9aSdWOywfv//Qv/XPQDT7wwU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-FIid0kppOrSOO34pB7mjcA-1; Mon, 26 Jun 2023 05:28:14 -0400
X-MC-Unique: FIid0kppOrSOO34pB7mjcA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-78f229627adso327646241.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687771694; x=1690363694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhmAWT7uZJerclNaWqthTbAc0Vtt93e8ajC09PiYkKs=;
 b=dELVid3Tr/1me9McLctphQ0K89bqa9sMIIAxuPqnhz4K0gKnAQ/39IB5eTp/ydXFY2
 I/+1Nfj7t4pGkZeI8IR4GI/+/zOBESDKHnYdFpEfekLhZQHAJE2+05No9TEbYcMF2/ZX
 XioupgLk2TlT6/yyx9loXtgMI3Wm9tAusXFzfbFqZJI0DVzRCo1q434wCg7UTGelMkP6
 4EecVIBQmrnS/bxOA3qCX8xIyBuHA2NCXYL4GuyZq2fdTWbIQ/hZuYMx4qnetFHQG1eP
 FkWl/4Qi03W1MLyD2mrxfBaL+WeolQExfFsMExYjRV2Bs+EktMbHAcXzdMXnTNjuL8Rf
 +7AA==
X-Gm-Message-State: AC+VfDwSKRIyVRHHXQAWib7CYn/nPDlJx4/WzdfGAk9W4AEDjWuS1Ei7
 6mweuP/9r8B3Nj6NkchYei+fQEnFxGlmea5fAWi0Z8qx66r6cRCN5UIHPd8cn3qvUPAnVS2DMIW
 OBIP5r4Yr0ByfVawtrOZD1iyQBEi7Xa8=
X-Received: by 2002:a05:6102:3025:b0:440:cde6:b37e with SMTP id
 v5-20020a056102302500b00440cde6b37emr9238091vsa.33.1687771694286; 
 Mon, 26 Jun 2023 02:28:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5C+A+R3YqiO/lPzh+z6MFaUIYpxlEcM3hsDjlszNPWV9ujwjLz5ErPz48QlYCC9vCnJNxD6gxHJApQfJMeWlM=
X-Received: by 2002:a05:6102:3025:b0:440:cde6:b37e with SMTP id
 v5-20020a056102302500b00440cde6b37emr9238088vsa.33.1687771694065; Mon, 26 Jun
 2023 02:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230626083317.144746-1-pbonzini@redhat.com>
 <ZJlYbXKwd4SxoaxY@redhat.com>
In-Reply-To: <ZJlYbXKwd4SxoaxY@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Jun 2023 11:27:54 +0200
Message-ID: <CABgObfa2ft-j0CdDyV78awrKu1nowXDSVxeqtQoFG_+qOp=6tw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] target/i386: allow using named CPU modeles with
 user mode emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 26, 2023 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > - for qemu-i386, the issue is that this emulator is restricted to runni=
ng
> >   programs on a 32-bit processor, even though it is actually emulating
> >   programs that use the 32-bit kernel ABI on any processor.  The behavi=
or
> >   the processor in compatibility (32-bit CS, EFER.LMA=3D1) mode is most=
ly
> >   the same as when EFER.LMA=3D0 and the little code that is needed to h=
andle
> >   64-bit ring-0 is even present in the qemu-i386 binary, just hidden
> >   behind checks for HF_LMA_MASK.  So, LM can also be treated as a featu=
re
> >   that is only relevant in kernel mode; not entirely, so this cannot ye=
t
> >   be extended to bsd-user, but the required changes are minimal.
>
> IMHO in this case we should hard block all named CPUs with
> 'lm' set from qemu-i386. It only makes sense to use named CPU
> models that were actually from the 32-bit era with qemu-i386.
>
> If someone wants Nehalem then they should be using qemu-x86_64.
> If someone wants qemu-i386 then they should be using an older
> named CPU model predating 'lm'.

What you write is true for qemu-system-*, but the problem is that
qemu-user binaries are only able to run one ELF target. qemu-x86_64 is
not able to run i386 binaries, unlike a 64-bit kernel; and that's
really intrinsic in the design of qemu-user because implementing
multiple ABIs (including multiple definitions of structs and syscall
numbers) would require compiling the same files multiple times.

Also, when using qemu-i386 on a (non-x86) 32-bit host you really do
not need the performance penalty of 64-on-32 emulation to run 32-bit
binaries.

Paolo


