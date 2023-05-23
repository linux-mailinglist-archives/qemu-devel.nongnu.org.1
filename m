Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 096CC70E20D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VAe-0002gv-8c; Tue, 23 May 2023 12:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VAc-0002gf-9V
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:47:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VAa-0004Gd-RW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:47:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3095b1b6e02so3010877f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860451; x=1687452451;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjgTeB1EyLfSRmtIChJixytg6q69O/cwCyX1AIzh5bg=;
 b=eud/jwloJSJK2Jwn80FK9irQLpVby0obSB5rBZ/CBLjp5urJ1XuPpWUvOYTg7tlaHW
 WTT31LiosP0Uqfx3vYFCQSEFae2CwoVTb1PkhIegSGO6qxFn0OYdQ/LMyD1F5nJn0sVl
 Nbdfj/SDbhZXJ65/xjKsPl6tsvyoHXvqv2V7r2ubwpAIr1rW2gVyYZagszGD1dM1sqxB
 lfz/N6o4PSZi5ETN/HUgqDjW/4z+p5hdn3pcCSDbNVWAuc6Oo8OTB/+5VHSu7TdAOjYo
 vf4Axus0N7Q4yGHy5IT3bk9Hdglt+eVAuFZmn5vBWhdoosSnm3DbpuM8+Gki5zI/npY7
 /YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860451; x=1687452451;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FjgTeB1EyLfSRmtIChJixytg6q69O/cwCyX1AIzh5bg=;
 b=kar0SOCumvhGfC9oyUQHMRqN29R5fPtDVdq5J5Dk+fIWMJmydQNI7M4lWa46wSWFxL
 x1QsLR0E485flW/3YXYWAexlMPP9+aFYzJ3fg4uwMpOXvE1KsL0mKkNmatKmg5ehGVG4
 EaH3cckGpeczehslichqZNKUlT35/tS7r/8tExwMCEjTQe5S7hz/LCZpp8poY6PfkMrm
 zYTDrrbegjY2DheEg2d+MT0vL84tB6SM1g9hQgBaG4vVeSND3ZIj4Hkm7y0n1In+vSUc
 7hvTECqVyvY8ityPnj0E1aN6BtM+DfwfkdDcF4a+VGPAtlUWCziVUqHFUB/moTb4DB0C
 VO5A==
X-Gm-Message-State: AC+VfDwtdcwf6G+nyxUGJD/oiNuOqgOS2qY5FFEMK1a4nWWKqwh48AS5
 2/7Y+MboL7FY7jZ+iWzT9Glx7Q==
X-Google-Smtp-Source: ACHHUZ7V+CHajBqVvmpVpOHdKj5F22Sz2MdaOClGWwxqZLa9r8L6rbLaLAQKZPPtlK3kWck8ju4CZg==
X-Received: by 2002:a5d:43cb:0:b0:306:2c39:5d52 with SMTP id
 v11-20020a5d43cb000000b003062c395d52mr10502259wrr.57.1684860451528; 
 Tue, 23 May 2023 09:47:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bce09000000b003f4247fbb5fsm15378488wmc.10.2023.05.23.09.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:47:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9B211FFBB;
 Tue, 23 May 2023 17:47:30 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-22-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 21/27] accel/tcg: Eliminate #if on HAVE_ATOMIC128 and
 HAVE_CMPXCHG128
Date: Tue, 23 May 2023 17:47:26 +0100
In-reply-to: <20230523134733.678646-22-richard.henderson@linaro.org>
Message-ID: <87cz2ryoyl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> These symbols will shortly become dynamic runtime tests and
> therefore not appropriate for the preprocessor.  Use the
> matching CONFIG_* symbols for that purpose.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

