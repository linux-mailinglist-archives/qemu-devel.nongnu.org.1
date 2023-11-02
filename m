Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551B7DF121
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:28:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVqZ-0003xN-AV; Thu, 02 Nov 2023 07:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyVqU-0003wy-H1
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:26:42 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyVqR-0003TW-6A
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:26:40 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c6ed1b9a1cso10847741fa.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698924396; x=1699529196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mYOVtPxm9uIrIzEvQWCjkhasdDoYfOFUXTSXi9j4HoM=;
 b=e01A2+ikEfxCezFe6XYEiUhliG+HbNpO+u3zHllR3kcAIuy+ZBQMBSoXXXj/BbCw89
 2wcn1ZWl140FXiyBde1RP0rnpNnIbyQxdEZLvnIp9m1oWLKA0+2WtGgl2sKPK8YCMnwj
 ppfslZKkP24Bg1OC7NmPbfzYpa1+f2sh2ErkWMlxSoXB5L//EJ6n5k0PKYovs7vl6grF
 uil0x5nw0QeXX1ZY4ui2SugMEBKAjxzfenxnpgcxAyMisnXE/HPxQgBaeiWe/hoCyNur
 AA9SMn1QhXadLI0+nFjAgQpEs7prXoG6GOJCaf9ENJ4juUVZn4bhpG9Wrx9F3uVQN3cb
 jILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698924396; x=1699529196;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYOVtPxm9uIrIzEvQWCjkhasdDoYfOFUXTSXi9j4HoM=;
 b=GUPMIx0gKR+Gw3PJqGgh/OLYrJmwiUJsnY2SFTceT6SBi8qiz3S9Tbmm9eBUNxmsDR
 r+Fo+97eNHq1CGUb4DiXKJQvDOaDkHhZO0Pin4cmgXRpPrM3nsh5w+dHvXgrTDNRK0So
 b4lLwi02cVbigB1vZFGN5PM8uRsb71QdjS1hnDQFzEBwwx3JzFeT9airvvya5aRWo8Er
 5EYhBH61WQXfmwlQ2KpnMyM4f0vyP+WtYzP2mxKFlWuRLFb2Dng16h9Ct7xhfkAWJ06o
 8g4skxunlDJWX5RjvXoeQDHhh2tX3236RisJ5H0VcP6EyFM3/rgBSbc+gzaJLxC6EEL/
 Z7KQ==
X-Gm-Message-State: AOJu0YxWbdeGhRsb3gUUpS19xqYAe9i/CqeEufdZ6NF0xLpQmwaNKTTj
 OI4O1dEOwf5pcfxX0wZ85wPR1g==
X-Google-Smtp-Source: AGHT+IHuq8cdtJkHzERpeWEnS+8slR8wjeJzGlrZ4Ru9+T++HF2IYCMxl4UlKq7iBmwtRZ3U2BKosg==
X-Received: by 2002:a2e:90c4:0:b0:2c6:eaf3:8065 with SMTP id
 o4-20020a2e90c4000000b002c6eaf38065mr2391501ljg.26.1698924396025; 
 Thu, 02 Nov 2023 04:26:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b003fee6e170f9sm2572543wmb.45.2023.11.02.04.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 04:26:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 122145F781;
 Thu,  2 Nov 2023 11:26:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,   Aleksandr Anenkov
 <a.anenkov@yadro.com>,   qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,   Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH v16 17/18] plugins: Allow to read registers
In-Reply-To: <20231025093128.33116-18-akihiko.odaki@daynix.com> (Akihiko
 Odaki's message of "Wed, 25 Oct 2023 18:31:17 +0900")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 11:26:35 +0000
Message-ID: <87zfzw4cr8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22d.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> It is based on GDB protocol to ensure interface stability.
>
> The timing of the vcpu init hook is also changed so that the hook will
> get called after GDB features are initialized.

I guess this was moved into an earlier patch.
>  }
> +
> +int qemu_plugin_find_register_file(unsigned int vcpu_index, const char *=
name)
> +{
> +    QEMU_IOTHREAD_LOCK_GUARD();

What is this lock protecting against?

gdb_register_feature doesn't protect cpu->gdb_regs() when registering
features as it is implicitly per-CPU.

If GDB should be locking I would push that down into gdbstub itself (and
not use the global IOTHREAD).

> +    return gdb_find_feature(qemu_get_cpu(vcpu_index), name);
> +}
> +
> +int qemu_plugin_find_register(unsigned int vcpu_index, int file,
> +                              const char *name)
> +{
> +    QEMU_IOTHREAD_LOCK_GUARD();
> +    return gdb_find_feature_register(qemu_get_cpu(vcpu_index), file, nam=
e);
> +}
> +

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

