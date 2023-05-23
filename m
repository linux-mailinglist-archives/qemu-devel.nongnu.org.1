Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A970E203
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:45:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V86-0007iU-5E; Tue, 23 May 2023 12:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V7w-0007a8-RY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:44:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V7s-0003XV-S6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:44:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3093a7b71fbso7356494f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860283; x=1687452283;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5Tc6p6XTgSavHgk0cyEF60WYHMi5C9jG3et+vJYS8o=;
 b=BC253gdyaT4wOYViQNIFaRUeVRW/bZ3ZqflNWSGQGIhqfsVE3nRdJYH0IX/AYgdjBH
 A7GPsL7JUqQLt7nG0RvOFz4ft9foUScJWcdoerSciswzxD7i//nxPM1JXue560ntbDJr
 j5kaxDALp7aykt8T1IDiyJW/jGRHWSTQWCnsiqabhW47LwP8rQRcQ+uMsYdOXLC69YJS
 c+13kW37/PsArBd/AqGQ3PT8G/Vv0JqK+BFC9b1iSCiJ51Ux7P1qYc5ih59/2LMVuWDc
 EeDNm34MZRGg5fEtve82r96G67JYPjeJOdIc+32rLAMjUwat3amdgubg1fpyla10ib9b
 KJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860283; x=1687452283;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M5Tc6p6XTgSavHgk0cyEF60WYHMi5C9jG3et+vJYS8o=;
 b=L1g2AXZ57ZLHHDTJSkpXJu1rzc1jtDKu6iqNUro6XdmnHH8ns25oU7zD3+XKS5rFca
 pEWZqdE9oPHWehccVu5a/pnaLZxaQMWGZ64kixpoRV/2o9bAWxbO8L+ArqBogGrjL0GG
 UrVJGUTJOyoRa+stQT0xkuzssepjWP+o63lbr0BL7Zu5wPga2UW0wKL5djqk4s+/0mXP
 pxLwqc1zgwQt6rJCotmI7sz8/nUTCYnEsI6ZcjyHsY6rskPlck1KMTztymXVRcLiQ3gt
 eXeWhXwRDmKv9atOmol56LotG++KP/+GeKSnUl9GafOYT49p/H89mx0lcye8IWboXs5u
 7X/w==
X-Gm-Message-State: AC+VfDx9YNu/B7qOM4WLFV2pCehDQs1bbFCipcZu0YKCYoYFaCqnf25n
 aUInS+cc8wm901mdKMYSdhT2hA==
X-Google-Smtp-Source: ACHHUZ6c7x6wt5jMtharOObShs5ZURj0B56Me9Mveu2p7Kadai3V6wKyeU2ld3dx4OY3OwFE8UOGzA==
X-Received: by 2002:adf:e945:0:b0:309:3a83:cf43 with SMTP id
 m5-20020adfe945000000b003093a83cf43mr10299152wrn.27.1684860282820; 
 Tue, 23 May 2023 09:44:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a7bc5d5000000b003f42a75ac2asm12345526wmk.23.2023.05.23.09.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:44:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43C411FFBB;
 Tue, 23 May 2023 17:44:42 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-20-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 19/27] accel/tcg: Remove cpu_atomic_{ld,st}o_*_mmu
Date: Tue, 23 May 2023 17:44:36 +0100
In-reply-to: <20230523134733.678646-20-richard.henderson@linaro.org>
Message-ID: <87lehfyp39.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> Atomic load/store of 128-byte quantities is now handled
> by cpu_{ld,st}16_mmu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

