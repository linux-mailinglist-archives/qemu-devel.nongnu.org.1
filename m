Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD77616F1
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGSj-00047k-2t; Tue, 25 Jul 2023 07:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOGSh-00047a-Ci
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:44:19 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOGSe-0000lj-IV
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:44:19 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so8247720e87.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690285454; x=1690890254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHd3VnQsU/rbe6XhcZtRIxMIlyb7sRVEaHAFXfvrBEo=;
 b=cJeAoVHSF3Yw2wmoJYxM4s30ENeTb1IPki/wUv40LNd+seGIFSEeYcjn4CR3nmL1P8
 ejOjv+KQIFZneVTet3m3dsbqCfjCruUWB8IU4TqXnykU+D9MtIBp4Qkg1b0x3DF9ndL7
 3q6cW8lUnlmHUEVckg83hib0J4SKA53OKUkqZiQHMT8Lb6YfEsGQfiwjodc8CtRKa/Nv
 FPXh9qOMogBc5ud0Ru1YJUz2ZeR0twB5BWeGgMYDnkmP9WXrHNsBJ5967UCyzryvSvHO
 cQ5cEgSr5e6Rv5OndF8Lm1JMbMalO+a2L+Yydtowus/tYMXc7NW2AP3crE7ZwTpv5hQz
 pG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690285454; x=1690890254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHd3VnQsU/rbe6XhcZtRIxMIlyb7sRVEaHAFXfvrBEo=;
 b=h6QUULv2JsajgE0JmlioiGyH8OCZzRsVnbRG48gJb/jhvl5HIhZky6A7wznhOW+sbu
 6Xv7o30JiPcv6vgwT4DticZQOop0wP3fJQgiq8TRzU95pVwUR+1CObWFx31XzIl0ycxx
 eGCtQM6XetckKB2LyMkmrvlElU3WFcGtzZ47lCUoIF9zNPdpmUuw7MAot+tLNkQYOkg+
 1EtXtPtVlGA+PWwd8LA9kFreRf8p1LaCvzT1YxK5IAvf0pt5t/P7AAvN6CeeDnnAwz8p
 LEj5ZI+CkDX+8P1LRVW0CF4ibhciFT0Hs1iIVJsCJDOKL2mYhMgZ3D31dEUg4dLYwpZ6
 fzpA==
X-Gm-Message-State: ABy/qLbNrnSBlgtoHQ+5PqTzRLG2PR5ma+fiLVQ44aBxF+u475D+mgNj
 Kdd8TBih25D2kbj4UhpnGUduzX4CgkZBs03cqdYY6Q==
X-Google-Smtp-Source: APBJJlEVuegH7yaMRfSBokft6bTV/d0UboXi3LJIUI/6RJ4h3NAoeb5eOeptvipoFs0BT+qxIs6kWHjLqw/dGFAFUCo=
X-Received: by 2002:a05:6512:128a:b0:4fb:74da:989a with SMTP id
 u10-20020a056512128a00b004fb74da989amr9047392lfs.3.1690285454584; Tue, 25 Jul
 2023 04:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230710111959.637011-1-armbru@redhat.com>
In-Reply-To: <20230710111959.637011-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 12:44:03 +0100
Message-ID: <CAFEAcA98h67hDGeD-2yR2tALH9p0_YcieOcjFN8rRZxnqnp_9A@mail.gmail.com>
Subject: Re: [PULL 0/2] QAPI patches patches for 2023-07-10
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 10 Jul 2023 at 12:21, Markus Armbruster <armbru@redhat.com> wrote:
>
>
> The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:
>
>   Merge tag 'pull-tcg-20230709' of https://gitlab.com/rth7680/qemu into staging (2023-07-09 15:01:43 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-07-10
>
> for you to fetch changes up to fd658a7b8cf1091ae2914655add4511865d7edc0:
>
>   migration.json: Don't use space before colon (2023-07-10 07:47:36 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2023-07-10
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

