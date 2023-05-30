Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D227C7162B0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zmO-0003nQ-5e; Tue, 30 May 2023 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zmA-0003kj-1w
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:52:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zm8-0001Xn-Jb
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:52:37 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51491b87565so5816251a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685454753; x=1688046753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=00hkDcTKeUxAOYBEp8EsIKjLJEzdU0MdBB7bslm+fVI=;
 b=daiWbq9e+0jFjM0yc2r/vHSb+K+DlJZm77V+NVB8ou8R8a8ygCdGmlyHbUHV6+y+Z6
 BVYn1rEHe0/Q1EFIZbj+5z4A/ZTgm4QLmPhvWatHhkdh3tT8H5bj51+0TY4vDKptbyrq
 M1kpm0qYUjfW9Xxf1p8MOEilTZeI3zrXSbsdvGpLSn7DHKOtWcUfzAJfKfCv2Ax4bPfn
 h/dPJvrNj6oCDdTL/rqNPSQ2wbZax4KQXIwa6CxTZns/cmid/NSdVgFwiF63kp0ZuDOg
 rt/AAjJxWKud1G+EMbOXHjYMgBOtN/sNaIM6YQ+SBUwvbSD5LBp+3UvQSlBFbQcHftMy
 j8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454753; x=1688046753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=00hkDcTKeUxAOYBEp8EsIKjLJEzdU0MdBB7bslm+fVI=;
 b=KBVEvpVBK+h9fU6cIH5tPUnSI5XQybzoVFPq2h4CBUFOC2WgfNHx+VwaU2tDX6k7lO
 3ewC0vjXmZfON1e9z0CL/JbXyB8dI3SQBGedH1ALtlwn1Ny7iFhNe4PMTs9JwqP9F21i
 3Kei2O1/0SUNRSUr1TspQJX5/8zW+SsxloL/X3BtsRNSL3LWdaFG2gF1UOkCWsDrcPoO
 HRf8xgrLI73T3F1lPgT6nsyiN48ueYNUZ1BTPlpRA5YJIZnAEM8Rc0INEVOSDxDrLiBX
 Sq7cFjyfhs09VyZ1nBXG0rJUbckzcMAE3ipdmcxaw+m3rbGxOj5pdB9rTsgH9ovu0Xl/
 MnIg==
X-Gm-Message-State: AC+VfDz8FdiQ7FpgX77zk4lGpEB80p3c+OwcmufOIh5ctSeoSFE5MRLk
 Po826L/XYf/3yNPzG7X/bM5LCTiIhOzZ3JrozsdvGL0v5hcF/qsy
X-Google-Smtp-Source: ACHHUZ7tqDyC+FY8BDsJDQBX0ij9ttj0kr7fKJcsOXqQ/RzwQjuXTGyIYBDzpWIZgzRvyVe5vF++skXE+vUg2qoN1Jg=
X-Received: by 2002:a05:6402:5178:b0:50b:d5e5:519d with SMTP id
 d24-20020a056402517800b0050bd5e5519dmr1687949ede.4.1685454753596; Tue, 30 May
 2023 06:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-8-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:52:22 +0100
Message-ID: <CAFEAcA9f_cqYv-64iSckU50b=B95-5moAi+BPbEadvbgsKcsZw@mail.gmail.com>
Subject: Re: [PATCH v4 07/16] tcg/aarch64: Reserve TCG_REG_TMP1, TCG_REG_TMP2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 26 May 2023 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.c.inc | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

