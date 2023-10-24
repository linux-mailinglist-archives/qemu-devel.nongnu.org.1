Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E367D53CC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 16:21:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIGq-0006Mi-Hl; Tue, 24 Oct 2023 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvIGo-0006IT-5A
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:20:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvIGl-0007Sx-AF
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:20:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so3311742f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698157229; x=1698762029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODTkQtGQD4KZ9gUIcggxSOVrhwlkUWj/j+BhGlp+ZNo=;
 b=la5y1rnOOWpnYi62Jda4P9/kVFKyykomqKMyS/80k1pRwe8Qh3ulkTx42+Ye8r79JS
 C5EtMHGGewZ3EC9V6aG8Y83EaI16cEAY4/cVjyBF5VO2g6pWecZfsdAwT7W+UpNKFkcE
 YG8CNG+QZS1AZOKcsQGe9BFtT6F3kgV4EHxFSLO35OB0ktvHgcl8eNCFcFR/WP7jJ+ZE
 HErEeG6FLCS+pNxHmE2LXjGPVSge/u+sBfNErTvTCJqS+xRkFPa6kwamwZi+FW5VZG51
 DM9SCtUG2oT3Hbl6j6MXl77bORfVmbWHdltQ3YnKqWc6G1vvPOzb2KZOriMeruajBc1O
 qfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698157229; x=1698762029;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ODTkQtGQD4KZ9gUIcggxSOVrhwlkUWj/j+BhGlp+ZNo=;
 b=oU81T/7t9liDHMklCRsvzft7cuXtBELaaQkrP78e2tKPr/L1AYzRsf8H6WVTmnY7y1
 3X6Y35Y80pTr6gRxmYHqdmHXEG9Tw8u6DHir7eYUh8zTSbWZyirZsfOY/mAm+yFvDgYY
 pkb8HTqMeRwAoeji9COMnEphLluQAVs92uHPqhj6vXhP6OySV3HCXsiVsPAo6So57i7D
 4x0PbyXO3C5VqDN2//7N/SBBz34BSpYOihcXwpdQ14hE1Ec3xwh8/IMBEChxT/cAXaS6
 lAeJh0JDnfll1F1II/COOdzASe2SI2q3RCcqQevvhsNP9Ab9oEoZWCrS5lLhAc7UTcG+
 qKeg==
X-Gm-Message-State: AOJu0Ywl+qrAb6qoy0kFqzBZXxdita3rUJE0+Fe/mJa5gTwltmbReYFg
 /I2xTU13nmN2R8T+Sjco7S6Yvw==
X-Google-Smtp-Source: AGHT+IGUZg8GBEdkKbQmbLM50FkA5EmLBJEtovx4Otw86nP65HS/pzHcbfg2XlJdI1nXqOIseWXMEQ==
X-Received: by 2002:a5d:4a86:0:b0:32d:a2c4:18bf with SMTP id
 o6-20020a5d4a86000000b0032da2c418bfmr8491586wrq.59.1698157229421; 
 Tue, 24 Oct 2023 07:20:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r4-20020adff704000000b0032d88e370basm10042461wrp.34.2023.10.24.07.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 07:20:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 298BB1FFBB;
 Tue, 24 Oct 2023 15:20:28 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-10-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Brian Cain
 <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>, Laurent Vivier
 <laurent@vivier.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v14 09/18] gdbstub: Change gdb_get_reg_cb and
 gdb_set_reg_cb
Date: Tue, 24 Oct 2023 15:20:21 +0100
In-reply-to: <20231019102657.129512-10-akihiko.odaki@daynix.com>
Message-ID: <87v8aw2jbo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Align the parameters of gdb_get_reg_cb and gdb_set_reg_cb with the
> gdb_read_register and gdb_write_register members of CPUClass to allow
> to unify the logic to access registers of the core and coprocessors
> in the future.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

