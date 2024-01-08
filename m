Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D3827400
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:43:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrlj-0001Pt-MF; Mon, 08 Jan 2024 10:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrle-0001Ds-1H
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:42:22 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrlc-0001kQ-2s
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:42:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so1852819f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704728536; x=1705333336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+zq0eAJ8bnvzZww3oF3k7l2MJoHjo61IChq0q0yyX0=;
 b=yFLLcc1NAIVbbQFBT0VWhor4LfaWs4Xto4oOpehIjArMo3gviKeRJERgHayoTUZTc7
 kqi43Vmn8/xI/tTJoeCAfoiGX2sEKPAiOV/kzGHaKszXNQRsUBSV39Dv/ilAiUZspaID
 peyOcrohRCa+FnkLSyU4sTu538dN6MjXPSiAZNSyW2WROnO4UooDQyLA9BteZeQNH8Co
 P91fRPJoy6Oj1cP/P1orNqDFnMab+q4cksGo31Mo1nt37OAQAQbwum+ekpmn8XeifYkE
 R0i6qIGFdpAmkdp/ASaLJQh4aXa5g7emIMqCPqXd5DbbXbjhROpk+PKR93Nvg805c0Fq
 RL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728536; x=1705333336;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9+zq0eAJ8bnvzZww3oF3k7l2MJoHjo61IChq0q0yyX0=;
 b=f9Fi6+ipHtDbxUTpBzoNIOTN9oqOLGzZVRmSjBF7eRtW0Dh0TlfXZzXw35TQJOsDwu
 t7M2/Q2F4115/DAcce/XLd0olNMpNxCqS1Th8gpDLsTpVkV3h8RdIT248/QyeMl6eKk8
 w07U7qv8bDsE5HnB0WnQIPcAC+aOmGo5Nh2yE74NgK79fMrRF9o9sWlsuRQ0IRhReL04
 CZ1csdHXDtO16fL1Q3xsAtCDlSXRy0nZ2FmUu01TuO9TfuNZIq99ZsE9TwbHDW/Eqlhi
 6KhBLbW2cGoePALcu/YGawME5b39zobybVL1NgvSoiNCgNlFxLzkxY+k/Kb7V0jWcgCl
 usPA==
X-Gm-Message-State: AOJu0Yxps5NzcdcvA1QdsSZCfOn6rFzhJDbtesu9rvYSfJwQs80JpJ5h
 vTQRNzA/cJDg6lJlVKOB7kN9UAjlpBEQnA==
X-Google-Smtp-Source: AGHT+IEgtyqgyTqbod9Kf6NoPB3N1lGdn0K/I8y2qeymJ1ePt/2JGWNh/xIFDfV+gZgkYj8VyO6ozw==
X-Received: by 2002:adf:f5d0:0:b0:336:7a58:39da with SMTP id
 k16-20020adff5d0000000b003367a5839damr1660622wrp.106.1704728535992; 
 Mon, 08 Jan 2024 07:42:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a3-20020a5d53c3000000b00336751cd4ebsm8137614wrw.72.2024.01.08.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:42:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FA165F756;
 Mon,  8 Jan 2024 15:42:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 23/43] target/riscv: Remove misa_mxl validation
In-Reply-To: <20240103173349.398526-24-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 3 Jan 2024 17:33:29 +0000")
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-24-alex.bennee@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 08 Jan 2024 15:42:15 +0000
Message-ID: <87sf37hlwo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> It is initialized with a simple assignment and there is little room for
> error. In fact, the validation is even more complex.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20231213-riscv-v7-2-a760156a337f@daynix.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

ping: along with this are the RiscV maintainers happy for me to take:

  [PATCH v2 23/43] target/riscv: Remove misa_mxl validation
  [PATCH v2 24/43] target/riscv: Move misa_mxl_max to class
  [PATCH v2 25/43] target/riscv: Validate misa_mxl_max only once

through my next pull request?

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

