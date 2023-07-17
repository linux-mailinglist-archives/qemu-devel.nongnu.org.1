Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9267F756D16
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTms-0001L0-GD; Mon, 17 Jul 2023 15:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qLTmo-0001KY-Mr
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:21:34 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qLTmn-0008Qa-8d
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:21:34 -0400
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso7947535e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689621691; x=1692213691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fqurkKmxmhiR0Kl+zTP5dgSmgnSLzRlQ9mPsV/c11g=;
 b=lz7RgSYARJI8H+uebHcTMGIoWaOXUyF/KG/p2/jnYurxU5HtV5dOB+hrNrDQTsH04p
 cxWV3fOVuzvLizkEeayEblPEsgZ7oQQDOmTVufZQfkxQIz9SIw+kuVqjJQfYPYlnSzwg
 RrOkh64Z3aVj1+/adiER14POQqPrOJBD97v3Kx6wHfa3YOwi0JiBfOGmhbFxwiBgc0bP
 vPNpemC/4T9d8RiiUY6PbPwaEDqPHLZrLjLVVkOL4AnJJeMM1wP0qWNmGnX0ioMopRgR
 wnmdKUI24v5ztohD8+cUpn7xhgbyZNE5lXiTwjpZpzCdVSUFEdRxqSJTwQPQHLXSVInM
 fEvQ==
X-Gm-Message-State: ABy/qLZEQ0sjkrxLJO9U+soZaV6JBV3TCwCjZPbcqIkW+wka+0lix9s4
 IwBAJ54M6X0Bm4eE+VrO8syr/2o207PAgqsD
X-Google-Smtp-Source: APBJJlGcepawa3kmUl2scUSD3VGlKw5droNrkpWnJYlRjaGvGfIYU01WiAgnxGQ/VkjGK2E3BmYr7A==
X-Received: by 2002:a05:6512:ad1:b0:4fd:b7fb:c9e9 with SMTP id
 n17-20020a0565120ad100b004fdb7fbc9e9mr3274487lfu.41.1689621690443; 
 Mon, 17 Jul 2023 12:21:30 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46]) by smtp.gmail.com with ESMTPSA id
 ep3-20020a056512484300b004fb895662d8sm53608lfb.84.2023.07.17.12.21.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 12:21:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso7947499e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:21:30 -0700 (PDT)
X-Received: by 2002:a05:651c:120c:b0:2b6:a6e7:5afa with SMTP id
 i12-20020a05651c120c00b002b6a6e75afamr8677613lja.12.1689621690037; Mon, 17
 Jul 2023 12:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
 <874jm2ya3g.fsf@linaro.org> <87sf9mwnzo.fsf@linaro.org>
In-Reply-To: <87sf9mwnzo.fsf@linaro.org>
From: Matt Borgerson <contact@mborgerson.com>
Date: Mon, 17 Jul 2023 12:21:18 -0700
X-Gmail-Original-Message-ID: <CADc=-s46VkRZiU--59VdeTcACoir1srxV=eTxPwwwut_tSJESQ@mail.gmail.com>
Message-ID: <CADc=-s46VkRZiU--59VdeTcACoir1srxV=eTxPwwwut_tSJESQ@mail.gmail.com>
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.44; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f44.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Thanks Alex!


On Mon, Jul 17, 2023 at 8:34=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Matt Borgerson <contact@mborgerson.com> writes:
> >
> >> Translation logic may partially decode an instruction, then abort and
> >> remove the instruction from the TB. This can happen for example when a=
n
> >> instruction spans two pages. In this case, plugins may get an incorrec=
t
> >> result when calling qemu_plugin_tb_n_insns to query for the number of
> >> instructions in the TB. This patch updates plugin_gen_tb_end to set th=
e
> >> final instruction count.
> >
> > For some reason this fails to apply cleanly:
> >
> >   git am ./v2_20230714_contact_plugins_set_final_instruction_count_in_p=
lugin_gen_tb_end.mbx
> >   Applying: plugins: Set final instruction count in plugin_gen_tb_end
> >   error: corrupt patch at line 31
> >   Patch failed at 0001 plugins: Set final instruction count in
> >   plugin_gen_tb_end
>
> I think some newlines crept in, I was able to fix. Queued to
> for-8.1/misc-fixes with the assert added.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

