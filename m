Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84D7435E0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8fc-0000aw-KJ; Fri, 30 Jun 2023 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF8fZ-0000aF-Le; Fri, 30 Jun 2023 03:35:53 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF8fX-0005Cx-7A; Fri, 30 Jun 2023 03:35:53 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b6a5fd1f46so22952461fa.1; 
 Fri, 30 Jun 2023 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688110549; x=1690702549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Otot1Hy4zwvIBVC+PaePShvhd8A0ROZEWpoqH/YHjVA=;
 b=U3KbwE7sjQL/zXR6rZl3++1CrT5CnGFOoWUxDdN7+mbSeNEE6Aew1UyAsISy5mtWtx
 ylQymmz/D8Q8p8ciOwqaYL6e9io8K0Wwt1zxBiWu8nNsbHwZXRk5t7AwG2xyBpKiRJD5
 V6HdYRpJ7sAB6bN9+lqEtT8/HELNHZiM0bGv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110549; x=1690702549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Otot1Hy4zwvIBVC+PaePShvhd8A0ROZEWpoqH/YHjVA=;
 b=QgXMLI5v/MXpNm2OdI3M8153+e1xKeQUYGlcmveOOwRfQf76P9ZmRkqcuHpKunJ4Wz
 02GKUcxUb92Elh7O37dvs02ED/fiqp+xGHMAqCjNUjOpmWQuN7FbW1ASJ+T6CC7GrWa6
 pqzvMHpykZGjcsbgRRa2CmBQZWboFL7yUe6bJa1GCSdU79lfeKN/qVqj3eUfr7fOPJn5
 ULMCPDMqapVY9mqjsV+CauSiO8h4IL2vm9ubdkXZn1lBgbEKnnV2wrCjcKpQBEQv2EbQ
 cdjP6Y2X5ntD8OmpO6vqExlgNwWWr3EXvoxZLVG8n8YwMt6+i4s7laI8N2UwuZOCZtfD
 UmTA==
X-Gm-Message-State: ABy/qLYSvcmruCRv1tR/Zsoah/aozSBgPvw1+LguhIjk4WBv3GZKfl+p
 cIZQZ76ZPVNgRQ2lRt5dU3/SpeLTlQJU89fmkrY=
X-Google-Smtp-Source: APBJJlHRmuCqL5SvCzD1DtrI6eeiqoKSUoQSnGqOPHRh1WFxpM/w59+4PrdIRu1CHjr2Iq0dP9AHiULIUa27duVzg7Q=
X-Received: by 2002:a2e:8686:0:b0:2b5:813e:1c3a with SMTP id
 l6-20020a2e8686000000b002b5813e1c3amr1723889lji.13.1688110548323; Fri, 30 Jun
 2023 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-4-joel@jms.id.au>
 <da80494b-0626-62f5-65b7-1e4b0901ee27@linux.ibm.com>
In-Reply-To: <da80494b-0626-62f5-65b7-1e4b0901ee27@linux.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 30 Jun 2023 07:35:36 +0000
Message-ID: <CACPK8Xdyp_buQ4A=h8aJB1A_Q2kUpAGRHY1mm0Gn3jB3vk9a3Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] ppc/pnv: Add P10 quad ops
To: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, 30 Jun 2023 at 07:30, Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>
>
>
> On 30/06/2023 05:55, Joel Stanley wrote:
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index b9a57463aec4..7fff2fd9e298 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
>
> > +static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
> ...
> > +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
>
>                                           ^^^ reading
>
> I'm guessing we'll need to flush out that function pretty soon, so not
> worth resending.

Thanks, good catch. It's incorrect in the p9 callback too.

I had it fixed locally along with a re-wording to make it clear the
message was for unimplemented operations, but decided not to send
that.

