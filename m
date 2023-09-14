Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FF79FBD8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfki-0006og-TG; Thu, 14 Sep 2023 02:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1qgfkh-0006oN-83
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:22:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1qgfkf-0001oT-9x
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:22:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so616568a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1694672572; x=1695277372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEQqLAGfGXDXNSVrgkSbbPwz6XvycvCh9/uDhckRC2s=;
 b=FW90GCzaupX7li/kCQq9AM2zcPXCD404BG8fvcNVhC01tPR597db30NxIqVazVbVsR
 W/ynM/NOgM7sQp6olJ+AgIDFiyS1EYrkHaZqGB0Ovo5oHfzAU0VQiKwUa5MCHNgzW+RT
 OtY/p/QRYHz1dsGkUtzRCRBiADB/QKT1CbC6aXxRgKj2qG1S/JUU1Bm9y+k7+sJWAiPX
 4EUNHYnTLxu4sb7hAf8vcSxwYZ7pWaHrYO0Yk0nsUF2w4yjODGpQj3dpfYL3SJT4Q6Qb
 uhMwn/8yGgrSAv5TzIj6FZ9emBp4J97GF6a5Ng3zJiXZmXhY3QFl1ye2X8QwpyarpQAE
 +u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694672572; x=1695277372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEQqLAGfGXDXNSVrgkSbbPwz6XvycvCh9/uDhckRC2s=;
 b=dWc74PLM1sa8dYN25pmx/d9ig4OrYvqoE6mpC4jXejxylDAXqDh888Ps79xF+NHNIK
 z4Dl7HScfA1QeyvWO4ViIUoMzyZ2wCG+Dj2QSkbhOKQHk194mKJa4T7vSF9bu1VUWIPi
 OyV8hK2gsmk1rWnUwYPwqeE4TQn7eD8lo1/QZVzhEoeiK7AiJuk5KO/WT0DjQEtkGtVc
 tM+350BL9DvQ3+WzIgZuKzhMlmCjOBzNG1A2CXhvhcNb5K80Iv5H5C40lOETsnDys9/h
 XxbN9QDyNZY7ChG3Lsjm6qrKFlrUWE1mXYxQtNsdItJvS8eKzOnSY0S4+D5eqZgr3ZK1
 OSHw==
X-Gm-Message-State: AOJu0YzupOijtqg15mNjrjvQ//w+4iehoc+fqajZis+vYFtQd//rKcdq
 3KjXXRaJBwFfGQQs7XtaOiHdikazYREvDn4UlSe6xw==
X-Google-Smtp-Source: AGHT+IHt3Fgp9GWKZ/0ZJrSAvXweB0M/RmQCqluhvfxrL8t9CjRrGiZVhq//tf8nEhITaZDMb/ToqqvOHlEPe1fIBew=
X-Received: by 2002:a05:6402:1807:b0:52e:585a:e96 with SMTP id
 g7-20020a056402180700b0052e585a0e96mr4173367edy.7.1694672571986; Wed, 13 Sep
 2023 23:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <fde42d81ce454477ca8e27d5429a190b7366fe86.1692074650.git.pawan.kumar.gupta@linux.intel.com>
 <89e97deb-65ca-e1a2-da53-7ae29f13ea26@intel.com>
In-Reply-To: <89e97deb-65ca-e1a2-da53-7ae29f13ea26@intel.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 14 Sep 2023 08:22:41 +0200
Message-ID: <CAMGffEkfQUJi=shsySeSCvB7d-LwbqXib9j7eAKuRivaiz0t_g@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Export GDS_NO bit to guests
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, 
 qemu-devel <qemu-devel@nongnu.org>, tao1.su@linux.intel.com, 
 Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::531;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

Ping!

Thx!

On Tue, Aug 15, 2023 at 7:44=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 8/15/2023 12:54 PM, Pawan Gupta wrote:
> > Gather Data Sampling (GDS) is a side-channel attack using Gather
> > instructions. Some Intel processors will set ARCH_CAP_GDS_NO bit in
> > MSR IA32_ARCH_CAPABILITIES to report that they are not vulnerable to
> > GDS.
> >
> > Make this bit available to guests.
> >
> > Closes: https://lore.kernel.org/qemu-devel/CAMGffEmG6TNq0n3+4OJAgXc8J0O=
evY60KHZekXCBs3LoK9vehA@mail.gmail.com/
> > Reported-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Tested-by: Jack Wang <jinpu.wang@ionos.com>
> > Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>
> > ---
> > v2: Added commit tags
> >
> > v1: https://lore.kernel.org/qemu-devel/c373f3f92b542b738f296d44bb6a916a=
1cded7bd.1691774049.git.pawan.kumar.gupta@linux.intel.com/
> >
> >   target/i386/cpu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 97ad229d8ba3..48709b77689f 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =
=3D {
> >               NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
> >               NULL, "fb-clear", NULL, NULL,
> >               NULL, NULL, NULL, NULL,
> > -            "pbrsb-no", NULL, NULL, NULL,
> > +            "pbrsb-no", NULL, "gds-no", NULL,
> >               NULL, NULL, NULL, NULL,
> >           },
> >           .msr =3D {
>

