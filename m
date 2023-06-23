Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3D73BC01
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCj1K-0005Ev-Uv; Fri, 23 Jun 2023 11:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCj1G-0005Em-KM
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:48:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCj1E-0004yx-Tc
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:48:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-312863a983fso864556f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687535294; x=1690127294;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uun90XmMgtNIGN2R8MbzvADfpdj9cx5Pq5jccLYjNsM=;
 b=tJsdW+dn2unaqx6zkSbMTi1xfY3hsSkxOPKvbTLzb2+oaaTgHH0O0SIH7Zk6GH3FQX
 CM+PkZyrJaaI2hf/EKf0vD4jU778AX+r2eehO640QCM5uZxtSPmyO6aKw2OZEVw98NA0
 EWxE6kbi+LJRYm24BiNR5OXPjq9qLhaqI2pkJfD79x+HOQjOqFafat3FYyWckzlBulny
 IoFq25N+8AKpZauYcO+FATDy/Ut8ZDDG/49v0gpwsq/0zw5Q0ipNvQ13TjpDRlArpIZl
 Zf7/BX4Go3CqgSjXElasWbIkPiVEmAa3obBky/WqrmVjctKRwWAJQvo8wE6RoCoeexho
 uyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687535294; x=1690127294;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uun90XmMgtNIGN2R8MbzvADfpdj9cx5Pq5jccLYjNsM=;
 b=ffc7Fj1iAaV47N42J4g/KClGfQjNTRfWiQyUDzEQoOm7ftW0qdEIDufRHd4ehQivio
 adZaHoQx+GYmBoufLbagpMKAYr8IwV+SEOxXsaGOUU3EjzMtz+IcVa/vU3XC7jLzPZ3L
 Pk4ugcJuriF26pK9zD82IGD6A0cNLbE/kUOZMF9heUZ7EJVlFLj13uzzpo8D0ftehNzL
 PvBnJ9Zm3IwwqrNbLipDEcSf4PjfevdZ02e34rKlNlwMSFAIxTwveQMDLLQYb3t/47OA
 +LiLfgYulxCxmtDMd0sGAHtBxR6/tImzO/ta6TXNNlHqRa7awpRvfD+e0kRwAzywqng5
 fczw==
X-Gm-Message-State: AC+VfDzqbWA/X0l6GzE6Vr/9lCGqKzfOKddeTR5qSbfbPT7EHIBf5zuH
 wfb0FTUeqbiUAK7XLM6Q/xFAg7gWDeWNH8komVU=
X-Google-Smtp-Source: ACHHUZ7dAn+f/Z8ii9SPB+JGcNdxPPtXCQysaJI78tTaTDuQtbFGTbuCf29wEeQZfOgXFJ9u79byVA==
X-Received: by 2002:a5d:595a:0:b0:30d:d85c:4472 with SMTP id
 e26-20020a5d595a000000b0030dd85c4472mr16452697wri.62.1687535294553; 
 Fri, 23 Jun 2023 08:48:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a5d6545000000b003113bd9ecaesm9785206wrv.116.2023.06.23.08.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 08:48:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B14CA1FFBB;
 Fri, 23 Jun 2023 16:48:13 +0100 (BST)
References: <20230621111520.1390967-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Fri, 23 Jun 2023 16:48:08 +0100
In-reply-to: <20230621111520.1390967-1-richard.henderson@linaro.org>
Message-ID: <87ttuydvsy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

> This is a perfectly natural occurrence for x86 "rep movb",
> where the "rep" prefix forms a counted loop of the one insn.
>
> During the tests/tcg/multiarch/memory test, this logging is
> triggered over 350000 times.  Within the context of cross-i386-tci
> build, which is already slow by nature, the logging is sufficient
> to push the test into timeout.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Queued to maintainer/june-2023-omnibus, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

