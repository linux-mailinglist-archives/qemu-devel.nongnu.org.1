Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639170DBD5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:57:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Qc0-0000Be-Qw; Tue, 23 May 2023 07:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1Qbz-0000BB-0L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1Qbx-0005LS-3M
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684842926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rMaZR8SqtuOVlr8iHVn3Ks0EuuKQVnHT9L8QCSJ1i8=;
 b=MgXAeSsg6QLnnWkoZelsSjtRwxJGhCBwy2bt2iTNIjKXJKdmRHWRZ6QJz7UVU6UAiSXcrF
 JLQRHo8GFD86ADhYJirwCMZbB4vLMPOhR77Ico8reuLkfVKuGfTF1rI3WXW3xIZFmM07Yk
 lAMiGzoyU9ay2KlPpW/EAsDMWNY8qt4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-uQAOUJb_PvCqB4Wm7cdrBQ-1; Tue, 23 May 2023 07:55:25 -0400
X-MC-Unique: uQAOUJb_PvCqB4Wm7cdrBQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-773260e46e3so2350121241.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 04:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684842925; x=1687434925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rMaZR8SqtuOVlr8iHVn3Ks0EuuKQVnHT9L8QCSJ1i8=;
 b=ObZMY1XO/l2OJVoAf215f9Has4s+tBshOk0cm+dl6m/Qjdz//i6DcGTtYOa28wZD0b
 H/Twp0my32NA7UkZIgRXlgTvgegzIWXvWK0vVLiXZUQHwKMKcz1mpPnelItHCcnU+PVe
 f4jK2yLALZYgVYv8X7qyCpMgSUXR3msXfQQA33xG7ZTt3y1546ClGgHArOp8huT5GxGz
 4vLBRhZMSjgX3QIXxrsSgxq+ldXkNlgV6IglQzLsIdXCpNgppKBFAxkOz/P8HRUYVdKC
 7b+WsT3syTv392Re7jHyjqqlxVj33jRUvpjDh8mh7Pis9w3ZOtMc7yjzVoWdfWt/P/A8
 h2iA==
X-Gm-Message-State: AC+VfDwClqqqRKpEyo/nyT5lxC3Tj9DA2/8a/2CinWrXPY3wg+IEfsW0
 rDd9LUN1OpL7YmTsHlQQly9Ef/uoVgGlmflw+Vuy7UniHEYlLrsLK6ohl7t2i9RiMmYF8u5nvIw
 ZRo7HAuBSi75LuLU/LjoLacK/29C1sgg=
X-Received: by 2002:a67:ea8b:0:b0:439:4a00:67f0 with SMTP id
 f11-20020a67ea8b000000b004394a0067f0mr1569482vso.11.1684842924974; 
 Tue, 23 May 2023 04:55:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sY+hGlgqXdv0Ir0T8Xp/36Qq5XHNro5CRPiXDX95+xc+RRpaIfdK/pXQBHV8I2kXWCln00HlnLbx1LspAk4A=
X-Received: by 2002:a67:ea8b:0:b0:439:4a00:67f0 with SMTP id
 f11-20020a67ea8b000000b004394a0067f0mr1569480vso.11.1684842924733; Tue, 23
 May 2023 04:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230522080816.66320-1-pbonzini@redhat.com>
 <ZGxysnpYm8FtL0VM@redhat.com>
 <CABgObfa+EG62MV-9xG7dtxiXj5ocosXS8kNneAoM_kTbmo0CbA@mail.gmail.com>
 <ZGx22AySUhoZZuW1@redhat.com>
In-Reply-To: <ZGx22AySUhoZZuW1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 May 2023 13:55:13 +0200
Message-ID: <CABgObfbhdqfMzkOZVMGzUbdg4eL1AXc8b31LqKZ5QRTHksOsaA@mail.gmail.com>
Subject: Re: [PATCH] meson: remove -no-pie linker flag
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, vr_qemu@t-online.de, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 10:18=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > The issue is that Meson only has "enable PIE" or "leave PIE to the
> > compiler default", while QEMU also has "disable PIE"---which is the
> > messy one.
>
> Does QEMU actually need "disable PIE" ? It existed in configure of
> course, is there a reason we need to continue to support it in meson ?

We have "disable PIE" support because PIE has a performance cost,
though that's mostly for 32-bit x86 processors. Other ISAs have
instructions that help (like x86-64's RIP-relative addressing,
aarch64's adr/adrp, or RISC-V's auipc) and then position-independent
code becomes the natural one anyway.

However, I am inclined to keep it also because "--disable-pie uses the
compiler default, and who knows what your distro did" is less obvious
than "--disable-pie disables PIE".

Paolo


