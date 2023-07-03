Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F968745795
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFDb-0004BM-0c; Mon, 03 Jul 2023 04:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFDU-00049F-CQ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:47:28 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFDQ-0003JE-FD
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:47:27 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b6a084a34cso60924041fa.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688374040; x=1690966040;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aKOS5oNxly952rEbKKoK5WrKou4NEB8671919LU0Pw=;
 b=W4ZfsqueXdEGlhl5lr9PPgTB753ZYZmgshoe3Cy2wbmi4eC+JphOlMgRRZMDgvn+Zt
 xXVACIMRToAChCt29XeRrJ7gxhoQU65RYtA3YWnoEsPCsuNK8RczKuTsNK3uSQmDbTi3
 wucmTxI5IKTVvwnAIaGScbvjuv/e8rfvIQm4oKXelldLh/RzlH3Ykb2CObbw+yZIFXB0
 4eRd+syq2fHtmYHdwWelxMtF6ffmIcYlQZ1XwrEJSHzpzXh4mbYOAqS+e65aMMkWfoyd
 RHUwYTjh/93JyzmUjB+eWmYrbX1ADvvXXFat0N33r7zysJSPfui4tIVbFqBHA44/QTex
 TFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688374040; x=1690966040;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7aKOS5oNxly952rEbKKoK5WrKou4NEB8671919LU0Pw=;
 b=ZR7LpuKdkXV25GO3o1GI/YchQ+3vXfXo54MEm+oAasiSFmCTgB/GHGPPa606iMtqxm
 uUt/ldcvYC+7WuB50UgA6HS9ycZ8gnhzhdBnGzNDQqutzUqQtUsCVp+bWUpOo020QdHu
 VyTIQUD3xzjpixy9sPm6Lt2YKzvrXNOOoJyUgoYFF8pl/cEdJsfl+bNi+4QP+q77iWgq
 5D7z5pPhjMQtGBZfsAKt2feDeGy4x7oxll9kj+Rxh/m09Da+aDSP1j+xhmOO9cxwDT5x
 +Zu9uuRmsap+EHdvDamfkUkpJ3AnigOcdzkbfUh+MTWHo75f9zs6AOj3pBxV7COIPrfQ
 bH6w==
X-Gm-Message-State: ABy/qLaz7arhsiR1ZWkNn/fY55e3N8iggrPbP3K8rie3Y2Eqk8epWsOi
 Hg/4DOKsD58TLScvKuFbrSSQNJbsgt37GTvI4zc=
X-Google-Smtp-Source: APBJJlFT1jZEIqtAZBkx24nQYZfi6si81wp0zrKzNgKWU3o6BDA2cJ5sRbFUBVelLHZxI5dZbmMSEQ==
X-Received: by 2002:a2e:7c0f:0:b0:2b6:d7a0:c27d with SMTP id
 x15-20020a2e7c0f000000b002b6d7a0c27dmr4087835ljc.37.1688374040552; 
 Mon, 03 Jul 2023 01:47:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a1c7510000000b003f9b155b148sm29287660wmc.34.2023.07.03.01.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 01:47:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC8211FFBB;
 Mon,  3 Jul 2023 09:47:19 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 01/24] linux-user: Use assert in mmap_fork_start
Date: Mon, 03 Jul 2023 09:47:15 +0100
In-reply-to: <20230630132159.376995-2-richard.henderson@linaro.org>
Message-ID: <87sfa5jsa0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

> Assert is preferred over if+abort for the error message.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

