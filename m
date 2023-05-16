Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112D704F18
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyuaP-0007IA-CA; Tue, 16 May 2023 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pyuaL-0007I2-OY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:19:26 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pyuaK-0005ho-2t
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:19:25 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-55a14807e4cso243296967b3.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684243162; x=1686835162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqXA+Oza3qlqCN5TRU/3BBW7QelTi9en+Brj7O5fZMs=;
 b=KjRGLl0cYN7qqRKWbjUJ5n+ruTkwr7t0HlQLXh8KZkSjRAY4H64Mye1bWqyxK/Vtra
 GR9Lz7en6HntFGoK48CzJdeJbyKsRTa/QKc3jqtBOw9A4iDPbEpx4grSO4zBJcNccACR
 zUg/uIkSgIq2mjZ7ZTe75c+Wv5gje5fCvyZYDPCM1xemFuiPn1eiBGG0v+fU8Oocjume
 +8upJe+I1/2ROX05/g9JGsDqwQX7NcmohmeJYVCWlQJ7drc70NE3J4k0sM2NFMpwfr4k
 u3IvV+buBE5pmcWPtBVLyghbtjhigA7ff/EGpKfxHPZAdqf7yn53I6glum8J9hF+eZAQ
 Wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684243162; x=1686835162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqXA+Oza3qlqCN5TRU/3BBW7QelTi9en+Brj7O5fZMs=;
 b=i+1R756W0HpPB3ZZWH+INEI5wBQC9kT/k8gsTbB4iHLeriJX/IVL5i8Q75AL1qE+PH
 L8ceBRynwvztbBs4GBHam4X+SieBNuM8okceeZ7quAExAd0Pk41X66z0iEn2ocx38HEK
 u7kMszxloVAgWQJjTI9R+T3FedQf69h3cnMuhm64qwIclKEgZnWI3ea6QQXOnLUkBn9o
 4nyWbf/MtrV+6QBgqSSexu49s9Mqpd7KJNpYA3daT8bWg4zXC+D00UhuryvP+Ko4hnaP
 NrA6L4eaPidXNkr914Gr/FgOMZXSIKh3xGk0omaghXMaWe2kzxnj7uFGqZx9Oo3ovQVg
 lIlQ==
X-Gm-Message-State: AC+VfDxATtTqU8vQKYRu11+UKA+IluqtRhRsbTdtamx7TTbmr1l0PqUM
 kS5+cPR6EuMjaTi4MD79wPIe7KHraHduxc3/M7s=
X-Google-Smtp-Source: ACHHUZ5Kn6PwpXzkOfnQiWiMwnkRJXpPm7Z+acZi/s1h8892reOFneK1UXd7FmF6etfoWfGnBib8mioJi7Syz4zHUtg=
X-Received: by 2002:a81:8205:0:b0:55a:af7d:8e27 with SMTP id
 s5-20020a818205000000b0055aaf7d8e27mr35323795ywf.25.1684243162492; Tue, 16
 May 2023 06:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <a3fda4a6-412f-8230-3455-f8d2c34637a2@redhat.com>
In-Reply-To: <a3fda4a6-412f-8230-3455-f8d2c34637a2@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 May 2023 09:19:10 -0400
Message-ID: <CAJSP0QU5TcbpvHPF5yH2pAn=rPmKzZPZaeR855u+F3jVYgA0mg@mail.gmail.com>
Subject: Re: Performance improvement with
 58a2e3f5c37be02dac3086b81bdda9414b931edf
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 16 May 2023 at 08:56, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> w=
rote:
>
> Hello Stefan, folks,
>
> the perf-ci detected and bisected the 58a2e3f5c37 - block: compile out as=
sert_bdrv_graph_readable() by default - as a performance improvement especi=
ally with 4K reads with multiple jobs (but minor improvements were observed=
 in other variants)
>
>     https://ldoktor.github.io/tmp/RedHat-virtlab722/v8.0.0/140-improvemen=
t.html

Thanks, that's good to know. How much improvement was there? I don't
understand how to read the report that you linked to.

Stefan

>
> Based on the commit message I guess it's expected so take this just as a =
record of improvement.
>
> Regards,
> Luk=C3=A1=C5=A1
>
> PS: The list of perf-ci issues is available here: https://docs.google.com=
/spreadsheets/d/1HEXI5wDsNgAIgXl5MIhGond898Vz5A1Hrkl0lZmWEbg/edit#gid=3D0

