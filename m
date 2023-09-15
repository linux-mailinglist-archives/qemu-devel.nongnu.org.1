Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E07A2453
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCKb-00012U-If; Fri, 15 Sep 2023 13:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qhCKV-00011R-Fi
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:10:07 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qhCKS-00022V-Le
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:10:07 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bdacc5ed66so1294811a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694797803; x=1695402603; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDdn3611HSw8poly4seHNvUveHpcRhKefTwKphbLwqM=;
 b=JYIJWRFGwsymN40Mx1ZVXX6pZSheKI+FTicNriJQBBLxglcbs9rEJjwwtQI2hVa32S
 cFW1wv/SllPS4l3coO2phhE2Rvis7bd98RMPrn5vcIe7MWVMRFxHg0gvHOolnWz6RYgs
 yXOYPSiFge2PYIMm0ijHuN5x5EDSsZAi8fkI33/R8JveBlu4W+sKyKMvn9UAE/x0AvQK
 sNWDUCeocZvgQlPHt4K82LfDU1O3UGUwHpfgZMlwKeKx4zNfnuTEy1kbIw/xjhejWUNL
 /9yf80O5SnEcoFLr4qPVIXrEPRWQm5i+xoo8PEcC1tJ1l78Yz1HzQHKKcrjlv4QMr2vR
 BSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797803; x=1695402603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDdn3611HSw8poly4seHNvUveHpcRhKefTwKphbLwqM=;
 b=UWpOfDSfwubGanFm4MO+A+l9jjkM5Xy/Zxq8OL8HHu9/S3jfFSazgN05o0BBgGeLj/
 i5vuDssTEYx3GPH0+A0b7VOVD7RG29XXtgGvUIK+2tYFh7akpz2bvqQLZLElpc2A4M3P
 pdzx/PXCgpn6hGuBG5RG2cARcGxEszIzQN9JXn64FOgrzIEitQRqhQ/D+guEqnjct/+E
 6aqWLFgqvhdqg3Nue5KuYi92nLZgYMow6c6ji5UEAFNzXp++O9Vq1/tkpHjUogDnVz1n
 vywEkhwY/xilyfQGR/Cmu3IlzTF30gnE5aArN4I01WjiDPEhQlp6s8kSnd48xilElkpU
 Qimw==
X-Gm-Message-State: AOJu0YzqxKoRAZHwc3Q1YuS3rvAXjR3hVXAM/NMpyt3Ly0hJikehdCZl
 HvQObqVkXp4bi2ely2u3Ua1sIltT4zSyl+Nu3flyGxNR
X-Google-Smtp-Source: AGHT+IEbxqhb+nSSkGm1GnciPyWIz014+Z5dW7NoO567O3mYuhtGcXVC5STplxxFXc/Uu6+4EYsA8i2U5DSHV5SpDfg=
X-Received: by 2002:a05:6830:3188:b0:6be:f8fc:8207 with SMTP id
 p8-20020a056830318800b006bef8fc8207mr3418566ots.17.1694797803005; Fri, 15 Sep
 2023 10:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230914175835.382972-1-tfanelli@redhat.com>
 <ZQQplEOUE2GhBL07@redhat.com>
 <CAFEAcA-DnH4oQ5kUioTiQr7COEbAqCKdkDPkBS0iJ3XUrKzOLw@mail.gmail.com>
In-Reply-To: <CAFEAcA-DnH4oQ5kUioTiQr7COEbAqCKdkDPkBS0iJ3XUrKzOLw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 15 Sep 2023 13:09:50 -0400
Message-ID: <CAJSP0QWprJhr_yiTLBuJ+aPDsanFdO-CfaTvoti-KT5V2kRK8g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com,
 mtosatti@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32a.google.com
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

On Fri, 15 Sept 2023 at 09:50, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Fri, 15 Sept 2023 at 10:54, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > My summary, is that I'd personally be in favour of opening the door
> > to Rust code as a mandatory pre-requisite for QEMU, at the very least
> > for system emulators. Not because this particular series is compelling,
> > but because I think Rust could be more beneficial to QEMU over the long
> > term than we expect. In terms of consuming it though, if we're going
> > to replace existing QEMU functionality, then I think we need to bundle
> > the Rust code and natively integrate it into the build system, as we
> > have recently started doing with our python deps, to detach ourselves
> > from the limits of what distros ship.
>
> I'm not against this, but there is a fair amount of work here
> in figuring out how exactly to integrate Rust components
> into the build system, questions like what our minimum required
> rust version would be, liasing with downstream distros to
> check that what we're proposing isn't a nightmare for them
> to package, etc.

Those details are similar to what librsvg2, libblkio, and other
libraries (like the sev crate in this patch series) have had to solve.

libblkio uses meson as the build system and has C tests that cover the
C API. Cargo is still used to build the Rust code. It is possible to
integrate the two and I think QEMU could take that approach. It's a
little ugly to glue together the two build systems, but it has been
shown to work.

Finding the minimum Rust version across QEMU's support matrix is doable.

Stefan

