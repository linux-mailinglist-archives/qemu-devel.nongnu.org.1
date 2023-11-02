Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF377DF9B6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:14:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qycCr-0000Xf-3P; Thu, 02 Nov 2023 14:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qycCo-0000XQ-FM
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:14:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qycCm-0000wI-Vz
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:14:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so10898225e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698948847; x=1699553647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OW3l1Z85RK2aI11BSO/Kgu2D/SejBjLO3Lal8dIF04E=;
 b=sw8hPDuOuJZj6n+lmpuhO4YEijZQD2+1wiZIIDLPcIFvArD5sIw/JdGQaqTRmg4Meo
 VS0mzErsUU67LAp76pEMn549ZnZe34tw0YodTV8t6ON3TaLMHvFvvsbtQfk0n/sKJYRn
 GXUYJifuGbPv1CDDucj43W+MUzGNpYSepInTVVlt3RLs3IARnDcZYfmWyc+YOoxUcXoi
 RQYF5D3Xbwu7ASV50W7mv4077zu+Ol32psS3512xSHndrgKk3cs/Zp3PgVN5qZoULNet
 BhVx2MOu9QctHcIFVgUBBHi0kh9nz4/iwctfe+ajBcpCZ0+pNtejHnibwDzrtt36mSrK
 nmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698948847; x=1699553647;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OW3l1Z85RK2aI11BSO/Kgu2D/SejBjLO3Lal8dIF04E=;
 b=NCkKeU1M5kC45ddv2Usi9oqBvzanIfW/DRu6PPJte6cl9IwhbzINdpKkV2Wv0DbbUM
 PGJ7J968SziGL2mHohnDo0Lk0jin63YQuS2LYdWNiPx50tddGVQf2w6wYXM6eHWSPqCM
 vS1yJHpq2f54Z57aqdpMR/U6lP+x5sVAUmRxm33216qE05m5m7AzyHpEl2aIbr/NBFW7
 ap1TvoDYKKkZ5z7d+NV1xa6EW3XkCXbz7qOOO+Z5dg2Ugy9d8ChxcVOFkLQ4NlcZKXsg
 RBNmO7nBJU9c7WYdGWVe8oF2iK/ulIjOEMS3sJqe9bpVbTafXYtjAYWQSrl71iL2lmom
 jS2g==
X-Gm-Message-State: AOJu0YwcNiY+Ayz0FzbXWc2imT4wx598OUaI2wlcM+A3WVYSBKqO7ga6
 3LSNnVwPpevchS5l/Pu9jBvG0NCbhvWdsolhAX82fQ==
X-Google-Smtp-Source: AGHT+IFTWOrTEN9Z4MQ1CiJ68kInPEZCjToEMSD22FhE3LPEU2emTVc1wcR0C61CvuzYTy/RtkiW4Q==
X-Received: by 2002:a05:600c:2990:b0:402:ee71:29 with SMTP id
 r16-20020a05600c299000b00402ee710029mr15709455wmd.10.1698948847528; 
 Thu, 02 Nov 2023 11:14:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j3-20020a05600c488300b004054dcbf92asm245350wmp.20.2023.11.02.11.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:14:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C24BC656E4;
 Thu,  2 Nov 2023 18:14:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,   luoyonggang@gmail.com,
 richard.henderson@linaro.org,   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] plugins: allow plugins to be enabled on windows
In-Reply-To: <20231102172053.17692-5-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 2 Nov 2023 17:19:47 +0000")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 18:14:06 +0000
Message-ID: <87pm0s2fbl.fsf@draig.linaro.org>
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

Greg Manning <gmanning@rapitasystems.com> writes:

> allow plugins to be enabled in the configure script on windows. Also,
> add the qemu_plugin_api.lib to the installer.
>
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

