Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB297D541F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 16:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIRD-0004Wx-AM; Tue, 24 Oct 2023 10:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvIR4-0004TL-6o
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:31:10 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvIR1-0001bi-T5
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:31:09 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so6205247e87.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698157866; x=1698762666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWb20dfK560rIF8adWY19+tt4v4j4W+IGWYOb1Mi0Ms=;
 b=kNtBCaOH/bq6O7SCeBA1vzs3t3c8NMv6ZWuAkymeHUjXQkSzMR/2gp/rY12FN1jMrP
 fO5T5jB2K2Awy3gASfo79dDjJIG7mC1Nfr4iQpfyJdegW8yIMBUYo1h00M3/mWDtoOky
 Qb7Xg9VOU09IKCBpe85PF+Fiunq8B9osAKcciQAEKOtg+xv20lKAO1Mfv2P49AD/ggbM
 2nHKouF+RIFMZNFpBvqkrLFSODHQZagCO2KylyIAda5nd0xcnBLZtJlaAH6f2dc7W3tr
 QiING0js0h4t5rNqqPGKyazN9ScOMryEIhh82mEZizrf7qpiwsp0RpJgrsLguPUcHSTp
 Fs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698157866; x=1698762666;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EWb20dfK560rIF8adWY19+tt4v4j4W+IGWYOb1Mi0Ms=;
 b=Xd+06sAVmY6UklhSqycFDqVOz9d+9ri2qB4FNLgEMAIOzir0phVtWdJTujiNe1rMfv
 jytB1gCOPM3y+BURhg2PDK2IONFCFeIutNnH/5zbNFook6VV/NLUSiv8UEkfeErKyILR
 Ra6/YZ6I0FZdZ4qiPisP2J8oM28/UxYOMYAYN3LmL82egQPINdv5UVCZc6HBqXGx1vBD
 I2frdEK448VkAf+IDXA6Ncvw9z1elVz/3bfM+h4Bu9JzIaqlrM2HaH5O6NLllQd9Nx9X
 gHS7UqZMQCQpAHnZ5c2JDUY7KvnmxjnC4fAz3pP1BR65fQefl8BtTNvGzbvb6xb7HoLA
 k1nA==
X-Gm-Message-State: AOJu0YzNHDANmaXyvT0z0SEY+RfL3Zp1vnS24MFvbXPNr0aE3fMQ0qsg
 BqfYPy6IKA6lI0s9ErJ+JaEW+g==
X-Google-Smtp-Source: AGHT+IH0dWMqZZPpseYBO94Ur/wUU/ac0+s6vC+gY0EGN6jxMZY3tl2gJaJy33i+3fRuLGzUgzZqeQ==
X-Received: by 2002:ac2:52a1:0:b0:503:7c0:ae96 with SMTP id
 r1-20020ac252a1000000b0050307c0ae96mr8129902lfm.20.1698157865812; 
 Tue, 24 Oct 2023 07:31:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c469000b004090798d29csm3704919wmo.15.2023.10.24.07.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 07:31:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A57231FFBB;
 Tue, 24 Oct 2023 15:31:04 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-11-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v14 10/18] gdbstub: Simplify XML lookup
Date: Tue, 24 Oct 2023 15:25:05 +0100
In-reply-to: <20231019102657.129512-11-akihiko.odaki@daynix.com>
Message-ID: <87o7go2itz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Now we know all instances of GDBFeature that is used in CPU so we can
> traverse them to find XML. This removes the need for a CPU-specific
> lookup function for dynamic XMLs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
<snip>
>  }
>=20=20
> +static void gdb_register_feature(CPUState *cpu, int base_reg,
> +                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb =
set_reg,
> +                                 const GDBFeature *feature)
> +{
> +    guint i =3D cpu->gdb_regs->len;
> +    GDBRegisterState *s;
> +
> +    g_array_set_size(cpu->gdb_regs, i + 1);
> +    s =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> +    s->base_reg =3D base_reg;
> +    s->get_reg =3D get_reg;
> +    s->set_reg =3D set_reg;
> +    s->feature =3D feature;

Why not just:

    GDBRegisterState s  =3D { base_reg, get_reg, set_reg, feature };
    g_array_append_val(cpu->gdb_regs, s);

?


Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

