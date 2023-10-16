Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF87CAA79
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsO06-0007Z6-CC; Mon, 16 Oct 2023 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsO04-0007Yd-9Y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:51:16 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsO02-0005Mr-Jf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:51:16 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-57b9cb05fa3so2301549eaf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697464273; x=1698069073; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ob6dP2QOPHWAMPGzD/fFQE8iX0ALddbvfHEUpzAiXTc=;
 b=msh/pdGxMYhzS7aJ1sdruE4nWOUcGm4J7URJZ6bbSMUl8MqKkSnL10eSsSrwpZ6Iwi
 jQze2HT2YFCefcXfx3xG7VmDGqb1im4MzSrDndewmUiJGu41JxNkQp/xWnRBU/KAinHx
 J9A6ZYmUPEqpxFJqXo/zn+PS/Lr2F1BHzLvKqJibwzgDuK36TotkdukzI0UZ4zWCwim3
 Hbg0Q4zZZfPYpi4cKm8UYmYr4clXaP9ClxDdMHuBSjv8dTkdg2uvSHc0HWD9xQnjGXCV
 /FE3ghR0HJAv6murXm75kUE1ZZy4q5ytkXnSFnv3tblnsyIDnMQtIthkym0QZywH5aux
 LAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697464273; x=1698069073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ob6dP2QOPHWAMPGzD/fFQE8iX0ALddbvfHEUpzAiXTc=;
 b=habJWa+S4lSXOpcLaxICaL3EuAP8DX2FybDFv3Wit6TwWodqG2ljcuLNKz7nqCZnbO
 KMqqXSXZwFVcakmcqOIX8DPMMlRXl3lVLwpoCwEkqlITp0gnzglxodQ76cFtft/qZZYe
 OYB1SgqmTMBiyqDqXSdCOcNKn8W8qd9XTVpA89g68usY6c3cYcMulkVsv9uPB64UcRH4
 sas+Yf5iazokYlH9GWFyCxuIla0/vN+I40gIXRAdvhIfizrIdxL5pUnjysbPQmy5x/h8
 FjlqOqrw0iReLa0D6/ylrt99CFK7KFoOHrO2xQODJIwhhT5KkcnBi1CdOcIcX7caakag
 tywg==
X-Gm-Message-State: AOJu0YyzQdN++9ij3fWhOEyZfqIAHw0guOqqZbcRGP1J8AsOLlTVR6lR
 oLtO0OlvEXPDHGOENhpYzPdfQhUnNaE116q0kDo=
X-Google-Smtp-Source: AGHT+IEUyocduW5CKsbmKH6DZMwNFd77JjRSXvm3z7lfxSAZnrTt10qZNXEVmDbT+JJVjowDxpxuhzO+zRZ0+5hJOe0=
X-Received: by 2002:a4a:374a:0:b0:576:b301:a9b1 with SMTP id
 r71-20020a4a374a000000b00576b301a9b1mr5034669oor.0.1697464272878; Mon, 16 Oct
 2023 06:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
 <20231005155448.GA1342722@fedora>
 <bdca3b98-7c22-4732-adfc-dc51c93c5eca@redhat.com>
 <CAAjaMXZb1Les+5Q2uhtpm1dgCm11qfs=Rfcq-6dUvQJj2+HQ3w@mail.gmail.com>
 <60c1bcc0-9b96-4c37-afee-484ffbe40431@redhat.com>
 <ZSz/dxLsHPt2+2XN@redhat.com>
In-Reply-To: <ZSz/dxLsHPt2+2XN@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Oct 2023 09:51:00 -0400
Message-ID: <CAJSP0QVX5CGjUrCTg6XSPwB_NAZh7Qh_p+e4R3Sx-20t1O9LxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tyler Fanelli <tfanelli@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, 
 philmd@linaro.org, marcandre.lureau@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 16 Oct 2023 at 05:17, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 13, 2023 at 02:20:16PM -0400, Tyler Fanelli wrote:
> > Hi Manos,
> >
> > Thanks for the heads up, I was using rust 1.71.1. Will update the serie=
s
> > with 1.72.1
> >
> > Stefan, Philippe, or Daniel: is there a specific policy for the Rust ve=
rsion
> > we should be developing on for crates in qemu?
>
> There are a couple of dimensions to this.
>
> First is the matter of what operating system and architecture pairs are
> supported as targets for the Rust toolchain, and the standard library.
> We'll need both to work of course.
>
> Second there is the matter of what versions of Rust are shipped in the
> various operating systems currently.
>
> In a previous discussion there was a wiki page fleshed out with this
> info:
>
>    https://wiki.qemu.org/RustInQemu
>
> but the min versions are certainly out of date now.
>
> Third there is the question of whether distros have facility for pulling
> in newer toolchain versions, and if so should we be willing to use them.
> This is relevant for the long life distros like RHEL, which might ship
> with a variety of Rust versions. Historically we've been very conservativ=
e
> but with Python last year we adopted a more aggressive policy of being
> willing to take any newer version available from the distro vendor, not
> merely the oldest baseline. I suspect we'll want a similar approach with
> rust.
>
> Anyhow, I think you could probably start by updatnig that RustInQemu
> wiki page so that it reflects the current state of the world in terms
> of support tiers and versions.

I have two specific scenarios in mind that should build successfully:
1. On the oldest operating system version supported by QEMU where Rust
code previously built successfully. In other words, once QEMU Rust
code starts building, it keeps building on that operating system
version with the distro's Rust toolchain until QEMU increases the
minimum supported distro version. The rationale here is for both
end-users that build from source and for distro packagers to be able
to build QEMU easily.
2. On the latest Rust stable toolchain from rustup. The rationale is
that developers often use rustup instead of the distro toolchain, so
it's nice to support it as a convenience.

Stefan

