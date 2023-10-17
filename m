Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C87CC8E3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmyd-0003kO-98; Tue, 17 Oct 2023 12:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsmyU-0003e2-K8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:31:18 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsmyR-0003DU-Uf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:31:18 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso4339759e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697560274; x=1698165074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+FdS2Hh0u1oHoP7gY5vka4xuDTHAmavulQ/v+ehkN0=;
 b=A0XXX37az2stadykGsqhQeQcHJerSDf7kKTiezEH76c+QYgoXPahISNaoTxLQm5Qik
 tVxWLkcXBS5MxMZAKhq3UyPR87eutjUR6Nz/OeHAcsMMKlNnpmgmWFqO4y+fU1UslhJR
 Iz1QJj7Uu3dpASCffEULJ1FyvZ3qr7rKSPpqsddxtE/Ui7xRbuJOLsVJlQ0Cho0v4cfY
 1SE9dPd9WPktPbzK8x0EsLKNHf4lR+Ztqw3ksh89Pqeb3/oR+tNXNlRxQy4e0SuSzuNh
 Fz3nsocifjmlLcml8OREIrbsp6UbljK3cyLx1T4T+JXgTuq8RhbaAeuSsQgB0C3vF1Xr
 cMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697560274; x=1698165074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+FdS2Hh0u1oHoP7gY5vka4xuDTHAmavulQ/v+ehkN0=;
 b=hz2zhFnpKx7zBeNEnZ91WAK5rznL4589Nim65Srr/nrPIYaaH+D8RjJyG8Zmxa4U0y
 vJZQeKhIte0nuzSqD8K6JMXEeoU9hG9jyZwsB4zcOWSJQ2/TdIi+Rtw+UUBkiQ48/KrG
 xP/LMjLIEFEw4cHdep1R7dtcv0iDaQTt/L79t2of+8BBCOL2Kr33YjE7xfv65t2yjsDQ
 BYDnbwUUMTQORroTeMrGBrvBPyXk+1PMWD0p1/UxKde/d/VaqC87eb++XMcqiNybIZuq
 UIttLz7tCPnjtHQsT475hdPwO7O6znrwlCtRS38ms+6g4VUa9GullUNDs1ErfDY/AnFG
 bpiw==
X-Gm-Message-State: AOJu0Ywdee3x+DX/8h5mlkg7fEz5T6+m7+QwUrSRetU/C3VHEwWXv5aa
 ibp1kXM9bVUHGvgW63zf2AF7qw8fHQS/qeUYv7tSXg==
X-Google-Smtp-Source: AGHT+IFxlCKZQlTd2swzFCdWvdgF3E/+IDWcBGY1d77BMdhuT//kwR4M7wfStyg6QDnm702LjYF2EIfiikEVE06Z580=
X-Received: by 2002:a19:e05b:0:b0:504:c83e:322b with SMTP id
 g27-20020a19e05b000000b00504c83e322bmr1849374lfj.38.1697560273932; Tue, 17
 Oct 2023 09:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-2-philmd@linaro.org>
In-Reply-To: <20231012121857.31873-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 17:31:02 +0100
Message-ID: <CAFEAcA_tzc+BE237U1pLZ1JO6KCqLvdbR6LMhZ_0VNC7m73dCQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] hw/pci-host/designware: Declare CPU QOM types using
 DEFINE_TYPES() macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Thu, 12 Oct 2023 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
>
> Remove a pointless structure declaration in "designware.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

