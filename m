Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0319B74D387
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:31:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIo9g-00075I-OZ; Mon, 10 Jul 2023 06:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIo9e-00074v-IS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:30:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIo9c-000350-6c
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:30:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso5100686f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688985001; x=1691577001;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ju58M6RIg840o2sMmJkivNvtXUXH4POnMnZDHHgGwk=;
 b=Iu2VngPyDYsH8Fiat1j+E2GTzKWM35ddh9y9/DLgpj3TTSQelONkonhWbNP1eRKFgX
 2HQapWVE6uU1/ULuMoRydzgA7Z+Hc+dZPNmY5J/HcCWvRo+otWB/EK3yJpGHw1ygfczH
 VqozL0TyS4EK2jHLkkzyGXvaOdQ0z+p5V59MPfJU1Q0OvjI8YmiWEr/P1btd5sL7q6oc
 uMJNkPF0qHBhrDSaVj6ErbPslqcsbLIM7+UJ4eD1uAZ4RwkQi+fomWeEKK146ygh18zF
 YUbzUYUNzr3qiy9q4mgqPw9daBN4mP92T451ovDA1qdzkftdTEvUrkgvIPnmuI7oOmlP
 AfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688985001; x=1691577001;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Ju58M6RIg840o2sMmJkivNvtXUXH4POnMnZDHHgGwk=;
 b=SKvR4lOcondnRsE04gd8Am9odMmXKHIs8foUwEwuaYs6SC2CYgXl+FGygUqK7EvyA+
 PMMZLWAHzzGewbPJ8beIyiKxNAj8ApXopDvWliurDmgZ5tVM1WECQyjQbDCR+pk4fKcg
 7OLaKsXpwkwltrSGwctiXHUsn6WapGBg2FLcYrYj6Ita0SXGXHuVRNpt8k8Enfz8L5lQ
 3Vm3dUzkrKGQtRz8tIe6oxXcVJ6wA1Wzal0jctCtje3M443H2FDw40+n1rbkP3J8CLNu
 dIUW4eL7QWS9CncPh+JL/4wmt7pOrZNSeDfckkbzYzzJewAqiLG7ZGF3fgVoyvBVWnxI
 /bgg==
X-Gm-Message-State: ABy/qLYYnFpgh5sRNrfpaYGtgZpvXlEny/6DEBXEJKGeBB+CxamlrXtU
 vZrd5QZtg5WoEPuugg9WwDSfHQ==
X-Google-Smtp-Source: APBJJlEYOo7o4Si4zHnw3PmaWAEJFXPxiDCd6RFOj6V5iT2j8BDvJGdv1eyAa5A5dRN+jRCB4es/XQ==
X-Received: by 2002:adf:ec50:0:b0:315:9993:1caa with SMTP id
 w16-20020adfec50000000b0031599931caamr4293999wrn.12.1688985001697; 
 Mon, 10 Jul 2023 03:30:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a5d65c7000000b003159d2dabbasm1595581wrw.94.2023.07.10.03.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 03:30:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D3D941FFBB;
 Mon, 10 Jul 2023 11:30:00 +0100 (BST)
References: <20230710092638.161625-1-thuth@redhat.com>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] docs/devel: Fix coding style in style.rst
Date: Mon, 10 Jul 2023 11:29:53 +0100
In-reply-to: <20230710092638.161625-1-thuth@redhat.com>
Message-ID: <87wmz8hxef.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


Thomas Huth <thuth@redhat.com> writes:

> As defined earlier in this file, the opening curly brace of
> functions should be placed on a separate line. So we should
> do it in the examples here, too.
>
> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Fixes: 821f296756 ("docs: document use of automatic cleanup functions in =
glib")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

