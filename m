Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C930F70E1EA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V11-0004AS-Hw; Tue, 23 May 2023 12:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V0j-0003u0-Ho
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V0h-0001pV-VE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-309382efe13so4846633f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859838; x=1687451838;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMcEk5XAqp7Vm6XpBgnhKbi0LOXoiRCObtJuOF1xeQQ=;
 b=zEnW4BgmRl1gqOmfE7hbkKsi+YYAstKpNmiF0a6X58VpxtA2Mi0GAkDCWvUYbn6dJZ
 FynC9WeJ281gLtifCkplouvysOmYxY1perFkEI1RFbg0b6Xs8WpUDA1I1Re+GDSF+jo9
 k2BQ6VfZZjWghriCZ6bQ/gzQNLuTwdE0ckfd+5J98/Yhvo26fnw2JjkrioOdpg2m/A4b
 9RdsE3iEoG1gOXS3Ry+s5D8QQg09nsTUP8+PHcSumtHy/K1f8aPjvm6ZMK4yelmeNifT
 J/d9/JFu2oyuWbt67fExA5ic0Todf8beGy7sNNA3paKt3y3ZO5pChTcF1tzMeuunqELy
 pu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859838; x=1687451838;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FMcEk5XAqp7Vm6XpBgnhKbi0LOXoiRCObtJuOF1xeQQ=;
 b=YHJgpRgkGRiIRLPz5KmkgP1E/AORHdpYprskfXgQ1NwhfgK3ygPL7cjxArIxXumqba
 yWCOdDBWF7aHhxQoNubL2FmSqVlF9hiK2Exi+EQNjCTFNhjZ42ud52R8HR4pQuMZe1x1
 CH7jazCW/SvKXC3jdY5EBZ/9KrzLILC+O5T98w7bL8wrsjsCzaH7BUmugbmWpmpdnrHa
 xfaeasjfQAUhUk/qja/52ldCZytwQPDiyyu7jKit7wUKYFtNP497wegLxvuApdq6q56o
 nSbjOMKKifKaURzPshBmjNMIE5nXPFr/YoDO8wvPEO0ZqlPjk6l5iZ8a3j6HLACdx8Ah
 +xfQ==
X-Gm-Message-State: AC+VfDwF2YebXp1cxq5UpaaAQZJPjUqyWQTuD6BxUAYA59/S5VSFDsHk
 f5klqYmrPEczeDRaezXXHaNRUg==
X-Google-Smtp-Source: ACHHUZ4JbvdHWttp6xcuVZDffWC8/vZ4nClfmyAPptx1z/am+Uznfow7AM3yj7HyYawv0G+Gt4S1RQ==
X-Received: by 2002:a5d:5346:0:b0:306:31b7:abe4 with SMTP id
 t6-20020a5d5346000000b0030631b7abe4mr10390578wrv.14.1684859838399; 
 Tue, 23 May 2023 09:37:18 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a7bcb47000000b003f080b2f9f4sm15732740wmj.27.2023.05.23.09.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:37:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC6441FFBB;
 Tue, 23 May 2023 17:37:17 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-15-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 14/27] target/ppc: Use tcg_gen_qemu_{ld, st}_i128 for
 LQARX, LQ, STQ
Date: Tue, 23 May 2023 17:37:13 +0100
In-reply-to: <20230523134733.678646-15-richard.henderson@linaro.org>
Message-ID: <87353n0zsy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

> No need to roll our own, as this is now provided by tcg.
> This was the last use of retxl, so remove that too.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

