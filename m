Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23C7D0112
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:00:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXJx-0004qs-MB; Thu, 19 Oct 2023 14:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtXJu-0004qK-W4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:00:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtXJt-0002Ci-Cq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:00:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso6970755e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697738422; x=1698343222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65ULfk/WldDt7TGT0mCwgA05llIswxViMbipAhFyqRM=;
 b=sz1ahfSBnXZCRCsGAIZO444T2I9QvzOBbZUNMEOEw004IFzdeTCBuZr2keLUaZJF2o
 Ylmt3EH1dzFXDquD8MOLYBRUzijlMCXFC4bJBrSr/g0Q/Q2+wYx9Tmn7K0eD7mxj5IXT
 FeWN6Ads6RMUcw3gvcJX8Tx1rJVNvag/X+ixmTf2T51TDti0gxFjFGPjcI9fEoCxAR5q
 In7XSKtQ+YDP4jK1MBs6Wwl2Pf0p06XMFwdacZ/xTLFIubZKVk/6TKIzvVdALV5cjUES
 ckEsRSpk0f4YFBnlfOwisWtnD46c34Hm/p29D1uLQ2qPqO7B9YTtfyRdT4ZJhYbfeD5W
 kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697738422; x=1698343222;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=65ULfk/WldDt7TGT0mCwgA05llIswxViMbipAhFyqRM=;
 b=MYxtk+0B9YfzqPGM2HZCk5kMUN/LWhUqSwIVEReQ3Hp8o8KPgHieBXN9VDi6zW20gB
 vWJxxxUTA9MdaMMRgYcfFxEDbIEowYHx0HJURXpojo//dHXAQRId5nUXjZTHayI55N65
 TK6IpeEoeRXniKp/b2OfScQ9SaLZNDap/7OdrXLolqdbFq8OJwc6oO/tGvq/t+Z+mEPz
 MzDWZmDfs2tC9QfcM2CAIhuj+D+YoMrupdfeQFxYx+clj/vmAta7JRJqvG3LOVVtVF8S
 NtYSpDTvlN/Acd3yMO9CwKUmWCqvLHDOFzT6JFQR2HpimPANFKMowu6kP0TBgHFlYY3I
 O7NQ==
X-Gm-Message-State: AOJu0Yzp0q3yO/+OvpsMK659ZNFh225l5JBfer20GoMiEPLykuOplOJa
 KKG7cUt4Y55Ooj0W6r3jwpUhpA==
X-Google-Smtp-Source: AGHT+IFpuf2s5L/wN8NPPD+suffJLHo6SA74UVRFhzOCOXNXLwgMuwyLdOtGPU9dna4ArjoVIV0SNQ==
X-Received: by 2002:a05:600c:35c5:b0:407:3e94:bcca with SMTP id
 r5-20020a05600c35c500b004073e94bccamr2752302wmq.1.1697738422608; 
 Thu, 19 Oct 2023 11:00:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c350f00b003fe1fe56202sm147629wmq.33.2023.10.19.11.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:00:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F66F1FFBB;
 Thu, 19 Oct 2023 19:00:21 +0100 (BST)
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
 <20231019101030.128431-2-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 1/6] gdbstub: Check if gdb_regs is NULL
Date: Thu, 19 Oct 2023 18:59:55 +0100
In-reply-to: <20231019101030.128431-2-akihiko.odaki@daynix.com>
Message-ID: <87h6mm8pca.fsf@linaro.org>
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> cpu->gdb_regs may be NULL if no coprocessor is registered.
>
> Fixes: 73c392c26b ("gdbstub: Replace gdb_regs with an array")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Queued to gdbstub/next, thanks. I'll leave the riscv stuff for the
maintainers of the arch.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

