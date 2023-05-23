Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AFC70E190
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UjZ-00022I-T9; Tue, 23 May 2023 12:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UjY-00021Z-I7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:19:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UjW-0005tV-4F
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:19:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f607e60902so266545e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858772; x=1687450772;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXjis4tVQITjRbY2U37g5vHq59fnL+CRwkhLtmFiqp4=;
 b=OhUVc9b57HaKJMGDw+uqu0XQibVTkepy8OAXqqwybhXCS9Yr44Zxs+4ClKgnQR9P4n
 STNd/duHnD8m1bMedVm2TVteJFMcJymCUlIlJsUu+pclVPzb2S5XXyJRQXJ6MtsrQpRb
 iXqva0EqQBbCoNf9qs/X5hBD6F3gSzdyd9HVppvfasrsTKGIoQJVO2f9dY+IMd2ZbHvc
 6DAz/rZiVAcjk+VGnLNjziAiU2mLlhMxldmDPCSn5Zuk5g0u2NgnbTMUj5gtFaGpEP28
 JQyMpVaZhzEJKj2nNCgRKgCvpqnoAVc8JJPrj/gc3kqRwVIWs/8FcXnLGrBumpUrB98h
 TpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858772; x=1687450772;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mXjis4tVQITjRbY2U37g5vHq59fnL+CRwkhLtmFiqp4=;
 b=LqkSJbK0AceRkAR4ANr7dt16e4BYVMV+0TUdL/rnQylKyvt0oJ5bnrkUK7pFg5ETGV
 YqInZ7KCFW+kje4Ep1Jge2vQbDtqCJfc3JZTqD8LHnloqWhTV81FmurX4GwUVocFs8vk
 rfRQ1b6iqP8nGdbRy0meXvEcCYSmX3OtmgZefKV+nA0MYA9iVh3mvbQhyAtPto92omT7
 AkMpDtL1e967nQE3em9tY7dgCZEUiNGfTrSSqAsOpmIq5hVni12PBw0RTgggoXH/1vJu
 8N3niU3pggRroII0yx5FAL1pDAw69gGgbFlZAA4QVsfJaKvE6ZL/Xwe/0tz7Y3oK/p31
 zmbg==
X-Gm-Message-State: AC+VfDy+GI88zgENqgMhsEQOvNszrGIgwLNpvNIsjzdcpOT6dvpaMOe1
 wYFLM+YSObTBHKWywnv1PcXmEfryqMNB6Gk34J6IUA==
X-Google-Smtp-Source: ACHHUZ47zpJYXKhoxGSjYgKMPDQK939cv7l7scFl7zY080e893WqmBCHsq0uzfMar9iYnh0UZWCCRg==
X-Received: by 2002:a1c:f217:0:b0:3f4:2328:b5c2 with SMTP id
 s23-20020a1cf217000000b003f42328b5c2mr9510569wmc.35.1684858772540; 
 Tue, 23 May 2023 09:19:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a5d45c4000000b003047d5b8817sm11613693wrs.80.2023.05.23.09.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:19:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC3E31FFBB;
 Tue, 23 May 2023 17:19:31 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-7-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/27] migration/xbzrle: Shuffle function order
Date: Tue, 23 May 2023 17:19:28 +0100
In-reply-to: <20230523134733.678646-7-richard.henderson@linaro.org>
Message-ID: <871qj72f70.fsf@linaro.org>
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

> Place the CONFIG_AVX512BW_OPT block at the top,
> which will aid function selection in the next patch.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

