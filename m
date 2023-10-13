Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C520B7C8B83
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:39:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLC1-0007Rw-RM; Fri, 13 Oct 2023 12:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLBz-0007RQ-Cn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:39:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLBx-0006oX-4a
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:39:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4054f790190so26272725e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697215151; x=1697819951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMmgl5HPojV2rPup0n0ex4tLV6+N3+6J9boCEQmTWpY=;
 b=lAQLqYElmk9ZMKfbL19cGuiPsEZRRYlyfTYRs0cMiCR6DkmV6Z4jrrG6RTLoS3qeHI
 FxnqZeHWUE9ScKTcT0AAgXgBDRN988K579o2D1ZBInAm1mokULVO5x393I4VsDndc+a0
 +AL8iMXHLmturSKwqQB1RNxLP2spA4P9b4K7YuiMSE9BHbqACHaoFEJSthrVQSBpbTIk
 mq1HUxJDGvMB3dOdLGkzohmKwTFxgJuBXz3gi+jnCvs/W75Hf72/N/19s+6M/vuEyiCH
 DZK81wc06iEHqy56OIEbvf2XAu/5VvpH0PpjJYwiiJOb+8SY5FVw+6gYsK9838fqvtUA
 mpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215151; x=1697819951;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PMmgl5HPojV2rPup0n0ex4tLV6+N3+6J9boCEQmTWpY=;
 b=CRFFpMc79v7jNUxnHJRswepjyh/LgrI07jCAi5pawtbGeqZDZ4pJ+wsWLjKKgFRRkm
 LaQFVjqx6mmqSLwlIQD5jqibC0nNWB71zyriUJ/RVm+xtEm3p6hl/jmkrswfHP9JHnxd
 R/ECxwxlN6vVe30oW1JRFA4xnJ4Q/8l/DCXVLvgsl8nKHbYmRMdjCOviHBEppKEjmMFo
 ZxN7YMyCppfShnYCmBQbcF0nbFlIiQ0Sv+EliWlyoKuDMFqqV+AXi5w7gnot4Fh6ZMML
 l6pUW8JfOA9336vxbkPAA+NpSTDz28I7MVcu43kD50SNUhVRpyPm8tDNBd+1QdPQdnow
 01qA==
X-Gm-Message-State: AOJu0Yxnq2AAXdNy2NkTqZRh/No136BfOuAFkR4nIPv0JhMRhjJVYHb4
 6k4q/rUv/Mfk7l+VqXWo2G+ysQ==
X-Google-Smtp-Source: AGHT+IFh4G/Uld4U9Vpl2HWJotzTZ34gPguvt0eEx5slrSSORJFg31AbyrVFUnQIfCObVLkygupqxw==
X-Received: by 2002:a05:6000:109:b0:321:5d87:5f7c with SMTP id
 o9-20020a056000010900b003215d875f7cmr24108382wrx.30.1697215151571; 
 Fri, 13 Oct 2023 09:39:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f8-20020adfe908000000b0032d8ce46caasm5208868wrm.93.2023.10.13.09.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:39:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C2EAA1FFBB;
 Fri, 13 Oct 2023 17:39:10 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-7-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 06/29] query for registers added
Date: Fri, 13 Oct 2023 17:38:49 +0100
In-reply-to: <20231006090610.26171-7-nicolas.eder@lauterbach.com>
Message-ID: <874jiumq8h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> From: neder <nicolas.eder@lauterbach.com>
>
> ---
>  mcdstub/internals.h    |  55 +++++--
>  mcdstub/mcdstub.c      | 320
> ++++++++++++++++++++++++++++++++++++++---

this doesn't match

>  target/arm/meson.build |   1 +
>  3 files changed, 344 insertions(+), 32 deletions(-)
>
<snip>
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -3,6 +3,7 @@ arm_ss.add(files(
>    'cpu.c',
>    'debug_helper.c',
>    'gdbstub.c',
> +  'mcdstub.c',
>    'helper.c',
>    'vfp_helper.c',
>  ))

this.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

