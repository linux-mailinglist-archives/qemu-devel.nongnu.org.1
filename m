Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88B7852B0
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjFp-0000Qt-SG; Wed, 23 Aug 2023 04:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYjFn-0000Od-Po
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:30:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYjFl-0002fN-OF
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:30:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fee843b44cso34011515e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692779411; x=1693384211;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DR5wz2T5TZ+5moOSHnTix6tyEkDLpDXIHTTk8Pvyi7U=;
 b=nnINOxYZrS1NVDBdB+Z97OwHc/N7xFiRhk/cBNFKBV3SHX4my4ejYUosETjA/TVLgJ
 Godu0Z8arFXtFFDbBa9mIvE5x7vyef+IYbUE2TOSHZyCr7ucY67TewQaRajcYcKEeeY9
 ULuhae8sOvde0jjohfE2YUUERiqfpePDycD69ibfsGCTI59YNn3tb0Ymc2b2cXfntFoo
 wR3grNEp/DRz/cHj7mxunHrBthgEwAOJ6AwGEkDX5c8vTmHHpax/3bksYmHUAgKsLQUZ
 5QbDP4CLm9IlyOCcVHOu51cun5+VZIqKQklsqs5ci9lFGt9z6NBZ+3bqO8+E3hrbECS2
 T/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779411; x=1693384211;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DR5wz2T5TZ+5moOSHnTix6tyEkDLpDXIHTTk8Pvyi7U=;
 b=fDaHLTh1zfe+SCiYTZRHfnWTSAvaSFZyvzSPewZXnNNjyoYShXyBSQBIKfc02F0fQj
 20/5EfnXNRJDjPlYp5nv4JIIcgFqd3xtAeUNRbXKQisBDw3+hkY3Cc0E8MaCU8cnvlyA
 X1ccJzJMm5SOTvzTxPjOjjhlYr5XNayy2XJ2N5ETJshv5k7HJIbflhMPk4V9WyBJi1UF
 OjN+d2xVnW+pYgGD3t57t0RaHQu7p6nVtTCGOQ8aE0jAs19sTUOwlRrme5OJNeu5jR7z
 0p89LyqksAjGaWOn2WEVbszMTcKStlYP8rICzBLL6mBmhLtEdbqBzDTbWVmGcg72hzWP
 h4xA==
X-Gm-Message-State: AOJu0Yx7CK+tVC5/lGv7A9HBNDCMZplVRjcDOF7Zxlj16hu2KQwiG8/x
 u31ZmGxN1cHvOw+a0aBvcxMpXd/JICjiuE2RPdk=
X-Google-Smtp-Source: AGHT+IHd6xXsF+J7j5cK6sk++bTGvWh8kPjuj08PdbWu1DVh+9jBi41VYKdtFBgDft03l8QY8E0IHg==
X-Received: by 2002:adf:ee41:0:b0:317:6220:ac13 with SMTP id
 w1-20020adfee41000000b003176220ac13mr8866723wro.32.1692779409764; 
 Wed, 23 Aug 2023 01:30:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d4b02000000b0031aca6cc69csm18289095wrq.2.2023.08.23.01.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:30:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 080391FFBB;
 Wed, 23 Aug 2023 09:30:08 +0100 (BST)
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-4-mjt@tls.msk.ru>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 05/24] tcg: spelling fixes
Date: Wed, 23 Aug 2023 09:30:03 +0100
In-reply-to: <20230823065335.1919380-4-mjt@tls.msk.ru>
Message-ID: <87v8d6gnzk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

