Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE00E797225
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDiy-0006h7-3B; Thu, 07 Sep 2023 08:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeDiv-0006gG-Ih
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:03:01 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeDin-000470-E2
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:02:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso1170850a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694088171; x=1694692971; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jLqQNsqhY0Y8Lz9dXWkAowjyYKyxSNZY8cuHuNL3H/Y=;
 b=lG4AYdB1TY+iG/MnZ3a8HJc8ug2UI3TxrTQx1WwPW5SN/EKvR9XIniVfVnLnRqSVjc
 cR5Wuu1KKzrK5l2wAJWXtA/XUgqjsELjL4heDFzi7Fnc/WLEXOYlL5GMDc8JyqAQL2kg
 APnk/vuBuQGtWiTKUezu6pbYGvbsOaODsGnNvRMmSi02gQLXeQMgEFoMUgw8w4QPSz3b
 v1wcS4jX5Ej6LnoGvebDXb2qHA/bXgvQzw6tAbr16CdBkXJa6NTBUQgH7SoOFXlq3pbn
 u5vTW5Egzk3zcT6p6F/PQMakXkj5Gmq0Uogq1VcO+YoxWU3xhvTSE1OpXYXaDprpfFCI
 g+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694088171; x=1694692971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLqQNsqhY0Y8Lz9dXWkAowjyYKyxSNZY8cuHuNL3H/Y=;
 b=VS88B9CdIQ/XaoqbcNsthJIIsZ6KdoPTfpebxZHE4Gdw21g7g7j1HXFB+gO8zPmbfd
 WvxDXe430r0uRfEwQ0xi655T2TaMrBMoZugR2UmzTp85cJsEKVBTJILWxM+SfxJqteWR
 v5XqCwDmkaq5gkMVrxlUzAm6s5MHTUfMj5lGdiwI/bXtM/Ow5DnlaRDWmPOntwG1WerR
 eXKeFpO8O8JGZCimVhD0fEA24/4hNH3KnweE/8CyJ/GSVxBhOb5fWDpob9ZWxOwYJbYn
 SooZb/CvEqEOKnWml6i9ASbq1U1+YMHN1B9hCdCirc2MsP52qGZBZhIUEu86lt2ectyS
 B2Uw==
X-Gm-Message-State: AOJu0YyFSwyPky5HfGQiMqUPkkqdXbb9iOfAlQAbsmQX6LK2VG/z0xYN
 gx772c0tsAjpwXfJETMmRdy8e2mUOREckNIXOK7COw==
X-Google-Smtp-Source: AGHT+IFmhYA6vsjvGxHmw13m9heHTCrsaOLOSKxO/ZQtqsHct4c4SVFMc9YKRyfau4z//xoFCIlfSe74C1/7veF0fcA=
X-Received: by 2002:a05:6402:3d6:b0:525:6588:b624 with SMTP id
 t22-20020a05640203d600b005256588b624mr4434960edw.37.1694088170805; Thu, 07
 Sep 2023 05:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230907113500.185276-1-thuth@redhat.com>
In-Reply-To: <20230907113500.185276-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2023 13:02:39 +0100
Message-ID: <CAFEAcA9MXyJN7=mYAydfU29NLzPUmU7F71m_2igP+NMSE5SQEw@mail.gmail.com>
Subject: Re: [PATCH] trivial: Simplify the spots that use TARGET_BIG_ENDIAN as
 a numeric value
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 7 Sept 2023 at 12:35, Thomas Huth <thuth@redhat.com> wrote:
>
> TARGET_BIG_ENDIAN is *always* defined, either as 0 for little endian
> targets or as 1 for big endian targets. So we can use this as a value
> directly in places that need such a 0 or 1 for some reason, instead
> of taking a detour through an additional local variable or something
> similar.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

