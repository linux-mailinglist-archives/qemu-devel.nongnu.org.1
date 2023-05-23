Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4343570E1B1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uqn-0007Dk-O2; Tue, 23 May 2023 12:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uqi-0007CQ-EB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:27:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uqg-0007kA-Uz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:27:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f60dfc6028so442565e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859216; x=1687451216;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7tMrbx2GNAkgaNipKnQX61t7gDNpZTI3gWYy93sp/M=;
 b=y5hKEIn6CCOxEPUTbiVG/sUei5JeqNiQdOGN+RaMmz63mQQpkWdBd8LDGPiyJ6+fQP
 37RdEjUpa+slKKudX06MHxu0C2TiUOhDrogRBy3WnqbPhfKqpzKLwBaiN5g0pvYUR+1V
 8zEpHEGf9eqdTChfLepo7xo/aKEkBn0vAltqmBVP2ksvifozfP1elislRpIkdiwllcCV
 ISr4yQ0MS/X1bTpwj0BVyAtgFxLrd2OwyWaLCjx7rbV+xFKwU0Rzs7v0+8XWMAPLk+Ak
 nhBz2rb03RUmbQwNLjECU8z/WRVZ6pdwyym3QVfqj6CCyH26FBUfj2LcBgGLbQJbpcPO
 uiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859216; x=1687451216;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J7tMrbx2GNAkgaNipKnQX61t7gDNpZTI3gWYy93sp/M=;
 b=jvKGXEdHzy5dM2pCzsdpbVostBDnogXyFaryHDoXfOganzIBNOc51IgvDyviHY54EU
 vkM17p/sCpa8yRSR01ecQRJGPpWjm2zeeSyumFWnTfdcBEFlgpEjbm1B4C8wyOedRKaI
 ZHFchRIr13B00aFTHfOlZ8ZTKrVVUKHW7F8L4JbWElTaDa1KyuHAhpv7Z5YmyKHY1Zox
 rOEYru405d2VAa+JmbNwD6Z9Pemax63v1R7O6wnorPIdVYnyxuYfz7Qy8qADZ9juxmYR
 I2nU0sdTcFvEUigkaDLH9wCntqYelO1WXq6Mh/jXZ711n/LjQIsldEYwoPqjNX8/UHdd
 tppg==
X-Gm-Message-State: AC+VfDwJ6dPvNr+G1R1XsDnkgN/14IHD8ofp3juq/bzJjqhyT4u5vhKV
 TUfuIhXLR3qojaQDZIKajwET+A==
X-Google-Smtp-Source: ACHHUZ5EeYU38WS+CKchRkhdJ5OhpElRTKZZ867pjAG2kh86mQ2abg0L7fbUSUUxQv33VdJMeyllZg==
X-Received: by 2002:a7b:cbc4:0:b0:3f4:21ff:b91f with SMTP id
 n4-20020a7bcbc4000000b003f421ffb91fmr10590173wmi.28.1684859216296; 
 Tue, 23 May 2023 09:26:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a1ccc01000000b003eddc6aa5fasm15563956wmb.39.2023.05.23.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:26:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 81C331FFBB;
 Tue, 23 May 2023 17:26:55 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-9-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/27] migration: Build migration_files once
Date: Tue, 23 May 2023 17:26:50 +0100
In-reply-to: <20230523134733.678646-9-richard.henderson@linaro.org>
Message-ID: <87sfbn10a8.fsf@linaro.org>
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

> The items in migration_files are built for libmigration and included
> info softmmu_ss from there; no need to also include them directly.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

