Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A8745A94
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGH6K-00072r-Nm; Mon, 03 Jul 2023 06:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGH6E-000724-Fr
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:48:06 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGH6C-0008Oh-UH
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:48:06 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fa16c6a85cso6618318e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688381281; x=1690973281;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uBlIGnKpJ+UgFKwNAplF3WihVaf6nRKjKgIbA+xtCo=;
 b=Hq5LOg0zd+InUZkOzKeei9KIKKJTUg2KgY7ZmPD43OVLkJHbwtuZrM2c7izrDOaD5r
 /x5URvT3JVUtuudSuHYbC2TFEl2cD03+ds+IuJv7gznuJ2XblYNSY4Kh2vVw7XyUQ/+8
 jsUJuw358D2/vSsLoqnlJ7jESKUdtIqd8h2j+8xSPL3uKYbFm1Dfn75Qygzt3dXVfwT0
 p3J+6ri1gR3NNj9oDO9pbXVsly/kPvJEEwiRWvSJh97GLrWQb02XG1uyLg6XDZeDQpM3
 w8HTOLYf4lbyE00FGI5A/zNKe+aR+qMFh3WArW2z09O3J2Wbx56AlOUkniy5eT3x8rTT
 mR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688381281; x=1690973281;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6uBlIGnKpJ+UgFKwNAplF3WihVaf6nRKjKgIbA+xtCo=;
 b=LhEPl5WaB+x7Qm/CFWazH7I6QotDSrSvmxyhmje/pj1b5RgQfIFr5DJu3va0eGwz7p
 rPd9Vp4w+MnnmFmr/C8Fmrk9sT52tVyqgfnT13r5iihPNieXNyIzM5J87HXiM6h31n7j
 oBZJa6SkOARMSQqsIn4/2wNoM4rkvv0meNT0i7puCQ3ykoc3A5UzA4+q5cxW7N/6SmEe
 y32gIbY3If8P+7o0ujMNP6qpsMJfu+Yt6Dpv38GrfdmD9RZf5NDosBYqxx/HaiZc2LFk
 hR8hyGSBUOOhPEUWt99Eb5kZlH3ugOyU8oFM9CvFpW4Oiw8etcTICvSY5bMf1kfYPJM6
 PufA==
X-Gm-Message-State: ABy/qLbYsp9UxxAZkRxC+t8XekUugSfZpY2SW2H+J0ldOTCYU3iHn6kC
 ni07xvCZOlZaY5uSHaNsTIu01w==
X-Google-Smtp-Source: APBJJlGlWOgIRyL5zJ551qYdfZtlCoW4CsYQHFC8cVX6fbU8HOfV/aJh79wX7QMsI786RPu+qxxggA==
X-Received: by 2002:a05:6512:447:b0:4fb:94fd:645f with SMTP id
 y7-20020a056512044700b004fb94fd645fmr6601668lfk.68.1688381281568; 
 Mon, 03 Jul 2023 03:48:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a05600c3b8a00b003f7f475c3bcsm7699440wms.1.2023.07.03.03.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:48:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C688D1FFBB;
 Mon,  3 Jul 2023 11:48:00 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-12-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 11/24] linux-user: Widen target_mmap offset argument to
 off_t
Date: Mon, 03 Jul 2023 11:47:56 +0100
In-reply-to: <20230630132159.376995-12-richard.henderson@linaro.org>
Message-ID: <87pm59i84f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

> We build with _FILE_OFFSET_BITS=3D64, so off_t =3D off64_t =3D uint64_t.
> With an extra cast, this fixes emulation of mmap2, which could
> overflow the computation of the full value of offset.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

