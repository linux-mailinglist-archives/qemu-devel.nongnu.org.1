Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DDD7739CE
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 12:56:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTKM7-0006eX-8q; Tue, 08 Aug 2023 06:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTKM0-0006e8-Rz
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 06:54:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTKLz-0001bt-Ac
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 06:54:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e7efso31351685e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691492057; x=1692096857;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAcS4wWfdoSp5wAHSYEqVFYnn7GBn9wt51pKrebGK+E=;
 b=oq3UVu77yFYa4mjRuPpS528OPDJM7ZqNRJav0LORLvfQVkRyRxsb8R+oiXi5aSakOV
 6EYaFPUN9rbrlyyY2r+RbJ3DEnqPGC80yENMW/rg+HSXkSGifahj/iOpgm+lbxZed4y6
 DokmaS2MvgaQYg7hc2xzaHhIgI/8EBmt46TR1Li8P18OTFIFqqWroYdjiQCRHHDiUI2C
 pZbbMnSdiC5bJUvKEwflI0jX005l8GccasFYzIy/mfs4RjsOZLatgDOC0Tj016ygQKbV
 3kDBBrv2tFsq2UAArSeewqMVFwmDwW0t5cwtXkhSHy0uk4HZKYIF5kGuknwKur3kTMGr
 tU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691492057; x=1692096857;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aAcS4wWfdoSp5wAHSYEqVFYnn7GBn9wt51pKrebGK+E=;
 b=dgSiwczwyaLsNfKIxkoFmSCQxNCajh9VRtRtpwFuXYdT1PEPSSAIdGZgUtwBUpRDcV
 rHrzOH7NdwTNhsrfOBGW380vdd4ZnsFKpIEqX6gqBqoQCpUEukkvLrtkwe0RuX1b9pvn
 VPEH7Y74+MpkyFxkUp7ZFW5UPPct4VnGK66dp7LFr/zm8d9mP2K1idDabO9jz37qv0wL
 aeDr13e1IP36WutxW8MVdtjQlQrwAT6x7gr2PtpNO0rE6CaiyYwkIilS5y2pV925EO60
 PhiP6PyYn+zzr64iIkoTPugRwV6RR/LgfKfZgA0rSsk4RJM7yDf3uUzVVE/Sb5y48OYK
 FapA==
X-Gm-Message-State: AOJu0Yx2M55qp7fNSGN0svh0R0V9NIITnAccRSXZI25qwu0x96kPhHz0
 Mo5byLL6zdzm+n5ZxjJRIFvSgg==
X-Google-Smtp-Source: AGHT+IHX/jdodyCw0pY5F8XxuWh1s7A4XblxIy1FAPjeAnJgAZ9QkSoKQNwfXjMkUSENtBlQ0yZn9Q==
X-Received: by 2002:a7b:c84b:0:b0:3f7:e3dd:8a47 with SMTP id
 c11-20020a7bc84b000000b003f7e3dd8a47mr7497690wml.11.1691492057645; 
 Tue, 08 Aug 2023 03:54:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c214300b003fe407ca05bsm14747674wml.37.2023.08.08.03.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 03:54:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A0BB81FFBB;
 Tue,  8 Aug 2023 11:54:16 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-7-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 06/14] linux-user: Adjust initial brk when
 interpreter is close to executable
Date: Tue, 08 Aug 2023 11:54:11 +0100
In-reply-to: <20230807163705.9848-7-richard.henderson@linaro.org>
Message-ID: <87fs4t9547.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> From: Helge Deller <deller@gmx.de>
>
> While we attempt to load a ET_DYN executable far away from
> TASK_UNMAPPED_BASE, we are not completely in control of the
> address space layout.  If the interpreter lands close to
> the executable, leaving insufficient heap space, move brk.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Helge Deller <deller@gmx.de>
> [rth: Re-order after ELF_ET_DYN_BASE patch so that we do not
>  "temporarily break" tsan, and also to minimize the changes required.
>  Remove image_info.reserve_brk as unused.]
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

