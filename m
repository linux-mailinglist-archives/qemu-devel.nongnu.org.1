Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5379A95D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiSu-00014C-Mb; Mon, 11 Sep 2023 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfiSs-00013u-SC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:04:38 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfiSp-0003bm-WB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:04:38 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50079d148aeso7695678e87.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694444671; x=1695049471; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Br4rbb4L130TUG5AzyJUmc52uMMoIeX3SY0EmuxSc/M=;
 b=GiPYnG0y7bcTHP8TMvNFUJYZjVTW5B43I1cmuHdXVJ2AYPf/sDUu5J3OP+FPiKzr/q
 ozgBL8N35Qrn2Hee8Wy9RirVQ1Mw6/onsYh+CmjuqTcDrd//ueVzkX8ml/hRNMJ9D/zZ
 pLcXPkZa32dr6JzIj75qBnV8uTv2eTb2YsSv/i3seLRBSBMrm9YOPf7WIwTH7V3pea7L
 Niazm/Ci70JQ2ifmuJekHX/qLPYxZFZRwXpOOiiXYSjaA9KxR6NiVVzhTaGa6gjwRFW3
 j9SU0EQQ9+ERFp24BHMAzPrF8xGxjepw57gGqQAglq2rO5V68PsEls0obAywzpkDF3BB
 Ionw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694444671; x=1695049471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Br4rbb4L130TUG5AzyJUmc52uMMoIeX3SY0EmuxSc/M=;
 b=WNiUsyFxuiRS6A9bmaljCa86Wh6/oLmIkvmMmbvoaUeCbzg+cUL7Wtir2pY60mlVSs
 dI3+89mZZpMZsKhxaUoe56DhgTQd8j4BjpCUWFIC7orJBuf94N6B9dRcp7PSU7ZAlWP/
 VAYXatcHDnCLpAaw9TAWCpQjQd/O3/yB//ze+UIDgwuXyqUsEZmI70Ti4ol1BUi2zoqj
 Ho5P1Ultymf9cOx4cFM07kHqqPb3A+6A/t2/oMWsIXyUQaCb1YQZWuK9/5WHPnQO/Z7Z
 gvK6EGi1ZV98djM7WZ0NLWTnjUqL2B5SqUI768WxJmr8F+lDSubz/mH0veQ9IaRkIiSz
 3Z4g==
X-Gm-Message-State: AOJu0YxbBO7+vsWk+oxTlpxkP6KJLRhQ3PY/KYV2I+RMM8xw3TlBoUX5
 b220xYzeuHHiQGnM6XaCFcEe/RwaugbeJNorU2+2kA==
X-Google-Smtp-Source: AGHT+IHVv+MaiNRLZ+Q4XOJj0zXZBA5sIcpTQSA7/Bh/2l47jCVWKB+sX1pCShENMnPt4pI1v23AkRg7JXO8wK0zmv0=
X-Received: by 2002:ac2:48b4:0:b0:500:83d0:a0ee with SMTP id
 u20-20020ac248b4000000b0050083d0a0eemr6846371lfg.69.1694444670851; Mon, 11
 Sep 2023 08:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
 <20230911135340.1139553-4-peter.maydell@linaro.org>
 <5d042c96-c5f0-bad6-f0b5-90b9e50e59b9@linaro.org>
In-Reply-To: <5d042c96-c5f0-bad6-f0b5-90b9e50e59b9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:04:19 +0100
Message-ID: <CAFEAcA-n1G770qbXYXUVzLzYFHtMC0e8Y6W1e2R6QuF1buAaug@mail.gmail.com>
Subject: Re: [PATCH 3/7] linux-user/elfload.c: Add missing arm and arm64 hwcap
 values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Mon, 11 Sept 2023 at 15:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> On 11/9/23 15:53, Peter Maydell wrote:
> > Our lists of Arm 32 and 64 bit hwcap values have lagged behind
> > the Linux kernel. Update them to include all the bits defined
> > as of upstream Linux git commit a48fa7efaf1161c1 (in the middle
> > of the kernel 6.6 dev cycle).
> >
> > For 64-bit, we don't yet implement any of the features reported via
> > these hwcap bits.  For 32-bit we do in fact already implement them
> > all; we'll add the code to set them in a subsequent commit.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   linux-user/elfload.c | 44 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 44 insertions(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Why can't we import asm/hwcap.h with update-linux-headers.sh?

Probably no inherent reason, but historically linux-user has
always defined its own versions of target architecture
kernel header values and structures.

-- PMM

