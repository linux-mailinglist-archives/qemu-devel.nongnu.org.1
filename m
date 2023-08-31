Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62378F06B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 17:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbjgt-0005Xp-OS; Thu, 31 Aug 2023 11:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbjgn-0005XD-AT
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:34:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbjgj-0002oK-Ue
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:34:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so810849f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693496068; x=1694100868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgU6mAtiCUnZnHZSYdXc2+Tg489tSf3aIw7bmd44Wk0=;
 b=hvsdgwuk8V9VMXifO0whDbXGOTvGRWiKy4GkY3GprUtc0E3XUX98cuY0NALvjA9opN
 oXYMsYkqZaAex+iYDdvAFUSM6p19/SmjfmqNuSQIGnXQU5TQuN8WBw2kOap4aCzPn9Ej
 aXwNFmXN1NvKDo+bK2p2xK27eW/LxbfLmDXvsf8PRLq2Uk/9n68egHMMyVbnRt0B52xK
 BYJmHxFMfiYBzYFYhdlbApMPG7VBgA+Uy9nh9eF8Q/vTmcx57QSzoueGd8k0kEoD7aYq
 eueva2YQR3Xp618Rma2PqzPnOQhmc3L0yYNydxwGHtoo3sYYps8nuaM5badQvlIl7wzJ
 +8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693496068; x=1694100868;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wgU6mAtiCUnZnHZSYdXc2+Tg489tSf3aIw7bmd44Wk0=;
 b=DW6d/LgNYqdacFXkr0AgPD9XbXft53pXXIDWYO6T4zCWV+Fe093ger1OaAA1Rkb7fC
 Anp9pn2EQ1nUF+zFuWICjhT5cojfRXcZT92R2xezUNvRQPTdEyqBmo4SaV+UXYjOuqYP
 9aVTTY+RYoib5aeJlG0OcbP9s6BxcbKrJWAHymYsFq0kZoOguc5iR1RFnZ99YseQRL2/
 50+Lvo3JCB+K18xuEkEoeQGoTnrNs/kwewQsFVHqkkBz4qOgNEpLpTzF/DPUkkmJjxo+
 SWaouKAoPmgezmSlAKdkRKrCd9HpVoqqTa9xWO13WwBmoeJNh90v44vmqEWHlD6mW9Mn
 ALaw==
X-Gm-Message-State: AOJu0YxSuHlV1hAzcFZ8HDX7FFEhql4tg6zYUp5ZEPSZciJATBUpeMSp
 okg3V4WV/iHQ4DSXG8IkVUyx3A==
X-Google-Smtp-Source: AGHT+IGwkt6PVLttrvKrgB36GKx1oHF+OICd3FejER/RJU5gRki3FVeGnM3ycFEFIq9ghepy8VOQyQ==
X-Received: by 2002:adf:f40c:0:b0:315:9e1b:4ea6 with SMTP id
 g12-20020adff40c000000b003159e1b4ea6mr4272785wro.58.1693496068090; 
 Thu, 31 Aug 2023 08:34:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c00d300b003fe17901fcdsm5458769wmm.32.2023.08.31.08.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 08:34:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54A5C1FFBB;
 Thu, 31 Aug 2023 16:34:26 +0100 (BST)
References: <20230831082016.60885-1-philmd@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, libvir-list@redhat.com, Richard Henderson
 <richard.henderson@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH v2] accel: Remove HAX accelerator
Date: Thu, 31 Aug 2023 16:34:16 +0100
In-reply-to: <20230831082016.60885-1-philmd@linaro.org>
Message-ID: <87v8cvp6nx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> HAX is deprecated since commits 73741fda6c ("MAINTAINERS: Abort
> HAXM maintenance") and 90c167a1da ("docs/about/deprecated: Mark
> HAXM in QEMU as deprecated"), released in v8.0.0.
>
> Per the latest HAXM release (v7.8 [*]), the latest QEMU supported
> is v7.2:
>
>   Note: Up to this release, HAXM supports QEMU from 2.9.0 to 7.2.0.
>
> The next commit (https://github.com/intel/haxm/commit/da1b8ec072)
> added:
>
>   HAXM v7.8.0 is our last release and we will not accept
>   pull requests or respond to issues after this.
>
> It became very hard to build and test HAXM. Its previous
> maintainers made it clear they won't help.  It doesn't seem to be
> a very good use of QEMU maintainers to spend their time in a dead
> project. Save our time by removing this orphan zombie code.
>
> [*] https://github.com/intel/haxm/releases/tag/v7.8.0
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

