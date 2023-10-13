Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346E7C7FFD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD7p-0006wQ-B4; Fri, 13 Oct 2023 04:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1qrD7M-0006pP-7M
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:01:59 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1qrD7K-0008Hl-Qd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:01:55 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5aa0c64ef2fso385485a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184110; x=1697788910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjJyt9wPYbShF6kdsQPvRH+Kdx9xjsbLI3R14Xj1NOc=;
 b=ia/c225sqDia7VibOHvwgJ/zy1jVzVegjmNW2p8oUcU4lwYnW2ViXIPl/UIzVClHDw
 shvg+Vc897MBOM2f6qNpzqoK4O07nr8UmG4VVuRyT0RaGNU5Secb+EqNiIcDD+wgFh7L
 r6E/9p6z/5kQevwLqHQCsPoraoaaul+bq2/VkLG1t065cCeaG6d0y50oacccoflGkAMA
 MPLuew5WC8CHSpPDHyFfR5/7p3nPsVJGbeJfeMPo7bV5DsZ6j83uHDypSM1g8UguD3VF
 fC6aI2CjmgEY6P8AnLai35QpNw3LTHeja5VixddE/gRzfXFIvvAdsReqHt/3rTtN3m4i
 zz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184110; x=1697788910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjJyt9wPYbShF6kdsQPvRH+Kdx9xjsbLI3R14Xj1NOc=;
 b=RDt6Ic2Ju7D93UtVVztmZQv2eiHueOnxyhAZj+tiMQaLBO0Z5PRDZfzyRauN2xWvTo
 EDk9NurbMh1QV4XKvvTZpU3CCWT2JmCaB+wUB4Qt/Q5PseOyJJmWV3PcF5vC+nLqXTAJ
 R2tan1SIsu7etBl6z35+oM41HbUwlbD57VEuJIRLTK8+I4X9Zg5WKsoV7a4IFERah9Qy
 zlxKWn8kiVvmsJWrawW77/IQgNXHyIYMM1K77OBvh106W6KnVe0PXNV2IQXed81Drzwy
 63GDzucZLPotPIJIiS2FYJojXMkhwG+g1a8nH3DYu92ZTnQT/+hS6kPtMy2+9tuYjt/1
 uY4Q==
X-Gm-Message-State: AOJu0YyHoiNLBMVaqVGqudx+8p22ZQynyFqptnomaMYn8hwgbGMewJit
 y10EYe/Tpxd3JLGgmNmIAIAqblzybS/yLAmdsJPvAzyE
X-Google-Smtp-Source: AGHT+IHPAkObuehT/txqYsUTUv2mSXisD6MdsUEN9C8dtBcOvY8pAcxjTvIDRcJOvZPlpODUO+hZ+7uNGLp63MMohwk=
X-Received: by 2002:a05:6a20:f395:b0:16b:c62d:876 with SMTP id
 qr21-20020a056a20f39500b0016bc62d0876mr15342672pzb.23.1697184110536; Fri, 13
 Oct 2023 01:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <390bd7d2c57e0ab48dad854c7dd44037a3fe31c4.1697183699.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <390bd7d2c57e0ab48dad854c7dd44037a3fe31c4.1697183699.git.manos.pitsidianakis@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 13 Oct 2023 01:01:39 -0700
Message-ID: <CAMo8BfJpbJk32pS8Fn6LF6+rFtH+gU894-WoK7TpJ1v2O52B4w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 31/78] target/xtensa: add fallthrough pseudo-keyword
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Oct 13, 2023 at 12:58=E2=80=AFAM Emmanouil Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  target/xtensa/op_helper.c | 8 ++++----
>  target/xtensa/translate.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

