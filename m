Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6181D825A5D
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 19:43:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLp8Q-0003Xq-E4; Fri, 05 Jan 2024 13:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLp8N-0003V4-QM
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:41:31 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLp8L-0006RT-UC
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:41:31 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5573a920ca3so1116458a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 10:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704480087; x=1705084887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A2qdGAXqBAyo3dhmj1sOx9fo3snJwo+Y2oTFJPOGDbc=;
 b=Sw5BVVeDAyav4iSvOz69E17igwp0r/wGOcFSF8vpVnp/4pha4I/zKz+xToitDJN3Bt
 V8ItnIswaGamc9/1Wqo8i2pNQnZVSoacVr3tZCLM9sACu+xZxz1S7ntC92Zm0fDkMcmo
 C+M9+X0mgHLbsDrCMW/tFsU3sBiZzYehY5HoDCYaoL9ez4TkQcJlTOQpeAU1OxSFNS83
 bbLcTuzikleqiTdqS85PN12AFgXOopnlX3o9wjQO/vWgcPdIkm99KGwfZNgxxaMeUJPt
 q3nm/R7xPzvMmHZizYG3cMiaPF6yaFVnL7+5QH8uPsxpkojio/6DlYlCzjOo7ZNah/l/
 OnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704480087; x=1705084887;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2qdGAXqBAyo3dhmj1sOx9fo3snJwo+Y2oTFJPOGDbc=;
 b=QlgvyZL8E/PARGcCNBVkG+SdlJCHzFmwr7jY5GvC8mCMkwRxpauFAb6H3YiXMavVvy
 jIBteoCfJ2Y0VVZZsdkVnDUG5E1FaxkOK2syKmIVEKcMq0NLt9yEGNjmYiidnbwToiw7
 fbov+E296lxbGRIOFznucFSvg5RQvVtdT6FnpoXh88KVUIbeN72boneOt5TKo5ZMji5f
 v8LleZQUHIhU628//cE84J4L3ehlylB03LeSQUfNBfQyeNtxz57UXMSFTt3uzBaNuf3e
 MrhDYTdRijvwuVL31vrI/wVnQTJqDW1y8U+E0nRpGHepzuTa24E2N00doREAHdsprdZG
 N/ZA==
X-Gm-Message-State: AOJu0YykFYM1hCbglwo7AnbBvMHQCCmLsuYxSgNiMRlJWQTP0jXhpi/p
 Lrlv9cS7Y+HDR256YZdmuEjS8Bg1QpfSVkK1vu9N+gesLtQkNaVA45OEKXft
X-Google-Smtp-Source: AGHT+IHmH3N4z6xtytJd4ImVyxbsE67ZFCwjhRqAm8DiZ7lIe03kMB76v81kSdRRvG5UKar8UWvuTrebAoxZx5cyzfs=
X-Received: by 2002:a50:8e5d:0:b0:556:d3d7:b7b with SMTP id
 29-20020a508e5d000000b00556d3d70b7bmr2259567edx.20.1704480087047; Fri, 05 Jan
 2024 10:41:27 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 18:41:16 +0000
Message-ID: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
Subject: acpiBitsTest.test_acpi_smbios_bits test intermittently times out
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

The avocado test acpiBitsTest.test_acpi_smbios_bits seems to be
flaky in CI -- sometimes it appears to time out.

https://gitlab.com/qemu-project/qemu/-/issues/2077
has the details (including links to jobs etc). As far as I can
see, the test is still running when after about a minute it
gets timed out. (Though the python tracebacks in the logs are
not easy for me to interpret, so I might be wrong). This I find
a bit confusing, because tests/avocado/acpi-bits.py sets
"timeout = 200". So maybe that isn't taking effect properly?

Does anybody have time to investigate this? If not, we can disable
the test as flaky until somebody does have the time.

thanks
-- PMM

