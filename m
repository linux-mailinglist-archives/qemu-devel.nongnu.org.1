Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01D7C804F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDaY-0001JC-BH; Fri, 13 Oct 2023 04:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDaS-0000kp-SK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:32:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDaQ-0006Yb-5T
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:32:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so2700255a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697185916; x=1697790716; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJrOVDaZRMEvY7AVofKMbtOS95sXplJmJD0aoNJu15A=;
 b=fXhFnoUz0o2e5U4sGwMikac5ve5pM+wvcoiNAbybqvTiUoh4eWw4n7BbBYES9x55Xt
 zsJu4UF7dPfycWHLVPkl40lZZsxbss8/qG5mjHydukZFW5HeuhHA02KD/aW8TnYDaXhC
 v7dYWloPQ/KD1UNMNpKwelDXhm/mfn5WhspdkMCaeL/o9WTxYLYodYJ9dV4B05Rl8fpT
 o3s3h2ncE80gRI1DAyPm1Vm/2EUzIRBkPgODE+v2uq6IHvc3zIuRs7UnYrUoaQEXojat
 GCJ746J9+BKLZgpjOkVGeiPjKPRUMcmh2oqYz1tn3s2sZGQSOfJbOgexj6dX0m+ykFbC
 10Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697185916; x=1697790716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJrOVDaZRMEvY7AVofKMbtOS95sXplJmJD0aoNJu15A=;
 b=dF660hP3iVoNmJqWEL1MxxYJQp/qxWR8ReztV9YzDdVs9BL2G/ficZaD8+Lc2Lez52
 opyNax9ybMk0ee2qsjXfTNjKyenA8gOYztwBt9cPPpXEBA/GPreYPsoliOmGEO5Pz5hx
 8K+LIa9QbeoEjj4pC4bitdNEFIEB6DCPF5DZT09KoCrluvO85Gfg35DWhMNQRwP8YLxx
 oC2/M72+/3H5NdDxYYHGHhy9QyoCxfqBFzLCagG6/PjiuTMlwcQO5715BQX0vbwiGrR/
 +6B2TF39AmxGVEc31s2SnQTGZ4UdHEmS40XBDpSwsWaur8FuPn/UXmFdMZMVhi3pw0Oj
 8wMg==
X-Gm-Message-State: AOJu0YzdwvKPOcEaO7DoCMQs9TiEzNulITJcCieZqPxVLr9z8iuypqfv
 sgTwjIDwTyfQ59ULm0ScCHghj7CQB01uYMayk3lBhA==
X-Google-Smtp-Source: AGHT+IEqBAL7107d7AorN1KJr8ugEDu3Ae7KzXo923TRzo9qReKgwIrBVxDMwTz8om8gZPije0Ecoq8Cl6PTkVNnGus=
X-Received: by 2002:a17:906:5381:b0:9ba:321b:80e1 with SMTP id
 g1-20020a170906538100b009ba321b80e1mr10193633ejo.0.1697185916235; Fri, 13 Oct
 2023 01:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183082.git.manos.pitsidianakis@linaro.org>
 <ZSj860T0LVIAzQgs@redhat.com>
In-Reply-To: <ZSj860T0LVIAzQgs@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 13 Oct 2023 11:31:40 +0300
Message-ID: <CAAjaMXYaOQVT0nnky7wy4RUxBt18-e_CSog4g=pTPFDYM0ux1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 13 Oct 2023 at 11:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> This patch (and all the others in the series) have a ridiculously
> large context either side of the change. It makes this horrible
> to review as it requires wading through pages of pre-existing code
> trying to spot the change.
>
> Please send patches with the default git context lines setting.

Many thanks Daniel, I had not noticed at all. Somehow that option
slipped through...

Will reroll the patch series.

