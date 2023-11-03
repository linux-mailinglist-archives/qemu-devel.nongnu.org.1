Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4457E09A4
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 20:50:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0An-0004ND-SG; Fri, 03 Nov 2023 15:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Al-0004N3-Sa
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 15:49:39 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0Ak-0002o4-4R
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 15:49:39 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50930f126b1so3025453e87.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699040976; x=1699645776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rh/yjE/KV0nAg2eNGdJAzIjmLAXaXmWMjW2OUzyjT5w=;
 b=D/HJcZEXBzsLlYk9v6phW+ENG5+MTCNemCmWBDKcxheV4zK9ju2rfNdoO67CmNGq05
 mXFiKAy64QLAzXzBj+zg96MW5QbwgAzm03fpE9xd0hgLYfNte4kaRSu0OXqQomPa+ZyD
 vuiUFp2zsBBSe1PIp4zdnADCPic2AQg0NRti12nPXC6lWIQixC21sHoxgotI25eqrbLj
 Pc5cAAkaHG42+HS3ZehNDdwAC/RyDVbp1l7US0WTViNNc0kzfby9QZmKmOSSAe0bSlfX
 VGRTYeQZMb7S0fo+H+vR9rvUIMnf7DZfpfsLcI/WuhW8KYOwjF2yYTdA67cx/UYZ2LBT
 6NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040976; x=1699645776;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rh/yjE/KV0nAg2eNGdJAzIjmLAXaXmWMjW2OUzyjT5w=;
 b=nflB/ACk9ikacO3C28n/NqSQM919VEmiRx4gA7gICwL0VDDynK5Pbu+udUbdYgkB0M
 SA2eJK2BGpZ9GzcXhs7zmiECx51dy6sUaqlPYeu+O3fee+ML5+ILVRouNPo2iC1ANFZr
 3gx/jVKau1fYxVNTbPbpbItD+Pc9fWA2l+S8oZsqb3rEqUK0t5lZzpL9eFFTV9gutyzv
 KwWnoSDKY6CF6gy7uxFoUQnpmOt0RDyrywv3mrWzaBfBZUtABI0NniwwqLkWkecmAlCY
 jLmxa3bZmgyVGNfzRShxVTTWOOp/ER3jYlGbm6DsbeA5UKjgyQCpqJWqNss9zzGGDSR+
 F7kA==
X-Gm-Message-State: AOJu0Yx3cX7PDwflGpR2bDRAwg7v01qCaiFjP1oFgnEVIzfqhbu48EW7
 Fvjb6wDl67RZ+WOLOEFb8s/uBQ==
X-Google-Smtp-Source: AGHT+IGDzAjCIrMHaR1CqLoUXR+MXUm6MWi3NNmgIawHhGwsLiaUJ8DX8m/E1m5w/5yNCWNOD21zrg==
X-Received: by 2002:a19:5e47:0:b0:504:7f58:6dfd with SMTP id
 z7-20020a195e47000000b005047f586dfdmr14169152lfi.2.1699040975744; 
 Fri, 03 Nov 2023 12:49:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i18-20020adffdd2000000b003253523d767sm2591737wrs.109.2023.11.03.12.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:49:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1042656E5;
 Fri,  3 Nov 2023 19:49:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,   luoyonggang@gmail.com,
 richard.henderson@linaro.org,   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/4] Enable plugin support for windows
In-Reply-To: <20231102172053.17692-1-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 2 Nov 2023 17:19:43 +0000")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Fri, 03 Nov 2023 19:49:34 +0000
Message-ID: <87v8ai1usx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

> V1-2:
>   * Break up commit into separate commits
>   * tidy up contrib/plugins/Makefile so the "if windows" and "if macos"
>     conditions are symmetric.

Queued to maintainer/gdb-and-plugins-for-8.2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

