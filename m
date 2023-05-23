Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDACB70E27A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VHM-0004Sb-E5; Tue, 23 May 2023 12:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VHJ-0004S6-Vj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:54:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VHH-0006Mh-H2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:54:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so690615e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860865; x=1687452865;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO2otKlSh8vqo1YGutxfynq2qeuzepy4yK29z6tpG4Y=;
 b=OF/5Oe4U87PzU6K6WW8eQJZJj0EmDoSpQiKHc7qBaQK6+gSTu//w2N4a+4tfCwUEzX
 6N5Wp1OKg4IJHR9CAhLvznOCgAligTEScqMLWkzckhKXrTVMuVuoteOx40LyECvQYVJA
 n1YWCMaeWyguHQOlLjZRGc6OWlSLRibIv1C0zLqzBbDOfVNTcmCnI6XRJrKWDrLVK1NT
 AlwhIAbG7sbYouS0vFoP0DQNA5FuVIvT8CK5q1lvTcOThMBpQyWZgjTmTc1oJ6hE1m4e
 YOuCyDOKAytH17pRc0nXa0YZG9oL6D1iV1f53/7U18Wi7gvJ3hMefziZqfiTnEUl8fuY
 vM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860865; x=1687452865;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KO2otKlSh8vqo1YGutxfynq2qeuzepy4yK29z6tpG4Y=;
 b=UNQtbGMwso+SAv9jMXp59Rv/MnfZSd3BKU9iG2EPzYPly49qBvpwb3r/02YuYAWZp8
 EdUYIGKcNEwGf3FjVAt6MM7UoYFjSfsUYd9jcpKwzI2wSJgj4GMdvzuKM5VSYEOdXhY8
 Qnv3rNyIfve1TttixmY0qLNyAzqlrbVPBawKHunFbwSo1X7Gjodec/mTwWBYlLMJl5aq
 5f8vml3eSgTagZex84tFk3908iTlwDc1UaB1CNzYnjdyhmbINktLPrVzJxkYRz0kJoCv
 3gnqGMTr2vtEO+/R2NBdZC6S4khvC6UxalDIRFfExQN96T2uEkZsvr3jxrcjcWOWujHL
 XIqQ==
X-Gm-Message-State: AC+VfDyhTnuAk0Y4+gM7HOQqZjQIvUHKGBMHUqyapd59uP+3eNc+7PGo
 2DaAHcHIndM3SLg4lzLVwawZDFskojCH9O8RM+qEYg==
X-Google-Smtp-Source: ACHHUZ4Zc84E5QDwllTEqLaerosc9VmiCMFdAPmZ9Ov65tGeznFv4Jmus9LiVOWgIxL7IFxCx6psRg==
X-Received: by 2002:a7b:c7d8:0:b0:3f4:f0c2:143 with SMTP id
 z24-20020a7bc7d8000000b003f4f0c20143mr10942800wmk.20.1684860865563; 
 Tue, 23 May 2023 09:54:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a1cf710000000b003f4fe09aa43sm15618246wmh.8.2023.05.23.09.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:54:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CACA71FFBB;
 Tue, 23 May 2023 17:54:24 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-26-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 25/27] qemu/atomic128: Improve cmpxchg fallback for
 atomic16_set
Date: Tue, 23 May 2023 17:54:17 +0100
In-reply-to: <20230523134733.678646-26-richard.henderson@linaro.org>
Message-ID: <87v8gjxa2n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

> Use __sync_bool_compare_and_swap_16 to control the loop,
> rather than a separate comparison.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

