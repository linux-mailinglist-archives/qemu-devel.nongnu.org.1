Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B37D58E3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKTI-0004PN-CK; Tue, 24 Oct 2023 12:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKTF-0004Iy-9J
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:41:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKTD-0006b6-Ng
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:41:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso36949395e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698165690; x=1698770490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awxLtNOqWYASZHdbf28m2QJJs6Pq6yxb+MFNpXcWp9c=;
 b=GdFiJnXw2zVViqx3z3EKmZdCBkGJYpj8OX3uTmhMgkvCOR4grR+XNfq1t3I8Vt/ln2
 K/sYZIerGDe1uXQnbfxMa61mil+CThEviojJJvSnASPj3A0d8BXuNZf0x51XtPnyGRJK
 z1jJCmpRdwp5Z1lWFRdUG8aL7nMw1i7560TStbI2ttDmXrjLb7PmcLnQ4Tst7+Mgz4Iq
 UgHPL9LNvZZgOiMjIZUCku39oPASlftNpEdCG1d98sRup5QsrNwZpree7u0XXwRCFPxg
 dRv7zGCwJs1guF+2/AtWbLEmRdgbat3kJCnoq4YKYN1Rylx27Njby68p/iM4/8OmAcRp
 xW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165690; x=1698770490;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=awxLtNOqWYASZHdbf28m2QJJs6Pq6yxb+MFNpXcWp9c=;
 b=v4novNDVJLe44EGjjFLa9qO9KYvrpxKgzGuuKrpP9nIdeANsoFfaswJElAxMVTBWMk
 dQirSRyZiyq7bR/GPSUZCeAUKdvgsjM6zrGglMhazdrAjPnMj3IWx7ZDjcQ1wJS7pqIX
 fNrZ0dxAZFNbanKxlrqHOoc7vX2qeyktSHe+XOI64618F1CCkNMV9My6up2WKW/QLMyQ
 2FHfsZIOiUtaXZptyy/iBsSjiMO60Zu/FFeO1VYL76ED7I0tE/nYMJzIki3JJU4c9ITi
 qBrYxE6oJTRQ7T+iEVmOAjSjjgCWiiGe55KK2QkLeejCR8kJ/VDi+uWDzhODubNUpfn1
 DX6A==
X-Gm-Message-State: AOJu0YyhLliTqG956xbf2feZiHfA7vM8XaRIvf2o9IFezz1TLcV+D6Pu
 ahuRfiZS8m7t00DAASAGHDoOJg==
X-Google-Smtp-Source: AGHT+IH4culZyQXFaUAdMtOEwOWlzJ/pa1caexlZ1MRsZ6YdLgz5DEhKj2SjQ9WaKukn8RuPGDXuAA==
X-Received: by 2002:a05:600c:450d:b0:405:3a3b:2aa2 with SMTP id
 t13-20020a05600c450d00b004053a3b2aa2mr10668089wmo.37.1698165689593; 
 Tue, 24 Oct 2023 09:41:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a05600c46d300b0040836519dd9sm12457899wmo.25.2023.10.24.09.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:41:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A83FA1FFBB;
 Tue, 24 Oct 2023 17:41:28 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-16-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 15/18] cpu: Call plugin hooks only when ready
Date: Tue, 24 Oct 2023 17:41:23 +0100
In-reply-to: <20231019102657.129512-16-akihiko.odaki@daynix.com>
Message-ID: <87lebs0y87.fsf@linaro.org>
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

> The initialization and exit hooks will not affect the state of vCPU
> outside TCG context, but they may depend on the state of vCPU.
> Therefore, it's better to call plugin hooks after the vCPU state is
> fully initialized and before it gets uninitialized.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

