Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA301773F00
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:40:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTPk2-0004F3-94; Tue, 08 Aug 2023 12:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTPjz-0004Eh-ST
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:39:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTPjx-0004gA-3U
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:39:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so49755575e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691512763; x=1692117563;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7raVM3Rk1ZEGvxTQBHzwRBotgdwyPsIycEtc6M1M84=;
 b=JqfwXz4Awad6RjOHrWmQb+KdGXciIj9UuU8K4KrfvguvlkDm+9k4as+cdrE/BMZDxZ
 LWNLfn72s3+m9P05GK0pNXdOQk9P1IuI0X5mrRB3mYKq98a0vi5WvsrUDJYFPLCW+apF
 GScbP34MoY2wguSVvWRq70f/y7lUEjhptYml1QtZyJjjXadO1+vjc9OztF62oYCWy6iE
 c7LTGN1QuXqdupNf1hYBcAmWcU8PtOOu/y2Gv6HtYuhdUHRwk1+vrV/mMlUVNHJk2L3r
 cPxS8HRna6pFWV88sYgFEMgx61BT1qJA/YIFPeQZqiIBkvve/oKWD/piScQSY9hcUq5J
 pWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691512763; x=1692117563;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J7raVM3Rk1ZEGvxTQBHzwRBotgdwyPsIycEtc6M1M84=;
 b=SW14+U+RwGQzfPAb3at+3WSyRkSbHIiDehlr8uoyCjr71B3hF4kUkX0WtJZzqTQrvs
 7xcHl49ETQhbanDbYNb2J4HDD748aCrTMAHU16CriQLlNiDQEjpBCdWn3tpfs7yL4rYe
 5UXDpghsbl2RiECDqTFCWIdB6lXjXgjQ6xZVkm0e/hlw/j60bycys4gg1wHSGKEE5WOe
 cMRBFZOgkY6Kerns+ZiJoKNKmU6LI6UWs/cICnGMu0GrSGSi3R9Q5DSTWk/qi3GafP0P
 n4WOx1jGp9PKnOg4dKgoV32JEkg1D7Phe1QNP59vPXqVayQbQIEdVbAjKqO3kRkVct07
 qq2g==
X-Gm-Message-State: AOJu0YzQgQNyPYQJARW59OvuBz0YsyyKAaGiBpgt63iUv9N9ZGgD4AHf
 64tgRJLdS4t9aeyHEpOGzf3F7Q==
X-Google-Smtp-Source: AGHT+IHxGdIksaxfvFWbkAyhViMQx0+wDfqghypT/Zn83ZVS0L2TnAXgXWIiEbm6O99NTSFyr03fYg==
X-Received: by 2002:a1c:7504:0:b0:3fb:b248:67c with SMTP id
 o4-20020a1c7504000000b003fbb248067cmr278454wmc.22.1691512763459; 
 Tue, 08 Aug 2023 09:39:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003fe26bf65e7sm14263197wmk.13.2023.08.08.09.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 09:39:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B54FD1FFBB;
 Tue,  8 Aug 2023 17:39:22 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-14-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 13/14] linux-user: Rewrite fixed
 probe_guest_base
Date: Tue, 08 Aug 2023 17:39:17 +0100
In-reply-to: <20230807163705.9848-14-richard.henderson@linaro.org>
Message-ID: <87cyzx7akl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> Create a set of subroutines to collect a set of guest addresses,
> all of which must be mappable on the host.  Use this within the
> renamed pgb_fixed subroutine to validate the user's choice of
> guest_base specified by the -B command-line option.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

