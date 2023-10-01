Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383D7B4923
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 20:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn11E-0007k2-Ox; Sun, 01 Oct 2023 14:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qn11D-0007ju-Ro
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:18:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qn11C-0002uP-97
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:18:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4054f790190so149622235e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696184291; x=1696789091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+26Utzs2N6ef9Ikil3Ugy/MDC38C7Hgdb5mxcW/SGSE=;
 b=Rb8WAHM/uHRlaFjbp2n9vJe6w5hNpQImhS8xdBuiy+PT7nfrWhwnrWw6yC0+ffNgDe
 8fyxzL54ItXchNfNFMXNU3mLXDXPfJu4P4/91Ay70F6dMVLK54dWJaQS7nKWgr+lP6bl
 JmmGlHOp10eyYpRctzgZiltKDHbe4RjTAQJpv15qA9b8fpXuc5Oa9EsYpx401PMUoL3O
 xz+7j419hbPORbiig2xr+5x09/ETbljs8djvq5wRWeBZ5siypbVJSIjromHgZ9C01es5
 onZzgVDPpj0MKaibHV4K3z3N/FMXxLdQJcejJ3rvF5m+nLWOKt6b39rUMr4ucpnwwMQR
 vw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696184291; x=1696789091;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+26Utzs2N6ef9Ikil3Ugy/MDC38C7Hgdb5mxcW/SGSE=;
 b=IKRjw4ZlvljVWmARsfEW9jMHWVGs0pU96KRd9SQeX8oDYfp9RGEcNwCcSvrZvxSP3i
 X/0jH8glONtdJ9+mjbt3MXl+oVtEnMWwjqJPV4ai81ErTN5UFt2pxi4cnVsnhlVakcMQ
 EoLjN0nufmX1Mzy6m2xJb3gzoiBhC0bcXCVYkDTcEiDsN8zGFxmX3kTZLClEn6rbkrWx
 SPCmfRs1Y2dIp6hXn8m1v2TPuumeHF8d1HIYnhutLT+yboUHaN1w0EdhMwyAhr5Z1cem
 0LkvKg8sifmjSS1C5yk99EeWc9maNKA4LQiUB4QfH1waEx3UoV+wnL7oOmvuTYk0Fzyo
 Tyww==
X-Gm-Message-State: AOJu0YysmHRwHyMXj/x9AvsLszZuEfFsj9bADAkUyNhPRgA8CUF60TF+
 E0jiy7MhhJAw8ZcEWaZoz34LVg==
X-Google-Smtp-Source: AGHT+IEoBhT5L1QCvSIGpg3vAhMQpN2q9zCiesbxE7HcNXRMlqBZlTbIGZBZO7LQeqbhJGMFZxPGWw==
X-Received: by 2002:a05:600c:601b:b0:406:53f1:d629 with SMTP id
 az27-20020a05600c601b00b0040653f1d629mr7556251wmb.5.1696184291154; 
 Sun, 01 Oct 2023 11:18:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a7bcb8d000000b00405953973c3sm5755877wmi.6.2023.10.01.11.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 11:18:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 457971FFBB;
 Sun,  1 Oct 2023 19:18:10 +0100 (BST)
References: <20230930181841.245024-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] build: Remove --enable-gprof
Date: Sun, 01 Oct 2023 19:18:03 +0100
In-reply-to: <20230930181841.245024-1-richard.henderson@linaro.org>
Message-ID: <87o7hi2om5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

> This build option has been deprecated since 8.0.
> Remove all CONFIG_GPROF code that depends on that,
> including one errant check using TARGET_GPROF.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

