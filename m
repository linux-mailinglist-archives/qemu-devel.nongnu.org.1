Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564397C990B
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 14:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs0gW-000138-Ha; Sun, 15 Oct 2023 08:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0gS-00012y-L9
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:57:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0gQ-0004lH-JW
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:57:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3296b3f03e5so3174339f8f.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697374644; x=1697979444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W17WwLO/4nqpLC8Jwelaz5zD3p+vrkyzZkXpNS/dtYc=;
 b=Lm1UUAJO83Wj1t1IdVKh/TQGhDXxKe133o13+1Tl8PVWZ4+knbnuBRdAGeS2paxaSB
 Dcx/zL6AIjwpu+kku0djtwo39rzYz7XuBfyYuLJcZJ6Fpw54Vd7YQa6WkbHWoPiH+iaM
 +AK66rDDgXK5q2gCaKkOfiuRiCOmTvYQO897jhpZMRST98K0mmmDTu/oX7MDB6XmmirD
 W1BgmTbgdstbusSfUDD/ypLgEka0PLssrLUNGr13TXZo1/ciqsp+VQBKGkxsme7Suvw7
 quLzxsbIRze+gJfWOSmhIwj6cQ1O5MC3dby9Yhf2itzyuJoRIEA+ooCIqLdf24mVxGUi
 /hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697374644; x=1697979444;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W17WwLO/4nqpLC8Jwelaz5zD3p+vrkyzZkXpNS/dtYc=;
 b=a+kqn5kQHX+CQzLdygRkr1z/deUrEZHwpoBr+AKqA4R9k/pP09CSQ4XR1BTzx3eNHa
 3/lv12hM/2MznZdj1g7e6jvXYYGWirY1Y9BqI8KnxAveH8ir4Em0V9QTgLmTV7H3V8ox
 oNu8ZashZy8WvbOImSKjyFrrS+Pscf+uwWz4U+3GHPvJSp3eucp/Wr4V/ICPk5czAw3y
 zQvZ+k80gZZ73AbCcww4HXktH7WYWG9YovRTHpXAaMjSShfRQWO410yQqdHfqHi6EQ+P
 SQRsi4izvZW2EDzyykCjfVY8GedqYuEd7kGzRUC1DbRL4iB1OZaIrqDjdx/KN/t97XZv
 SQbg==
X-Gm-Message-State: AOJu0YwQA1kSY/P99f2kvL4PSBxMjv5JR7AvcCOnwV+EY3P1ShJPZKI1
 ZUJ6bIZrBWxxsysm7yG6iGn74w==
X-Google-Smtp-Source: AGHT+IHonWTdMtoTYemS9b2ObclqyLN7wyPxA/kimiJL4p++j3KIEhB/ZY5w6dljmQQAREpyWJlsZQ==
X-Received: by 2002:a5d:42d2:0:b0:314:1b36:f440 with SMTP id
 t18-20020a5d42d2000000b003141b36f440mr23861258wrr.70.1697374643628; 
 Sun, 15 Oct 2023 05:57:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 dh13-20020a0560000a8d00b00327cd5e5ac1sm10561851wrb.1.2023.10.15.05.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 05:57:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9FAA1FFBB;
 Sun, 15 Oct 2023 13:57:21 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v17 02/16] tcg: Record orig_nb_ops TCGContext
Date: Sun, 15 Oct 2023 13:57:17 +0100
In-reply-to: <20231003183058.1639121-3-richard.henderson@linaro.org>
Message-ID: <87o7h0xcum.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

> Remember the value of nb_ops before optimization.
> To be copied into TBStatistics when desired.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

