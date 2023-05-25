Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E7710D49
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B4T-0007uo-4K; Thu, 25 May 2023 09:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2B4M-0007c7-AT
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:31:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2B4E-0005yD-8D
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:31:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so4605435e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685021487; x=1687613487;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D01E1oTPlhhO4vo+N4O/r+ggyvkehI4W5wHdmiZ0c7k=;
 b=s5GbYEG0+4q1cPGp5ZklP5M//rfzh6/L8ICZQzQB5qfCgb0DfkjUM9mTwg9KuJ+Zz4
 AJXEh0qQbSlzSEVSqDPdsunnvJh9/27o2MxnEcXhKbJ4mMAhbKVfpC0Wt3oG3YL2/UFh
 1FZrS+2OQ4SCqlacbVQkLJXvdrCH+K13UOWClL+ZtpMdaWR8uIDMqfxdAFFhqx/Q16dH
 LqxM3AuY6phb5ttm1Mkj/X9QUZFx8JJOlyrMLDiAecoUJM1NAvXy496BcvySL+BKbXJb
 TpNM10R7o3su/p0fgegAxoSkZhaSJwfiMNMbgb6/b3GvjnUUHR3H6JsDl4mdGnKxOufL
 sj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685021487; x=1687613487;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D01E1oTPlhhO4vo+N4O/r+ggyvkehI4W5wHdmiZ0c7k=;
 b=kbw+7Lr/zuu7Yv2+UvrmOos3l9zqi1GROsfddyV3Btx9WaYb4UDZevIKO4Z5AK8nPH
 9FRUMaioH8ydHZ9VCNz3Gap96Q93ZR4DF4za/8a2D1mvGDS1QMeBDvPGVJcRa3Pk4gad
 NGVM391sXkoD9IK+XKcUj9SpqiDY0yVxBsmE+ZdGKxIxL3mczLE29F0oSZX6k0bpFCKB
 8ovrb+YSZ1RfmtFslan6lZYRaiJB8SPgebGLQnjGjxBOJajcsjE24DZVhvshWBvvNYRg
 BsiwbeX/ZElpHsD9B92PoSZzPL/J3yQVa7PuYqiiBoxg5CH6v5jy4NYwJK3foYFm+Qvi
 y1hA==
X-Gm-Message-State: AC+VfDwwsDJ0k/AgMjZ2+9lI3RuVlQEb6KkQ7wz+Ob+i3bZk9P6lWR5E
 OKWF13CrEdwOquP/Pf35zKjVYURuOgpNGd46VuuyRQ==
X-Google-Smtp-Source: ACHHUZ4QUuJZi0NHKw86in+USBds+h5QScjXgAuA35IfE3E3gFfFS8Jc2P8Y3qYpqhcL6Tq1T0Likw==
X-Received: by 2002:a1c:7415:0:b0:3f6:11cb:4926 with SMTP id
 p21-20020a1c7415000000b003f611cb4926mr3205605wmc.22.1685021487376; 
 Thu, 25 May 2023 06:31:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm5789227wmd.1.2023.05.25.06.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:31:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD11E1FFBB;
 Thu, 25 May 2023 14:31:26 +0100 (BST)
References: <20230525102844.209240-1-pbonzini@redhat.com>
 <20230525102844.209240-3-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH 2/3] tests/vm: fix and simplify HOST_ARCH definition
Date: Thu, 25 May 2023 14:31:22 +0100
In-reply-to: <20230525102844.209240-3-pbonzini@redhat.com>
Message-ID: <87mt1stu4x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> ARCH is always empty, so just define HOST_ARCH as the result of uname.
> The incorrect definition was not being used because the "ifeq" statement
> is wrong; replace it with the same idiom based on $(realpath) that the
> main Makefile uses.
>
> With this change, vm-build-netbsd in a configured tree will not use
> the PYTHONPATH hack.
>
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

