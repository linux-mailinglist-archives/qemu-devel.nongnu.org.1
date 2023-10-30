Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2497DC133
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:27:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxYqj-0003Zy-Hr; Mon, 30 Oct 2023 16:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxYqe-0003Yq-MG
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:26:56 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxYqc-0005YN-TL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:26:56 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso69400331fa.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698697613; x=1699302413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iaZp7y8XPyeIgvY/5BKyCg0ftQbeQm6BmnM+msZVIqI=;
 b=hb70MThobHzl1r9gqkB79rFkZVJ5TUF7ngpFgNkRbe3oz5+QP1uN2ch8NH74bq4bKZ
 iZENfH06SHpFYjwC3IH50Og+kCrIo6rnsHL7Qn+LZpy/osiUj75ZoeURj5D/OyLtNIhF
 q+omzSnwdwdQT/aFngCyv4C2mKNs7Y/eO/nXE3P/H5O9xbDTJpU94ZU3mk2CpsLdbFwz
 9gAtDzDLeztwQbsqkaD+D6u9DirYT5gHBr2QUQ45LZZN3cAqvStxuqsufeq7cGxfN8Bf
 7//Fz4Ie+KDlM4cYDpuRJ3GJjURi9mvly/3QlDUJxUDFntmTKTQCGJbauyZpwS9G/rKz
 iRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698697613; x=1699302413;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaZp7y8XPyeIgvY/5BKyCg0ftQbeQm6BmnM+msZVIqI=;
 b=sC3f1ia5RLY9mG8mB9ddJ7FGb/08z+t4Yo9RLakMA21rBjYA6KnIAw7QAfVbUy6hV8
 ocNAwvk9QzygkRpRwFHr4nAOkYfTHC5vojtV3KCcdiKjBzkV7sXmEfOraklEiVX/VmNy
 u9wwFcB202FdvagSZ61YaXx/c1d2zpmeyDa9nvspP4FPnk+Pbl3oe5lCkAaUQ+qCfa1F
 7QBPWI34f1a2l27pNFlgKUJjoqQV+zynN1433doKESF6JN+Y793OCSAcrOuigjiZVuo7
 xD/sInC0yUjoRe/B5ekgwKo6lcWEiRc358/82I3M/zsKXwOlHyter5TXweAiRhvh99Cl
 b4qQ==
X-Gm-Message-State: AOJu0Yzc8gPBEn8+ReAyK56jXAIhGwRdEBSy36h+qltmdr73I2MA2mpr
 pXUZsUh4E33iC+PGdil0DvnUGl7BR0xBF0ecYhk=
X-Google-Smtp-Source: AGHT+IHgZ+CCsjSj6OxCvTqe3QO4kysbdonK3g3vLEApu0lCNqX5yBRcoLFTPSbI92r/i7yp09yxsQ==
X-Received: by 2002:a2e:a48c:0:b0:2bf:fa62:5d0e with SMTP id
 h12-20020a2ea48c000000b002bffa625d0emr7396623lji.2.1698697612888; 
 Mon, 30 Oct 2023 13:26:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b00405442edc69sm193058wmb.14.2023.10.30.13.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 13:26:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2124B656E5;
 Mon, 30 Oct 2023 20:26:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  christophe.lyon@linaro.org,  laurent@vivier.eu
Subject: Re: [PATCH] linux-user: Fix guest signal remapping after adjusting
 SIGABRT
In-Reply-To: <20231027221150.19807-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 27 Oct 2023 15:11:50 -0700")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Mon, 30 Oct 2023 20:26:52 +0000
Message-ID: <875y2nvotv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

> The arithmetic within the loop was not adjusted properly after SIGRTMIN
> was stolen for the guest SIGABRT.  The effect was that the guest libc
> could not send itself __SIGRTMIN to wake sleeping threads.
>
> Fixes: 38ee0a7dfb4b ("linux-user: Remap guest SIGABRT")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1967
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

