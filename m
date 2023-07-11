Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8174F841
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 21:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJIhn-0004tm-K7; Tue, 11 Jul 2023 15:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qJIha-0004tN-G8; Tue, 11 Jul 2023 15:07:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qJIhY-0004qr-98; Tue, 11 Jul 2023 15:07:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso63325115e9.2; 
 Tue, 11 Jul 2023 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689102425; x=1691694425;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGJhlKXKWzfcK4ldjlHZQNpIIHqBbbxxZqJpsbQUwQA=;
 b=gz9WDjmfLSP75xY/QBfP+Bpe7HtakcliDDprWZElOkb8mITcjjMn0vYD1w09XCpN5q
 MYghUttRaV//DMrCRKkkrGS2zQftzAc9W2Q1ZiS+dzVDmiCK6trFauTScn+8+sBRA2np
 8HdwEAuFsqCn9ioBUgLw3lr3+CWRUg2kYzZ7tz51rWnS1iHeLcukOv7/Fz/hInzgtsv5
 qDH5/mCAby4dKoY5ZVfUhKQREd7yr+cPLT8x4HnUQfEvdybmK/CJimvo12DzDHSRKGF2
 Axymzm0wHZ+ID2MONTaAc0A3o5zJjf+Jh02eyOu64O7Pnzm10Wx8VAsGkeR+4M5Kx21o
 ot8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689102425; x=1691694425;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGJhlKXKWzfcK4ldjlHZQNpIIHqBbbxxZqJpsbQUwQA=;
 b=GYt9yGyK66PnobPrGG7KRCkmqovcbUCm5Cu/XYrEa4fdDBoGi3Q3OBUaRjnGBwloih
 wBajQHogpz4Ja3PeVomYsihT3bFO3/qyxRTAWOu6jYQWLMBruZ4bQPQERVEpHpMwtAq6
 6N9+WAQUaQ0NHv/wxGnu2oXkKGlvVoYOKdLxDXwpYywv/zIbdXR3F2aQiDkCP2LrXDau
 nWYEZPJfN2FXqF/qRFYDPW4c6o8DHkdFq8BzEK8gobQa60V12knadbtC3Fr82FxRsbW8
 up1TI8rPkLfpq8XXI1QzBSEeF8AVDJJSWC1VpqM8Ku3YYObNokhpxy1iCIQATQh2KFQF
 xxNw==
X-Gm-Message-State: ABy/qLar4I7I5mjqm/d97FmbJG5KyRWj0MCLHcCvheHHaEop5ZQWnklh
 efK1a9E6twQPVgvdbVqEvuc=
X-Google-Smtp-Source: APBJJlG/70yrD3GF8tFgwmMjhSZ2DzlZDkX9/Nyv/qNtlCAOzPx67kZjEXd7ZOsT+VRVufcW7Qr/lw==
X-Received: by 2002:a7b:ca51:0:b0:3fb:a2b6:8dfd with SMTP id
 m17-20020a7bca51000000b003fba2b68dfdmr14025513wml.32.1689102424728; 
 Tue, 11 Jul 2023 12:07:04 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-077-090.77.11.pool.telefonica.de.
 [77.11.77.90]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b003f9b3829269sm25011248wmo.2.2023.07.11.12.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 12:07:04 -0700 (PDT)
Date: Tue, 11 Jul 2023 19:06:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
CC: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
In-Reply-To: <20230711110547.20cc57f9.olaf@aepfle.de>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
 <20230705120121.4f353ba6.olaf@aepfle.de>
 <3FF0EBC1-F1F8-4D1D-91DC-904DB287C887@gmail.com>
 <20230711110547.20cc57f9.olaf@aepfle.de>
Message-ID: <1BC19F3D-BF17-4419-B3CB-C16DA7C47C8F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Juli 2023 09:11:33 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Wed, 05 Jul 2023 21:52:05 +0000 Bernhard Beschow <shentey@gmail=2Ecom>:
>
>> I wonder if we should fix this line rather than dropping it=2E
>
>I think this needs to be fixed, just to fix the initial commit which
>added this bug=2E This will allow backporting this oneliner=2E
>
>Further changes to pci_xen_ide_unplug will be done in a separate patch=2E

Sounds good to me=2E You've got my R-b for this patch with small changes i=
n the commit message=2E

Best regards,
Bernhard

>
>
>Olaf

