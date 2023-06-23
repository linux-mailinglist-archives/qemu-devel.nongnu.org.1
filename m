Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8F73B733
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:28:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfrL-0007j5-H0; Fri, 23 Jun 2023 08:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfqy-0007OV-RA
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:25:36 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfqw-0005fC-5h
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:25:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-988a5383fd4so118972766b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523121; x=1690115121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmKf3A/k3LsA2vd9VJMx1nMvPcRqxo1Q+dCvMYHx+I4=;
 b=AeEoZ2wZ3hKpz2O3yzX81Iu0uGFGTzUfQTegkzujqF5xT7flBgAfmOG99mM1iDQZ3J
 Zfy5q33aXQw4f/L67dc3YbtVXoOYAJk+0Tc90v86ZypNsyxD7l/s4DjI99FOHh/AV956
 8ds4uedF3N4EwoK4hTKz6myJvBnOmrzi2Vqtujl660AFdLoSw2fOo0P2pY1d1LaF/zo2
 kMQAdWJ5uQwv5Ll8YqlsNZtNQfBttRVySI9QfdCwjO834676408piCS2oJpxrD6CKwNm
 jA4zaeKEoAOPEYjKkK5zOU7o7YUQrJPn6y1wYczsipkJuCxR7J21rYzAkEFgPzeJRo8V
 gYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523121; x=1690115121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmKf3A/k3LsA2vd9VJMx1nMvPcRqxo1Q+dCvMYHx+I4=;
 b=DNjpUc4pxylXieMohxRR1502Ad4czMhwEbbFVjbwUMqKAMeUy+q95mRZOkROmSvLfO
 5X/TdYv6qjGd2t1J//5Rg/8FEKODDpF57ha4Boik1w/nbOY+Prxn+/g00DU2GcIHDAcV
 ng7uQ/Izpi0SdU2cXs8ZtSvr0jxI4mRl7HQPz1TTUDFOj4ki4ixYUXEZP9N1tvXv5XVq
 b94wTuzR+hkx/S/s5ROybWLYESNS8A62WC6HEvP5TWb0aG/0F0rtYAn6HBYPreyqwOZS
 Ofjj8aNxnBgQlK0N7/FncRRomRNHMuGlSEopYDNZ8nzI+TrRMQMlgqqjVF0Wgwv2G2qr
 PU+w==
X-Gm-Message-State: AC+VfDxqGus4JSqJDqH1bADqEeOt8/uJYfA0ugTVD3dsT6Kk6xoeZApJ
 OZHRZj+0Qw5NOgYdEhc7nFADlCjRdg5mTZaiRyBr0Q==
X-Google-Smtp-Source: ACHHUZ75Wm01NYVv4EgW3VkoJ9IhWU92gXiSLyIH6Zst3yw9yzvidkblDHQbb4b2shVl/hURdAzitc9v2liXAOz/El4=
X-Received: by 2002:a17:907:7255:b0:98c:2b4b:7da5 with SMTP id
 ds21-20020a170907725500b0098c2b4b7da5mr6828389ejc.20.1687523121371; Fri, 23
 Jun 2023 05:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-8-alex.bennee@linaro.org>
In-Reply-To: <20230623122100.1640995-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 13:25:10 +0100
Message-ID: <CAFEAcA8QX55yeTb+DFxwzd=ntOS8nH95xtQKPNGLiQRvC1=Fcg@mail.gmail.com>
Subject: Re: [PATCH 07/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, 
 Alexander Bulekov <alxndr@bu.edu>, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 23 Jun 2023 at 13:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
> as an overly wide shift attempt.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Same comments as on the first version of this patch:
looks OK code-wise, but have you eyeballed the output?
Does the keyboard layout that triggers this have no
AltGr at all, or does it call it by a different name?

thanks
-- PMM

