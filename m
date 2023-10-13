Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B537C8BE4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLVl-0006YJ-1L; Fri, 13 Oct 2023 12:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLVi-0006XY-Rl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:59:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLVh-00030x-1q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:59:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so26604135e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697216375; x=1697821175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mo/AXxM3FWS/Wq7dxNQH3bgsNykqjLSSf8jGD5leeTA=;
 b=tRh+6vSmaYyldwwunWkMaNKRgjRlWspdKRB1WAbk94RDF+IhecBE2Z5CjGg0+gI/PM
 Bl0+C6VqajuMZ2/qdAVIF/AGBp/bZBPf0pmGjFTyIGjxLnKETn5LkodX8OOmD0YhoPJf
 8d4mTdJ/U+kDFhybIUer1dBO4LeFFty9/RtFfGjYohsVkmgNX0+KZSve+elBmLgsuzGv
 QMexaHc0Jl6mbWHszp+3PNhyVQPUjyPOspukc84UncaiCVkkd339/i3O3bUSRDv7U7HM
 Ai/iAyK9FHF5V2CiMgDMyJqZDsiZiW14ZnyWwkjna8tjuShmGab9EmJcbE160DLpmjaG
 fZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216375; x=1697821175;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mo/AXxM3FWS/Wq7dxNQH3bgsNykqjLSSf8jGD5leeTA=;
 b=lZe1Ea6YkftngepuY03CN3WSGuU+JQagpTAD0kEQ3Ft21wgs7nmujN6twXJl1Oankq
 3rzLjnrGUVQs/gagWYPjvtRIRzJIzMzRWtwSRZpMP4Fg5qkroe0Hu2YIpCQuP6u+Aj2S
 88QSTpDIvQKboTAzZlZAAKUF6CCmtQmZ7ijgswOuU45QIv3CZz0MqZnWhGzYVXVr1tSt
 iG2TGawn6A/BCJFzBPQsZ+N4VJhyBgDkl7jJLScuyUK6+MdodC4iHUo4NDgzG0Zf7o86
 bamcawl05sW3lsNsmqUeHr4mqACyKO25RTh4Wen5TL29d5bCkX6ZutbUUtuhpHRm693g
 380w==
X-Gm-Message-State: AOJu0YyY1eqfxBGGuRO2HPTyY11UchxMs6qBCfb77Mwr/jNIw52n1z7e
 2AX3YzKrgJQBMyO+YxYVMqsixQ==
X-Google-Smtp-Source: AGHT+IGA7BIWuLBb5/9mt+lzK/2jG6wC426z/Wcgp6yWrXqq0uare16V4NXO3OTXUT0nuPxb5af9tw==
X-Received: by 2002:a05:600c:c9:b0:405:3dee:3515 with SMTP id
 u9-20020a05600c00c900b004053dee3515mr25368028wmm.27.1697216375235; 
 Fri, 13 Oct 2023 09:59:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 15-20020a05600c228f00b00401b242e2e6sm610511wmf.47.2023.10.13.09.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:59:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4AF6E1FFBB;
 Fri, 13 Oct 2023 17:59:34 +0100 (BST)
References: <20231013141131.1531-1-philmd@linaro.org>
 <20231013141131.1531-3-philmd@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny
 Iakovlev <eiakovlev@linux.microsoft.com>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Francisco
 Iglesias <frasse.iglesias@gmail.com>
Subject: Re: [PATCH v3 2/10] util/fifo8: Introduce fifo8_peek_buf()
Date: Fri, 13 Oct 2023 17:59:29 +0100
In-reply-to: <20231013141131.1531-3-philmd@linaro.org>
Message-ID: <87il7alaq1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> To be able to peek at FIFO content without popping it,
> introduce the fifo8_peek_buf() method by factoring
> common content from fifo8_pop_buf().
>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

