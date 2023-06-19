Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8757358A2
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEzA-0004a7-63; Mon, 19 Jun 2023 09:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEyy-0004WU-O3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:31:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEyw-0001ry-Rn
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:31:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51a3e7a9127so5942727a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687181505; x=1689773505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gs3S7YVy4Ut559ccseAcaMLNlFLchAIeC7draST7rDY=;
 b=v2iRqR0RRsXPkBQyFOUO/TcxGQPTt4C/WH2PMluUObdSWYn2pg6tBVoi2+CxnfAA95
 kecKvQY6fb9oE7L8o6CpzLDty/Roy5dMf/7Wc3gCrbcAtFyovRnUXq2FFN3+PDlGXENO
 XUqLbCt4q5dw/3IptT4KyLZ7Emrwp2sakajYOutw+mpb4tCvuPx0gpF7qlP0/WsawDxp
 Y0Mm3Ykf2lrEJZ3pMjXo5W/eMqacbPIiGc4FEdHjL40No7rMYDkfgAd3r6RHWSKxMc85
 J+btPEVnyGzJkQYzMpg86gqbetOCMWg8cJ/L5xUmkaR9FJWyJcY/+/H1bIwihcmvbH/s
 UKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687181505; x=1689773505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gs3S7YVy4Ut559ccseAcaMLNlFLchAIeC7draST7rDY=;
 b=YokTtVdWOIKqCEZxIEMQ+ep0B6eRs1NZ+n6UG0tRWwWPyNp75z2kNBO4hoNJGwgyd2
 NLBgytC04SJg7hxWHxdVBtFSrocINP9i31T4Pr3Nu9sMsndehf3J98X8hkEhLVLUXKH2
 ediLz5aGyhZQjlz//cu2XxT/lrvdBoNEUuuBpH0Q94WC4j3+aDU2cDf3SuBRxp0kLq94
 tYgNMixiofjmSKG0LzrV4SuijfI/v1CyTFiVHk4UJfuIrLBiOPXGCrGOP0RJRWF7iW5d
 rziS6fBGXMLzNzoP2PUMKbCJQCBDzfBF9f2bJyJPI5M/RMNTefxtagFPENdU7dhIbCEQ
 yjZA==
X-Gm-Message-State: AC+VfDwl8p4MA+Gtcwbx9p9D2Rw91DsJyE6Bu9dPWbnuACJ9WNZWBEpL
 lV+QmU7X6Rf/D3hq0al58ct0WCR7+BDkLcSH3rOKdA==
X-Google-Smtp-Source: ACHHUZ77mTLLFoXlyu9DjP3CIEECwkW0r9x6weLg4xos4ivoMyIwAj9ufnj0zY7EO0RT4zeRuRWq6zXfIU+kHXosYxM=
X-Received: by 2002:a05:6402:350b:b0:514:9311:e83a with SMTP id
 b11-20020a056402350b00b005149311e83amr13905254edd.8.1687181505365; Mon, 19
 Jun 2023 06:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230612223456.33824-1-philmd@linaro.org>
In-Reply-To: <20230612223456.33824-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 14:31:34 +0100
Message-ID: <CAFEAcA8VNj31LTQQgqbYWFPVfTRFYTMSraVLfNRd_vGa-BvUzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] hw/arm/raspi: Use named constants in BCM props
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 12 Jun 2023 at 23:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> v2: https://lore.kernel.org/qemu-devel/20230612115950.5002-1-sergey.kamba=
lin@auriga.com/
>
> This is a respin of Sergey's patch but
> - split in multiple patches
> - removing redundant comments

Applied to target-arm.next (with the comment I mentioned
added to patch 4), thanks.

-- PMM

