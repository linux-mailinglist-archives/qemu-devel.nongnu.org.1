Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71A7B0482
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTrs-000264-U0; Wed, 27 Sep 2023 08:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlTrk-00025g-6c
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:42:10 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlTrg-00033S-3Q
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:42:07 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50308217223so17479233e87.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695818520; x=1696423320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qc+wsmbxHPuDpxCkR0sIYJ4r+s8VoplG/Wn/SydaYig=;
 b=EcO9eOXk7j3C7SPnYHlm30zs3OvZATGwg+voVXLOq6GVfpHOlZF9CLzCBZnVvE/Lmh
 a721Kj0/INXFHmnpvsDBbneDab6wZMVR3vEoeQqauCg2le4it8DClho8yza/Qf2AgylJ
 zCcCEDOea5CQ+W1M0ANVv8ICcMGfomsJJSkBLd/JK0m+4I5Hk5G+CxjB2VLl4RzsgWbh
 qJq6cDXLR9Ag/KWkOY1vamtp2EfVFhSnTW7FAq8vEoE2eRL2DZe443AzIKzMAUbl+AgB
 858hCI95+wz2q0iPnebXY0OuEX9TusgND9FnX+G48si8eRDFVyUnT/Kqv0yxrWarnnHz
 zCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695818520; x=1696423320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qc+wsmbxHPuDpxCkR0sIYJ4r+s8VoplG/Wn/SydaYig=;
 b=TrloRmLtBKbIUqeW0I8r7kFIMOZXLAkMSjPNMWryyjy9JBRNTPb9lcHK/2cqyw4M1g
 jeT02j1AWlixSc9hAh+nxiRYHXBJwgdQ7BASAPwG6ht47DBw15HVgzPHk8Ci786h3JKp
 16oB6LpJ9fVpPTcCJf5OSSq4Whu9zuZRBesOnmLFe+XcBL1QzXC10932Ni8MfxOxzCsv
 i1bemTC5OyZ7SrBXEEoBfHq/oIlYTjWqGWVClWlwZ99jmCXNeqCuBO1Kk3SSzzQdf8V0
 PUsELQHvileliiq9Q2rdAWLqp+C7wuCTTxphsWzSol4ysHGWQ9Xvn0KQBX1devUgzQe+
 LvOQ==
X-Gm-Message-State: AOJu0Yy/++SRY+JNSFMn+LY6IBq/BA0V8+JCUWDEnKOhQ80sq6DgPx5m
 pZXyX3B8NbnlRB0i3I3FgWMb0cGSPOSV9YIzJAwX7g==
X-Google-Smtp-Source: AGHT+IHLfg3XTotbvAdZ9ywh+UmCd6RbbNriC/KRmoaYxELgG803bGGnZ0gv6Qg7NO1sU09uJFRx5GCbQq6CuAS0T3I=
X-Received: by 2002:a05:6512:33cb:b0:503:33ab:8126 with SMTP id
 d11-20020a05651233cb00b0050333ab8126mr2025328lfg.17.1695818519712; Wed, 27
 Sep 2023 05:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
 <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
 <CAFEAcA85LwsFiBxbDiki6-8FAbmZSFFH7Esf+x8stiPDjww_KA@mail.gmail.com>
 <o4gb5k2pa2h7krwvstec2qdfvrsnzlc2l3q3da476bofdepazf@mzqnyast5uw5>
In-Reply-To: <o4gb5k2pa2h7krwvstec2qdfvrsnzlc2l3q3da476bofdepazf@mzqnyast5uw5>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2023 13:41:41 +0100
Message-ID: <CAFEAcA81BGW46oMiC4u3oB5d+CJrTo-p6R_397-R0fAFaDz3Qw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
To: Eric Blake <eblake@redhat.com>
Cc: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org, kwolf@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 26 Sept 2023 at 20:42, Eric Blake <eblake@redhat.com> wrote:
>
> On Tue, Sep 26, 2023 at 02:46:44PM +0100, Peter Maydell wrote:
> > What did you mean by "we prefer to avoid adding more entries" ?
> > It reads to me like "don't add more entries even if we get more
> > accidental attributed-to-the-list commits" (and I was actually
> > thinking about replying to this patch to say "the mailmap file
> > says we shouldn't add more of these lines"), but presumably since
> > you've reviewed this patch that wasn't the actual intention.
> > Maybe the comment could use clarification.
>
> Indeed, it is meant more along the lines of "because our build process
> was tweaked to warn us in advance of merging more commits that suffer
> from the same problem, we shouldn't be having to continually increase
> the size of this section", or even "if you end up adding a line here,
> please also take the time to figure out what part of our build process
> failed to catch it in advance" (in this particular instance, the
> failure was effectively that we were grepping for 'via qemu-devel',
> not 'via qemu-.*').

I've adjusted the line in the apply-pullreq script:
https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=f9a317392e83c84e4fdfcff554f64da3dfb7907b

Richard, Stefan: you probably want to update your copies.

(I also noticed we have a few commits from 2021 that were
attributed to qemu-ppc@nongnu.org.)

thanks
-- PMM

