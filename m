Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5077B7BF
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 13:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVW0G-0004Wx-KO; Mon, 14 Aug 2023 07:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVW0E-0004Vh-2P
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 07:44:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVW0A-0004zy-Kl
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 07:44:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e57d2so37986245e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692013489; x=1692618289;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FZFiFIXsz8UnJfsIP9ylKoEjoVeLGdB+Io7rdRixes=;
 b=M2jvErsIgjc+KDW5GD5ogH/sun0xIzpAEGpJOiLl9ZzAHHUb6UacfWqhHCla78bAyj
 ThFlxfsWKhfmtM2qQad/0jHpROCtC07TogmxdauuO+EIXM/5DcPr0WZocjAjwYnquuUt
 u6f6VAj1YTjSX27/pv/+EqHx2rZmTFPDTtAfG2OfHyL1dqgHgQce3JnjNm3TVgCbUS0n
 +Z6aqtF0ldyKhiUvpIo5CHUmGwhys3SqMdPkgVCm/usbYeiZHk1UnDni4grSlSinNP1i
 MNeC+HLq3cFgC8xNs0i8SqERiyqsaqtT4Ly/hFgMZrWaGDcMZvNBGkZ7Z8p1sOy32bGp
 +rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692013489; x=1692618289;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8FZFiFIXsz8UnJfsIP9ylKoEjoVeLGdB+Io7rdRixes=;
 b=kJ4lhe51MWq303kQ+kN7xIiE0wk2EbGVJ/u4ffs1tF8h06Gt9fqb/M1eQsz+YF6f6h
 W+QKCGs7Lm7x6uaS0j+Y/lJvfMwnGaHB8QzqC036KEQ/csDvO4SrJi/V2RzgBSAQelDZ
 2eD5AvkETvCBevQZ7YlWMqxsMxH6j8ddmyRt76RuLlTaBg2qf/PVR1ohWc38fkffX1LO
 kKUeokpUGRuLOxiUAQ/MwsIZxcJAqGEfjPUgW0JFPbbt6QP1I0reQVrSQAHM+6Yo0NH8
 mKEwPTszCzUQqi9JemfVw2U/QMmFnsjU8y9Zc0XiiJXFN8qKRSiuN8HpXpBszbnDMeEa
 oN4A==
X-Gm-Message-State: AOJu0YwEb0LEmOgwienDp8fA2910fu0wdEq6tuW9OOG2hIrWQuwV1pMu
 vf1/L42hU1UJOrJDBxpzYWwr8g==
X-Google-Smtp-Source: AGHT+IGqfpvTFtRhZm2xPRLjEgD8b0yg7J+av9sJxJ0orm/+Updpj246TB07Veo1Vyv0c9RI0Z4uPw==
X-Received: by 2002:a1c:7c05:0:b0:3f8:fc2a:c7eb with SMTP id
 x5-20020a1c7c05000000b003f8fc2ac7ebmr6988361wmc.5.1692013488761; 
 Mon, 14 Aug 2023 04:44:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a1cf716000000b003fe23b10fdfsm17221694wmh.36.2023.08.14.04.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 04:44:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C05701FFBB;
 Mon, 14 Aug 2023 12:44:47 +0100 (BST)
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-4-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, Aurelien
 Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Chris Wulff
 <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne
 <shorne@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>, Weiwei Li
 <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Max Filippov
 <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH 03/24] gdbstub: Add num_regs member to GDBFeature
Date: Mon, 14 Aug 2023 12:44:43 +0100
In-reply-to: <20230731084354.115015-4-akihiko.odaki@daynix.com>
Message-ID: <87cyzpsv9s.fsf@linaro.org>
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Currently the number of registers exposed to GDB is written as magic
> numbers in code. Derive the number of registers GDB actually see from
> XML files to replace the magic numbers in code later.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

