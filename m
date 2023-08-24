Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7F786F02
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 14:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ9Qx-0007Z0-M3; Thu, 24 Aug 2023 08:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ9Qr-0007Ya-HR
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:27:25 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ9Qn-0008Pn-TT
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:27:24 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bb99fbaebdso102946121fa.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692880039; x=1693484839;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tk0ZXvv1tOxBFZnQeSj9o/7GEAQKtjC6MZ86caYJwt8=;
 b=oqbVL91FpeLgGmU3wbnTh+Tw7mVqhXFEEIPzEMI7oim5j6VQS8xJUtIqK6Ac/NufoH
 vyVySCMg/EliuqLy1mVpDljkAThfeI2LQa/bTMwvPPAFGd0ZiYCUTBtIJcsPojoJpLFb
 HMbtjUCTL/yIrbJblp4eeiv/uusTo7PNg7ltCloRFpMs6IlEnmAXLqsRVO4XzLpaxCA9
 tlQgeCDXWfYgEfdy0tvq9Se/UFpUz95A/Ru07/p4QV6ErHHZYdnUhk8zn6XsFxmXCdQt
 Z+mtlDAWUOUueNPe6+ljki37zbDbzpvbOllQHDJm22NJdXvNBrILJ6RXk3Mn3SdZtolR
 oFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692880039; x=1693484839;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tk0ZXvv1tOxBFZnQeSj9o/7GEAQKtjC6MZ86caYJwt8=;
 b=i6w+6zWB1kMQBLFR+qHw86X9Ol0u+HhZm0CU9mzJX9hH7WRcVyHfXxPT0qw3vc1+52
 orNM0W3tQpvOXDrqQEidpymWp9BecO839iMcuAUhW5ylUCp+Bdyup7VWj8r/mZBQVx/Z
 cgXXj45PTNjdwUmh6dMptduG14fX9d0XTaQeplNRwIpsx5ioL8mkYY0NIFG/TRg3Mi9w
 SBXlq1AX+IPsQoVkPS7C3oCscYWcuZhOr3FoZKjnb+/rWFxOyqSH7a1V2S6HlUkc/9mo
 Kql5DVM0vR6cKi9JBR0P6IdHWWUepuKFf3wHmyqhm3BPHklP6l+S6QQqvwc60kIkNiNM
 Avvg==
X-Gm-Message-State: AOJu0YyJZZ7bMBrZq9qQ7kev+Qk/BcSbG1g5wXiVDmbihT0ZRjNGmOs1
 JV+ufTyVTKi5HUWX5c+HbNmFoA==
X-Google-Smtp-Source: AGHT+IGWp4xU0iD14LDS05HZOB1pSOgRzpcwpzbrGDKbnV3pdsb0KRVFDxydWgN0WlQu+DSsuIqqYg==
X-Received: by 2002:a2e:3a11:0:b0:2bc:df66:5ff2 with SMTP id
 h17-20020a2e3a11000000b002bcdf665ff2mr3722323lja.9.1692880039536; 
 Thu, 24 Aug 2023 05:27:19 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c221600b003fe1c332810sm2509208wml.33.2023.08.24.05.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 05:27:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9952D1FFBB;
 Thu, 24 Aug 2023 13:27:18 +0100 (BST)
References: <20230823144533.230477-1-thuth@redhat.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Thomas
 Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Warner Losh
 <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, Ed Maste
 <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2
Date: Thu, 24 Aug 2023 13:27:13 +0100
In-reply-to: <20230823144533.230477-1-thuth@redhat.com>
Message-ID: <871qfshbh5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

> The FreeBSD CI job started to fail due to linking problems ... time
> to update to the latest version to get this fixed.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

