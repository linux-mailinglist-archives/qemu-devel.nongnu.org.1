Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EDC73FA32
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5uW-0008V4-TD; Tue, 27 Jun 2023 06:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE5uT-0008UW-7U
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:26:58 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE5uR-0002Ep-Fy
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:26:56 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-991e69499d1so171561666b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687861612; x=1690453612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsdL5qGafkVjz4+AWbAfZ9Umx3OTSf3bC4/pTasPW9E=;
 b=hx6s/lOey3XhaC+tj12CM95B6t3P2p+it4mdgWVBXJCfHYTZASWp04PbHnMrC4HITo
 jTl6ggNKXg2AaVSbXkdN0+URUcXkesemBLsi/IJYKPZkdQvXutZhtM+dlGvLi5ArmEA9
 IpBoEy7YT48I+WHpHydxxrSJs7Gy+gFSxsyI8UjAnzU1SvY3WabcqERVBrxy1KMmQat7
 KpV75QAcxdwXLIHeZLGAYh8rzLv6wRjmaRfWZDrcXsGSQ7SDIiUYpvuW5JysSTCufG1G
 gOh3wMhJ09LKjoG5//4FK1rOjF1EFBEFPaIHYQUPa66GB6kwyQYefLEtL4ApoO34Y7g1
 yAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687861612; x=1690453612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsdL5qGafkVjz4+AWbAfZ9Umx3OTSf3bC4/pTasPW9E=;
 b=a+IhToLzqyPiG4c9IszbVtz5GzxOuilqdlYRY9uETRq3Vf87CyTzgBI3Fl9e0vyh4c
 3OoQO13f3NjpxMF///wuuoQjzhq0rf3L/kXXXsvKzIdxjxL1E2aqEOM4zGmPAQDqunzx
 xreBiC5hneiNzskXYtlQifhyh+z2eu5slAEBJm5VZcv3EZoLs0XLdIh1Ro1pFr5gbMRc
 64GvUUZDzwwcAOvf3w46Ykf6hzfAdZj+Ayg6RftAqRJr80UEUMXRgWu3mlTTOFd6pSFR
 B5BpCtEs/cxdoDElciUeao4iJmxmjXfGpIFclaf1Omb9caQlBt0ecIWnLDJwHc4d8qlu
 t4vg==
X-Gm-Message-State: AC+VfDwJic6HrwW9TLlOROwo3dKIjpMgGHH/nvQgOCOeF03zTcwLP+6o
 t+0kCckrg6qR2QI/aLxZQtbnZXbZub0cV0c8H15V2w==
X-Google-Smtp-Source: ACHHUZ5sUXPNGOe/UeNrjcPbxpkER72EWVL05vc6ecmdrrBNdfaCXE+p4Gc+TfHvgAtE7NDa/0mvFUM8PAqx/KT/Poc=
X-Received: by 2002:a17:906:8442:b0:991:e458:d16 with SMTP id
 e2-20020a170906844200b00991e4580d16mr3013645ejy.72.1687861612556; Tue, 27 Jun
 2023 03:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-7-alex.bennee@linaro.org>
 <32624588-a714-6317-77e3-39ce7cdaa8db@linaro.org>
 <87v8f91b4f.fsf@linaro.org>
In-Reply-To: <87v8f91b4f.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 11:26:41 +0100
Message-ID: <CAFEAcA_cOT9phmZevCz6mu+4U92sk9SeBsP-eux3w-c3tDcToA@mail.gmail.com>
Subject: Re: [PATCH v2 06/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, 27 Jun 2023 at 10:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Ahh in the other thread. No change, it looks like AltGr just doesn't
> exist for some keymaps:
>
>   =F0=9F=95=9921:20:36 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING =
2/22) [$!?]
>   =E2=9E=9C  diff -ub gb.before gb.after
>   =F0=9F=95=9921:20:43 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING =
2/22) [$!?]
>   =E2=9E=9C  diff -ub ara.before ara.after
>   =F0=9F=95=9921:20:50 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING =
2/22) [$!?]
>   =E2=9E=9C  ag "Alt" ara.after
>   21:#     9: Alt
>   23:#    11: LAlt
>   24:#    12: RAlt
>   29:#    17: AltGr
>   294:Alt_L 0x38
>   1711:Alt_R 0xb8
>   =F0=9F=95=9921:22:14 alex@zen:qemu.git/builds/all  (399fc0c) (REBASING =
2/22) [$!?]
>   =E2=9E=9C  ag "Alt" gb.after
>   21:#     9: Alt
>   23:#    11: LAlt
>   24:#    12: RAlt
>   29:#    17: AltGr
>   338:Alt_L 0x38
>   1757:Alt_R 0xb8

I'm having some difficulty interpreting this output. It
seems to show that there is an AltGr modifier in both
mappings (that's why it appears in the modifier listing).
And for me (xkeyboard-config 2.33) in the gb mapping it's
used too:

# evdev 2 (0x2), QKeyCode "1", number 0x2
1 0x02
exclam 0x02 shift
onesuperior 0x02 altgr
exclamdown 0x02 shift altgr

(i.e. the '1' key is 1 with no modifiers, ! with shift,
superscript-1 with altgr, and inverted exclamation mark
with shift-altgr).

The 'ara' keymap likewise has and uses altgr:
# evdev 2 (0x2), QKeyCode "1", number 0x2
1 0x02
exclam 0x02 shift
Arabic_1 0x02 altgr

So on the machines where we were running into this,
what's the version of xkeyboard-config and do we
output the same mapping as we do on machines with
the older xkeyboard-config ?

thanks
-- PMM

