Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCBA737370
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 20:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBfft-0004ZJ-Cg; Tue, 20 Jun 2023 14:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBffd-0004Yy-Dh
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 14:01:37 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBffa-0007OR-K4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 14:01:36 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f6283d0d84so6761510e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687284093; x=1689876093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G8CpDD/DJ1qzaiVbhWk5ocDQkWeitlOuSjDGc1u0z0M=;
 b=f/trkmekoe4H4MiPz8CA1EPQkwp5oH1j1seulQDft3kiH1fBtRqbYHZERu4VvjlZKC
 FemoojRFtEQUq1Dafb+fWfnNjXtvnFHaGSu6Nm1KG5a9J/UB6P15AapYc2sNUAjm5pzU
 PPgufikBsN+MTv1WQuRuf2636hn2228b61SjFL+R0qoBKLHoP/RPdthmV6hsFDGWSmnR
 xAGHOGa6bQ/Lp6UfJsNwhnrw3yTT5kFMrwUs+uVxKo54IErUajNj1l0+IrAeNH13SmEa
 hRyS1c3v6zbPfESXWy8WTuHvzlUgaOXez8vJsXxgc/QrkQthHq9HxryzlFjw2TUE7LVK
 xLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687284093; x=1689876093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G8CpDD/DJ1qzaiVbhWk5ocDQkWeitlOuSjDGc1u0z0M=;
 b=KQhbT9eGbVsyL++NTmqDSchgqHBEdzXjAbbqRQgpG5DoqHBOWviiCMi2lYmcKhHcJ7
 qeqcq1SH8/Rz2dKLqcHAo9G2En7Udz05OUIsSBn6CqohrKzcTdUPURSuQ88LdEMWRC/I
 o+Zu3dYaCya6GH66HZveVtC2Te9WYSIMUNwTW9VnL1llPPHaDNo76wEMsRCydu8RYCAi
 kCyb5lJx7YTeqUM0+ZvL9NDg2t2BO2A5Z57gQ9g0wIqg6RxS87+vG6+ujBZO98xLh7Vo
 Czw2mKJQhvbz7kqEKW6+tAiXhyF4C2R83Ngg3GvfcyuYHmznzOBmMYgTugL6Ll9ydv7r
 eB6Q==
X-Gm-Message-State: AC+VfDzNKUD0UDeBbH5KyMz8845atb+hS3jw1V+VVOv7VDHp+oKvnxuE
 zC8enqU+xZuatZmFq9Cv1E1Uif/rhOIsw/14AA8oDg==
X-Google-Smtp-Source: ACHHUZ6NoRY5nJePrewvELnMaJhmy33cX8epA3V6fgcCX6Tr0PgdS/mfK5gbiezj2Q9oPB/cqRUFDjYUqe4Mpxe9rC8=
X-Received: by 2002:a19:3807:0:b0:4f6:6b:a43b with SMTP id
 f7-20020a193807000000b004f6006ba43bmr7763357lfa.52.1687284092672; 
 Tue, 20 Jun 2023 11:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
 <20230605201548.1596865-50-richard.henderson@linaro.org>
In-Reply-To: <20230605201548.1596865-50-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 19:01:21 +0100
Message-ID: <CAFEAcA92u+N2Vo8+GN_DutdqDeen0VDAe1=b8vTRNnpEUELodg@mail.gmail.com>
Subject: Re: [PULL 49/52] exec/poison: Do not poison CONFIG_SOFTMMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Mon, 5 Jun 2023 at 21:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If CONFIG_USER_ONLY is ok generically, so is CONFIG_SOFTMMU,
> because they are exactly opposite.

This isn't quite right. CONFIG_USER_ONLY is theoretically
something we should poison, because it's unsafe in the general
case to use it in compiled-once source files. But in practice
we make quite a lot of use of it in "we know this specific
use of it is OK" situations, like ifdeffing out function
prototypes. So we'd like to poison it, but we can't poison
it without a huge amoun of refactoring which isn't really
worth the effort.

So it's not a good model for "therefore it's OK not to poison
CONFIG_SOFTMMU" -- we should leave that poisoned if we can,
so we don't introduce either new buggy uses of CONFIG_SOFTMMU,
or new "we know this is safe" uses of it which will make
it difficult to put it back into the poison-list later...

thanks
-- PMM

