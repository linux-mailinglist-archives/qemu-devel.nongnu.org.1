Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B67EF6FE
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 18:34:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r42iM-0004em-F5; Fri, 17 Nov 2023 12:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r42iK-0004cH-Ih
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:33:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r42iI-0005Lh-VF
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:33:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso13855705e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700242384; x=1700847184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hE9SYlzRhx4fMCqOERRNXzoYvzH7kMD30RphHScvQA=;
 b=ozVkygs+6Sovm0QeQvdSq8JwJ94NywJUM5fUtve/n1WlGa8iZAc/LFlZaJs4sm3zK6
 lKCHqRTlhHNIDLprwXG/64sx+ObtBWlGL4XJLcgQ4ZXeSwBUVRravjhSqatY6q0slQJt
 ko7iU5M5hyxLyb5SGKKH6m3/CwC+czQjFI8qKA+JKsJ1XdNbir2cS5HIRMhhjWgBrpn1
 Q5JJFA/4n81WqPOyVHh/RwCXxX94Z6fTIvAU0jmYfMIWVnYtDZ2iCMjgnUbFqrHu6jU3
 3iH9c94jHV3fT7JuN+lkJiB12ZnJgPpM8Oj7U3TUNFZgl+LvuwrVRi8ObJdydSJm59//
 dBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700242384; x=1700847184;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1hE9SYlzRhx4fMCqOERRNXzoYvzH7kMD30RphHScvQA=;
 b=lG9yIvvy8We9PJGYvhZD0prII28mfa2ZsXHAHmwBAr3HF9oTHEpn6FhPAHamZZrpMW
 UJrav/tRD3TZ5M5ag5tRJ1rAvN9+GuNeNyvs2VrNvzCWBVljhp1GfVVGJI8wAMnyJeNC
 imJ2VZNPJliCduD0AOBRiHhhty/ffmm9y5rksHF94rW1D6BCHp1dTXT1l07MdatRaUlY
 SxpFRCho9/g7mlNyL5BlewElPSgfiLYzaPl1boO9+6abJ2AmIM7Sv2UdGMgpOx+n1wxu
 ixL6eWDBAsCA25iAVmnx7jnesdkFvLs0QXRLjvuBez7SJ/Kf6DiH0KvscJZ2BPijcFZz
 g8rg==
X-Gm-Message-State: AOJu0YwCeaKhz3sh6qhhZUjNi2r6X+cvUlfVarsumRzOA1zqtmF4yM7Q
 lPrWk91ZqP8Dtjiw4DVRU5rLdw==
X-Google-Smtp-Source: AGHT+IFf63rioapzxj1ZaX5Zjkwac3MmhHxtTmN2/U2bvA6dhoW3BPKQbMcLSaqmhTa1r/IsGKUjUg==
X-Received: by 2002:a05:600c:a41:b0:408:3634:b81e with SMTP id
 c1-20020a05600c0a4100b004083634b81emr5083260wmq.13.1700242384175; 
 Fri, 17 Nov 2023 09:33:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c3b1500b003fe61c33df5sm8050204wms.3.2023.11.17.09.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 09:33:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 612C5656E7;
 Fri, 17 Nov 2023 17:33:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Chris Wulff
 <crwulff@gmail.com>,  Marek Vasut <marex@denx.de>,
 devel@lists.libvirt.org,  Sandra Loosemore <sandra@codesourcery.com>
Subject: Re: [PATCH-for-8.2] target/nios2: Deprecate the Nios II architecture
In-Reply-To: <20231117070250.32932-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 17 Nov 2023 08:02:50
 +0100")
References: <20231117070250.32932-1-philmd@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Fri, 17 Nov 2023 17:33:03 +0000
Message-ID: <87y1ewnv3k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> See commit 9ba1caf510 ("MAINTAINERS: Mark the Nios II CPU as orphan"),
> last contribution from Chris was in 2012 [1] and Marek in 2018 [2].
>
> [1] https://lore.kernel.org/qemu-devel/1352607539-10455-2-git-send-email-=
crwulff@gmail.com/
> [2] https://lore.kernel.org/qemu-devel/805fc7b5-03f0-56d4-abfd-ed010d4fa7=
69@denx.de/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to for-8.2/random-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

