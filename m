Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911A73BC2A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCj86-0007t9-JJ; Fri, 23 Jun 2023 11:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCj80-0007rj-Ol
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:55:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCj7z-0007oC-7B
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:55:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f8fe9dc27aso9049235e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687535713; x=1690127713;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxUY4XgdL4b+2sfC/cPLfgvY1psK+wCHIevlqmIHGlQ=;
 b=NhVzBNeyRb5tTGl/ozEohJQk+QCEwXwbUoAoWy62dfsVxwVvswoQyxkdHOmc984OvE
 +7PW8kzTG+JTfwpIavocQi1UW9tS3Ps4UkBnd6fUPFkjmLWnEjVbYUwwzxzCGzrEZIT0
 QtEGrHh2z3ISJMbGoZXRxzanxgCa42tNl0bi8zIvDSBRpuJkaCfNzy2o5Cz2EyKqxGJg
 AyD5ha1zdFPiN0qNVFXOU33fMGA9jsQA6+vsPCBUzH4iH4X088tA2KA+f7WJxrrXYtdK
 0dbKW20/Oh8Ivw0A37GA6JPIs6ln5Rpu6mpZyWxfms9inK0uJkAK/bkQX1JLzLRSJYEg
 JARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687535713; x=1690127713;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UxUY4XgdL4b+2sfC/cPLfgvY1psK+wCHIevlqmIHGlQ=;
 b=K719DN8rAYYpkCQu4RrEddcJuLDltgGCGhmArZoSSkWbxa7TvIkmjW+unhpwKz0QId
 JFp2A3Zb+AxXJCdeRTUuBDm9Ad53398tmWxj03kiMZsfwkc6xWZgQ+RJ7bjMPVPcxH8W
 liA+YuX5ckBOKtRLZMia0MqYaTgeXhCR780RNKh4a0jAJOdL69B1Fmd7L5t6frtWPIC+
 THYgW0j2g78ifaNZWvs5UP8Zd8yXOkxGp46+Sc8n35XM2+M0s2DF+WotYRa/+kOOkDwi
 g7MATXPrsNx1Qp5JZctV9bAS14ATRfIS1YVsw5bwKm/vhyyUCFD1lZ0laUbmPz9SAPV9
 b1ig==
X-Gm-Message-State: AC+VfDxHN9ImCSqE+FYmZ5jT700sCgyqdkllB500S16IyjFHwi8fRFei
 UqmbyQEOHgUDa6M7W0dfMkAcWQ==
X-Google-Smtp-Source: ACHHUZ5cyETyjgbhKHjGa49zSEJJwH5OOgel8pE8249+yzZ4rWFI4RtdzsSvuWyL3Cv/gaz4pZ02WA==
X-Received: by 2002:a1c:f609:0:b0:3f9:bf0f:1ceb with SMTP id
 w9-20020a1cf609000000b003f9bf0f1cebmr6338918wmc.37.1687535713562; 
 Fri, 23 Jun 2023 08:55:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a1c741a000000b003f8f9ab6f30sm2691081wmc.20.2023.06.23.08.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 08:55:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCCB91FFBB;
 Fri, 23 Jun 2023 16:55:12 +0100 (BST)
References: <20230620162024.1132013-1-peter.maydell@linaro.org>
 <87352ifbm5.fsf@linaro.org>
 <CAFEAcA8JD7ZJy+X=pccCHawuuMee9rdW78mReaG4m3R1xXkmKA@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
Date: Fri, 23 Jun 2023 16:54:09 +0100
In-reply-to: <CAFEAcA8JD7ZJy+X=pccCHawuuMee9rdW78mReaG4m3R1xXkmKA@mail.gmail.com>
Message-ID: <87legadvhb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 23 Jun 2023 at 16:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > The xkb official name for the Arabic keyboard layout is 'ara'.
>> > However xkb has for at least the past 15 years also permitted it to
>> > be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
>> > synoynm was removed, which breaks compilation of QEMU:
>>
>> Queued to maintainer/june-2023-omnibus, thanks.
>
> It's in my arm pullreq currently on list, so if that gets
> in first you can drop it.

Will do. The qemu-keymap changes where needed for most of the
fuzzer/clang failures I saw when upgrading the fedora container.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

