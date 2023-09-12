Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A129879D314
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:02:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3x8-0005sw-UC; Tue, 12 Sep 2023 10:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg3wt-0005qw-Vc; Tue, 12 Sep 2023 10:01:04 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg3wr-00033g-R6; Tue, 12 Sep 2023 10:01:03 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3aa1446066aso3881226b6e.1; 
 Tue, 12 Sep 2023 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694527258; x=1695132058; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6VNrOlTbRQ8r/IqS0kHMTPARGr9ZW04VY49rjvJqiqo=;
 b=EiV6RQyszaa+vEz/cTkPVMapmqJ8MkwmqjSF/8Cu5Wk4QXrMoCdTrhjT1l0q6ZcSoX
 oqIYWipOWQCKqEOoW8og1psSLiO2O5w62vawUNwtkNpJ2yPoZB8gpCx1kMnK6omSML0Z
 5Wv/g02ZKSo/g7DVmHKnwhNMSxe1tQni71TcwlTbfgcarAPQXlucDFY7tDfZQQkPMUAp
 TLtxfMiUYBjhv11Aa7YVm8UY2bZcKBDV3ahXnHkFMNLl7EmSHpcdiQPsrph0oSq7LLcq
 5FTjWmSN4FwDO440d98SrctDaTa+hnGpjIRdyo0l1hLKatMbdk06c9cbjsSolFMN/uS4
 fH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527258; x=1695132058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6VNrOlTbRQ8r/IqS0kHMTPARGr9ZW04VY49rjvJqiqo=;
 b=fUm9w0DgqbKt7QAvDRs8ZN5KMpPR2l8Tfq00qQ4Z/+nrSaVGciheiEevi1q4x1vDWJ
 kV6/mhLRuuF+B/SPrkIrR77GtmxbwNZBsstP62Sskcj/bLaUBi9hRQS7hMJCjQYQ5kaJ
 l9SLg1+27282JC3HXuKwiTXxuAg9syOmSGzisbhhQV0v9NWZegm/ds83K9GjSHxai+tN
 j2Ze6PdgVRaEgElTHhuYJafc6frgL8Tnf90xYg/3Sp3O8mYqsJaizFXdM7msZkjbrT1b
 0mC8jEU3WtMpXM6Z7YvRe4YRW6UykD0KCA1s7HP+Cmw4qO8wNiyIXKzUmAro/mrsTiar
 WJkw==
X-Gm-Message-State: AOJu0YwpK2SpIt/TcJNnG5lB81irp0gpVu4S6dA579uBc+yKnW4FceDn
 LMW6bpzrq2bIXKaPxSphw9YRe/Qt7yCl94lVNHk=
X-Google-Smtp-Source: AGHT+IEog0SDpNXWp5JvoromWCYMwxKym5LWkyNIwbVQypC+cUpeDHSCT9kQkwOcAK3LlL+1jY+48ED11sDZ9H+ZZQM=
X-Received: by 2002:a05:6870:e0c6:b0:1bf:d8a:b5bf with SMTP id
 a6-20020a056870e0c600b001bf0d8ab5bfmr16229954oab.36.1694527258512; Tue, 12
 Sep 2023 07:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
In-Reply-To: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 10:00:46 -0400
Message-ID: <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
Subject: Re: cherry-picking something to -stable which might require other
 changes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, 
 Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng@tinylab.org>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22d.google.com
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

When I backport patches into RHEL, the general process I follow is:
1. For context conflicts, just adjust the patch to resolve them.
2. For real dependencies, backport the dependencies, if possible.
3. If backporting the dependencies is not possible, think of a
downstream-only solution. This should be rare.

People make different backporting decisions (just like structuring
patch series). It can be a matter of taste.

Stefan

