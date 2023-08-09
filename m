Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1491775633
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:16:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfHV-0006OE-Pm; Wed, 09 Aug 2023 05:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTfHS-0006O3-SZ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:15:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTfHQ-00017R-Ql
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:15:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe4b95c371so3891475e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691572497; x=1692177297;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnIaLEx26x6QjCxiijPE4Wx4VYH0qw3tVyVTw4zHmXQ=;
 b=vrXbwjQsgziTDpWNWv0jYdqbOuIMXi7na1/Orrip5Ept6XJBuXhIM0MlkxOMANh8fT
 UzVApEoUxYIlr563kbpbIY1pxvUmyAfoVtamcmpaqcJ+FVdEDGPLQ7fkFksbrw99+Ltm
 pCyvyVVQDbq0WAOWxlvh3bz4qMYed+Nx+kRUymlFDzxqZtPNmltXlz+CavlGJP7qhYuO
 RvW9HHngl8J73h4xAxUJJAw95rWwliGJh0GExc4FE16JP9nFc0WU8zFBPUUo6h6l3oTq
 1GPKTA1WVYU24uypvWaUSuGMrQIjTqgaVB/DOUdMYMpZiDpJe8hbSE0ZuvRwLucayJqt
 95TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691572497; x=1692177297;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LnIaLEx26x6QjCxiijPE4Wx4VYH0qw3tVyVTw4zHmXQ=;
 b=ZPPUF0+aHrNsU7pAEfMp7PGYbUz1nSbcfjQinpkHr4xfBhjEDzhDaoBPv9ukmQgGBV
 IRsDDe7XdAziFHIIjAkGZiQ8CghJ8IlEgxTpRQCpc6W2//UpM/Ly5WR57nyqnrlXW9E5
 cihhsiap6ADs56Yp4/ILZ+oMv0jo+4/AZQUDTIxgNpB6KWKOS5UOZw0aNauXmxq5hfTs
 AbAQuPNAWOFv4JKO2SluTDQRWILquxZrTSSkIyK+ZLvyEDQMQW/mlyY+dhKh0nF8aV8k
 Uw1BD/HHaeBRJi69HfGi1/Prmp82+tYibNX7YcDfbHiEcf+CPpAEPfxLy2SSa1K/TfaN
 gBWQ==
X-Gm-Message-State: AOJu0YxxXI9c+Rwpa6Uky4rn5yg0L/bld+J3k/SCNRoOjgDRJ04mdeyy
 3ZGUG6GdTzgo9R9aJh9mxu7Izg==
X-Google-Smtp-Source: AGHT+IHytye7m4ONVuNbjaWr1m3m+F9DzY4GBvLE4yN7NRxox5Sqp/RJbmf6OF9CIufB+Gr9OgV8yQ==
X-Received: by 2002:a05:600c:43d5:b0:3fe:1f70:9e54 with SMTP id
 f21-20020a05600c43d500b003fe1f709e54mr10081900wmn.4.1691572497677; 
 Wed, 09 Aug 2023 02:14:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c2a5000b003fe13c3ece7sm1368650wme.10.2023.08.09.02.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:14:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA0171FFBB;
 Wed,  9 Aug 2023 10:14:56 +0100 (BST)
References: <20230808025542.50392-1-richard.henderson@linaro.org>
 <20230808025542.50392-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] linux-user: Use ARRAY_SIZE with bitmask_transtbl
Date: Wed, 09 Aug 2023 10:14:51 +0100
In-reply-to: <20230808025542.50392-3-richard.henderson@linaro.org>
Message-ID: <87edkc60hb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Rather than using a zero tuple to end the table, use a macro
> to apply ARRAY_SIZE and pass that on to the convert functions.
>
> This fixes two bugs in which the conversion functions required
> that both the target and host masks be non-zero in order to
> continue, rather than require both target and host masks be
> zero in order to terminate.
>
> This affected mmap_flags_tbl when the host does not support
> all of the flags we wish to convert (e.g. MAP_UNINITIALIZED).
> Mapping these flags to zero is good enough, and matches how
> the kernel ignores bits that are unknown.
>
> Fixes: 4b840f96 ("linux-user: Populate more bits in mmap_flags_tbl")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

