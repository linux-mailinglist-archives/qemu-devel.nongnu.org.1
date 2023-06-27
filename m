Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA76973FA44
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE600-0002P5-3M; Tue, 27 Jun 2023 06:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5zw-0002OA-EQ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:32:38 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5zu-0003DO-Ts
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:32:36 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f875b267d9so6147642e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687861953; x=1690453953;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZmtbjl/vbaLGz6oT6u2vRHYpRo06QHC/0j1EXbEeDs=;
 b=IVYEdnjzJoMEIJ7cv12Pz+dlUnR+RtmyU9i6Iyk+VtMkvr+vQtOe8hk+IvHDWq0kAw
 NQXnmsPhcrLskdvcPh9FXh+kDbL/uaGjQYz71dSXEDUDtwhjvwI4fpxNl5qZ9S/5FXC6
 WkPJCC7nDffFt6Pt1X8QbNqrbzfnoBFuNt33qhXz6mARo85DiTeewNXRQcFn7OkudBnF
 UqyYYyEc9KFmUKYHWmkPY3+K3PyNtxA89cQxMvBeojL25soHj+aMUWROVX5z/FM5Y+3J
 QOQ0OOnRZO5/wBa99nfFG2x+hBVpIe+wcdJCtsKryYdKwEW/kL3qgwuZFnyRvgTqtw11
 liQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687861953; x=1690453953;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fZmtbjl/vbaLGz6oT6u2vRHYpRo06QHC/0j1EXbEeDs=;
 b=IFirjkpzyPG+eW2991xG6A3gM15rqE6uS6ngMU2bAh4WvBpZAgaOXumZtpCMuczh8I
 M6ETNDM15Nb3DUHKVpYi1etiYG/Vu3p0gtPIVQeAGFug2lmuk9Nu1NmPSiGHMRolmfUc
 HjUGzbPJOvETOgc73OpSURKlDvdTJFndq5vrd9mm+lI1tGqy2nddtw/JB6geIPxkQtjv
 UQKO+UTiIql0i3KVSOWDhTUL7G2/jvdfaeEZcMl+qp5Hy5TxpGTK6DlFP0koE1beCsIT
 oklv/PHaaCWODZdfisI3fPmosvDmJgzWENb2fDTgIsUrsKcqUcanFX5XFMUZdC/Zpydl
 UeGA==
X-Gm-Message-State: AC+VfDyWiKVdR6H3+pHv/pst+kCqVT6DwoF7SkAr+ANALZjxBhsB4RLu
 jh5fFFwwVJA2wJCMC+NSZJL2Hg==
X-Google-Smtp-Source: ACHHUZ4dk5eB3496GtzP2x/6wF5XwRSxXAq5IXFyxmuYR9gVfW/sq+5OkNgPZ03wj+X4XZgj20/Xbw==
X-Received: by 2002:a19:6558:0:b0:4f8:6abe:5249 with SMTP id
 c24-20020a196558000000b004f86abe5249mr16143280lfj.3.1687861952791; 
 Tue, 27 Jun 2023 03:32:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fa78d1055esm10283425wmd.21.2023.06.27.03.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 03:32:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C808B1FFBB;
 Tue, 27 Jun 2023 11:32:31 +0100 (BST)
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
 <20230527141910.1885950-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH 4/4] target/arm: Use float64_to_int32_modulo for FJCVTZS
Date: Tue, 27 Jun 2023 11:32:27 +0100
In-reply-to: <20230527141910.1885950-5-richard.henderson@linaro.org>
Message-ID: <87a5wl19hc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> The standard floating point results are provided by the generic routine.
> We only need handle the extra Z flag result afterward.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

