Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C57D97B1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLnV-0005hG-TC; Fri, 27 Oct 2023 08:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLnR-0005cr-Oy
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:18:37 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLnP-0007EJ-Uo
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:18:37 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so3144871a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698409114; x=1699013914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJHAFGdNUhuVw/PfxoTbIpKdsSQ1dyoiqDNoqW7Fazk=;
 b=kPJlyFGLzeuUvOSEY7KGuHHM1dQp9J3oik5lq+FiAYbdunpxADgAKgIhp6VMYrkL/6
 ShHR0fBSUkEI6tLKCfhTiNVoBWmdJnBWGr20/y3Ax2T9++GgvMVsjdkoSRP5Ag/RLWkT
 tLC01CajmGZfurpmBvDziG7eGpemX8YWehcDCv9prsMPFFpRMrtS+G4yiYAU25+P9tDm
 vNsWaP5W8k2gs8HOgZqvoZMFlbrG/Jtq96sZasWKKMUqIUSoNLhG6lx6grC3WkVMBvXw
 0iDi9D7IBmY8ErAH1g2wO5NI+8ZAcbMRrdKvpt7sS+0BOu3HSeIOY5847ANVJSSB9lLv
 tjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698409114; x=1699013914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJHAFGdNUhuVw/PfxoTbIpKdsSQ1dyoiqDNoqW7Fazk=;
 b=ka6oWGZ+8MQAkAKxpUGcf+c3/Pz0a8sk5/imrr3slmZRNY8h9pnPB70zjgGZV11T+F
 e0a8iaIcbuBTdc4C69URAMfkCGvKPl1Q7Rh4AIV/sK1YJhxQUrBB5ZDlJn5AHOYCiyT3
 HyUacc5v+Ja6sfMNVFDjNw3iq8ClRiPFQzAWSPJfmb+6uJx/WU3imRl3T85/zUjbZ8+D
 7/cpxR7n1mWoaVmTfgIrworxaV5J9CpRiLw8kMYnCNw+V31LTNvWF+PdqoyAN2ifzZ09
 XfST1YK2FzhG/57q1bFrBONqqyXJEoYOgIMkTK9Q3KbGICE6Qz2YALRXpXaQ+sJr75/B
 MKxQ==
X-Gm-Message-State: AOJu0YyXtymWaFAgY9zmYiC3ytuHxH7iW0Pu/3LSJI6OV4Vw2L24n+j3
 4ErWMjJYcdeAHvFjw5OI1Lwm8e52Z5c5VbyvkclCDg==
X-Google-Smtp-Source: AGHT+IFPHALZYRISZKMRVB5asQY3Ii60TTUKd1FKF9dmKm70VlzlQnxkQ8s/KKkirCWhhNaispd1RModuQz06zK7DvQ=
X-Received: by 2002:a50:ef0e:0:b0:540:9444:c281 with SMTP id
 m14-20020a50ef0e000000b005409444c281mr2137325eds.24.1698409114277; Fri, 27
 Oct 2023 05:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121857.31873-1-philmd@linaro.org>
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 13:18:23 +0100
Message-ID: <CAFEAcA_Ec5ahSbD9-v8o+-WX-4jraRt0JmFDydywDQ2iGhznHw@mail.gmail.com>
Subject: Re: [PATCH 0/8] hw/pci-host/designware: QOM shuffling (Host bridge
 <-> Root function)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
> Hi,
>
> While trying this PCI host bridge in a hegerogeneous setup
> I noticed few discrepancies due to the fact that host bridge
> pieces were managed by the root function.
>
> This series move these pieces (ViewPort and MSI regs) to the
> host bridge side where they belong. Unfortunately this is
> a migration breakage.
>
> I recommend reviewing using 'git-diff --color-moved=3Ddimmed-zebra'.
>
> Regards,
>

I had a go at reviewing this series, but I ran into the
problem that I don't know enough PCI to know whether
the various things being moved between root and bridge
here really do belong logically in one place rather
than the other.

Is there somebody with more PCI experience who could
look at this series?

thanks
-- PMM

