Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C03047C8C0A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLfA-00066A-Sa; Fri, 13 Oct 2023 13:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLey-00063S-9G
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:09:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLev-0004uy-Nv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:09:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so2184006f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697216948; x=1697821748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qOi0xwKuGSLTHrRHx2vwO8Oqun+v27D8JdNp1n4fc8=;
 b=Xlh4LEN6GWqjCe5/QqzCMLIZtvXlG6KPnX4FLJhVDPbZFvbZOEPb6apHCHychdyoLH
 0WJS7FUdHehiPCH8Eic8+KX2Kt3N4gjmBR5HHGF2l72UEpcOobu2QYeVhxpint46zk92
 xtrDqnL+5vkw3Hj3ZwcH02ldEiclfFG6MxdsSw1/f32DHNyJwKEFcvi4b4zGoBZPK+6r
 mFlK3j68FFXBZ/vQ0bKdODhuIszkrpOzyXtl7IYTDpQAUs865cXcqpMz2mGE4YXrvuny
 Ys0IKhtO7mcYJGY0ApfiB5/ZOHbDFrZ9MEXvUxQ/a1fOHD7nEI/72u0LxPyFlCziNRNt
 YhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216948; x=1697821748;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0qOi0xwKuGSLTHrRHx2vwO8Oqun+v27D8JdNp1n4fc8=;
 b=SWBw4I0UVQAca4XMIgFyCklwUferPrPIAYOP8MtVfd351mOow8dNzwEeNQM4MhBxlU
 n8O32MAhwR9G2dtHPC9iHG8nTdqa3RT02a8RCx2ZQME0qFlrg4mF8L3uZuDkG/Iqd4Ow
 DZqL3noulwLX9Ds3Yy1AwgzAnHNXPTioSj7h4xlnfKvLFAOImVF3S3/MwXXNd92x1Qes
 +HXXv0zEcPxzJCW/YORhF2GgPm1kPw2fc2TWyZ4serlDL5D5+Ep8vTg/7Nmsyo7BiPcH
 SMcs6OoGPlKQReNKZ0Wj8X5t92VFICTDMjlwl3XDPKBOntnWoZvcCM+H6QcAnTyxdjJW
 WkAQ==
X-Gm-Message-State: AOJu0Yx0Ci7biCWrKyCaN/DmlDs/TGnNBOtNL9YVoUVfrb104XvBg9ef
 S/t2/yv3hPePm3qwrjI53UNB4g==
X-Google-Smtp-Source: AGHT+IHyTHLgIyQEIxYFan3eGzeY+ZPWYqu++q4yXwn/u33HNxBgNapMW814PNWvR77TqWV2h2iWXg==
X-Received: by 2002:a05:6000:1245:b0:32d:8eec:96a5 with SMTP id
 j5-20020a056000124500b0032d8eec96a5mr5254972wrx.42.1697216948188; 
 Fri, 13 Oct 2023 10:09:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a11-20020adff7cb000000b00326f0ca3566sm21067816wrq.50.2023.10.13.10.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:09:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 840FB1FFBB;
 Fri, 13 Oct 2023 18:09:07 +0100 (BST)
References: <20231013141131.1531-1-philmd@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny
 Iakovlev <eiakovlev@linux.microsoft.com>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/10] hw/char/pl011: Implement TX (async) FIFO to
 avoid blocking the main loop
Date: Fri, 13 Oct 2023 18:08:34 +0100
In-reply-to: <20231013141131.1531-1-philmd@linaro.org>
Message-ID: <87a5smlaa4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi,
>
> This series add support for (async) FIFO on the transmit path
> of the PL011 UART.

Hmm neither I or patchew received 10/10:

  https://patchew.org/QEMU/20231013141131.1531-1-philmd@linaro.org/

?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

