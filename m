Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4760838D14
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:12:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEhg-000524-Kr; Tue, 23 Jan 2024 06:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSEhS-0004p5-EE
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:12:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSEhP-0004dJ-Ev
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706008330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6aq/Ijjh/vnlChJ/HoevxoLFpiIHA5IftpWu5u9MMA=;
 b=es9nLopeO5R08KgAFbp1Tg+v0zowinHBXvaACKvc6YtWbVbFCj32r8MUW7fqUQnKwNsw16
 p0ZpoFSR2+tNHfJs46gBVCtOjXcCz3EyqPWfcGb4xH02ZfnMiAVpUSazyz6kwCjtoLr/cv
 vqTCQO6n7vRxcHbuyTfBvEe6RKKqfjk=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-jb18HG9tMmej7bqRWK40uw-1; Tue, 23 Jan 2024 06:12:08 -0500
X-MC-Unique: jb18HG9tMmej7bqRWK40uw-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7d2dfa4c664so1489498241.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706008328; x=1706613128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6aq/Ijjh/vnlChJ/HoevxoLFpiIHA5IftpWu5u9MMA=;
 b=H+m1XpWSF0WSE35DaR54MiRoleOg+2NOSAyuV5fbs51SfVX/sVvLcQYwqN3/XmiqQk
 nG21wG3ok+O9wy1UkXnGDpSGrFGda2DS1zHU9lB9C5Jm5yFzzaBKzKWpagyFpl4+XstA
 jgZYfNl/pzL49b06aoXvGfXzhbFMIu4wqhkdeF7s/3ycnEyLKNQfoTSb5R683+RFCpvp
 4ebYcZG3EjFjoowOS56+wi2X7ortoSIlzUsQ/yMRZwCbpNzNeyza2S+tFsnl/81gx0P/
 lIxQiMj0Xg4enPvmAL6x/ZSc2MfKSSiD5F6T1k50V5QA+9L2LozXXZYeISltnsWw6He/
 NRmg==
X-Gm-Message-State: AOJu0YxUmQvDnflpYcV2TMnfkqYnRn/oBY2MLJ8wrTp0E4ftyLTodI+P
 +qfmpKSqRq8ty1EswlWljlNzjCUZuQnk5DXxyn8M54e5EvnyLBRycyL4tMKbnG+jC6jdT/HrEjo
 uDZfqikabwI2ckKdTT8stRoHIQKUxaOgbeFYSo6GzufhcPoDCbbHrJMvPWKismnbB0jceelEoxx
 NNu/ROVglqptFnLEUd6ac5ZcB/Esg=
X-Received: by 2002:a05:6102:160f:b0:469:b0b2:2150 with SMTP id
 cu15-20020a056102160f00b00469b0b22150mr2373442vsb.3.1706008328303; 
 Tue, 23 Jan 2024 03:12:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAgo/FhbAsuYBwQsX1N/zLAYfJ3s0pVdHpQOi6C/ENsBzO0zJRGKdxoW4a5gzx2RDfLJcpWDOMBgEEAFxZgnE=
X-Received: by 2002:a05:6102:160f:b0:469:b0b2:2150 with SMTP id
 cu15-20020a056102160f00b00469b0b22150mr2373434vsb.3.1706008328055; Tue, 23
 Jan 2024 03:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20231222175951.172669-1-pbonzini@redhat.com>
 <20231222175951.172669-2-pbonzini@redhat.com>
 <4f419058-fda4-4101-8787-167056ddbf33@tls.msk.ru>
In-Reply-To: <4f419058-fda4-4101-8787-167056ddbf33@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Jan 2024 12:11:55 +0100
Message-ID: <CABgObfZN0ZLoHijRwPWZ7pxKh=_fON8me4enVAWrtGBQ=vUMCw@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/i386: mask high bits of CR3 in 32-bit mode
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 18, 2024 at 9:04=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 22.12.2023 20:59, Paolo Bonzini:
> > CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
> > paging or PAE paging).  Do this in mmu_translate() to remove
> > the last where get_physical_address() meaningfully drops the high
> > bits of the address.
> >
> > Cc: qemu-stable@nongnu.org
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates=
", 2022-10-18)
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Ping?
>
> Can we get this patch set to master before Jan-27?

I have to test and send a new version, and had to spend some of my
precious TCG time on the PCREL regressions. :(


Paolo


