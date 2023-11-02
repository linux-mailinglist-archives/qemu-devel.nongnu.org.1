Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820A7DF9A6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:12:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyc9l-0006F0-RM; Thu, 02 Nov 2023 14:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyc9j-0006Di-Sg
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:10:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyc9h-00009g-VK
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:10:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so817641f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698948656; x=1699553456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yVX3p/i2IMd17KWXoWKpGcHuOL8xDfRYeYQAUreckxY=;
 b=SJXePQsNhbvXWnC+9nOXT9+QS8r5717S7TMc+HKEl06GqO6ET31ZoWZNcx+yOU2iha
 H/hWYTHBd1Oa6fdMJpw6+x/NL5wwZP9u4KFhtyLOqetFFlQNxru9nIWKp+iDPrsF8RvJ
 h0G8Y5uF6fhFKasiikxp95+mNu1VZZ8pEZMxKxuTJ/xrtnhm3A4mhH3BS1jD13zTwqqR
 1M0S7RffamFjKsKxcL0qXh5so/nhIB6bxm9gAn8oEhElg68LFxau9dWRWP0bc2akZV1b
 2FC/yzYZJzMPDMtfSRyO6SiZomv9mSBT+ME4c3Oqq2uKzcvZ0dfkTxoxmm1bKRuCTyek
 fGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698948656; x=1699553456;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVX3p/i2IMd17KWXoWKpGcHuOL8xDfRYeYQAUreckxY=;
 b=EJ0zQQiuZqvnsmETo9RATF3PetBI1K1HPsX0M7rP8FdRnCOgCB6XtZkT2wQgulvg5F
 9dN8iDmDHUvGE3idnJ+vQkN/0YXVpauar4UoTqKrYhHbiTw6SyNjffK234HRYZjTJzMs
 E0gGMeg+UA1/hg/TWG0Ta2N9Nzybb+0ITqJrqzzhEdagt9p39spVL/FABNY/h3ZU6aGO
 veM+paA7/Ko2RFQsbhNDqSCNwBDb6Z7SkPOPSm4c0eqpmps0Ul3ioiWoxBpY24Gby1Bm
 QoQSyY96TQUz9KHcwXg4wfBNTtNRZHO57jdCfva3Qt6VJsla79uL92Inh9UJ0PDh80rZ
 cTzg==
X-Gm-Message-State: AOJu0YygDIVJ295P9uzlb43D5rWYKXup6pVCPG3Hucz26CQ/DFpS9Ts3
 PbcuUpb2rCnHAfGC72Oi614ygw==
X-Google-Smtp-Source: AGHT+IHjyjUkfBkTvNDNl/26po+W1cfmd8i3lIGG23gmP90v7LGDdjKGPfEVcUClQ5hybVXgHqG86w==
X-Received: by 2002:adf:f70e:0:b0:32d:885e:633 with SMTP id
 r14-20020adff70e000000b0032d885e0633mr13780723wrp.19.1698948656110; 
 Thu, 02 Nov 2023 11:10:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o15-20020a5d58cf000000b0032db1d741a6sm3065509wrf.99.2023.11.02.11.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:10:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C0AA656E4;
 Thu,  2 Nov 2023 18:10:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,   luoyonggang@gmail.com,
 richard.henderson@linaro.org,   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/4] plugins: add dllexport and dllimport to api funcs
In-Reply-To: <20231102172053.17692-2-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 2 Nov 2023 17:19:44 +0000")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 18:10:55 +0000
Message-ID: <877cn03u1c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Greg Manning <gmanning@rapitasystems.com> writes:

> In qemu-plugin.h, mark all API functions as __declspec(dllexport) when
> compiling the executables, and as __declspec(dllimport) when being used
> to compile plugins against.
>
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

