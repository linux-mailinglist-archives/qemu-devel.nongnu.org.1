Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DC81A63E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 18:25:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG0Ij-000241-EO; Wed, 20 Dec 2023 12:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rG0If-000224-Gl
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:24:05 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rG0Id-0006dG-E4
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:24:04 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3363aa1b7d2so5703283f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703093034; x=1703697834; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sr/KllH0FCv/FTJIN8cKQru6YWz8VFaFkw+ezklVJbM=;
 b=YXh3Bq5VNIdMU/JKNZtqwCqntYuhYXTc4ytJiBy81VaKNR5TeOW2CBwjZl2PlS/obj
 EaIdv1qtH0HELABr6nfRNMZI2bn6ojNwigkioJMaFpKY1yPf+I2H8BA1Pnu0NKzNItT1
 5XsCP6STWV0l/tuT0XblTjq1Z9DpRex9tQ2PNpM75jKW8kBWZT47MWKbN967C/svQqzL
 GOyl6yB7yYeBpVs0I7DztohFBc1vJKIjq0dbyX4yRfvROOllgI1O7t3oo50I4k1sEilu
 5UB0zzVG0s/XREhcK5bv3AvBrk0v6CMKU/TXOmtfNJAhBT9QXBiBd9URNY2zm3wwsKBF
 3XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703093034; x=1703697834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sr/KllH0FCv/FTJIN8cKQru6YWz8VFaFkw+ezklVJbM=;
 b=hxAc+BNofaO9uU4hTFrxGM063cBibEhNmn9EoRuwnRm+X2A4P5LWiHOIyMc4jf7Yje
 wdFIHx0EFwQlZN8o2AwxlMfSVP8izjOm02mR8HrIWnLLnqYH5d3sukyYJXTUKzITQUl4
 GfoCBPxsAWi5joM6mXzca9ZGKDXyJw69CtjgTFxSudIWUHYP42MDhZFtPKNL1MNtLVXI
 1ZIDVD6ezlGqvokw1vH4kZak47JluXeU96M/VlWn2KRpfV4yeR2R21EF6BfEHcnrk25X
 QEkf+OKOVGkshHnVZHflFteUOHtzmGbSuwCNU/jsYcDAIhlM0e2gQ/u0ypHPpUDUuVpE
 y/4A==
X-Gm-Message-State: AOJu0YwakFnMvYcoRckx2BfwJooDQ6QvaOBCibo1KXg05BppuUZKWls4
 7x0p9Oni9VXqt4t9bwISv/afqckAUkER+HZvuRGLug==
X-Google-Smtp-Source: AGHT+IEkKyab+S9YRfMG0MjKhazi6pGxNlVFcxqj4BNG7sVYC5G727HfgLAkc+Zp6CNgF3YvmtjLgnX9O4sKhPkoHaU=
X-Received: by 2002:a5d:4e91:0:b0:336:7db5:8bfd with SMTP id
 e17-20020a5d4e91000000b003367db58bfdmr24651wru.18.1703093034433; Wed, 20 Dec
 2023 09:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
 <20231220160340.GA843272@fedora>
In-Reply-To: <20231220160340.GA843272@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2023 17:23:16 +0000
Message-ID: <CAFEAcA8+Cw5NcH36GSydLyYf9_=CmP5qeyRsTHYyxYXKLEth_A@mail.gmail.com>
Subject: Re: [PULL 00/43] target-arm queue
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

On Wed, 20 Dec 2023 at 16:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

Should be https://wiki.qemu.org/ChangeLog/9.0 :-)

(I have just created that page and the accompanying gitlab milestone.)

-- PMM

