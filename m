Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287578373C7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:31:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS0vs-0002aa-Ce; Mon, 22 Jan 2024 15:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bugaevc@gmail.com>)
 id 1rRyx5-0000Xd-9S; Mon, 22 Jan 2024 13:23:19 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bugaevc@gmail.com>)
 id 1rRyx3-0003PD-NE; Mon, 22 Jan 2024 13:23:19 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2046c724383so1137057fac.1; 
 Mon, 22 Jan 2024 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705947796; x=1706552596; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TmwHmnOhISs71aSrcCBz5bcG+VwDO7652AAuKwae3A=;
 b=C/5NdNIzKOVtlUY5i1okN9Bx9uj06xIY673yhr5DC9CwDfCVuWXPSa54siF5vFVFzh
 rKpHV2U1499qHTRxuDQ/OJyPCQjT4tB0hPX+vbBvR1OL4leH7QB3ULWy0JYaehYRC5/0
 WIR1uGPCSkXHyHQvL56fN/1iRL6wrkVj9OWsl5jhbVvQdIgY/xqhvCdCVnbhtG+LSg3D
 W0bBHBGqUx5wsv1hHjqh33cIvAwWK6yBzw1D5sl7Y5HbErFTN1VGrwhE7W6XDEA3w/Sj
 QeazFNPS0ouJfrvH4Docz0LewpWw5wWxsY5JErinDCIZN3uwImDS72G5wnvrFcjP2cpG
 0IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705947796; x=1706552596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TmwHmnOhISs71aSrcCBz5bcG+VwDO7652AAuKwae3A=;
 b=Ad91Z6VOFGy6DcJkRcaXiz7nKsht2fr6EpYYBBNYk6NYxRm/N2jkvXY1DD7jjGp9YF
 8V5iNgknEtLCZQJ9xQ8rYaJAxUL1vL9/dKhthQ2y5HPQ3yrMEsYnaxmJSTYR8udcJ/L1
 SKr4MkbzVCn3SjBEWk5YSXK/SA4ajLUxTnFDX40v5EzOhMceDVYcgt5Js35CecB0ngz4
 839Eyhqpa/sFP70JZ6rOD+seL69O+5jaPFWmvUI7a0Z4FKaUnQyXu10XARg2DUXjBHrN
 eUelLo0v16Q8Qe0kihvhyvNowpoQhxNGieA5jvhm79PwMImA1mUlczXBzeqKFTsHgQYu
 VHFw==
X-Gm-Message-State: AOJu0YySiUi/AA2sCgVQL/xA4cQQDSvsG36Uzr9lKy22PMMEpq1eRLBB
 dKZDGWEqOrqvFU6rgg6B514acXdzmH1ojvhxdBsSOimj3NQp/q0YWuLluiIRMWAv8DJYhZN/WTk
 p0nnDDMjrX3qrn5bZao2rRykd8so=
X-Google-Smtp-Source: AGHT+IGJSzAxA13sM1Kh1MsArD9uuRPZoXE5RSBhzBPbjGsKhaqJ7NwwlTXqoNTiU4IFKKi/gnP/FVs7+9TYxl2Om4Q=
X-Received: by 2002:a05:6871:722:b0:210:a3e9:3bca with SMTP id
 f34-20020a056871072200b00210a3e93bcamr309169oap.98.1705947795726; Mon, 22 Jan
 2024 10:23:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
 <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
In-Reply-To: <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
From: Sergey Bugaev <bugaevc@gmail.com>
Date: Mon, 22 Jan 2024 21:23:04 +0300
Message-ID: <CAN9u=Hd7rnsE4XMvhTOQD0F3gBZ68L3kUvHphQjEKnnsY0iDrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Avoid conflicting types for 'copy_file_range'
To: Peter Maydell <peter.maydell@linaro.org>,
 Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, 
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=bugaevc@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jan 2024 15:30:10 -0500
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

Hello,

On Mon, Jan 22, 2024 at 8:05=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 18 Jan 2024 at 16:03, Manolo de Medici <manolodemedici@gmail.com>=
 wrote:
> >
> > Compilation fails on systems where copy_file_range is already defined a=
s a
> > stub.
>
> What do you mean by "stub" here ? If the system headers define
> a prototype for the function, I would have expected the
> meson check to set HAVE_COPY_FILE_RANGE, and then this
> function doesn't get defined at all. That is, the prototype
> mismatch shouldn't matter because if the prototype exists we
> use the libc function, and if it doesn't then we use our version.

Let me answer :)

glibc has this stubs mechanism: a function can be declared in the
system headers, but only implemented as a stub that always fails with
ENOSYS (or some such). You get a linker warning at link time if you
call such a function. For example on GNU/Linux, remove(2) is a stub,
and if I try to use it, the code does compile, but I get

/usr/bin/ld: /tmp/ccLCnRnW.o: in function `main':
demo.c:(.text+0xa): warning: revoke is not implemented and will always fail

during linking. This is done by embedding a
'.gnu.warning.function-name' section inside libc.so (try readelf
--wide --section-headers /lib64/libc.so.6 | grep warning). You can
also find the list of stubs in the gnu/stubs.h header, which contains
definitions like __stub_revoke.

Meson's has_function() knows about this mechanism, and returns false
if the function is declared, but is actually just a stub (by looking
for "__stub_{func}" being defined); autoconf does, too. But as the
prototype is still declared (and the function technically exists, too,
even if it's a stub), you'll get errors if you define the same
function incompatibly yourself.

Sergey

