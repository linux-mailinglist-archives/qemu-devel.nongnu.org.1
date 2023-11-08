Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DCC7E59D6
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 16:15:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0kFr-0001Bg-JX; Wed, 08 Nov 2023 10:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0kFp-0001BG-Kn
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:14:05 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0kFo-0007Dl-3r
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:14:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32db188e254so4227491f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699456442; x=1700061242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIPQGVsDFGXqUeo+mqd3ircm5kxLa8Y1e+Y3gHEUJGc=;
 b=QPRZjtKqH3IsIg1JpVu8Mj92tU/zLv73CG3klq4nD9WqzuQPT4urdNnHsubPD/L+Tu
 1mQUbkkpywpAMgGbhr17wIuRbJLXcvfAibLu50VD1XfyfNbZLAejt8u0QeOJTX/8FKii
 lBKibGbsFuW0O4z1w0KutBZJOVuXT/Ya1SpgxBu0c4Qe8qTzYwrjtlkEswJdzO/QUXJW
 IfyyN5bfVm84rkhEihe545GIQ3Dbq67xtEnoUOxI4ze9qQnBpIQUVIeM8k9a9Rb3l1Mv
 0GmQU5vDbOB8RE3VQorWX5iswJoKlIy1jacbwZt83uzqyFtVW/l7ckkaU9KJolirumGj
 QRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699456442; x=1700061242;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tIPQGVsDFGXqUeo+mqd3ircm5kxLa8Y1e+Y3gHEUJGc=;
 b=LA7gnbnFx7iCBxNYEoFkJlKIHWrpa/ThU8Mv183BLIbfCx65WgL5tS3bGjFMjzUMFU
 6msVeolYa8LA8vMz65PnPMbClACmkopzAJ5g+xk/XryxpPHitVdLwjGvKpJVlTT6zyOO
 oU8Wo2KvC2h++qNmIRGYOSBs+JYI+4xghveJKDyC6arM7d1N6WeZk7O8JwG97H9XEljP
 rFk4hBQkPRyIsmdlKDg5slgCBdrok4W6Xe4ZCT9AuRnLhOoYMm1Bjqsnlg1v5CFLtJ7e
 hiy5y4Ycf7XqyE5WMRndricWNw66+1yDt3KmSm0JdDP2w/qm+V8VVHOMVDKgoVVLh3XT
 eqvw==
X-Gm-Message-State: AOJu0Yy2ofmwKKgMw55ScIunTG31eNic/VqwFjS5GbLvLIdPx8oAXKN4
 14OVG9Mttcpil3kw789n/jb5Mg==
X-Google-Smtp-Source: AGHT+IFf5JMCvu+N35Uvsr/xlApxW0alozi1Ll8MpbQdYo/l379Hadd4AM3bxIePOhnGyHjbKRPpMw==
X-Received: by 2002:a05:6000:545:b0:32d:b06c:b382 with SMTP id
 b5-20020a056000054500b0032db06cb382mr1801751wrf.39.1699456442049; 
 Wed, 08 Nov 2023 07:14:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k9-20020a5d5189000000b0032da75af3easm5153487wrv.80.2023.11.08.07.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 07:14:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 465DE5F751;
 Wed,  8 Nov 2023 15:14:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hans de Ruiter <hans@keasigmadelta.com>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, Gurchetan Singh <gurchetansingh@chromium.org>
Subject: Re: QEMU Virtio GPU features status & roadmap?
In-Reply-To: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com> (Hans de
 Ruiter's message of "Tue, 17 Oct 2023 00:48:00 +0000 (3 weeks,
 1 day, 14 hours ago)")
References: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Wed, 08 Nov 2023 15:14:01 +0000
Message-ID: <878r789t1i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Hans de Ruiter <hans@keasigmadelta.com> writes:

(Cc: Adding others with interest in VirtIO GPUs to the thread)

> Hi,
>
> I'm working on Virtio GPU drivers for AmigaOS, and would like to know
> what features are currently stable enough to use. Looking at the
> master QEMU branch, both Virgl and blob resources are supported, but
> NOT at the same time. Is the ability to use both simultaneously coming
> soon?
>
> Also, what's the state of Venus/Vulkan support? Surveying various
> forks/branches, it looks very experimental and subject to change.
>
> I have the added difficulty that the AmigaOS Picasso96 driver API
> expects direct CPU access to all of VRAM, and likes to peek/poke
> directly into the bitmaps. That's clearly not possible without blob
> resources, or shared memory (not entirely sure what the shared memory
> feature is for). This is why I want to know what features are stable
> or coming soon.
>
> regards,
> Hans
>
> [2. application/pgp-keys; publickey - hans@keasigmadelta.com - 4293c311.a=
sc]...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

