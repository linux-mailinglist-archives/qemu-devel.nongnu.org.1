Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE023787481
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCWo-0004Uv-JU; Thu, 24 Aug 2023 11:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCWl-0004UB-LB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:45:44 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCWj-0006NF-8U
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:45:43 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5007616b756so7840299e87.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891939; x=1693496739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B0uYUo//zX7GRBs4+fMuPpd2fhUd8kvSIh02e5khGAs=;
 b=zhPqjnMKFojQs+86L39UzMWgYGfL5/5r0Ms05DS9JyAF20YLHSoy8kgsLCx2h1iWAv
 aS9m7MiwRSwk1WReZYVM+qSWSDhmeV/XhZ564BIEkx7B1fZTRw/M3pJlLSSgCVUunwhB
 +YSLmO47RtQd/cOFsFKz/9aEsuD1GC2rXlO2n5DehMD6qIzDKfO0XDMexdz5EQmLCeRB
 eGHf8DXpPzr7lfV6oKOwkz7r/yQZ5bSNzM+v2BU5eu8e1HGQe1ERbIQPXQxwl1a6lNXj
 IcDtuzxmvHcEm665UD+SErP88IxdwGFRE9AE9HQn6kTVbVP+0Hj4t9+02m3aM90RBQs8
 9TOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891939; x=1693496739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B0uYUo//zX7GRBs4+fMuPpd2fhUd8kvSIh02e5khGAs=;
 b=UxHljTTWB2Tnhy/RP1I9P8BAUCm3ekQvrH8P1HgGp4Mf0Qu5wlJUxsQGcHrP5TUGSk
 AFJo+FlPIyvJWNFn6mpqpJsr0Mi9djDUpLATzASeXKZZprvkYmHdswqn0yvCY03jce6L
 AHRyYSKEWVv8y7Ntd4tWQpxWy3SuwKGn7yNNVtmc+Ynw4rJVgWdqePMt8ds2fbvobLjB
 lZctGJ838Kba6ZSVP+KxDP8Hpn1DMVbWXPTYrFD+6I2gH47EKT0tn1CIsLxNxsnPk8r2
 E8MrZLw0itTkMN9C/cKRKm3oUHtGsSkSgxuwg2GgDQofZ5/DXidKo6BF30JweW6D5lZ/
 +QMQ==
X-Gm-Message-State: AOJu0YwiQ9s+xWTglMdIhiM+jKfVV3dOS9D4GxIGSPE2dENmCP51X4oT
 TfxT4+eS1poZVh7sPJan70LULaRltSkoRlccuYsyAQ==
X-Google-Smtp-Source: AGHT+IE4YoRRijbeGOl02EG5im/VQ6U1pBddS2TguSANVB0elWubKXCzV+n7WRrLOTSTLJ0nCy/VuYw9nJUVVuTsi1o=
X-Received: by 2002:a05:6512:1282:b0:4fe:6fc:1fc7 with SMTP id
 u2-20020a056512128200b004fe06fc1fc7mr15456641lfs.27.1692891938569; Thu, 24
 Aug 2023 08:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-4-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 16:45:27 +0100
Message-ID: <CAFEAcA-dDONiLWA_SwNx-zqGLf8d+-s_rqO62131wAirdH-kMg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] target/arm: Support more GM blocksizes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 11 Aug 2023 at 22:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Support all of the easy GM block sizes.
> Use direct memory operations, since the pointers are aligned.
>
> While BS=2 (16 bytes, 1 tag) is a legal setting, that requires
> an atomic store of one nibble.  This is not difficult, but there
> is also no point in supporting it until required.
>
> Note that cortex-a710 sets GM blocksize to match its cacheline
> size of 64 bytes.  I expect many implementations will also
> match the cacheline, which makes 16 bytes very unlikely.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

