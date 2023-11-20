Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3D7F16E2
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:12:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55wo-0005al-03; Mon, 20 Nov 2023 10:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r55wl-0005W8-Ex
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:12:23 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r55wj-0003e6-FY
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:12:23 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso6481015a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700493140; x=1701097940; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=owfh7IYvvjcgubE2cvHa+4n0iTItdhT5WQdBEq+V7qo=;
 b=EtyR0BPwPH1fiVOLx4drm9ZWESsCWqDU6+u4+nXooJ+4KSJ3SZfXRwLMEpSa/sVzuI
 xnf5gn70Royo+jwiI38d5OF1lnEm3jioOOCqh2t3eN8qyAXEVmzV3uOqoubnCHJeOYin
 bHbmNvJ+ZIA2mphvYl+qzZv9yXV64NIB9ArQHTnqUNtvWx6fjGdRuE94HXuQ+V1Zv3E/
 fsITqsekPX3SoBeBZ84DoDdwWYfr7jdahIMeJYJKN4iid5VC3YICr3QW9nznaYC0wqGO
 +N0Tu4zdGPBpCXHO8gsnmtHZlKhDpkGmc0IH0OQt0PKIswYgVNKkxpeWF8vqTItJDn91
 aChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700493140; x=1701097940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owfh7IYvvjcgubE2cvHa+4n0iTItdhT5WQdBEq+V7qo=;
 b=fAnhkuLsJzny1lzkccgrmmQP4QFmcZrf45RHDxtEjkdbPHD+FwaxdvACHjxO0H69Ey
 UZLrveQPrFGg11qo08/Wzv+0wqm++cdqqr2pDONnOx4w8r1dkM0yWVVtHZRD7pua0ude
 jx8bl5syFIeLbh/+SFPHU6FwM4v3Chw160miQ0xSVfkeafrkJJUHJJdBvQatZecakPUs
 dksG1kW3ilh8fz8xpwq/fSlnwsPf2LeSlLzo4eoV2u0He8L6tuo3F5fkDMPm0Hu8copy
 7vkWcLCiAQFjpUYXSZXJMldReuen6JWgMGhdxyE/B7j0m9o9usVBojfxIOUX3USQ2AZS
 /Nug==
X-Gm-Message-State: AOJu0YwIvLZg97OEpRX7MbAAm5XXF4UqkQ0vocysMuvBkLS59dnZPePW
 J6yG3KcSMAcOBSdmjPWZo0O3WwXsNiASFYOb2zQxvw==
X-Google-Smtp-Source: AGHT+IGWELGU8c6qS9GBYY349OXPgBTfFqhklxGsMEyLtahT0+IONl2odKMfKGimGoJb9pL338R+6gjtX9cNNOSLm/U=
X-Received: by 2002:aa7:c257:0:b0:53e:e6eb:c838 with SMTP id
 y23-20020aa7c257000000b0053ee6ebc838mr5497382edo.8.1700493139985; Mon, 20 Nov
 2023 07:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20231116172818.792364-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20231116172818.792364-1-ben.dooks@codethink.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 15:12:09 +0000
Message-ID: <CAFEAcA8_sYimPQ2hCT_LrDCcJLVOOh5et9M9yE6mASzr260E9A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 16 Nov 2023 at 17:28, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The ICC_PMR_ELx and ICV_PMR_ELx bit masks returned from
> ic{c,v}_fullprio_mask should technically also remove any
> bit above 7 as these are marked reserved (read 0) and should
> therefore should not be written as anything other than 0.
>
> This was noted during a run of a proprietary test system and
> discused on the mailing list [1] and initially thought not to
> be an issue due to RES0 being technically allowed to be
> written to and read back as long as the implementation does
> not use the RES0 bits. It is very possible that the values
> are used in comparison without masking, as pointed out by
> Peter in [2], if (cs->hppi.prio >= cs->icc_pmr_el1) may well
> do the wrong thing.
>
> Masking these values in ic{c,v}_fullprio_mask() should fix
> this and prevent any future problems with playing with the
> values.
>
> [1]: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00607.html
> [2]: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00737.html
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

