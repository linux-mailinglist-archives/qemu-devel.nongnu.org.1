Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87C70E1D3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UwE-0003jJ-Fu; Tue, 23 May 2023 12:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UwC-0003bZ-2p
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:32:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uw7-0000UE-6I
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:32:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so4841132f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859553; x=1687451553;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aGVtNqvP9C+1yDUCijYeyNXZG4LCQy53hVhBNf5zbA=;
 b=n5TdZnNmP2yoS4/75sNFs9ynmE2TSwIkHk0jFQ2b0lZ9cOL5rUzJ78uFrzKk1yMwUZ
 SNIG0fZ0ZBGTPO1KIKE/QKi6kIAKx34wJTxEiZyM/9SI/vjW6xSXku7kLgDi38wuVSX/
 tzrgzFecdFWnBw3Qj3UYVJOe8oZwrtO2XlN/kbFVA/3VYHN8wK2jZGN8JzUdXh161+PN
 g1g9kZrneEWyGlQ9quzAD6mIfp/iefiRypjW+wLGCNQimO5zcI+A64nrY1NV12EuNjKQ
 8no+BHfSvdXjQ84XI/2Loaue3D56KkooQnyhHOxtfKZ+WAxKQcRvj1MYurNPobO9vtbr
 iL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859553; x=1687451553;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1aGVtNqvP9C+1yDUCijYeyNXZG4LCQy53hVhBNf5zbA=;
 b=Yc6bjnrVQjcXyYkV/W5/uJIRmFsY2eJ8I5/krOa+af8cJUAUFZxoEi3Mu7nPgqBteE
 ccBfIi5lO2bXC11HHXQ+vfe3Zedn94wJNIbr3FUSDvYRdoekCkbZmrfHjmQS4edumNHZ
 M1bVhoqo3+ER8Hk4MIrDPSZiKu/xer2LSEWWueBVnCWm8uucKQt3H01rgdwdr6tTqOfC
 KtbX2DTnlZH/boDY5NdhIiUDALgIoxMnQnYnJt0Qzvz492vFlHqFismZKgy3C+5scJmq
 7DZEe1uuxgb0hW4sCLymc7Zwyxm57pCJHGU5uCozQx3W4wskswS7GAfpsGROh4JKHR5R
 rjoA==
X-Gm-Message-State: AC+VfDy4MtsfScKo12J88DnEZvdMQqpyaEqLPpSTCyXjgpqkJvh5EA/1
 Gudl9Ry+40ndDP6AqJWWE+L+Og==
X-Google-Smtp-Source: ACHHUZ6Np3oq786ZVKW4vpp5yRfKy0AS3wUgTStCRvXdqbZ7AnGlSeuvkugQARWVfMIQsjf6JXyHDA==
X-Received: by 2002:a5d:5704:0:b0:309:3698:8016 with SMTP id
 a4-20020a5d5704000000b0030936988016mr10497347wrv.18.1684859553693; 
 Tue, 23 May 2023 09:32:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w4-20020adfee44000000b0030785b864f1sm11594016wro.65.2023.05.23.09.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:32:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 113DD1FFBB;
 Tue, 23 May 2023 17:32:33 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-12-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/27] include/host: Split out atomic128-ldst.h
Date: Tue, 23 May 2023 17:32:26 +0100
In-reply-to: <20230523134733.678646-12-richard.henderson@linaro.org>
Message-ID: <87fs7n100v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

> Separates the aarch64-specific portion into its own file.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

