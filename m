Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C47CF906
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSDL-0003Fa-Kp; Thu, 19 Oct 2023 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSDG-00039u-6j
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:33:19 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSDB-0006q6-PO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:33:16 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507c5249d55so3429171e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697718790; x=1698323590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4iZjkjBPZcBqvp0nlccZJxG/XU2MklVmuRIjMW3mjM=;
 b=tthW/1nyIySPaW05rn9eFbpVXLmZemt/bB2JNtjl0mO3JXR9QhtPkZG4E0WaqRFYVU
 RnucGnWjSWsdxt2RnOvfP6SnNHzOrtJGI/Rm7iw3OHTVqb2milGlsKGIpEUVfi0z76qh
 AvS5VPMAiYI7Rmcb7bHXYBm0u0dPKy2vcPnvex3MqeAxH6sAE8985Q0hXsUxhYH7kqdA
 8za2gCKKkFyGo+OLzz/7L3vrE93jWxh2FoM8V9bsXBLbLTh05Eo+PRIPnT7Zb1TBh459
 MM38pPH9Fa6MEp96ZHxS2RUZC/e3y8IDSap0VR4YzT9oFzh5iTvgT2Wy5/nRPunckp6/
 Ki9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697718790; x=1698323590;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V4iZjkjBPZcBqvp0nlccZJxG/XU2MklVmuRIjMW3mjM=;
 b=gn7FgDMcDBKi5Q6E7qUzlT+MNzNChW4LaQIhltaICpOAehdpcwTg+xjiZsTaJFivc8
 otF9G8ygVBWFQlV8ZXlirmj5zPS4r97wktVTNPG1KcpyiNQLxrPr6id/M6BUtGfMHwin
 6AjHUSzfvQL49Hq0TT7IDfMLKhRMx9q+KTqLIaXi3TfNgVysU23zSfjTa7ertl7wE+JH
 wW2sZrEX6PnBX1g79M0E9luqFZPjNNIi+RMbxO1DkFQY5C3/qhHgLL9nn89e8Gmq+8YX
 kM4YMFwLMUqz8ytbzdvgxktdw7+OMeGJT+x7h2o8DUvKiD4paIKkyXrWHy+3jJJpvUHq
 Qukw==
X-Gm-Message-State: AOJu0YyR+gIssSNVXuJoqcH4J6+9qpba7ArEur5doRYVsbU3oiayVZNQ
 hRtGg0+SIpSkC7UOyNsEhISKDkq+l+qz5i6vJPM=
X-Google-Smtp-Source: AGHT+IHhwHQPtFM0uRqP5nPfbK5QPErL1i+/MXg70rPnXkmTZ5yw4vMn+txy3CSBLT/c2xLPywodNQ==
X-Received: by 2002:ac2:53ad:0:b0:503:55c:7999 with SMTP id
 j13-20020ac253ad000000b00503055c7999mr1537605lfh.34.1697718790368; 
 Thu, 19 Oct 2023 05:33:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a5d6741000000b003200c918c81sm4386330wrw.112.2023.10.19.05.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:33:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A7EF1FFBB;
 Thu, 19 Oct 2023 13:33:09 +0100 (BST)
References: <20231016154049.37147-1-thuth@redhat.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Brad
 Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>, Kyle Evans
 <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/vm/openbsd: Use the system dtc package
Date: Thu, 19 Oct 2023 13:33:02 +0100
In-reply-to: <20231016154049.37147-1-thuth@redhat.com>
Message-ID: <877cniaj22.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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


Thomas Huth <thuth@redhat.com> writes:

> We can use the pre-packaged libfdt from the dtc package to avoid
> that we have to compile this code each time again and again.
>
> While we're at it, the "--python=3Dpython3" does not seemt to be
> necessary anymore, so we can drop it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

