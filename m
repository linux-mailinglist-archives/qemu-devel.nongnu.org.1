Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 956B57F1757
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:32:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56FG-0001iL-Ke; Mon, 20 Nov 2023 10:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r56FA-0001dg-NL
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:31:24 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r56F9-000133-4y
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:31:24 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-548c548c40aso1721522a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700494282; x=1701099082; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeywu8kSO5O0y2XZ/oyJH7tep+m6AGiuZIfGIyFBXBg=;
 b=C0lmF+FIPRm6znln/cqppEENTiu5sTET4RJh6iUCYHUa3QVVD5PEzReEsTqNPmpV0N
 brBU1SWIyUqlWYccO3de2V9S/UXT0TlFQZJDFMQY0dSIza3S567z4j6GDzLj0mA5Qzga
 w6FBmNKCAShZDgWB0wTM13MVjpSdMob92mmdNEcKHibPGlMGS1TE4jamEyR5hJlGq1Ox
 7h1vlJf04K3D+F2Ujid3/iwpTXIjFe1o+UuRJyrc1Nm4eKC4kLToKK3UjrmUx+rsLnNO
 HOOy0BZb64OA3CWyoi6CKB1khAk/LRaPeogsJUzzb1KyLCVUZibA0zyGKAMsN0tNBakf
 5ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700494282; x=1701099082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeywu8kSO5O0y2XZ/oyJH7tep+m6AGiuZIfGIyFBXBg=;
 b=rxuKF3YnsUde9xXUXtIx3YRmDQgSjBPJr64pjg96QODwu9hNetek3eAU4Q5aQgGc8Y
 utIg8DJ9q5WrxPe6q6KdDRfcfSSrwTQ6yh3W3kKzjqlEszs/+VZdCtYKQeugzeK9ehI0
 IFoTDKETXEA3Oed8jsn06fPFeu9wNJaWh0iXiSoPsOf+pd8lzRH5Ob7NCsryp0dyXkoF
 NqMm5yMFMJpFOCcuqtIzPLr2ccDER86JIzTLTfRhMxpoP4Yt5RO+j2pVo42Ve1x996Sp
 s13Hz73/rMJOxna3FNtJfksl7G9xGWIHlALSio9ucQupClubCaQewd2WVf8UasjGUCkB
 hT8A==
X-Gm-Message-State: AOJu0YxUS7d7aem1ujSZZSiNF/yjbXK5UaRBzqSg1XpnlOpEymwWpGJ6
 jf2SNa7DFdrb6vfYmkD3I8A/d5UhIFTyuEUHn4QyXw==
X-Google-Smtp-Source: AGHT+IG/nViIfIhlEtyDvVgwRBA+GtsCMtUQJawLWqewVU0E2OO29cMyfGn/P6rVOoWAQJwo/Gn5sLjROySeq37038A=
X-Received: by 2002:a05:6402:1658:b0:548:ab1a:dc2c with SMTP id
 s24-20020a056402165800b00548ab1adc2cmr2124652edx.9.1700494281797; Mon, 20 Nov
 2023 07:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20231117071704.35040-1-philmd@linaro.org>
In-Reply-To: <20231117071704.35040-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 15:31:10 +0000
Message-ID: <CAFEAcA9-ECe5iFvru02z-3a=1ePCDCsFS-KYEpjx49m4gPrO5g@mail.gmail.com>
Subject: Re: [PATCH-for-8.2? v2 0/4] hw/arm/stm32xxx: Report error when
 incorrect CPU is used
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Felipe Balbi <balbi@kernel.org>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Helge Deller <deller@gmx.de>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 17 Nov 2023 at 07:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Series fully reviewed.
>
> Hi,
>
> While reviewing this [*] series from Arnaud and In=C3=A8s,
> I realized STM32 based boards don't check the requested
> CPU type is correct, and ignore it. Possibly confusing
> users.
> Since these simple boards code is used as template,
> I took the opportunity to sanitize it a bit, using the
> MachineClass::valid_cpu_types which seems simpler (to me)
> for newcomers.
>
> Patches are candidate for 8.2 but this is a long
> standing issue, not a regression from 8.1.
>



Applied to target-arm.next, thanks.

-- PMM

