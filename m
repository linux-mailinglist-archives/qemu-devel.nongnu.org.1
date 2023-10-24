Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E07D56AF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJUV-0007lo-BJ; Tue, 24 Oct 2023 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJUM-0007hp-38
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:38:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJUD-00071u-9E
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:38:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso36796965e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698161906; x=1698766706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aOIsLs5187z8drMHrajQ83KAXkk0KYBz3wkldFj2fA=;
 b=u1klkHeh4EcIHW8WhZNzNgCwSNcKvaz5kxucg5cIuLMQA4Nvjz7H7yd/43yC14eqH+
 q8/q8yIfgHfkbBNdmvkpF6LqJRHWv7NimQiusgCOkIhv5MTbqn2IAIcpWV6AECcN4w6B
 FjPMvpxfm2LzhManGmn3e12p1t5OIsea6TeeCv/ZQ4/dHRWd2BS4Ql2VGawzc8alfjkM
 rIEkuoKACmSk2d57uR1Z1cgxOOTp/bL/4cMu5AbFvOLBPs33r7ZwNBj+5RP/C2MLHJ79
 emYpp9vnB9IfDkuEohH/+dte97gyA5kGRsnayKqob99LBQWbU7G4WFYI527r4Q9lcCPt
 m7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161906; x=1698766706;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1aOIsLs5187z8drMHrajQ83KAXkk0KYBz3wkldFj2fA=;
 b=IDP3J4Vu8SbvUW5yXjB7T/zOMLjzuGvbyZQvWsMN6BnnZttt0Md6YaPybgS5VMlQUv
 xpr6WpDolQgHnXBcZ7SaNWMkQsR9vBbhU8V3Yh8vMITo2gzBrtiToMUXBcbgq/dre5UP
 UlzbKp8M2az84GGFODw5qyz1oq4T/liuaMKa/DRm/EK+8qy1knSFzQ+EloZFiDRkrHPH
 WSBM0oNdmBjYcrdwtGVJRtBe8ZvGFdzbJfPcTnyMXI2xhyBI5UEYv9Al4wwBUdkLR7t7
 APlRxoZj16vc8FZ0Jvi8PHx8wAFvz/Iml69jkmmZpZRzFh7KWyNEkV73/YzLhvWZ9ahQ
 hzTg==
X-Gm-Message-State: AOJu0YxYhTaCBmVYeTCwreoYjY5xnb5W4of8i+dmLXCAMMDjdNbTqxn+
 D5WVGtAuTXdNqYyVXUMh3imtfA==
X-Google-Smtp-Source: AGHT+IHVbldkAv/dEHpzKqu73rxtoNq04l8eEb9LqyCZKrMnTw7Ddtq72VAlNsVzvnD/7/n9fEiAvA==
X-Received: by 2002:a5d:4407:0:b0:31f:db1b:7296 with SMTP id
 z7-20020a5d4407000000b0031fdb1b7296mr8271523wrq.21.1698161906515; 
 Tue, 24 Oct 2023 08:38:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056000010700b003232d122dbfsm10095309wrx.66.2023.10.24.08.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:38:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A56611FFBB;
 Tue, 24 Oct 2023 16:38:25 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-13-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v14 12/18] hw/core/cpu: Remove gdb_get_dynamic_xml member
Date: Tue, 24 Oct 2023 16:38:21 +0100
In-reply-to: <20231019102657.129512-13-akihiko.odaki@daynix.com>
Message-ID: <8734y02fpq.fsf@linaro.org>
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This function is no longer used.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

