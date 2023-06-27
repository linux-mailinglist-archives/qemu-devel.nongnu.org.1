Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B973F999
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:03:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5Xi-0008K2-VU; Tue, 27 Jun 2023 06:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5Xg-0008Ha-EH
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:03:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5Xe-0005St-VL
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:03:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f90b8ace97so59172355e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687860201; x=1690452201;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3D1jYPuNcaP6dWIFfsr/5FXVVxktsT+ska3r/evf3Bk=;
 b=gycbPJdCEv/RLSfsQivq7tCG9Ll1grnbchH9Z+z+eOdeGM8n1XKzeBiIfJyNP46tkj
 xhM7YvZx6c+M1PXYBkel4O7tpBn8Qva2eJ7+YRdQ8CwH7B9U71x7AYY2QQbG844o2s0a
 BYhiuWLFtQ3H7rCLUgjM3z3aKZi7VHhsz7/Jw5qCiUGtf1NBak+76Ial5AUACtb4fZlc
 sl1oxwccGCK5X9zWoPLr78mZocffwxppwSfrLggT0A5SmBSwLnZ7Rucp/fND9lYVpmp1
 wBmhRO7aOEZbA9lXLkjkG1xo8r4ecA1YSZHq16uPv8pmwfTVENX/Bwyrd7aBbHiyEYJi
 tSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687860201; x=1690452201;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3D1jYPuNcaP6dWIFfsr/5FXVVxktsT+ska3r/evf3Bk=;
 b=EZSZbVPwtPzRnr8wftyWskgbNNDh/kJTc95PxoJ6brsrmk7lzcHH8kTSCtYJ08cWnR
 9UHejUNVhrxW04rUh/xyQYygIDWlxNze7tr+9Yw5yz1iqAKd8PNZ90DK+QlXccGl0h+P
 ilzgNpPyqkBc3OFI+/d4Y7mVjcUr02TXyRwqPXIlfXNvo8Q4Y4uYy9CQtLimsx0Z7hR7
 G9tgzIn6nn9aQixQfghJfskBUNUHUTYrghHFnKUhhnIHq1UH525VJf99YP7RqaThDDfJ
 dSlt/O5LT7VNO95k9UFXiR5IHaHG3OHDMm9ORqOubyRhxudttsOHeZbiL+zVXgO28oqD
 OqcA==
X-Gm-Message-State: AC+VfDyyvLi1ETUbMUK6IZoJmRgT8oImJG4/XGWwjZfw4BCdpichcdnE
 efTYWOdmiLuRLIEPsvAyKG36V5m0kz7ADoYiAVg=
X-Google-Smtp-Source: ACHHUZ7iUQWdsKYyPtA04rj4Do54eIaUVQSZn7rOTRAIwQaNkv1SlLatxe7CRWXenq9fUx3xPFt2Wg==
X-Received: by 2002:a1c:ed08:0:b0:3f7:4961:52ad with SMTP id
 l8-20020a1ced08000000b003f7496152admr28072645wmh.3.1687860201281; 
 Tue, 27 Jun 2023 03:03:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 er8-20020a05600c84c800b003f7f475c3bcsm1801194wmb.1.2023.06.27.03.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 03:03:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C5BF1FFBB;
 Tue, 27 Jun 2023 11:03:20 +0100 (BST)
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
 <20230527141910.1885950-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH 1/4] fpu: Add float64_to_int{32,64}_modulo
Date: Tue, 27 Jun 2023 11:03:15 +0100
In-reply-to: <20230527141910.1885950-2-richard.henderson@linaro.org>
Message-ID: <87ilb91atz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

> Add versions of float64_to_int* which do not saturate the result.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

