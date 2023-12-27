Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE281EC61
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 07:02:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIMyY-0006j5-4Z; Wed, 27 Dec 2023 01:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rIMyM-0006il-QP
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 01:00:56 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rIMy9-0006Bm-Ro
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 01:00:52 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ccbf8cbf3aso23306841fa.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 22:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1703656837; x=1704261637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzLoUSTFREGluRoy92/pVOFo+TGMcwB/0uk0LUg2exo=;
 b=UXUOeE+E41ooIbirYt+ZX13qkCsWn/bSkKRi1K3xE3berD1hAFLWYambePCokvuFW2
 3idCecZM8RflF31lhWH0SdLkqeaqqMp0SxxU9lY6mMdgpcwI2GFlAQVpf9+LiYeVs/bg
 CfPWe1mX/bAvzhftMsFRnBdzkPpEdSksIzYjN1VpagOn9dmjTmlsO4A5/eLnSS/QBrC4
 jh6+Ct5K9W2F4rPhiIQVgDcuHG6gJME311K3Cdxuvd8yYYSHX5MXmC3+zFizutai9mGd
 LtswMjhvvhZm3Rmua5OdhU2XdxvkA244e5T+/n60aYiUvQ2f5VbKhNLOZrCNUs1hbSYS
 eGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703656837; x=1704261637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzLoUSTFREGluRoy92/pVOFo+TGMcwB/0uk0LUg2exo=;
 b=aAo9BhhbbJxgrapskh1afRUvAfGJ4n5/EPGiZvd4Umvij1YBEIGLgigR3WOH7E+rJ1
 BHZQD6waiLu/dno8fLnguGaHLvTrVYA8Wuw+rG9kweyJEYhl7XbXaSZJLSGsrqE0g42D
 e+QN2VdliicWHjCbiYeST4fCQcDNeAxVGhDFJ+r3Ar3Bf5noR/VPVB8yV0VlTVRyCtTN
 0gBhBB+em/t/UvIcSLoYnPBmE7MyNG6o9KEMKMmdcXI1uEEzdPnIPLLmQyDovfD1ebnb
 6yJ3jITxK6z5hLSRHZfhquzw65eQpWTphVnLai0/dm1A8GQHEUS0BryvVYIJiPStXH6J
 MVeQ==
X-Gm-Message-State: AOJu0YyaHIzRHQQUfq6Z+UjjWl/MAslrpF8f+OSo+h0CMJnk8iIIOFw2
 t+uJe3qbIPYkOvYbJgRQo06gmsVWoqR/lzc5roFseo+Q1478yQ==
X-Google-Smtp-Source: AGHT+IHpvCuaN1dgifpgFOaCkZLZoOYDEIsUPxHRH0nBfoK9aGzhse9D1WE2ZRsfagRYK7Dzx9Yi2Xmi8ECDe0bPceM=
X-Received: by 2002:a2e:9e53:0:b0:2cc:788a:3d4d with SMTP id
 g19-20020a2e9e53000000b002cc788a3d4dmr3492370ljk.51.1703656837161; Tue, 26
 Dec 2023 22:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-8-hao.xiang@bytedance.com> <87h6koh1is.fsf@suse.de>
 <CAAYibXhX1Rw++m47SgOtd3B1zC3fOGCqBuMRTMihPJgm=ZQF1A@mail.gmail.com>
 <87ttoexrd3.fsf@suse.de>
In-Reply-To: <87ttoexrd3.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 26 Dec 2023 22:00:26 -0800
Message-ID: <CAAYibXhPqpS=tWPJLcAZ++xueQMzc9-dnLbL4scg18rHAYmf9Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/20] util/dsa: Implement DSA device
 start and stop logic.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Dec 19, 2023 at 5:19=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> >>
> >> > +}
> >> > +
> >> > +void dsa_start(void) {}
> >> > +
> >> > +void dsa_stop(void) {}
> >> > +
> >> > +void dsa_cleanup(void) {}
> >> > +
> >> > +#endif
> >>
> >> These could all be in the header.
> >
> > The function definitions are already in dsa.h Do you mean moving the
> > function implementations to the header as well?
> >
>
> I mean the empty !CONFIG_DSA_OPT variants could be in the header as
> static inline.
>

Fixed.

