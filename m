Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482B74BD93
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 15:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI7f0-0001lR-4z; Sat, 08 Jul 2023 09:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qI7ex-0001l4-Mu
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 09:07:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qI7ew-0007mO-6P
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 09:07:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf15bso359835e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688821652; x=1691413652;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9PTafEz+p5H4RxCzNKIJLt+WvAXL9oABrNq8ZxEobg=;
 b=F4Iw4slRS60HcTYLS/8tSz37aK+BqQGRz11A0r+T2ne2bAGTvLa/fDJUrJtiVXt9oX
 9IklfXla8LgQnURNLu7Vqm9ixN+f8+so71RFKRC00UjDFlfWWI5w5f12JUqmTdIm/w5N
 lh0KXcit9CUkqs0OvRkx9i4js8ORntTfKr6VIeyEjT/rgYf2Ah//iEDhy4W0K/ZTMykH
 ha/7zwM5RcPU+E3Kf/JqI1+p7hueQ5C1WrxZ25MLQZ74OrLhAR+OlaZtTPJVdVclwuuW
 baY4Q9nrlI8boCJ7sXIpxQxmxvCRgFB4kZnD6DrGcaAcNMs8UImYGNP4oWEtrKpxoQUr
 HUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688821652; x=1691413652;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i9PTafEz+p5H4RxCzNKIJLt+WvAXL9oABrNq8ZxEobg=;
 b=kIbGjY/cTGJz8w5hQA45fAlo3ekYJkweJcrUu47dhZ80SQKPpfIeliI6+xGoBBuLV9
 Ifotqj/NrxaxNg8upRDJCcIrU2HoQgO75/oqhDvCa/uYlSkAqObnyB1uizBQIlaEj+YP
 RjAosTinsfg3pJ/Pn1EqF8KhBGtP4RrZCYziZiKs4/kwmZ3A3B3Yeuvql0YbfTMDmXCp
 yZ0J12Z6YI+aW9+cX1MyKk+Y83z9u0HIjBubatdOzRK6A/V4hPzmJiI5cjdn6LsWYotm
 YUbT4kF761otaq1nQWK725uriwarbbj06/IMQyTC5Ic6gqmrFBecIlUOak0s94EN+ok6
 N2rg==
X-Gm-Message-State: ABy/qLbKHy/UtUNh7UXP2kzld+JyWwD4KEAaOoKB+KJ4jvY1WsgqLMWx
 r0nOOnlyReyiKqvNJVALez4q/G0i2kr9oP+Lc5Q=
X-Google-Smtp-Source: APBJJlGyWr7wZPds5dYPLbYJzAg4Xup0pGiTzXy1CWNki7eD3tvzQ7t+T+OgNJNVywodoaQrNuZ6Vw==
X-Received: by 2002:a7b:c8d1:0:b0:3fa:8fb1:50fe with SMTP id
 f17-20020a7bc8d1000000b003fa8fb150femr5934064wml.15.1688821651535; 
 Sat, 08 Jul 2023 06:07:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a5d658e000000b003140f47224csm6982378wru.15.2023.07.08.06.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 06:07:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD2031FFBB;
 Sat,  8 Jul 2023 14:07:30 +0100 (BST)
References: <20230707204054.8792-1-richard.henderson@linaro.org>
 <20230707204054.8792-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: laurent@vivier.eu, mjt@tls.msk.ru, "Richard W . M . Jones"
 <rjones@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Date: Sat, 08 Jul 2023 14:07:26 +0100
In-reply-to: <20230707204054.8792-2-richard.henderson@linaro.org>
Message-ID: <87mt06k0vh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

> Share the setjmp cleanup between cpu_exec_step_atomic
> and cpu_exec_setjmp.
>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

