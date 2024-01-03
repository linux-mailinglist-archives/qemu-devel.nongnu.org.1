Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51C8229F1
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 10:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKxEZ-00067F-Cr; Wed, 03 Jan 2024 04:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rKxEI-00066l-M9
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:08:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rKxEH-0001KX-3w
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:08:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso63163455e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 01:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704272872; x=1704877672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIcKzjZjSPa3A3hp55Tv6AE29w9HZt5CDLYKDVjAZ5Q=;
 b=pGOJiBMw37y0b8TwzbbP0FFGEr9m6r9TnlAQiSbZoXrcv3Jf9OJzIyqTXj+hqE6jRf
 t1GAdvbVYI0sBUxLaKyz5zQk4nr8PjxrTH+D3cwcijpEfxNvCCOPD2B3SNLYtDHriv8F
 MRjkE7isUDfnnnSSFyRiHc1U0CVSyjv3SfBqqwbZVz6FpQ3AK0POi7MKzUvABIi7TTG+
 OMIOAUJD/pPA+oyuTPKoILphmYC2rtwJxjcltXJvi1NTFRZAVnqU+VM5oLJz+/zQAzSI
 S8KoRzzuKJnM592ECBbnMCMNymwu+6WG6/8BETGPOanUpNLC80yLk0ZyQGYNZyrjOuqA
 wVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704272872; x=1704877672;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kIcKzjZjSPa3A3hp55Tv6AE29w9HZt5CDLYKDVjAZ5Q=;
 b=XXRUK22Ew9MS5tjOkIIiJX4ZoE/BCRqOcb0Ytlvl2H6rNJNuPLYa+Ds37CAaplYWSs
 bWydqBSTGjC3yC0dG7j8LtNaO8OyX41P6uCz8D1xi1RhWUPbzHX5a72xzDyn31pEPwiH
 4MDahhxSLXPFRkVciNlPVY1/No5GhU6EyzI8PLRFhnBhwulxfsvIy/eDuf4y/l0ovxuq
 txGRE+SLmibwKXkdCHnqDVumh8AKnjivAjnbzNNOWZw0wm+STmAcjdxa1VkeaKjfV9r+
 S4vmc+JtCu9QFESIC1Aam7EU29cEmpW8nMTbDCRj99mk4B//AUSqGnI2OCbKL4nMg3u2
 aYug==
X-Gm-Message-State: AOJu0YwUJ9vYRozZwsqCtxTixaVHsJjVCRbDEqXlSVJ3o3BwHoLj1FXP
 YZiQoH38c91w/+8BGeMWyYUwv/qqD45cDA==
X-Google-Smtp-Source: AGHT+IHEIuyjaT/WbTw4NEXQZawAFa3kbH7a4vnSaCnw0MTw2unQGH5HqhEFjWH3qRafLPTNzpGNtw==
X-Received: by 2002:a05:600c:c84:b0:40d:8cca:c637 with SMTP id
 fj4-20020a05600c0c8400b0040d8ccac637mr1068899wmb.71.1704272872456; 
 Wed, 03 Jan 2024 01:07:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c12-20020a5d4ccc000000b003371e7113d4sm12701446wrt.24.2024.01.03.01.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 01:07:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B603F5F8B7;
 Wed,  3 Jan 2024 09:07:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 2/2] target/i386/cpu: Fix small typo in comment
In-Reply-To: <20240103084900.22856-3-shentey@gmail.com> (Bernhard Beschow's
 message of "Wed, 3 Jan 2024 09:49:00 +0100")
References: <20240103084900.22856-1-shentey@gmail.com>
 <20240103084900.22856-3-shentey@gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 03 Jan 2024 09:07:51 +0000
Message-ID: <878r56iy3c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Bernhard Beschow <shentey@gmail.com> writes:

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 95d5f16cd5..2ae271e9a1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2179,7 +2179,7 @@ static const CPUCaches epyc_genoa_cache_info =3D {
>   *  Conceal VM entries from PT
>   *  Enable ENCLS exiting
>   *  Mode-based execute control (XS/XU)
> - s  TSC scaling (Skylake Server and newer)
> + *  TSC scaling (Skylake Server and newer)
>   *  GPA translation for PT (IceLake and newer)
>   *  User wait and pause
>   *  ENCLV exiting

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

