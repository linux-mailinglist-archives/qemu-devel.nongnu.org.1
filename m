Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE3749CCA
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOVX-0001Ps-Jo; Thu, 06 Jul 2023 08:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOVV-0001Pg-Sd
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:54:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOVU-0004gD-5Q
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:54:49 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b6fdaf6eefso9455441fa.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688648086; x=1691240086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3guBtNhqF4CEUto0+hAzbYK0KEXmWQIQC+PoiDnRiM=;
 b=jtJRXxqL8CD++Y8duxI0pspR7AKNrfV6N1Jh9pMZrIgEItFYV6iKmTJxoZRkKeTxJn
 n1bJUNQabAUWAje66STl5Q+N5vBI4O01OS52A+AR910YqQ+PVP50ZIbirvST3rcUhy6r
 0lbg8BBDMNY35ib0Kbi/qPWMNMjjqzyKCU8qqoB790fLG0uG5buxUw9R57Z08BhiKUXr
 YwCdBchn+8XyjheZum8VHrCJHyQqL58MTKZ0Xk10rhgF63zVa0Vygcl+HQRZ9kvWDsQ9
 9bPBi9oc97R/0c5ewz+yPji0C6yGjEziKEgnswbCFbpWeRu2boyiLdMVGz6NwDnk4GQ8
 u1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688648086; x=1691240086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3guBtNhqF4CEUto0+hAzbYK0KEXmWQIQC+PoiDnRiM=;
 b=B4Qwv0zYn4FxjQRI5FH5g8hRTgO8yKNBI8nH9aG4/j8OTRKVm7p7+vVrpkiWM9Gbin
 M68TL2cy3A0M3GvRRS1E6rV0kiXQ5RTQNT+tLUMcCG6m9yKh4T+jvqf/6MMc7grGgoQl
 FrIjt8hOnqV+jwm+0K/7EtyolVuHf87T1S3iGmgJ81aa51BfDFpoGnalFIiibExb5Uha
 GtFOlbYistL6NjrDO49+uDuYPn/udlv/iXRMa1FCYJXMCHB443qjgsaAN8/kWG9+ABHW
 nB+8B8IyrNDOl/vhqMe//9vQtaMv+LxVoUmbUmYJ2o1yMRFRIAFhevijr/JhhdLRaMAA
 GO5A==
X-Gm-Message-State: ABy/qLY7/KGk3J04exx/3Tz1v3QU5mA1YBuOGMSR4GmQW4PGw9xigbin
 0S3NDPxIVyt5AXGuJ51BW+kZ63+oVKGJFwpyhoZq6w==
X-Google-Smtp-Source: APBJJlE1SkvjLj/0HcYkO5JYxyNejZe7zNPDv0yd0kdV9EQKZKbTb5N3zMDF++qNeYzF6JExG27kuvHkD12JV97i3IM=
X-Received: by 2002:a2e:9917:0:b0:2b6:9f95:46d3 with SMTP id
 v23-20020a2e9917000000b002b69f9546d3mr1292006lji.9.1688648086129; Thu, 06 Jul
 2023 05:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
 <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
 <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
 <CAFEAcA8o8nG7_DWnjYHOL7R2x1DjJdQ-=Moe_jkSibXscZ2mQg@mail.gmail.com>
 <9cc96e295ba6ee2e8cad5cf82da6b926713fa9fd.camel@ericsson.com>
In-Reply-To: <9cc96e295ba6ee2e8cad5cf82da6b926713fa9fd.camel@ericsson.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 13:54:35 +0100
Message-ID: <CAFEAcA8KOsqS-T7rdrvnhkac5DuAhgkgZCsNgMGkWbk2kdsfuw@mail.gmail.com>
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
To: =?UTF-8?Q?John_H=C3=B6gberg?= <john.hogberg@ericsson.com>
Cc: "philmd@linaro.org" <philmd@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Thu, 6 Jul 2023 at 13:45, John H=C3=B6gberg <john.hogberg@ericsson.com> =
wrote:
>
> > That is enough to get it to build, but then in the CI the test
> > consistently fails:
> >
> > https://gitlab.com/pm215/qemu/-/jobs/4606447875
> >
> > TEST icivau on aarch64
> > make[1]: *** [Makefile:178: run-icivau] Error 1
> >
> > I'm going to drop this patch from the pullreq until we
> > can figure out what's going on...
>
> Oops, -pthread wasn't required on my machine.
>
> I'm unable to reproduce the failure locally. Is it possible to strace it
> and see whether it was caused by failing to set up dual-mapped code?

On the CI machines all you get is what the test case (and
whatever the makefile chooses to wrap it in) writes
to stdout/stderr.

thanks
-- PMM

