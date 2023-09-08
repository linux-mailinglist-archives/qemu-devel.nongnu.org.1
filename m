Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB00798661
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZX5-0001R6-Em; Fri, 08 Sep 2023 07:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeZWs-0001QV-En
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:20:02 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeZWo-0001dP-PG
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:20:02 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57656330b80so1111371eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694171997; x=1694776797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4cEozjMfqScGKPhD3dPZWOL3P2Yjs3hvZ0Dl36CQ+w=;
 b=kR/QX6WwDGsxbxzG2BeYWdaaGPsP38gOp+qwTLKhFCsKkwH+2+lh9r3KmLfaICyOlo
 CyamcSxsmaPohqv1JO2T7HPHT7ZwM61loM5haQhZQEiQjW1pXzuO2FTY0fTzJlfxvfQL
 XU7Pue/jTEuar5Cgf1F9d4jywU9R19vkdqUpeJ0mgaOtfRuI30+6+GbaiRqBvJxD3V0l
 mLllHzhArtiL+l5azB4YIUkdpefSY4LzguDC07fpUP6VlHF7fqB8JGUOTfS9GBcdu8ZC
 clBaOEGpvDdAUlsaPhbA6fNsLO0ywcH0vyfTwQnKTCJv/0Qgm0u3Cw6yOpSHapWODncZ
 b3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694171997; x=1694776797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4cEozjMfqScGKPhD3dPZWOL3P2Yjs3hvZ0Dl36CQ+w=;
 b=WwTkCJhphXvBTpwRT/Odrfz7n+PnDmkdC5Z+GKZG6OoXKeY4TwLQoefETFFVAl2PIy
 Mt8Iaqh+nvMYBOU4i5ZH4mFUhlzkIyJDWSxkYvm1CEkhQpAmRMd1KoKZyDb9H3REtKV2
 hkhcDX2Hb2HW+I5ogRYXNcDHqge6SHP53cndg3kHeawp4xPVk+03umQiQLG3RPIYwO/J
 05VDy6p1ll52BEFq0ddsb/i55IyMDNz+Y8vu7lgEeC7SPS+Jgvkwtv6sBYHfLAjgG5Xg
 EuaKZpr1AmDE8biuwXdqZKAbsaPiA/3fExASqn+5Q969ELx7v4y45lnxJc86tEeNm9Tc
 P65w==
X-Gm-Message-State: AOJu0YzrNIZBPbgor/BMMKBNpShqtDsmaq5bMhnFp4MHnRhvMK59wqDd
 AMVXdjD5nOzL/RP1JJhOqi34t//OoY2RnLLoWBE=
X-Google-Smtp-Source: AGHT+IGWPKRoH+FAVyWvL6FTUMoaWcpHgItavoVUu9zQcVDKud8V03dhSpIjAjrpBT8R1AvxeRh4Bv4TiRaFdmjRWKM=
X-Received: by 2002:a4a:3116:0:b0:573:f620:ec80 with SMTP id
 k22-20020a4a3116000000b00573f620ec80mr1972338ooa.2.1694171997118; Fri, 08 Sep
 2023 04:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230908064507.14596-1-jasowang@redhat.com>
In-Reply-To: <20230908064507.14596-1-jasowang@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2023 07:19:45 -0400
Message-ID: <CAJSP0QVf3CFf1zuBnQev-G54SiGZ53MWBj19SyH__19bo=vfWg@mail.gmail.com>
Subject: Re: [PULL 00/17] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Maximets <i.maximets@ovn.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Ilya and Jason,
There is a CI failure related to a missing Debian libxdp-dev package:
https://gitlab.com/qemu-project/qemu/-/jobs/5046139967

I think the issue is that the debian-amd64 container image that QEMU
uses for testing is based on Debian 11 ("bullseye" aka "oldstable")
and libxdp is not available on that release:
https://packages.debian.org/search?keywords=3Dlibxdp&searchon=3Dnames&suite=
=3Doldstable&section=3Dall

If we need to support Debian 11 CI then either XDP could be disabled
for that distro or libxdp could be compiled from source.

I have CCed Daniel Berrang=C3=A9, because I think he knows how lcitool and
QEMU's minimum distro requirements work. Maybe he can suggest a way
forward.

Thanks,
Stefan

