Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD0173570C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBECk-0000K1-5b; Mon, 19 Jun 2023 08:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBECf-0000Iu-9T
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:41:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBECd-0002Tj-Ix
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:41:52 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51a2c8e5a2cso4903568a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687178510; x=1689770510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfKugS4KjnqpQKa/nYjplISxJ/N19TWhtnUZRtVhYPA=;
 b=Hbs92V9MXGERT+VZd3it4R/pKTfWpabtQQXL8GV+hT0wVKiBQnFmalEChmftZk9Mom
 b4QocXrPWK0LOLPIMH00LjhnpT3shKBAORM411wU98lUyMmzO6CpdLpmKuxQLeNhku+U
 CcaRP930QgXtfOcDV5YoqZRPqdA8sJoQqDuIBcFV33nGY/4qVzlqeKvzVzcsNy/ad1iO
 6yap8vVRGdO6MUI8oqHMF1yjsZ9uRDxkjbq+3b0boPQp5hUPuXoYK+JKs0Lc1DeL4MTj
 yi6dM1MmcTIZ5hFloydVA3sx20R7Bw4LWJG1katz50YpvXblj4EbKNQF1MLHXJmHWJ6E
 W+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687178510; x=1689770510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfKugS4KjnqpQKa/nYjplISxJ/N19TWhtnUZRtVhYPA=;
 b=ZJi9RcbiAGnzGeeBB6FVHfgUESGawT6vpikpLwSjUZxIe+FIhpyqroL4/IZu/Eeaov
 G9GvZVDDdqOJaJJ2CqIw9PuFueSVizvthw77aubqq7LINXti4iWgs+2t+zgctc7h3YXA
 ANf/7MRIgPHfPZQIJ1ijTFaP5bz+nkfgsts0JmQGorhj9bCc/yrWOY6qb2h2S6I5MZN/
 TRlCq4OHrHes5qgLvRrVAdCUZ8H1gxil6x0ll896OazRFjeIvKufHnJAdhTHieq4gm9h
 UhaJ95xBtf+EwxmmCy0OHGHitbd+ZPJwFQgcVDq+RNhD8NpkwgcJAfb5d+auFK+MFtVY
 648Q==
X-Gm-Message-State: AC+VfDy/NeGGhAemRyEm3ZrxOaQNe9k/m+d2Pk1m7OemngQFjw0a7RLC
 LOgU4ryd4L2uOgvv8jt+G5bkLhZzzcqvj034f458UA==
X-Google-Smtp-Source: ACHHUZ6XvqYgi7l3vXWhZxZXQ1gsUqGoldnoGb1GzAI0WbcTLLOjgDAlmHyWFNbxavJda0A40YaF4Ewe8LaySCWNDGQ=
X-Received: by 2002:aa7:c48b:0:b0:51a:4975:f515 with SMTP id
 m11-20020aa7c48b000000b0051a4975f515mr4473415edq.38.1687178509894; Mon, 19
 Jun 2023 05:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230531171834.236569-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230531171834.236569-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 13:41:38 +0100
Message-ID: <CAFEAcA9dA_Siv5aKbF8Fj6nqm5KsuzU=qjEgiFC2KR6AhyaoDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: sbsa: document board to firmware interface
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 31 May 2023 at 18:18, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> We plan to add more hardware information into DeviceTree to limit amount
> of hardcoded values in firmware.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

I'm going to apply this to target-arm.next with this squashed in
to fix a few grammar/format nits and add some text from the comment
in the source file about the platform version part.

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index c5b3342b52f..f571fe645e7 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -28,19 +28,29 @@ The ``sbsa-ref`` board supports:

 Board to firmware interface
 """""""""""""""""""""""""""
-``sbsa-ref`` is a static system that reports a very minimal DeviceTree to the
+
+``sbsa-ref`` is a static system that reports a very minimal devicetree to the
 firmware for non-discoverable information about system components. This
 includes both internal hardware and parts affected by the qemu command line
-(i.e. cpus and memory). As a result it must have a firmware specifically built
+(i.e. CPUs and memory). As a result it must have a firmware specifically built
 to expect a certain hardware layout (as you would in a real machine).

 DeviceTree information
-'''''''''''''''''''''''
+''''''''''''''''''''''

-Provided DeviceTree is not intended to be a complete compliant DT. Only
-minimal subset is provided:
+The devicetree provided by the board model to the firmware is not intended
+to be a complete compliant DT. It currently reports:

-   - cpus
+   - CPUs
    - memory
    - platform version
    - GIC addresses
+
+The platform version is only for informing platform firmware about
+what kind of ``sbsa-ref`` board it is running on. It is neither
+a QEMU versioned machine type nor a reflection of the level of the
+SBSA/SystemReady SR support provided.
+
+The ``machine-version-major`` value is updated when changes breaking
+fw compatibility are introduced. The ``machine-version-minor`` value
+is updated when features are added that don't break fw compatibility.

thanks
-- PMM

