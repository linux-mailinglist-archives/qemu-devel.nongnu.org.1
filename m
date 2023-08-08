Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0AD773933
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 10:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIXq-0005Nd-E3; Tue, 08 Aug 2023 04:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTIXn-0005NS-R4
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 04:58:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTIXl-0000Ux-HC
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 04:58:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso52472145e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691485098; x=1692089898;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umweRdrmZ/sh4Y6FcLzxA5U/Bj8W/K5/2tP5RbtHjJY=;
 b=mM1fuDp0B813XfUJQXsInEan3uGi0L8mU6zpOkt61W7TG7ykP/nSbZSIJ03s06otbO
 gn9mheNQ4rVjlyEvYpFf2WwUvzPFsH2PjUDmyYAEjjXEWriegH252ZsLOmTyJy9RGVzk
 HHbOLoD/8nKqwwHRWrZ9iCU07vI1teYQzeL2YaofdhiICk5n+PAbomwkGF5cMFIuTqaK
 1GG72ILioltK78DkR0EZ/owzomn9P40rtMCrtOvCYsON7cTtMbxwKnCe3pzNuCyd4szL
 veWFVSx8thpPKsAjSY0x+RNVTTJauoirAqRggWhNYxoK7LfZ7Q3Op2jz+I6kNoCM2gU1
 R3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691485098; x=1692089898;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umweRdrmZ/sh4Y6FcLzxA5U/Bj8W/K5/2tP5RbtHjJY=;
 b=Xt82KNNApL1/PjExI1h3sXFhMkq51QQ4P1HUsL1VLocOpy+fzZ4bB0NrFJkATIa5Zr
 8eJyCUdjET6vHkxi/ZuGkGUdhoH2UAZxuwxykMJCD0GrPWMqW4tlsWj+MN12GSFr7HtZ
 2V+jnX6mNKEvwngms9g5IBm62+jipifFXOFxS1ydOsEiQD16aSVge+rUrLk2XpKik9qa
 IHpp6Fk7h58Z3+4q6lUTHeL5CslVN3KqazDY1aeBmIqBMs4d62j3zWQjN5fopcwMLaPL
 dlw6hn+RC+W8S2IqtOq/XxnrOF8OzD5/s5JsxxP7sC9m9bZCOSAqiq+ssTcZgGYbfBy+
 MLpg==
X-Gm-Message-State: AOJu0YxlorT3pBm6p6IdjIZsQiNEnkOw4iNRY0jgWML/8HEkg5vObLsa
 Y+77y+OnmlI3LKeZoakpfWVrWGJCurdpTAmALP4=
X-Google-Smtp-Source: AGHT+IFRjCiZm/PBELZ5fKTUY6CQ7ew3kYYWnZVGTAIZsno8Ohwc4pkO1kqLkz+yoeNIHgZT+beftA==
X-Received: by 2002:a5d:534b:0:b0:314:3b9c:f02f with SMTP id
 t11-20020a5d534b000000b003143b9cf02fmr7958054wrv.49.1691485098499; 
 Tue, 08 Aug 2023 01:58:18 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a5d4009000000b00317a04131c5sm12995884wrp.57.2023.08.08.01.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 01:58:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB3C61FFBB;
 Tue,  8 Aug 2023 09:58:17 +0100 (BST)
References: <20230717182859.707658-1-berrange@redhat.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Thomas Huth
 <thuth@redhat.com>, John Snow <jsnow@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 00/12] tests: enable meson test timeouts to improve
 debuggability
Date: Tue, 08 Aug 2023 09:57:28 +0100
In-reply-to: <20230717182859.707658-1-berrange@redhat.com>
Message-ID: <871qgdap1y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Perhaps the most painful of all the GitLab CI failures we see are
> the enforced job timeouts:
>
>    "ERROR: Job failed: execution took longer than 1h15m0s seconds"
>
>    https://gitlab.com/qemu-project/qemu/-/jobs/4387047648
>
> when that hits the CI log shows what has *already* run, but figuring
> out what was currently running (or rather stuck) is an horrendously
> difficult.

I had this in my tree but I see there are a number of review comments to
take into account. Will there be a v3 and do we want it this late in the
cycle?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

