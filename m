Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7182C106
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHoH-0003yq-02; Fri, 12 Jan 2024 08:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOHoB-0003rQ-0F
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:42:51 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOHo8-0004Kz-Qf
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:42:50 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cd33336b32so85446601fa.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705066967; x=1705671767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oE1ouddzc3nwH3KFektTNt490zmSSt0gUfDdS/eoORc=;
 b=bTBTnBIKM2hymu6NzrTg7fGWgitldKzk6CLorn8cDGP9bT6NddYHZJ4u+w2SPcW3+t
 +Ma11jT/+pdv7fm8w1sPZt2yJ0N8AiwqHOh3XJTRRPOgzYq4D3qxAhiedSsHVf0+3ob/
 uBEYasYCCGgRU+MQ/FgJnVd2ExlcccHDVKzkIRM/lNkOL17mA2yVaBiYnY+f78Smtr0r
 8AcCPsfSbHJGKyH4A/B2U4UoRdoPxNMnAnJ7AFQ8Y8cx4CveXO16jVKhTrOxT+BJc3SY
 iccigboGyQNtUssZuewnegtBjCWiH4dJk2Ooz/2LHFwg+maEvuKweP90RtjG7DE5UDG5
 Wyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705066967; x=1705671767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oE1ouddzc3nwH3KFektTNt490zmSSt0gUfDdS/eoORc=;
 b=JtUiKqFlycLOZkpLZ3hbAMnQYam14bhlwU/qKG5c+7CAU+OQ3zdwLe6Zs1iKqZSo5c
 +nw6g460+T0W0eiFBsepGOUR2AKnq9SoWQMKPjIiPBtXPiiCLiMeqPJnQ7+eM4E8wWFi
 PPjHDp848lEUlPe2zyXQsukAgBdgf6i3hGaQehi0psUZaoBQ4pV6foE74W7Y1wmoq1zN
 +JYl3g57DcuQsUoUQ2sA7NCGpdd2t4p6wN/dq2K4dRDGKlg7BdJHERxCTmAewUuFmVh0
 KPWkeKMLHXI+SHL8MmLkLZRi35Kz4FRW0vlNEU/wKRYR+KcNbrXqIq35vqkInPr+5sZg
 2gNA==
X-Gm-Message-State: AOJu0Yzb5VdvtYAD4iFTzXe+QRj9u2EHp6d89NfS4Kh8Sc2jSE7FWJGR
 0gkb1PjlVig7bITFnyCyNMsaexWPplMpboh8iZtBVsIOIT5thfVA94IhPns5
X-Google-Smtp-Source: AGHT+IHA/P6PhyodSjg2feqSJQgQJ6UcezHrJH4eKYz8q2Jhy/pQGfSVCnE7URhpgqms8D0mQnpTixx5cwE935tFj9w=
X-Received: by 2002:a2e:9bd0:0:b0:2cd:635e:cd57 with SMTP id
 w16-20020a2e9bd0000000b002cd635ecd57mr782817ljj.47.1705066966907; Fri, 12 Jan
 2024 05:42:46 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 13:42:35 +0000
Message-ID: <CAFEAcA-WQa5rJK3e2Z8tgcm0ZN8dDnFnF0v=hTPdJpapN4vsNQ@mail.gmail.com>
Subject: test-x86-cpuid-compat qtest produces warnings on TCG
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

When running under TCG, the 'test-x86-cpuid-compat' qtest produces
warnings. You can see these for instance in the x64-freebsd-13-build
CI job; here's an example:
 https://gitlab.com/qemu-project/qemu/-/jobs/5918818568

24/837 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-x86-cpuid-compat
          OK               7.32s   45 subtests passed
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
qemu-system-x86_64: warning: TCG doesn't support requested feature:
CPUID.07H:EBX.intel-pt [bit 25]
qemu-system-x86_64: warning: TCG doesn't support requested feature:
CPUID.07H:EBX.intel-pt [bit 25]
qemu-system-x86_64: warning: TCG doesn't support requested feature:
CPUID.07H:EBX.intel-pt [bit 25]
qemu-system-x86_64: warning: TCG doesn't support requested feature:
CPUID.07H:EBX.intel-pt [bit 25]


Can somebody look at these and work out whether:
 (a) this is a real problem we need to fix
 (b) this is a problem in the test case and it shouldn't be trying to
     test a feature we don't implement
 (c) we should suppress this warning
?

(filed as https://gitlab.com/qemu-project/qemu/-/issues/2096 )

thanks
-- PMM

