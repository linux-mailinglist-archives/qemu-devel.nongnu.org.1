Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8697DCC75
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 13:03:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxnRj-0000Nz-Mm; Tue, 31 Oct 2023 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxnRg-0000N7-AJ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:02:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxnRe-0001DB-GY
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:02:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-409299277bbso35596495e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698753725; x=1699358525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lNUoIdPBJxuDoALCe2GHz10b5kQPCQgDLFtrF/CEZes=;
 b=dPX71m1NaIHNR2+4WSMFW0Tv9S9Bucj5iorbvchq71u05wfTOPIB30jNxRtPWfsk5V
 B1zlOVw7J6gkMB3sRG22vd3bK8nZiGd2cKJB8jLP8h8Eaa7QZfpuSlQAZm/zYQ7A/zTL
 9F3OWUMjSEKACBg0vLqjL51zmXhUw4v+zpTFRHi8bJeBSCTyiB8J2CAPaw9fu/Zn8g93
 JiukaGRIAXFcbcyafS+U63RkwNyo+FmcPtwrECNYTZovsuFJ04GY6OJCI17M4XzL4OlR
 mklcGo9HkmCpZo9rSyeRD+yrI4A8ye3ORVCAr/SKkHsjP4eK6SKaP/vN29HG6jLZYa/h
 pzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698753725; x=1699358525;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNUoIdPBJxuDoALCe2GHz10b5kQPCQgDLFtrF/CEZes=;
 b=MI1Y75Qk0RFpi5ghW7Z1hACpPn2y4dFGQ/tq5Y9Ls3yYhBezBPfRpY3xCgr8OGGF+k
 dId8oe3YdTuSBzTF+Oo48q88d1bxWRanBbV/3erzVyXASIC7cc7CtHjf9hTDTW9ogWag
 VSS7PplrUFja3eXnwJrPt2MppGF201N76lL38AKoYcJ+x8KNyg6qG1j8v7S55/DM9M86
 ofSmWuFWYFNxoynDfW/DasrBe9p7H8s+zvgQQMlEz9j+08sNBZw3uMkG0Mirq8cmDm86
 A4qOa2h4UqYH3uXtO7J4zA2ESohbQlPBaJEiKHX51HYCLE1QM24vKocM1F1lPXdsNKAF
 9gnQ==
X-Gm-Message-State: AOJu0YzHBFdnc6M39+RFcruu0tksUat1XrwsuCZTDaqaB5oiDENBb+FQ
 +PcNuHPEtAARO3VS3akdZr/CLQ==
X-Google-Smtp-Source: AGHT+IFZqjymnAFwIVoDafoiuOTRIaYOwmeMPWJ3Z7GiTDaV0Jtsi7hP5xEc0onrhOCMoGa1jvX5Ag==
X-Received: by 2002:a05:600c:539b:b0:408:3cdf:32c with SMTP id
 hg27-20020a05600c539b00b004083cdf032cmr10622738wmb.41.1698753724002; 
 Tue, 31 Oct 2023 05:02:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x4-20020a1c7c04000000b003fe61c33df5sm1567917wmc.3.2023.10.31.05.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 05:02:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 44A4D5F78A;
 Tue, 31 Oct 2023 12:02:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Jason Wang
 <jasowang@redhat.com>, Kunkun Jiang <jiangkunkun@huawei.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Simon Veith <sveith@amazon.de>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, QEMU
 Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Joe Komlodi <joe.komlodi@xilinx.com>, Prem Mallappa
 <prem.mallappa@broadcom.com>, Leonardo Garcia
 <leonardo.garcia@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: Any plans to implement more ARM SMMUv3 features?
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Tue, 31 Oct 2023 12:02:03 +0000
Message-ID: <87il6n0zlw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Hi All,

Since 8.1 we enabled the FEAT_RME CPU feature to allow for Arm CCA
guests to be run under QEMU's Arm emulation. While this is enough for
pure software guests eventually we would want to support modelling
systems with "real" hardware. One part of that is updating the SMMU
emulation to make it RME aware.

The recently published F.a spec is available on the Arm site:

  https://developer.arm.com/documentation/ihi0070/latest/

As we have a keen interest on tracking (and implementing!) Arm features
we have coded up the various sub-features as stories under an EPIC for
each level of SMMU feature on our public JIRA:

  https://linaro.atlassian.net/browse/QEMU-533 (SMMUv3.0)
  https://linaro.atlassian.net/browse/QEMU-553 (SMMUv3.1)
  https://linaro.atlassian.net/browse/QEMU-558 (SMMUv3.2)
  https://linaro.atlassian.net/browse/QEMU-566 (SMMUv3.3)
=20=20
I think the state of the cards currently represents what has been
implemented and what is left to do. As you can see it adds up to a fair
bit of stuff. As a lot of people have been hacking on the SMMU code over
the last few years I thought it would be useful to reach out and see who
else is interested in further enhancing the SMMU emulation support?

If anyone has any patches/branches cooking or is intending to implement
any particular bits please do let me know and I can update the cards to
reflect the current state of work. As ever we will do our best to help
review and smooth the up-streaming process for all Arm related feature
enhancements.

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

