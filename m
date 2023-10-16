Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A72D7CABBE
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsOjl-0004Cv-Ke; Mon, 16 Oct 2023 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsOji-0004C7-NH
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:38:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsOjg-0000rl-TJ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:38:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so49427555e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697467102; x=1698071902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTmpG7pg4KLJVWg+ZcGjpNI9U8juXfRNj1RlWHhKX9o=;
 b=Zg9EDB3KkgGBntt/BVPvGEK0IAVUVai3MsEgcIljcHhKje2wgDsb4yXZNVY2Qli0It
 RTMZhwOFCUDgHRYnlcKI80fQYg7KA61Lwd4L6lIsPwgKssBMDnKUTRoRPEygZoqpLtnf
 UOKm3f3NgaimD+5haA1zgASqpmipQwfBtue7iCfqokRzcwpFw+Rb4Uls3gCbwCMOPaMw
 /Y0fDyEphI4l27yPaHtLKVtL5Mtt8YVyuWEMV1WxfNKPPehnaGxKsaG5Q2TphNK3jcTz
 vNDvSl9kLEcZymS7EIBdzUwCQo2Ae/psW86FqJ2Aqzrp035h2rhzez1AuWMK8g8Ts8mM
 xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697467102; x=1698071902;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nTmpG7pg4KLJVWg+ZcGjpNI9U8juXfRNj1RlWHhKX9o=;
 b=WiwnGkYPr9muxyl6hCBGHwnk/Xw+ibX3rwtqgMN5xo9gnD2Ww/osI6yMAwdSRpwTpd
 NXTK0Vc7CgXkpudFUKYZoOWzb48/80jMuXAIvyP1+KbB/8Z/m3PNrVxExYG+2qyiNW/Y
 nc6LqDHlwKkdJt6okLyIes8XnCoX4JMkwxH1z8GRWheghYTDmn4iCmIVcwhK/vC4b0BT
 PbyGKAbIC9JNUgtmyYEVsPbS9qflTxvZuTIkY93UdFa9aNteE9H+GU/4uZMvLo7pBsUk
 yc+hsSFD2yzuZ+sOAC0zjq5An7zxIZuMkJhVE2iDs85STJgNXKwXxyJP+gObL6s42/gq
 /Vlw==
X-Gm-Message-State: AOJu0YwZO89/rq0CMZE+A5e4ZLDWHyLmWpMoI5eL06t1slXC8OlMuTvV
 MQYCsywojSV5VFFMoD8LitEmcw==
X-Google-Smtp-Source: AGHT+IEOEJkzujfbQr1USAZT+321zXvuAugn5GoI2M0oyW1/zSR7govkvxhdc4acWu79sHF8XYIenw==
X-Received: by 2002:a05:600c:2116:b0:406:53c0:3c71 with SMTP id
 u22-20020a05600c211600b0040653c03c71mr29573501wml.37.1697467101714; 
 Mon, 16 Oct 2023 07:38:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n34-20020a05600c3ba200b003fe61c33df5sm7441164wms.3.2023.10.16.07.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 07:38:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9662B1FFBB;
 Mon, 16 Oct 2023 15:38:20 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-6-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v17 05/16] accel/tcg: Add TBStatistics structure
Date: Mon, 16 Oct 2023 15:38:15 +0100
In-reply-to: <20231003183058.1639121-6-richard.henderson@linaro.org>
Message-ID: <87h6mqd44j.fsf@linaro.org>
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

> Add code to allocate, reset, and free the structures along
> with their corresponding TranslationBlocks.  We do not yet
> collect, display, or enable the statistics.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> [rth: Significantly reorganized.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

