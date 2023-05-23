Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15C70E136
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:58:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UNq-0005gk-Lo; Tue, 23 May 2023 11:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UNo-0005g1-GO
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:57:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UNm-0000a3-Os
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:57:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f42d937d2eso88465e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684857424; x=1687449424;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEeLMkmcANZl80GAw+RXt84fB2+eSnJNZKWduDTOuzk=;
 b=SvsBl/0VLmQSBGOQipTgP1IjiqSoj7s/lPrEwldNLTtds23f3bp7/ZoxeuQR5fJ5Sy
 5Cyv1VaK2HoOUfywPOSlgTDcLWruslKlVWC/l1l4CrMQOYFOe6Y1MfJJSF4viDo2Oh/0
 9+4M+QEH46O4Uno5ayX472FA6I0HEkkx59x4dlZp9tfWx8HTvYc4RQ5LznQmbWfRrtNa
 fPPJto7dv1lBDgK1lJPLpR6xrdESbsss3Te87/aAM88TIN1vEbm5uJHADYcuI/RMafHY
 WWzUnnQW9X2m6+0qIHaTcySCgACC99Ad52grnja6ow8Urhaxe+2SS/G5W5oYapmWCRiC
 GJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684857424; x=1687449424;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AEeLMkmcANZl80GAw+RXt84fB2+eSnJNZKWduDTOuzk=;
 b=fps9K5XZnY9ovbjdynnpqJvGTYjBcoGBOJhp9br7mH/YrhNEY7ksAd2tDDXqOD9SZo
 aYepdCLSmDNgpIJgzYaoVSW468735Qf53MCIxqLgJ1tzy6czdolJXkb4yHVvk5ClIg3E
 ong5ERF+iPHkIOEfZTwC5Urw3Vnp74BkXa7LbKyqYmBJ6zQ2dh3FUF9wec8HrytZejuu
 AVdEtNZRuA7hefKCkozYtCBRae3NcnG7E9yDErCXRe6UoYQYS3kBHqZUYiHmZDRLciLZ
 HWL7KrguWCtsHE10KXAWEGZkyVxAsRrtnsUB796m3kPDGCuXheLrGRhTovmMHYnC7+KJ
 XSsQ==
X-Gm-Message-State: AC+VfDzweL5xOiPoA5Ssqu2rpGT+tGN+GSHCDhHMcWI0SIK3hy60JqLt
 eIsCPASuvcE3voJl6+fY4jRG6Q==
X-Google-Smtp-Source: ACHHUZ6IBJdYiBM1b2VYs3Bq+yJF5cmJUTgRpXFzARb8vxYhMq0lnhhskQGHC3NPivOnsNwUH+bI1g==
X-Received: by 2002:a05:600c:24d3:b0:3f4:298b:d925 with SMTP id
 19-20020a05600c24d300b003f4298bd925mr9457180wmu.41.1684857424139; 
 Tue, 23 May 2023 08:57:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a1c4c05000000b003f60eb72cf5sm1232296wmf.2.2023.05.23.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 08:57:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 67CAA1FFBB;
 Tue, 23 May 2023 16:57:03 +0100 (BST)
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 01/27] util: Introduce host-specific cpuinfo.h
Date: Tue, 23 May 2023 16:56:58 +0100
In-reply-to: <20230520162634.3991009-2-richard.henderson@linaro.org>
Message-ID: <87v8gj2g8g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> The entire contents of the header is host-specific, but the
> existence of such a header is not, which could prevent some
> host specific ifdefs at the top of the file for the include.
>
> Add host/include/{arch,generic} to the project arguments.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

