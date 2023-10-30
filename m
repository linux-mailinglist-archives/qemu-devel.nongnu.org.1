Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE67DC08A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 20:32:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxXxc-0008Ho-LV; Mon, 30 Oct 2023 15:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxXxR-0008Fz-3Y
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 15:29:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxXxN-0003DN-I0
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 15:29:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40838915cecso38351655e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698694186; x=1699298986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zz/c5qRhmk25KeS7JhdHZWGPDMabMMnOT7nd+wAXAwY=;
 b=A18o3k3GqtjRIXQIRqMbnJTyWrbZD8sjNSMNBkP9AWNdsCXcHM1VhX3YNqeHOuPsTD
 rpsqO8I39cY+FtJoQVgMwCKm+HcxU3JpFMaZTe9yIRf/t1+BtJA2NNji1nxbRkCkeGyv
 U8JBIiQ+k1lGDxJSHGoCBZLHb2lppVXZ8R0GbDaYQP8zeTt9GcbXhYMYdxqbcHtBT1yB
 PrZx6mB18TDP7kPXWYkIElR+EfXAsM9MDLXn/VM+ADn5P3gapkLvPM0w2bfS7tgYNEYn
 jiI0VepXWA1Gk8Y5I6hG/K8ovJf1p4rGbvNV8GAKOH7b5u+bwM+b319rEEIFnfG9oFNy
 lymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698694186; x=1699298986;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zz/c5qRhmk25KeS7JhdHZWGPDMabMMnOT7nd+wAXAwY=;
 b=amGqacCQ1wz9SGwnLDLGQcYWjYYAoF381SjP9mpg7hFd6SX7iHJpQH3Htht3PvXkEM
 jcFPjDhCi9H1R5i7S1d/VThpIvUnQH1GjC5CUJkTB18q3E9ZxKubTuWP9NfrZYpIAPIF
 l3IKd5pO1hVo7bLev0uv2elMRzbzTdXowVXIBZG3jBiarhAIKvGKVQMCXCD/5B/09FfC
 psO5SUIox4QFhFjaVRyIaGCY5E6LeixwCD/sR007u+6BZfOu6gPHX0Dsn7qOZAY95t0n
 1jnBOUQgeNNxaCncjkyuFRuoqVXbVUQceSJabgfdCL90uOVwtvXfQCoFNL4HAoK/lVAx
 rSRg==
X-Gm-Message-State: AOJu0Yzd1feLsib946kOL5xcJD39buUA4IoMPvvVOwAEyBs58fZ52MON
 XHfeyMWP43pG3NPr16f+MeaeCA==
X-Google-Smtp-Source: AGHT+IES/D6uT2blx+Hih2SK5XA2R0zLCq40mUNY4zxPInY5n4uXiRThEzn7nCOvmQRUiC0CVz+eNA==
X-Received: by 2002:a05:600c:4fcb:b0:401:b204:3b97 with SMTP id
 o11-20020a05600c4fcb00b00401b2043b97mr8842841wmq.4.1698694186426; 
 Mon, 30 Oct 2023 12:29:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h17-20020adff4d1000000b0032f78feb826sm6824497wrp.104.2023.10.30.12.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 12:29:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B172656E5;
 Mon, 30 Oct 2023 19:29:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH] target/arm: Fix SVE STR increment
In-Reply-To: <20231030190354.94671-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 30 Oct 2023 12:03:54 -0700")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Mon, 30 Oct 2023 19:29:45 +0000
Message-ID: <87ttq7vrh2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> The previous change missed updating one of the increments.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sv=
e_{ld, st}r")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

