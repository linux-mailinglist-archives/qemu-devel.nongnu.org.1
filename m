Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A56970E278
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VFe-0000hY-6E; Tue, 23 May 2023 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VFa-0000dz-Pl
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:52:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VFZ-0005vZ-Bg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:52:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f607766059so584645e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860760; x=1687452760;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbxdRlLt1QBXSBE5S6WfT5I5aAOS1544DeYJ9dIXrnY=;
 b=eJ/7Dqf7tfLdnH6PljGdmn4nXUIS+M0EKrnnTZFK7xS23IR69g3KTSy/MVYK3eYneK
 rr8AVjy+k3QWALJiOjztmNUjUZZhNFqLytI550Xu+uPce2WPB6CjuaEcpAKrn9bYsJZq
 uWrkIkvhofX5SeoysQMxOlssIGk1LbYM/DQblAyMqcszGcxZqiNvcSFGg0K+hekMCCNj
 cNTgz2DRfiM6Qaq3eQ7rwX01kDfGWvbT47xElqkl54QMWd8HocxSk0rfXSqKgh+PS0vG
 i2s+uq/9cXXWF46EZUI/yEbrRrbLc7DAAjBR4IqRYoExQvZ0cdjYhIYyxJiPyUcf5fAv
 Qurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860760; x=1687452760;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WbxdRlLt1QBXSBE5S6WfT5I5aAOS1544DeYJ9dIXrnY=;
 b=iOTjkSva/Xqw2f6CPiAQELcveIn4jDGM2wvxvDVguYoSBa+AB1AR5W+JiC9YKlJ++8
 DALOQ169J6xERQNOFF3HtUV6HJ2D8C1dHTec3GwYSt8hUkNq5bALxEfg2h4Rpzkoewmr
 AH1pJz1QLbvLxpSnJ/j5MBI9i7vlpCjpdls9lh1k6Aeez4dr6AfBQBq/IgqAq1S1W3yb
 WgzAe/OnG/jZXf+uZb9ZfHi5ZkBHKR3N5SqdLo8FXM3zk7buhP1/cq8VphFd23C9al5d
 HihNCdpFRj9HAgQZ0Bn1RZy1A8gQE9QD6LZLN0Dga3w3q2sQ56D8/GYSA5QvRYR48ogM
 MqiA==
X-Gm-Message-State: AC+VfDyoSclRJ0KvtOR1bdvoWTaDeldG+8KkjoeSa3ZEddAbP2atdAXZ
 du3HOegZYMUZ5sQrQy6zKeSAaQ==
X-Google-Smtp-Source: ACHHUZ6y6HROGpAu65NUPukxv6psJlT2dbvT+j3emKTLmOmSpPX5qhyHVeMBTdflRzMGdjLIOQCVvg==
X-Received: by 2002:a5d:68cd:0:b0:307:cf55:a7d8 with SMTP id
 p13-20020a5d68cd000000b00307cf55a7d8mr10968038wrw.42.1684860759814; 
 Tue, 23 May 2023 09:52:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a5d4243000000b002cea9d931e6sm11588168wrr.78.2023.05.23.09.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:52:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 235511FFBB;
 Tue, 23 May 2023 17:52:39 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-25-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 24/27] tcg: Split out tcg/debug-assert.h
Date: Tue, 23 May 2023 17:52:30 +0100
In-reply-to: <20230523134733.678646-25-richard.henderson@linaro.org>
Message-ID: <87zg5vxa5k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

