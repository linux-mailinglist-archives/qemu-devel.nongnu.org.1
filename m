Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D981555A
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 01:28:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEIWD-0001FJ-OR; Fri, 15 Dec 2023 19:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rEIWA-0001Ex-Qd
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 19:26:58 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rEIW8-0001jq-AR
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 19:26:58 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1d2f89ddabso145463266b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1702686404; x=1703291204; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUA2EJK0T9pVTwAtuaPxDZsT8NWySfTNVXtj62Z5wS8=;
 b=F/en+iewOLEGLElJGat8avJ4xRb4A35Pt5di2O8bDo6lek/E0cDisk+1ygppX7dNy5
 zdH+zJgPHJ9/jDJ1UQTbPpelcq2PSwzmrfh0AaeJZ7Do/C3LSM9H62Tc4LmG8brtz40n
 pBKtnumZMVYz9B8rXb33dq6PIq9iR6FJLyIcWM7Q5WQJiu18K04p9aqnnF82ZHVULDcD
 0gv+XdeJuicxKMOQUuX4kf176ThDYhXBfmlC2Q42RJ2ilpo52QFrukiqGoPR7os85kiP
 cw5TyRJDsKcMsObhNr+vEtpSDIl0hhDzf3DPnU3SXHyoseNbjMJAN+yZTyxPG7YneN70
 E+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702686404; x=1703291204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUA2EJK0T9pVTwAtuaPxDZsT8NWySfTNVXtj62Z5wS8=;
 b=RP5iXkiYcOtb5w/qjFEeH5oKMkKOi+cHAI5L3PZ+D+EvDfurthkaMFQ3cdLvwyaHV7
 9JDxHT+iczEXefsl/axBToKUaS1QWkL68SNZ0RKqVMFrwNlXbasQeaFFPLmGcmmZ/mfm
 r7GNXnAdk7OnPy7Ijtl+/+3nN5hDG2hIFaLBAk6z5q5/OEX9aM7Twg0R3AeXyci+BA6+
 Bxd3LjRMKrSRvWENQxxyfKI/97g0JBPSEl6qnXkaLnTGyXQKTGMbr1C1xkTdGvO9G7qy
 AXfvrPQIhY1bTXR4OkTlmbq/1pO7nH8wSVp4l9C1ZkYdD0amq++EbO00DuAH/l7SSz3s
 cILg==
X-Gm-Message-State: AOJu0YzVAQRrufn8GyB7z5potcquh9BMDxBRzYIiStjYatvdTO6uPKTX
 vHvp+XzD9LoKuAEEidTuO0+kK8Z8w5WVu4PYpzMFsg==
X-Google-Smtp-Source: AGHT+IF1qicXym9B8RGpeyIOvjx3SrQ7GqgDYcoviC4tTfrk7zgwVqCxJDOEKNMTTm50XXy9Zs3KozwiaZ2QD+PoNM4=
X-Received: by 2002:a17:906:80d9:b0:a04:d5ca:587 with SMTP id
 a25-20020a17090680d900b00a04d5ca0587mr6571738ejx.76.1702686404291; Fri, 15
 Dec 2023 16:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-6-hao.xiang@bytedance.com> <8734w8n3v4.fsf@suse.de>
In-Reply-To: <8734w8n3v4.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 15 Dec 2023 16:26:33 -0800
Message-ID: <CAAYibXgmaXu8sZGkw2bbWngvUXXK7GHqbZOMYC4ig=s9A93vsQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 05/20] meson: Introduce new instruction
 set enqcmd to the build system.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x631.google.com
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

On Mon, Dec 11, 2023 at 7:41=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > Enable instruction set enqcmd in build.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  meson.build                   | 2 ++
> >  meson_options.txt             | 2 ++
> >  scripts/meson-buildoptions.sh | 3 +++
> >  3 files changed, 7 insertions(+)
> >
> > diff --git a/meson.build b/meson.build
> > index ec01f8b138..1292ab78a3 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2708,6 +2708,8 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_o=
ption('avx512bw') \
> >      int main(int argc, char *argv[]) { return bar(argv[0]); }
> >    '''), error_message: 'AVX512BW not available').allowed())
> >
> > +config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd'))
>
> We need some sort of detection at configure time whether the feature is
> available. There are different compilers and compiler versions,
> different Intel CPU versions, different CPU vendors, different
> architectures, etc. Not all combinations will support DSA. Check avx512
> above.
>

Will fix it in the next version.

