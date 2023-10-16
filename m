Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2CF7CB317
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSld-0007O6-2V; Mon, 16 Oct 2023 14:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsSla-0007Nv-PI
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 14:56:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsSlZ-0001P9-51
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 14:56:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so4014463f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697482595; x=1698087395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nI2vt0OKcGQHsOj2ctnqeXVjH7nfJv+mkOLvOzgeF0M=;
 b=RQ0gEjY0loev/Yj6cK4opkWOQ0vpIsTLUmZlPJODCxM/d4wQ3U9MQz5QIdJhr+RhTc
 TC4Dv0tjoKj/Oq7HC+wvfJLfcy2Rcj2xvdjqOYm9URP5gw0qOOZP1VhCzY9sLH342P+K
 IDscJBbDgDXOTXjrgMsdTb1tiKqrnidyaMKVGzaaFCKwD89gKO5b+WPUdjvU7WBKrAMv
 eXreRBowjON0A9PEyics49FnyGX1bkezgRYYI4YTAOzcvB85P/6w4Fw0XPK1GUevHvtk
 P9ffOZAvJlV0dt29wcX3BkAJPGgXYVs6qthysKaobNyGjPSF91UW5HdYLqAbraIZt2kI
 gW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697482595; x=1698087395;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nI2vt0OKcGQHsOj2ctnqeXVjH7nfJv+mkOLvOzgeF0M=;
 b=YL+lFnQm157v7y+37l8mlydqrjtOA3D0i4glh3JtF7UK+2OHe4WVv1Al+rz99zut5N
 iWpY1UHZ2KsbJ2GwYRNAsnt+mfGlXOO0x5WDZtNMnvDEjP2fqpKkPAqF9MVhColl26wZ
 85x3V6k/a3HMEBxG+ZUnIt5DqDFJFnO0H8EExJl0PVreWM+VqW0PVW9PZjWAmA2cH5M3
 sBHbnlrIVp8Er2HTqadzMtQyHYZoN0DbTcvefXbzPqVq8uuG7K/XqaNqnDohW+9uQK7w
 h9+GDh7wf1+bGnnIWg8aU7UYY0lG0GFf+7kVCcNwrr9729aJ8UNInIyF49StUvwOOUnF
 YlcQ==
X-Gm-Message-State: AOJu0YyAhDTDBJdEiB8Z+aFzXytvNTx4WYnw4rD/elrmI6Rkzij3PdwM
 60fff0yjpwP0MzOag5THZp8FmA==
X-Google-Smtp-Source: AGHT+IFh+ELn60VQ/ButbH8wjNmvhf+YXmpQETzUxYef5aZRe+7Y2i3pyqFpgTfk0DQgicvEmQcTfg==
X-Received: by 2002:a05:6000:1c1:b0:32d:8da0:48d0 with SMTP id
 t1-20020a05600001c100b0032d8da048d0mr238196wrx.68.1697482595562; 
 Mon, 16 Oct 2023 11:56:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05600c4e8c00b0040772934b12sm7978726wmq.7.2023.10.16.11.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 11:56:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F0891FFBB;
 Mon, 16 Oct 2023 19:56:34 +0100 (BST)
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <f329886becdeaa9a0b7cc2d19a02b3973266151b.1697186560.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v3 03/78] fpu/softfloat: add fallthrough pseudo-keyword
Date: Mon, 16 Oct 2023 19:56:30 +0100
In-reply-to: <f329886becdeaa9a0b7cc2d19a02b3973266151b.1697186560.git.manos.pitsidianakis@linaro.org>
Message-ID: <87r0lubdlp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>
> Signed-off-by: Emmanouil Pitsidianakis
> <manos.pitsidianakis@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

