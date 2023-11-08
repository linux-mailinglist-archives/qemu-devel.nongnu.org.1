Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052867E5BDF
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 18:00:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0luV-0006kk-GI; Wed, 08 Nov 2023 12:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0luL-0006iD-0O
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:00:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0luJ-0001qu-60
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:00:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-409299277bbso49675685e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699462796; x=1700067596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVGNIJ8DjBhgmEvbz7dBpDVLyyQ6pCRuq6Jf8A9o4k8=;
 b=uB3SqanRdNX4H+63qfZ/ybpkoirr4k3PWW7qmqMUyNeyhBlaBfHR7jMukoG1140nCA
 3S+s59PlnUoInR2AdlQEnNDLHisoy9GEM8IWgwWPHYmteuPS6nA2RTY9nF1ElI+H5cBO
 gghz/vOMKUn5lIogfOKYvO2mVSv44+G0gtSi3NRdZa9kdSCOBEMYqt0UjME35GtmMm07
 Bok7BiNl21FmKPQFxBSEuVwbtk5Qw0QHL4jLHqdJJcmyou8pgJ8FKYwsQ8Yr00vQpVZK
 DyI/K0zzhgbPye/y2YV9mygyRhEUZjNZUx+HLqCJtgL57YPNA74hVOjw8yrkJFw0buIv
 Fj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462796; x=1700067596;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gVGNIJ8DjBhgmEvbz7dBpDVLyyQ6pCRuq6Jf8A9o4k8=;
 b=xUTZKqsx1KXizD1bxSOslj0UbsTY+AbMddYWbk2wjoUKFla6pwu1VlEAk61uTT9yR2
 6MpqSGneuWys/yTnu4j2AMevx6y7O3iY+zENp8P37ltmrLPTRbv7Sh2aLg0lPHBkrcSA
 hEJ0CFbIgalj6Wsy+YrKtBgYENsKwYmcNfBjyct1TnhWifFyw+4edUchcJUxP7OolDfx
 OWOblhP7OImzRS36WeLS1kRxSlDLAWucwyoYv5I8qSaWwxTlM4tR7279S/rzQKiahm1N
 /AqoF9AzA9NRk3YJbwJm77RRlwZQGcUQBYtXCiBExAx5edtByihXR5gkB0J74vNNBCGS
 2acg==
X-Gm-Message-State: AOJu0YzZqhp8/i2zzh87HL6EQbKOMvvaC22EtE0RMUpRnpeficOxuMEQ
 W/4B31J8D9WByuRH1Ft7h2FenA==
X-Google-Smtp-Source: AGHT+IHRDfdJHPWz9Y3xgGna9wHXRIUTgy1S8QFKAJsk4CNK/WJsMc2Nl8yIhDzXQppGuvKNv6mcpQ==
X-Received: by 2002:a1c:7c08:0:b0:40a:2796:61a0 with SMTP id
 x8-20020a1c7c08000000b0040a279661a0mr2134164wmc.33.1699462796187; 
 Wed, 08 Nov 2023 08:59:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004060f0a0fd5sm20006019wms.13.2023.11.08.08.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:59:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B5EB5F751;
 Wed,  8 Nov 2023 16:59:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Beraldo Leal <bleal@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
In-Reply-To: <20231108162022.76189-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 8 Nov 2023 17:20:22
 +0100 (36 minutes, 26 seconds ago)")
References: <20231108162022.76189-1-philmd@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Wed, 08 Nov 2023 16:59:55 +0000
Message-ID: <87r0l089kk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> macOS 14 "Sonoma" was released on September 2023 [1].
>
> According to QEMU's support policy, we stop supporting the
> previous major release two years after the the new major
> release has been published. Replace the macOS 12 (Monterey)
> testing by macOS 13 (Ventura, released on October 2022, [2]).
>
> Refresh the generated files by running:

Queued to for-8.2/random-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

