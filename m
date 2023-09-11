Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84D79A9EC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj6A-0000s3-F2; Mon, 11 Sep 2023 11:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj65-0000rr-SZ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:45:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj61-0004j2-JR
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:45:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so6046803a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447104; x=1695051904; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Clpmj591TrMrIimxKTvSp8KG9TOSImn90YTVZzgPZ+M=;
 b=AkvXOQcUKB7M2ZOqHGwkz86xHKW8Qt8ICRgbs1SmYpHvWoe6uKiOUXWy883dtyYCBy
 05kJDIUsi8WQOrE1BbpsWmC/kE/61LUhLcYkNYzxio4EaKbPf2YRM3AWinG8n9mbY7Jv
 K3WlohU8Jmeo52eOQ56etk+mn76g6fhxh063F3Doiq9AmcCDNxFbiHL9mwnTHVHxNbg8
 p8RI8/gDSCKm1/y4D33hDJmbNG7SWE5+mhmtiqz1y0Qq2BgH5lz7C7aDHetRYyQawrGT
 DAY8oaH4cJD5WszJwaiD2wMEsYMe6YpU7NDstNYttUgtU6JUUZ3vlGMAyiA00el9q2BT
 7HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447104; x=1695051904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Clpmj591TrMrIimxKTvSp8KG9TOSImn90YTVZzgPZ+M=;
 b=rXACEtLycHGkeoEndW6H+/ACR3Pz6q/6eTEh7JGLu7bvTESbPX+jmKEyAKqtBix2/6
 U3XwD040c3eUnW1Z2VxYdbNk0EjsmKWVViPz6CAFJCD4yGUnPKOhdAnw240gyf+Gpugk
 X7iHkMe5ZwJt6p/vhx+v7b13YUqvUChfXpAstxtc6TjGZRQ0rJa5OkzSGt+1gLdfEyXm
 Hh0JRjQLPr9xi8VetuPVGqaO5HBnNg/je6/quvWqR20jLTNSCv/9Jm4tGxUw1ltIo1yv
 Dl2zHN0WQlQcViJeSoP2Go0xjl3VVY5Tmp8/OiOMkP9o2I44Uk7CPOh/Scir3kOEFLVX
 SUnQ==
X-Gm-Message-State: AOJu0YyQzeNqYzakCATqYvDU8WhdKl7LMPoUm7/cmQGNL9EdeN+FNF3U
 2loEaevbhLXPkUjRpfm/sgl140d5/oETLFjbPdPEXq1bYwoPiHYy
X-Google-Smtp-Source: AGHT+IHVWnakKiMqNgWcFD2iYpLHRZMk+fk1spAHAS1Jy+qNmQI+b3WycXqaItkcePHI1cbsIRNWEiTrSNMDiXrf9gs=
X-Received: by 2002:aa7:d90b:0:b0:51b:c714:a2a1 with SMTP id
 a11-20020aa7d90b000000b0051bc714a2a1mr8545971edr.7.1694447104036; Mon, 11 Sep
 2023 08:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-7-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-7-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:44:53 +0100
Message-ID: <CAFEAcA_FJo0aXo4cbBO=UObB1GFfypG1u-7e1w6WUa35PrfOZw@mail.gmail.com>
Subject: Re: [PATCH 06/11] hw/arm/vexpress: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

