Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8A70E1B3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Usi-0000AW-PS; Tue, 23 May 2023 12:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Usg-00007h-Rk
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:29:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Usf-0007zL-7u
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:29:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30959c0dfd6so4765707f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859339; x=1687451339;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1Q2DwR7X/0Pnhw/Kf5vzO/d9JIwjUoDmUG+rezfItA=;
 b=ND38tInV/WKaCiCDD9kxbfBlEoC+Qzb4UDySmqhlCFwFuCekCIbaBzEkQdd9/VjPH3
 eYbK25g/Uj/AW6lniuJx5GG3O6nUmyFspge60fC4qEiliYNHXVq1YeJf1Er9XDd3p8wq
 SjSpEJROmoObM9MDjYNujBMkBITyip8rh0qomBFtPd/4udnPi6jsNJz+SvOhxS5Q5SiV
 WZOB34aOU4gnMv+XIkeecAkladjtZzvmpsWNPmULsLO99jZuVClpo4c7nWeukKTuJ7YL
 RmtgsljtTVIcTNTqX9e/0Ca061Gyv2PRkkihCEykMlLovWPC/ESSk6N9njxox3U9By0a
 QYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859339; x=1687451339;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g1Q2DwR7X/0Pnhw/Kf5vzO/d9JIwjUoDmUG+rezfItA=;
 b=kT8F7mwMR5m7nDhsH3b8kxss41z7fUOKDEXcoAL797lwLyGx1uIl6z3UbSfcboCTwr
 Gj2FX2+LCTL10QR66GjLpVTqnBcp0kqI9tEXzETtcvpBwfUVp29jG9cHHOHTVqYmEQZF
 uK5SmmK4eWoMfo3RDYTRUS8F8B6z6Kv3WVWXi2bHvhINb32jP8LaT9C8/X18FvbkCvBn
 XdJqJjmyjqEx99Pw3WtAFySdjNFVTWsH6A9IS2jK2RpQqk5KKVNqETQHjzvfFsSTh8Gj
 JwMA29ycMxeZ+JLtSs+sjhAydesA6j0tGRW8uc91ysHZWrdHA7cg3JuRSP69QfzgaK0+
 DyIA==
X-Gm-Message-State: AC+VfDyqBzaMs/qJ1seioNGPmJgnDjur5gF/7MAwtQCxXuQqIBJ1xQm7
 D/H/tl6US1938A2k3gFn1WHPBA==
X-Google-Smtp-Source: ACHHUZ4U96rAjzabRSKQ1Tf1dBiATGZWQBXSxxIRV/iZhJfgdOo9mOJ51Yh4RYzftHCWplPXG01A7Q==
X-Received: by 2002:a5d:4cd1:0:b0:2f6:bf04:c8cc with SMTP id
 c17-20020a5d4cd1000000b002f6bf04c8ccmr9809048wrt.55.1684859338890; 
 Tue, 23 May 2023 09:28:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a5d4483000000b003062b57ffd1sm11614245wrq.50.2023.05.23.09.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:28:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 25A091FFBB;
 Tue, 23 May 2023 17:28:58 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-10-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/27] util: Add cpuinfo-aarch64.c
Date: Tue, 23 May 2023 17:28:51 +0100
In-reply-to: <20230523134733.678646-10-richard.henderson@linaro.org>
Message-ID: <87o7mb106t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Move the code from tcg/.  The only use of these bits so far
> is with respect to the atomicity of tcg operations.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

