Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C097358A0
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEy4-0003jt-7K; Mon, 19 Jun 2023 09:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEy0-0003hq-3Y
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:30:48 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBExx-0001Xl-Ts
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:30:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so5029311a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687181444; x=1689773444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZupHGQB0s4VQQIw/O1fdK78rXvz8PP/sVJ/YPb0+Eo=;
 b=KPQXULVOrbgQ78lJpiyTOnDojuKcOOmNcnly4X0iRAChVhMzgurD9h8hy6X38yykog
 /NbFJ03D373z4aT8kvlv6JV3ZAn0RixuMvX6sFamwkSaH1En+5AgDYHogBtjkjBUL7kO
 2wvki7rWAej58frlLy5QIa0vT9qesesho0sY86b5ldBdalfWVhUj7J120lxCLO2kb17s
 wMRmIS491icBVjzRD7Ua1tCWC8VoxEpSYgLWJGrXe86a8SRf+zvMmk2M43Twxfnq8wmn
 Yp97ncq1fDo9NpWOoN34w3Z9oX8GQBZEcrV+q8BFzh5xnwp/jswLvQlg9E8IPZqgbX9B
 VUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687181444; x=1689773444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZupHGQB0s4VQQIw/O1fdK78rXvz8PP/sVJ/YPb0+Eo=;
 b=EAjvEH06UwDGTgm/zYdNk9tfuBFZ/kmNz+ja3+GHRU3/erg4jl2hRGH6EGLnVZlpUt
 hHFYmXpl6dCBabXn5Sr+90WwEfzmOEZice0lB82qZHg1aJycEUOV8EOePvmhd+8CrHYQ
 dlZCJ8BLA/pNhRb46bgKeUqBpKqjhk10cKZbVKMg5pT4HDApgjTPUWh0RtzBC5VSQc4O
 Cec1tV1aBIlW4sJ9Q53LCptipB28eJKn4KDV4kRm0DJeDSp2VqqXJbgb4/9y/8Rir5qQ
 +S1uMKZ4VH0ZmXzwq8EakOIquNvzVM9zBqc3sYzAasX4sW6fXyNYnbqMDU8kqbPBKNES
 iwwQ==
X-Gm-Message-State: AC+VfDwbjV+AWa9Ddjn2RmttstF8HOPwyQ8kPtnVbdN6qK8P3rwWRVNK
 I5P0nSL1xMiZ10D4jjHTaXVgclO5OHMX7InfSTLh/w==
X-Google-Smtp-Source: ACHHUZ44t+glto9bzG9zUfpQf0QVe3yD0u9ckQXrkDdJ8O4wGCGtgiq3RnEIL2xSFwVn0ui06/kDIPf/0hvwwgQIFj0=
X-Received: by 2002:aa7:d65a:0:b0:51a:2ca4:5758 with SMTP id
 v26-20020aa7d65a000000b0051a2ca45758mr6557733edr.8.1687181444351; Mon, 19 Jun
 2023 06:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230612223456.33824-1-philmd@linaro.org>
 <20230612223456.33824-5-philmd@linaro.org>
In-Reply-To: <20230612223456.33824-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 14:30:33 +0100
Message-ID: <CAFEAcA8_uZ7kLbHP_Lm755RwJYWurQez5fhRiFL_=7s+JzrrKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/4] hw/misc/bcm2835_property: Handle CORE_CLK_ID
 firmware property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 12 Jun 2023 at 23:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Sergey Kambalin <sergey.kambalin@auriga.com>
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
> [PMD: Split from bigger patch: 3/4]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> TOCHECK: seems raspi3-specific freq. Use a per-soc freq? Good enough for =
now?

Seems like 'good enough for now' to me. We can add a comment:

+/*
+ * TODO: this is really SoC-specific; we might want to
+ * set it per-SoC if it turns out any guests care.
+ */

-- PMM

