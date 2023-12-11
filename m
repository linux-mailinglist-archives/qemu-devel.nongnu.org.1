Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 511BA80D2D9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjVp-0001zw-26; Mon, 11 Dec 2023 11:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCjVe-0001zH-Lx
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:51:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCjVc-00051z-TI
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:51:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so33211725e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702313515; x=1702918315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NB+xTPLZXpkLiiKkOdT5pTm+XqCQmG6DDHrgwX5/f/k=;
 b=AINHWSprw5AqVodaWMC0mz6LAl3y7OiLyP0mDggNO3NdHTsMgJaMPTa0Hzn4+xvgHV
 3m6wkA0T2B2NC2h/cQnKrXBtxTT/qcopb9hM6k7cDGqF6ZF1BrU2AhR+u8JIkc0JpgDk
 ithRM6RwPAr1VG9LNTZS/FrLwRs9fvjhJt0EYwMxJsuONcZU66hJPV/hHwc4PeXc1o8E
 aZ+xmXQhkUh6OMcZ6xhLgOtys4zz+tCcvt2VYm1TtDwwiY21IXwGKNNzjJdBTkdAd8vJ
 6FMd8V38nt78+BF3gePVy3UkkMldDYaxJEqtFRHlfQPLXB3OgGYkPd+VYZB6twLd53i+
 MLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702313515; x=1702918315;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NB+xTPLZXpkLiiKkOdT5pTm+XqCQmG6DDHrgwX5/f/k=;
 b=ZiY1kxOKFtmmJQsjGm+LLk5QVH9CHLjVpiBK4GV2xbGr24/fJsT+nYJAPgYTB+MGx7
 lJ0e+vw3UjsTu12HsCbsktfGkw2fQaB0ifS7y5KECON0EPYWCMTKv6tlv/mexwZyGj7x
 Yjg6wpZfC1myiJ1Mt9Z0xpj1afFPgBGh3QyzMxdcD/ZiDMDvOonIzmONdORHxU72ZZ6I
 UBm8WIvphrZ3utzpboERITSB8dvyNXlvseLNV3NpLFaNryy+VH+Ok3j8qQspTA9Ucroo
 ui/Mv+8lw6Sz3TEgcLAi/T2c2qu1+91Jz2INMKuZ9KktIKRTm1xzLNIz73hxLrO7Gsq4
 lxAQ==
X-Gm-Message-State: AOJu0YygzHgHsADgaNDivinHSI4EYHvqUeR0b20o+75h1qhtEGmeMJX5
 h9zQOR2MMti3iCTRDxvrM2HHvA==
X-Google-Smtp-Source: AGHT+IG/E9r8AwAUQR/2cAquO/bnR2/jR44nUgtoXgw+QoC5FxbG37RGgw+QF5x6j6pxwjEQIS+UmA==
X-Received: by 2002:a05:600c:444a:b0:40c:4857:e000 with SMTP id
 v10-20020a05600c444a00b0040c4857e000mr970778wmn.46.1702313515304; 
 Mon, 11 Dec 2023 08:51:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b16-20020a05600c4e1000b0040c310abc4bsm13905683wmq.43.2023.12.11.08.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 08:51:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E39E5FBC6;
 Mon, 11 Dec 2023 16:51:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Radoslaw
 Biernacki <rad@semihalf.com>,  Paul Durrant <paul@xen.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Beraldo Leal
 <bleal@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 01/10] tests/avocado: mips: fallback to HTTP given
 certificate expiration
In-Reply-To: <20231208190911.102879-2-crosa@redhat.com> (Cleber Rosa's message
 of "Fri, 8 Dec 2023 14:09:02 -0500")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-2-crosa@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Mon, 11 Dec 2023 16:51:54 +0000
Message-ID: <878r60fzrp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Cleber Rosa <crosa@redhat.com> writes:

> The SSL certificate installed at mipsdistros.mips.com has expired:
>
>  0 s:CN =3D mipsdistros.mips.com
>  i:C =3D US, O =3D Amazon, OU =3D Server CA 1B, CN =3D Amazon
>  a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
>  v:NotBefore: Dec 23 00:00:00 2019 GMT; NotAfter: Jan 23 12:00:00 2021 GMT
>
> Because this project has no control over that certificate and host,
> this falls back to plain HTTP instead.  The integrity of the
> downloaded files can be guaranteed by the existing hashes for those
> files (which are not modified here).
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

