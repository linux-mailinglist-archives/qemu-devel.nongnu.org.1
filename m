Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD42AF166F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 15:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWx4U-0004ql-IN; Wed, 02 Jul 2025 09:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWx48-0004TL-B2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:59:59 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWx41-0007tO-06
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:59:54 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0ccfd5ca5so623286966b.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751461186; x=1752065986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9+XoyS+lvjeJBJDO3NHCXmpRb+IvEYkL23MZR7a1u0=;
 b=evIDXFTOqbNjp24yIKXJ8UaaxzwGTPIVLt8jacqvQtED6QTbdO2OwDEuLAEa485iW3
 wGzryRjImTqC6O5ZG86MARl/wExS8tC9JF6iuTBg9JSJw8/PzM/J+OEwV9GNkU0Gd6c6
 pkUNmkTV/GL6FIrYfLr6KoSjJqi6x2o2wkVDVTz8H+Xpg6gTzFM4XJNJKiOE5j8LuYAh
 qhk3FcCiTTKfLZYdigmwGj8XEHPi1mdT3bG2QclTi1lEATgeBYkDW6fDlFmXoOiHDgdR
 XachUhMvc1FzJ/Wn8/OzHKH6SJfzEVllqfLZmALVHduumZEq6WybeToaffwpvMx2ClxI
 12gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751461186; x=1752065986;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:to:from:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E9+XoyS+lvjeJBJDO3NHCXmpRb+IvEYkL23MZR7a1u0=;
 b=IN2eYQM788lgii1Wwv3H114CrCseRouQi65ztcSiJaMLHcGVJw9fvir04NgBmzXQni
 XUFtouaag+bxgDtn5cY9I70HjGzMeGb398//VOofzdHoLum4fnUqtcD1DO1qKSylN92w
 rr9tO6+IR7/DfvVJThWjUxfHbzfKzC8mlFz8GQJvydBWB7ckEiIrvS/fWs/3uOTLwidG
 lXP9a9xfGgsvLbKPu74yPgkE07Z/U7Xo0/StsExK52fvDzpNAifObsLxj2hRK9EkXg1b
 gYKO8KXuQgyUkOa9zu24V1JOTLh1NZXv96S2nqCa1n0o49NR6r12lmV/GKHkAEYYt97x
 XG4A==
X-Gm-Message-State: AOJu0Yx8vFQ7YFH9IyBP1E3zVFNKrPBYOLoO2dv0wGqyr5Bn+ignenYz
 I7J4q4qvt7XarVkIrg2eU6a+5ewtS59F1b08WRCdDufzucUqHgKQv4582KSZv+QLeqpOeQ4I4xw
 AmDCQEG4=
X-Gm-Gg: ASbGncspQgd1+9+ChmaUekN28PzLQhqoIKZMsWkV9JPGsf3q6Urxg0eQv3l5ZmhVf9z
 GC9BW74uaWbhvo128DLfYQPPawZQ7gzzTaJf040o4MrRShDMI2+ddNHgJpO0SfmM83Exqrjrhn2
 ZcZiIaWxCclmtzm7vdxrsbtkwHiifjRwKKAZYs87LWb2C0tbI6hOL4vVyuMTkUL52fyxS9Zgnpf
 uoY2z2Uu1AJoAuxsOmkuQtdgmKowOhJRiqpgF3Vm8XEEvOx6y0enlMeugtmmfdVi+ChoajiQGzR
 3Z2S0cdNvBzxPgEpUPlehq3nEZ1R7iUXvgHEStp1PMMOo1hyFQ4tW9H79ofoTXs=
X-Google-Smtp-Source: AGHT+IFFSpwRen/S4OEZfgyfvpN+v+8hLwgsgBZ6wl5IUK0juZzxie7v+Dw7L0whVyNx7ZB2YoaLsg==
X-Received: by 2002:a17:906:6a27:b0:ae3:5be2:d9e8 with SMTP id
 a640c23a62f3a-ae3c2b8c116mr295945466b.18.1751461186103; 
 Wed, 02 Jul 2025 05:59:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35363b1c4sm1073299266b.31.2025.07.02.05.59.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:59:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBAF65F8BE
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:59:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/15] Maintainer updates for June (gitlab, semihosting,
 plugins, virtio-gpu)
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 2 Jul 2025 11:43:21 +0100")
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 02 Jul 2025 13:59:40 +0100
Message-ID: <871pqyg343.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The following changes since commit 6138e72b7e33e0240ee955a2754dd038ee9949=
4d:
>
>   Merge tag 'pull-tcg-20250630' of https://gitlab.com/rth7680/qemu into s=
taging (2025-07-01 04:25:08 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-10.1-maintainer-june-2025=
-020725-1
>
> for you to fetch changes up to 1fa2ffdbec55d84326e22f046bc3e26322836f5a:
>
>   virtio-gpu: support context init multiple timeline (2025-07-02
>   10:10:07 +0100)

Oops - I should have realised it had been sent when it failed due to
missing patches. The tag is the same for both, sorry for the list spam.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

