Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763DE838E4B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 13:17:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFhz-0006tF-O9; Tue, 23 Jan 2024 07:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rSFhv-0006sy-An
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:16:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rSFht-0000nV-Aa
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:16:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40ebfc5fb19so3789265e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 04:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706012202; x=1706617002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9TlaSvBvWRxVof6oIJCMpj+PLk87M2+4QstXtHawgU=;
 b=Ms5Dya6C6s0OKvE9RCrb+ELe0vBuUPuP9sgXwtuzHU+y8BxsdW5XaFg2p2NNNkHl5D
 50KNyNKT110Kxf6s6ISMLq0yxuLchQfctH67rT2puJuowIajXqoInOAGwM42yZfkf+4E
 ONGfYkb4Zi5W68pCs8WY1upthfF4PJsc0zu24TINtOeXR2ocvgaJTTrs9cnqjQnuVIcU
 it0ZzCoc9LtUHUWp2VB1xouJvyUOVk9UzpZg6pzAZxpCMilP9OY38vDj6RtV7Jw1OqNL
 zr1JzPkOIDkpApR1Zti1gjQ3wEkigXsCqKDw85RQ0G7RA9FVQ24EBX4G+QAx8U8u+6RR
 XuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706012202; x=1706617002;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:to:from:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z9TlaSvBvWRxVof6oIJCMpj+PLk87M2+4QstXtHawgU=;
 b=uL7W4w3IesaJuDXrQZSQF2cz5gP+Euuuv8bhpb3Viyp8EzDNl0TnWjksG9rvbmDA0F
 5msML725o7q1ObViQExXOKDfYFcovPMMszkg1CWMNmv6ByjiitaiJQLevPYKDlnkcBIG
 PWf/P1M2lAkpbpOoXf9Qkhn5Mh6/EzaOS/Vq2Qk9agZPxybypwVczqD1yIV3O0+LSWKd
 Tj5VhA5U3frhgbfgHnYw++rNFVvqNERsbXXneiJBq81ts/9kttsOYryZzcozBIDdZEN+
 eS9KZHwlIyNxeLUbvmr1H+rn+/uY2mDAzdEcO5JGCt8qQLxB4+g2e7fqkRPwBBAKJyCV
 VBKw==
X-Gm-Message-State: AOJu0Yz1YGQNqnUxAPO0O0abVWf6DD1ma6yiWJMi55AjPYSZ3zqqgbQ6
 OIu5GAl5Yxa+JmJs/rPDlhoLH3Omztwq2ldrEWwC2Pn4FY5lzolrfmVHdgCgqidAfW0p8KY+xDA
 W
X-Google-Smtp-Source: AGHT+IEEunRDjM7haLy/QZ1GjcL+n9o9qoUHBjJSjUSdUMPyeo5PEd8LHwIhdHgBAI8BOxGHGv+k2w==
X-Received: by 2002:a1c:7508:0:b0:40d:94da:ff40 with SMTP id
 o8-20020a1c7508000000b0040d94daff40mr49340wmc.195.1706012202375; 
 Tue, 23 Jan 2024 04:16:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h2-20020a5d5042000000b00337d941604bsm11986704wrt.98.2024.01.23.04.16.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 04:16:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AD5B5F753
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 12:16:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: KVM/QEMU Community Call 23rd Jan Agenda Items
In-Reply-To: <877ck6hhlt.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 18 Jan 2024 13:54:38 +0000")
References: <877ck6hhlt.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 23 Jan 2024 12:16:41 +0000
Message-ID: <878r4gmehi.fsf@draig.linaro.org>
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> The KVM/QEMU community call is at:
>
>   https://meet.jit.si/kvmcallmeeting
>   @
>   23/1/2024 14:00 UTC
>
> If anyone has any agenda items please reply to this thread.

Reminder the call is this afternoon but currently I have no items for
the agenda.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

