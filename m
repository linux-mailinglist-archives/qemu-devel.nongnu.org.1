Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F38799598
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 03:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qemsg-00068A-55; Fri, 08 Sep 2023 21:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1qemsd-00064X-6d
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 21:35:23 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1qemsa-0003QP-IV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 21:35:22 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-502a25ab777so1372668e87.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google; t=1694223318; x=1694828118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fyjxW2eLZx0V0NXeZGIjIYEqBhgVPGDa3d0QU5Q9ZM=;
 b=Q4OtAIxLPM4zHQFt980rm+AnuTfKZsPWt6LGwNaM+mfHPzZoXr8KLKKzFuwRY8Ol59
 6Y2+tWIjaupIJLIqX4k3T8hHsjOythVSzrpgeB8byQAI0bJ6qJMtceqhoxkYJ5A9Qjqk
 Mgqqeye43l17p8EpZ6SMCYwzItGsOFfmRhH3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694223318; x=1694828118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/fyjxW2eLZx0V0NXeZGIjIYEqBhgVPGDa3d0QU5Q9ZM=;
 b=kNVCOu3GtVsMhPTcDCQDMXnV1bBl46X69OMDLWVZ3aqtlgIPuCHx/m50PSLbWFPBox
 F90aHruIPvtBSDcjHl/UBV2bHXM7OWNj+RKecrZCdangFENJp/Zx+Zcs/bdOlBQNXKNU
 vnriDu2aHZG5clN3oQnbumP/uH9oJ0vbVvRwKd9e2/uXXVHUC5pALN2LZxPFiD5EN2be
 r1uzLtHneTap6eh9lxjxmaJAtxK6fHXwf/xeobnKEyW32H9iN94W4Fiqd0WShneYuU/w
 AOoIqcckQ2UrrHrzIAPaVIrA8kk6Mz6Qe/i/3maJn5kgsctfSdIjk2f8pEggygclO08F
 XXIQ==
X-Gm-Message-State: AOJu0YzrCCLR1Dezz3C4dSgCb6FOR0ggAWJPf0B2wx+0aizZxtovWkiO
 KrDiXk5DZcBkOxiyU52IR3gIWBpW/I3tkRgM/JxN
X-Google-Smtp-Source: AGHT+IGWR5Hskrb8njW0iKdiK3ATHSCNQZMhPBZpwRawj2mT1Xyh6yU+40eMC912JtK66BryO9TL1rtIXE4PqVs4wLE=
X-Received: by 2002:a05:6512:3b89:b0:4fc:df79:3781 with SMTP id
 g9-20020a0565123b8900b004fcdf793781mr4464040lfv.66.1694223318391; Fri, 08 Sep
 2023 18:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230908033129.694-1-zhiwei._5Fliu@linux.alibaba.com>
 <20230908102912.535248-1-pbonzini@redhat.com>
In-Reply-To: <20230908102912.535248-1-pbonzini@redhat.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 8 Sep 2023 18:35:07 -0700
Message-ID: <CAOnJCUJexy3PhmGnGNgOk3a5LWLw6ZvFkwYRXTCErGnhn_A9uA@mail.gmail.com>
Subject: Re: [RESEND] qemu/timer: Add host ticks function for RISC-V
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, LIU Zhiwei <lzw194868@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=atishp@atishpatra.org; helo=mail-lf1-x12f.google.com
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

On Fri, Sep 8, 2023 at 3:29=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Queued, thanks.
>

I didn't realize it was already queued. Gmail threads failed me this time.
@Paolo Bonzini : Can you please drop this one as this will break as
soon as the host riscv system
has the latest kernel ? I have provided more details in the original thread=
.

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01941.html

> Paolo
>
>


--=20
Regards,
Atish

