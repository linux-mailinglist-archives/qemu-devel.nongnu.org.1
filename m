Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F47C66B0
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 09:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqqWM-0004Q4-DR; Thu, 12 Oct 2023 03:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqqWK-0004OC-Bb
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 03:54:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqqWI-0000cH-IR
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 03:54:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso546421f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697097248; x=1697702048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YppCOcj+UZBhzyVZEnIIPpu6MA6N/eXmfJZeFBb+eyY=;
 b=iPnKTQPjB7d10bhuYQAhGbZIY8kbbhUZ1F9HIgkszybhLMizPtvYIRzf3ukS3jSeOy
 eMM1qtoeitCgWcuDVQUsBLlsN9gEUbi0+Mfz97Id8lBRT76rH5FcMDLdwZMvBKLYVhC4
 Ui20ODe+YsfdmjOgfud5Y6AExoDCuaNO1uZLX7ZUpNegrIbFevqSvRkUNDX/W4a5JOfy
 Ny9BZZIRt/huAF5boF+FekWmGBW5sHIkQygKHk2zNwyn9qE91636oIxvoHy1aky6fJss
 vgBR+XZ3t1gXPd3xwwBkrzh9AIFqq2H3LkeTuoukiSUZaReeKvJRVZYRMinLD7FqgcSX
 I0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697097248; x=1697702048;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YppCOcj+UZBhzyVZEnIIPpu6MA6N/eXmfJZeFBb+eyY=;
 b=E+LD3sWa6gHavzvS7ltechXSWurt3OenEt5TtF+r1LqfQ6apvIhxu/DvgjjoMty+SX
 vTqBZG1bKsjCoooiEkKmT61uVb0aljo+0rswEjlTqzC7LGO1AblzG3wpKejFEPfVeeMc
 O2tIRp9s3gKR9dVhAkvZsy5d/FRyrINgFdyByaDqcaUGt+cKsA5odozzdqJezONmJlMa
 mD7XnKrYYyGIlUMb3Aexkeae9l/E5dtuaWbR+p0frfiCfG/6/4eo6dgzfF+VYyKmCAE5
 IamgYFpwm94EbxR57fFOSGXCA/9INcd885Axv/E5J9TZqd8AYeXwf7fI2yZI323sO5d8
 sWBw==
X-Gm-Message-State: AOJu0YzKd4tx5+GAsZk7TOd/ztjvWGH3grvPI4zFJ2sB/D6xZF3VvHot
 g9c97BWYOmKrMIwNRM5iNZHAmA==
X-Google-Smtp-Source: AGHT+IGKvIHZ/BpRKDJUrJ+hEJ5BW6UuEujYZyxvV0Jy5HkPYo2J+11Kie4MptSk1MvVhtRB8byn6A==
X-Received: by 2002:adf:fc0a:0:b0:32d:8b1a:31a9 with SMTP id
 i10-20020adffc0a000000b0032d8b1a31a9mr1866353wrr.41.1697097248026; 
 Thu, 12 Oct 2023 00:54:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a5d5257000000b003177074f830sm17551898wrc.59.2023.10.12.00.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 00:54:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 484011FFBB;
 Thu, 12 Oct 2023 08:54:07 +0100 (BST)
References: <20231012073458.860187-1-thuth@redhat.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm: Move raspberrypi-fw-defs.h to the
 include/hw/arm/ folder
Date: Thu, 12 Oct 2023 08:54:00 +0100
In-reply-to: <20231012073458.860187-1-thuth@redhat.com>
Message-ID: <875y3cnun4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> The file is obviously related to the raspberrypi machine, so
> it should reside in hw/arm/ instead of hw/misc/. And while we're
> at it, also adjust the wildcard in MAINTAINERS so that it covers
> this file, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

