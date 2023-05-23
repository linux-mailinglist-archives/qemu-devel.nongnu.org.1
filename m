Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E970D695
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:04:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MzQ-0005tS-EG; Tue, 23 May 2023 04:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1Mz8-0005pV-Py
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1Mz7-0001VJ-8s
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684828988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpSHZ/Udm8Mm0hEPNkv9UG8xxF7MSI6mCaU5MlWOD/8=;
 b=OqbNe32qkFHBzUlIEVetGB1DTSUWE4hlTRHEtZIIV4BjeDCxztJX/TvcPv7PCAMxhgNgee
 AYCeZWZaDrUQVgV3eHNuTePvqgsJuE4BIfzUoDbmMxWDpoJXf04eMs9+/9QOGX27EdTfIx
 Zizmbt/XFn9y40URVWjGOnn1gFoBAXE=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-tLETkb7cNYauqVzzj8PmvA-1; Tue, 23 May 2023 04:03:04 -0400
X-MC-Unique: tLETkb7cNYauqVzzj8PmvA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-77ab850888bso2384408241.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 01:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684828983; x=1687420983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpSHZ/Udm8Mm0hEPNkv9UG8xxF7MSI6mCaU5MlWOD/8=;
 b=CJ/WaSPxMr2njhN43nachZHKBn8sHIc93+e7Y4lERr9vcf/XBASY5BJYqknrNDA72R
 67ng4DvSjell/cXPEEwYKAeVBsi6y4B5jWs6ocva7kyYIPZ73tQOpLwnBMnP3VzR+zur
 zQEwH5zJjAfJYjW7vrb1gaDYoiJHVQK+dbGlTlblX/t+QOq6Yq8Nsj3D2w+6wXiQFT+p
 fAzcLzSQkfxTXjgxINv46v1nHpEDJ18ugv4uQgCPtYSIzIO9lxVgFyH02W6urC+1xS1E
 7YsQzTtkkHY/T62H7NDm9SyvL0yreP/1evmtVFsXumV6N7KelA/bwxZtBbSHH5Or4Tiy
 W84g==
X-Gm-Message-State: AC+VfDzHhv3IGIakJQSl/ZFtSocH/egjZYcq/F6St9zyZMnmFKm4PWPf
 njGqBqR8yAxuHutdpJ/iwc1/TAUABARRisOUa816DDhG6JeP7KR9Sy9JTVp8MDwpsk+5/KyTs+z
 Mig0PJFP0w0to9oiYnKUdP7G5YyHF0zQ=
X-Received: by 2002:a67:db90:0:b0:42f:cfdc:4803 with SMTP id
 f16-20020a67db90000000b0042fcfdc4803mr3025529vsk.33.1684828983472; 
 Tue, 23 May 2023 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5edv883Pad2+6Eak9a51rqdCtR9tBEOUbmF8hpSTqyqVqXG9tSUQOFhtfMbU40t7i3wWW5CJ8gQ9iHZCq2fiM=
X-Received: by 2002:a67:db90:0:b0:42f:cfdc:4803 with SMTP id
 f16-20020a67db90000000b0042fcfdc4803mr3025526vsk.33.1684828983220; Tue, 23
 May 2023 01:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230522080816.66320-1-pbonzini@redhat.com>
 <ZGxysnpYm8FtL0VM@redhat.com>
In-Reply-To: <ZGxysnpYm8FtL0VM@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 May 2023 10:02:51 +0200
Message-ID: <CABgObfa+EG62MV-9xG7dtxiXj5ocosXS8kNneAoM_kTbmo0CbA@mail.gmail.com>
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

On Tue, May 23, 2023 at 10:00=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> I'm curious why we need to do anything ?  I would have thought that meson
> should handle 'b_pie' itself, passing the right args to $CC that it feels
> are appropriate. I don't recall seeing other apps using meson trying to
> handle b_pie logic - what's special about QEMU ? IOW, is it possible to
> delete this entire b_pie condition and thus avoid worrying about this
> problem ?

The issue is that Meson only has "enable PIE" or "leave PIE to the
compiler default", while QEMU also has "disable PIE"---which is the
messy one.

Paolo


